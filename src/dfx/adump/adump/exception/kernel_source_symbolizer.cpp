/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "kernel_source_symbolizer.h"

#include <cerrno>
#include <csignal>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <elf.h>
#include <fcntl.h>
#include <mutex>
#include <poll.h>
#include <spawn.h>
#include <sstream>
#include <sys/wait.h>
#include <unistd.h>
#include <vector>

#include "securec.h"
#include "mmpa_api.h"
#include "path.h"
#include "lib_path.h"
#include "sys_utils.h"
#include "log/adx_log.h"
#include "log/hdc_log.h"
#include "log_types.h"

// environ 由 <unistd.h> 声明（posix_spawn 需要当前进程环境变量表），无需再以 extern 方式引用外部变量。

namespace Adx {
namespace {
// 异常现场，宁可快速降级也不阻塞落盘：单次子进程解析超时 3 秒。
constexpr int64_t SYMBOLIZER_TIMEOUT_MS = 3000;
// 逐偏移连续失败上限：工具级失败（spawn 失败/超时）连续达到该值即跳过剩余偏移，
// 病理全挂死场景总耗时收敛为 3×超时，避免长尾拖垮异常处理链路；
// 偶发失败后恢复或解析为 unknown 均不计入（工具应答即重置计数，保持逐偏移隔离语义）。
constexpr size_t MAX_CONSECUTIVE_SYMBOLIZE_FAILURES = 3U;
// 超时回收：SIGTERM 后给子进程的自行退出宽限期，到期再 SIGKILL。
constexpr int64_t SYMBOLIZER_TERM_GRACE_MS = 200;
// 宽限期内轮询 waitpid(WNOHANG) 的睡眠间隔（10ms）。
constexpr int64_t SYMBOLIZER_TERM_POLL_NS = 10 * 1000 * 1000;
constexpr size_t READ_BUF_SIZE = 4096;
constexpr char ENV_SYMBOLIZER[] = "ADUMP_LLVM_SYMBOLIZER";
// CANN 安装路径 + 架构目录下 llvm-symbolizer 的相对路径，如 <install>/x86_64-linux/bin/llvm-symbolizer。
constexpr char CANN_SYMBOLIZER_REL[] = "/bin/llvm-symbolizer";
// 系统默认安装位置回退。
constexpr char SYSTEM_SYMBOLIZER[] = "/usr/bin/llvm-symbolizer";
constexpr char UNKNOWN_MARK[] = "??";
// dlog 单条日志 msg 缓冲上限为 log_types.h 的 MSG_LENGTH（单源 include，上游变更经编译期传导），
// 用户内容最后写入，之前拼接：级别/模块/PID/进程名/时间戳基座(≤96，dlog_message.c 基座格式)，
// [__FILE__:__LINE__](绝对路径最坏假设 ≤136，随检出目录深度环境相关)，[tid:N](≤17)，
// tag 下游前缀 [%d,%u,%u,%d](≤27)，换行与结尾符(2)，最坏合计 ≈278，取整预留 320。
// 超预留环境（如 CI 深路径）下降级语义：仅丢 chunk 尾部，不丢整行。UT 硬编码 704 断言锁定派生契约。
constexpr size_t LOG_HEADER_RESERVE = 320U;
constexpr size_t MAX_LOG_CHUNK_SIZE = MSG_LENGTH - LOG_HEADER_RESERVE; // 704
// 逐行打印后多设备并发的 raw 输出需保证标签行+全部 chunk 连续（slog
// 只保证单条原子）：序列锁仅包裹打印段，符号化计算不持锁。
std::mutex g_rawPrintMutex;

int64_t NowMs()
{
    struct timespec ts {};
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    return static_cast<int64_t>(ts.tv_sec) * 1000 + ts.tv_nsec / 1000000;
}

// 校验路径存在且可执行。
bool IsExecutable(const std::string& path)
{
    if (path.empty()) {
        return false;
    }
    return access(path.c_str(), X_OK) == 0;
}

std::string GetEnvValue(const char* name)
{
    // mmGetEnv 内部对环境变量表的读取做了加锁保护，避免直接调用 getenv 的竞争条件。
    char value[MMPA_MAX_PATH] = {0};
    if (mmGetEnv(name, value, sizeof(value)) != EN_OK) {
        return std::string();
    }
    return SysUtils::HandleEnv(value);
}

// 校验 ELF64 头合法性并定位 section 名字符串表；成功时回填 strTab/strTabSize。
// 以减法/除法比较，避免 e_shoff + e_shnum * sizeof(Shdr) 等加法回绕绕过越界校验。
bool LocateElfStrTab(const char* data, size_t size, Elf64_Ehdr& ehdr, const char*& strTab, size_t& strTabSize)
{
    if (memcpy_s(&ehdr, sizeof(ehdr), data, sizeof(ehdr)) != EOK) {
        return false;
    }
    if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 || ehdr.e_ident[EI_CLASS] != ELFCLASS64) {
        return false;
    }
    if (ehdr.e_shentsize != sizeof(Elf64_Shdr) || ehdr.e_shnum == 0 || ehdr.e_shstrndx >= ehdr.e_shnum) {
        return false;
    }
    if (ehdr.e_shoff == 0 || ehdr.e_shoff >= size ||
        (size - ehdr.e_shoff) / sizeof(Elf64_Shdr) < static_cast<uint64_t>(ehdr.e_shnum)) {
        return false;
    }
    Elf64_Shdr strShdr{};
    const size_t strShdrOff =
        static_cast<size_t>(ehdr.e_shoff) + static_cast<size_t>(ehdr.e_shstrndx) * sizeof(Elf64_Shdr);
    if (memcpy_s(&strShdr, sizeof(strShdr), data + strShdrOff, sizeof(strShdr)) != EOK) {
        return false;
    }
    if (strShdr.sh_offset >= size || strShdr.sh_size == 0 || strShdr.sh_size > size - strShdr.sh_offset) {
        return false;
    }
    strTab = data + strShdr.sh_offset;
    strTabSize = static_cast<size_t>(strShdr.sh_size);
    return true;
}

// 从 ELF section header 表中查找名为 target 的段。
bool ElfHasSection(const char* data, size_t size, const std::string& target)
{
    if (data == nullptr || size < sizeof(Elf64_Ehdr)) {
        return false;
    }
    Elf64_Ehdr ehdr{};
    const char* strTab = nullptr;
    size_t strTabSize = 0;
    if (!LocateElfStrTab(data, size, ehdr, strTab, strTabSize)) {
        return false;
    }
    for (uint16_t i = 0; i < ehdr.e_shnum; ++i) {
        Elf64_Shdr shdr{};
        const size_t off = static_cast<size_t>(ehdr.e_shoff) + static_cast<size_t>(i) * sizeof(Elf64_Shdr);
        if (memcpy_s(&shdr, sizeof(shdr), data + off, sizeof(shdr)) != EOK) {
            return false;
        }
        if (shdr.sh_name >= strTabSize) {
            continue;
        }
        const char* nameStart = strTab + shdr.sh_name;
        if (memchr(nameStart, '\0', strTabSize - shdr.sh_name) == nullptr) {
            continue;
        }
        if (target == nameStart) {
            return true;
        }
    }
    return false;
}
} // namespace

namespace {
// 缓存首次解析结果。异常回调可能来自多设备/多线程，用互斥量保护解析与缓存读写，
// 避免 g_toolResolved 判断与 g_cachedTool 写入之间的数据竞争。
std::string g_cachedTool;
bool g_toolResolved = false;
std::mutex g_locateMutex;

// 实际执行工具解析，返回定位到的路径（未找到则空）。调用方需持有 g_locateMutex。
std::string ResolveSymbolizerPath()
{
    // 1. 环境变量指定的绝对路径优先。
    const std::string envPath = GetEnvValue(ENV_SYMBOLIZER);
    if (!envPath.empty()) {
        if (IsExecutable(envPath)) {
            IDE_LOGI("Locate llvm-symbolizer from env %s: %s", ENV_SYMBOLIZER, envPath.c_str());
            return envPath;
        }
        IDE_LOGW("Env %s is set but not executable: %s", ENV_SYMBOLIZER, envPath.c_str());
    }

    // 2. CANN 安装路径 + 架构目录：<install>/<arch>/bin/llvm-symbolizer。
    //    LibPath 经 dladdr 定位自身 .so，其父目录即 <install>/<arch>（如 <install>/x86_64-linux）。
    const std::string archPath = LibPath::Instance().GetInstallParentPath().GetString();
    if (!archPath.empty()) {
        const std::string candidate = archPath + CANN_SYMBOLIZER_REL;
        if (IsExecutable(candidate)) {
            IDE_LOGI("Locate llvm-symbolizer from CANN install path: %s", candidate.c_str());
            return candidate;
        }
        IDE_LOGD("llvm-symbolizer not found under CANN install path: %s", candidate.c_str());
    } else {
        IDE_LOGD("Cannot resolve CANN install path, skip CANN candidate for llvm-symbolizer.");
    }

    // 3. 系统默认位置回退：/usr/bin/llvm-symbolizer。
    if (IsExecutable(SYSTEM_SYMBOLIZER)) {
        IDE_LOGI("Locate llvm-symbolizer from system path: %s", SYSTEM_SYMBOLIZER);
        return SYSTEM_SYMBOLIZER;
    }
    IDE_LOGD("llvm-symbolizer not found under system path: %s", SYSTEM_SYMBOLIZER);

    IDE_LOGW(
        "llvm-symbolizer not found, skip source location. "
        "Set env %s or install it under CANN <arch>/bin or /usr/bin to enable it.",
        ENV_SYMBOLIZER);
    return std::string();
}

// 安全解析十进制无符号数：校验 endptr 与 errno，非法/越界返回 0（源码信息仅用于日志展示）。
uint32_t ParseDecU32(const std::string& text)
{
    if (text.empty()) {
        return 0;
    }
    errno = 0;
    char* endptr = nullptr;
    const unsigned long value = strtoul(text.c_str(), &endptr, 10);
    if (endptr == text.c_str() || *endptr != '\0' || errno == ERANGE || value > UINT32_MAX) {
        return 0;
    }
    return static_cast<uint32_t>(value);
}

// 子进程句柄：pid 与父侧管道 fd（inFd 写子 stdin，outFd 读子 stdout）。
struct SymbolizerProc {
    pid_t pid = -1;
    int inFd = -1;
    int outFd = -1;
};

// 创建 stdin/stdout 管道并 posix_spawn 拉起 llvm-symbolizer；成功时回填 proc 的父侧 fd 与 pid。
// posix_spawn 内部走 vfork 快路径，以声明式 file_actions 完成重定向，规避 fork-to-exec 的 async-signal 风险。
bool SpawnSymbolizer(const std::string& tool, SymbolizerProc& proc)
{
    int inPipe[2] = {-1, -1};
    int outPipe[2] = {-1, -1};
    // 管道创建失败依赖系统资源耗尽，无法在 UT 中稳定注入；保留清理逻辑但不计入覆盖率。
    // LCOV_EXCL_START
    if (pipe(inPipe) != 0 || pipe(outPipe) != 0) {
        IDE_LOGW("Symbolize: create pipe failed, errno=%d.", errno);
        if (inPipe[0] >= 0) {
            (void)close(inPipe[0]);
            (void)close(inPipe[1]);
        }
        return false;
    }
    // LCOV_EXCL_STOP
    posix_spawn_file_actions_t actions;
    // file_actions 初始化失败同样由系统资源状态决定，无法稳定注入。
    // LCOV_EXCL_START
    if (posix_spawn_file_actions_init(&actions) != 0) {
        IDE_LOGW("Symbolize: init spawn file actions failed, errno=%d.", errno);
        (void)close(inPipe[0]);
        (void)close(inPipe[1]);
        (void)close(outPipe[0]);
        (void)close(outPipe[1]);
        return false;
    }
    // LCOV_EXCL_STOP
    (void)posix_spawn_file_actions_adddup2(&actions, inPipe[0], STDIN_FILENO);
    (void)posix_spawn_file_actions_adddup2(&actions, outPipe[1], STDOUT_FILENO);
    (void)posix_spawn_file_actions_addclose(&actions, inPipe[0]);
    (void)posix_spawn_file_actions_addclose(&actions, inPipe[1]);
    (void)posix_spawn_file_actions_addclose(&actions, outPipe[0]);
    (void)posix_spawn_file_actions_addclose(&actions, outPipe[1]);

    // 无 shell、无附加参数：目标文件随每行 stdin 以 "文件" 地址 形式给出，文件名与地址均来自受控数据。
    // 不依赖 -f/-C/-i
    // 约束输出格式，解析端不依赖空行与块边界：单偏移单进程，首条位置行=最内层帧、末条=最外层帧，忽略函数名行。
    char argExe[] = "llvm-symbolizer";
    char* const argv[] = {argExe, nullptr};

    pid_t pid = -1;
    int spawnRet = posix_spawn(&pid, tool.c_str(), &actions, nullptr, argv, environ);
    (void)posix_spawn_file_actions_destroy(&actions);
    // 拉起工具失败取决于执行环境，测试中无法跨平台稳定注入；清理路径不计入覆盖率。
    // LCOV_EXCL_START
    if (spawnRet != 0) {
        IDE_LOGW("Symbolize: posix_spawn failed, ret=%d, tool=%s.", spawnRet, tool.c_str());
        (void)close(inPipe[0]);
        (void)close(inPipe[1]);
        (void)close(outPipe[0]);
        (void)close(outPipe[1]);
        return false;
    }
    // LCOV_EXCL_STOP
    // 父进程关闭子进程侧管道端，仅保留自身读写端。
    (void)close(inPipe[0]);
    (void)close(outPipe[1]);
    proc.pid = pid;
    proc.inFd = inPipe[1];
    proc.outFd = outPipe[0];
    return true;
}

// 读一次 stdout：追加到 output，EOF 置 outEof；遇不可恢复错误返回 false。
bool DrainReadable(int fd, std::string& output, bool& outEof)
{
    char buf[READ_BUF_SIZE];
    ssize_t r = read(fd, buf, sizeof(buf));
    if (r > 0) {
        output.append(buf, static_cast<size_t>(r));
    } else if (r == 0) {
        outEof = true;
    } else if (errno != EINTR && errno != EAGAIN && errno != EWOULDBLOCK) {
        return false;
    }
    return true;
}

// 增量写 stdin：写完或出错即关闭写端并置 inClosed、inFd=-1。
void PumpWritable(int& inFd, const std::string& input, size_t& written, bool& inClosed)
{
    ssize_t w = write(inFd, input.data() + written, input.size() - written);
    if (w > 0) {
        written += static_cast<size_t>(w);
    } else if (w < 0 && errno != EINTR && errno != EAGAIN && errno != EWOULDBLOCK) {
        inClosed = true;
        (void)close(inFd);
        inFd = -1;
        return;
    }
    if (!inClosed && written >= input.size()) {
        inClosed = true;
        (void)close(inFd);
        inFd = -1;
    }
}

// 组装本轮 poll 的 pollfd 数组：outFd 恒在 [0] 收 POLLIN；stdin 未写完时把 inFd 加为 [1] 收 POLLOUT。
// 返回待 poll 的 fd 数量，并回填 outIdx / inIdx（inIdx=-1 表示本轮不再关注 stdin）。
nfds_t BuildPollFds(const SymbolizerProc& proc, bool inClosed, struct pollfd fds[2], int& outIdx, int& inIdx)
{
    nfds_t nfds = 0;
    outIdx = static_cast<int>(nfds);
    fds[nfds].fd = proc.outFd;
    fds[nfds].events = POLLIN;
    fds[nfds].revents = 0;
    ++nfds;
    inIdx = -1;
    if (!inClosed) {
        inIdx = static_cast<int>(nfds);
        fds[nfds].fd = proc.inFd;
        fds[nfds].events = POLLOUT;
        fds[nfds].revents = 0;
        ++nfds;
    }
    return nfds;
}

// 同一 poll 循环并发驱动 stdin 写与 stdout 读，避免"先写满 stdin 再读 stdout"的父子互相背压死锁。
// 两端置非阻塞并统一挂在 deadline 下；超时返回 false。返回后 proc.inFd 已关闭。
bool PumpSymbolizerIo(SymbolizerProc& proc, const std::string& input, std::string& output)
{
    (void)fcntl(proc.inFd, F_SETFL, O_NONBLOCK);
    (void)fcntl(proc.outFd, F_SETFL, O_NONBLOCK);
    size_t written = 0;
    bool inClosed = false;
    bool outEof = false;
    bool timedOut = false;
    const int64_t deadline = NowMs() + SYMBOLIZER_TIMEOUT_MS;
    while (!outEof) {
        const int64_t remain = deadline - NowMs();
        if (remain <= 0) {
            timedOut = true;
            break;
        }
        struct pollfd fds[2];
        int outIdx = -1;
        int inIdx = -1;
        const nfds_t nfds = BuildPollFds(proc, inClosed, fds, outIdx, inIdx);
        int pr = poll(fds, nfds, static_cast<int>(remain));
        if (pr < 0) {
            if (errno == EINTR) {
                continue;
            }
            break;
        }
        if (pr == 0) {
            timedOut = true;
            break;
        }
        // 优先读 stdout，避免子进程被 stdout 管道背压阻塞。
        if ((fds[outIdx].revents & (POLLIN | POLLHUP | POLLERR)) != 0 && !DrainReadable(proc.outFd, output, outEof)) {
            break;
        }
        if (inIdx >= 0 && (fds[inIdx].revents & (POLLOUT | POLLHUP | POLLERR)) != 0) {
            PumpWritable(proc.inFd, input, written, inClosed);
        }
    }
    if (!inClosed && proc.inFd >= 0) {
        (void)close(proc.inFd);
        proc.inFd = -1;
    }
    return !timedOut;
}

// 进程级忽略 SIGPIPE：子进程异常早退关闭 stdin 读端时，父进程 write 默认动作是被 SIGPIPE 终止，
// 忽略后 write 改为返回 EPIPE，从而走 best-effort 降级而非杀死宿主进程（fujun19 检视点）。
// 只需设置一次；用 call_once 保证幂等，且不覆盖用户可能已有的 SIGPIPE 处理时保持 SIG_IGN 语义。
void IgnoreSigPipeOnce()
{
    static std::once_flag onceFlag;
    std::call_once(onceFlag, []() {
        struct sigaction sa {};
        sa.sa_handler = SIG_IGN;
        (void)sigemptyset(&sa.sa_mask);
        sa.sa_flags = 0;
        (void)sigaction(SIGPIPE, &sa, nullptr);
    });
}

// 在宽限期内以 WNOHANG 轮询回收子进程。已回收（或不可回收 ECHILD）返回 true；
// 到期仍在运行返回 false，交由调用方 SIGKILL 兜底。
bool WaitChildExit(pid_t pid, int64_t graceMs)
{
    const int64_t graceDeadline = NowMs() + graceMs;
    do {
        const pid_t r = waitpid(pid, nullptr, WNOHANG);
        if (r == pid || (r < 0 && errno != EINTR)) {
            return true;
        }
        struct timespec ts {
            0, SYMBOLIZER_TERM_POLL_NS
        };
        (void)nanosleep(&ts, nullptr);
    } while (NowMs() < graceDeadline);
    return false;
}

// 统一回收子进程，遵循 G.STD.17-CPP「先通知、限时等待、再强制终止」的顺序，并把回收纳入 deadline
// 避免无界阻塞的 waitpid（zhangpengpeng8 检视点）：先发 SIGTERM 通知子进程自行退出（无论是否超时，
// 正常路径下子进程收到 stdin EOF 本应自退，此处 SIGTERM 仅为兜底通知）；随后在宽限期内 WNOHANG 轮询
// 回收；到期仍未退出，说明子进程已挂死不响应优雅通知，再 SIGKILL 强制终止并阻塞回收（SIGKILL 后
// 子进程必然很快退出，不会僵尸/久等）。
void ReapChild(pid_t pid)
{
    // 先礼：通知目标子进程停止，给足宽限期等待其自行退出。
    (void)kill(pid, SIGTERM);
    // 后兵：仅当宽限期内等待超时（子进程仍未退出）时才强制终止并回收；
    // 否则子进程已在宽限期内自行退出并被 WaitChildExit 回收，正常返回。
    if (!WaitChildExit(pid, SYMBOLIZER_TERM_GRACE_MS)) {
        (void)kill(pid, SIGKILL);
        (void)waitpid(pid, nullptr, 0);
    }
}

// 判断子串 [begin, end) 是否非空且全为十进制数字。
bool IsAllDigits(const std::string& s, size_t begin, size_t end)
{
    if (begin >= end) {
        return false;
    }
    for (size_t i = begin; i < end; ++i) {
        if (s[i] < '0' || s[i] > '9') {
            return false;
        }
    }
    return true;
}

// 判断是否为位置行：形如 file:line:col，即最后两个冒号分隔的字段均为数字。
// 用于把位置行与函数名行区分开——未加 -C 时函数名默认仍会 demangle，可能含 '::'（如 ns::foo(int)），
// 仅凭"含冒号"无法区分，故要求结尾严格为 :<数字>:<数字>。llvm-symbolizer 未知位置标记 ??:0:0 亦满足。
bool IsLocationLine(const std::string& line, size_t& colPos, size_t& linePos)
{
    colPos = line.rfind(':');
    if (colPos == std::string::npos || colPos == 0) {
        return false;
    }
    linePos = line.rfind(':', colPos - 1);
    if (linePos == std::string::npos) {
        return false;
    }
    return IsAllDigits(line, linePos + 1, colPos) && IsAllDigits(line, colPos + 1, line.size());
}

// 从一行 file:line:col 文本填充 res 的源码位置；从右侧解析 line 与 column，兼容路径含冒号。
void FillLocation(const std::string& line, size_t colPos, size_t linePos, SourceLocation& res)
{
    res.srcFile = line.substr(0, linePos);
    res.srcLine = ParseDecU32(line.substr(linePos + 1, colPos - linePos - 1));
    res.srcColumn = ParseDecU32(line.substr(colPos + 1));
    res.ok = (res.srcFile != UNKNOWN_MARK) && !res.srcFile.empty();
}

// 解析单偏移输出：不依赖空行数量或块边界——空行只是输出内容，不承担结果分隔职责；
// 首条位置行填 innermost（最内层帧），每条位置行覆盖 outermost（末条胜出=最外层帧）。
// llvm-symbolizer 默认内联帧序为 innermost-first（19.1.7 实测）；双帧保留使版本差异不丢信息，仅可能标签互换。
void ParseSingleResult(const std::string& output, SymbolizeResult& res)
{
    std::istringstream iss(output);
    std::string line;
    bool hasInner = false;
    while (std::getline(iss, line)) {
        size_t colPos = 0;
        size_t linePos = 0;
        if (IsLocationLine(line, colPos, linePos)) {
            if (!hasInner) {
                FillLocation(line, colPos, linePos, res.innermost);
                hasInner = true;
            }
            FillLocation(line, colPos, linePos, res.outermost);
        }
    }
}
} // namespace

// 无换行符的末行若以 \r 结尾（如输出被截断），该 \r 按行尾残留剥离。
std::vector<std::string> KernelSourceSymbolizer::SplitRawOutputForLog(const std::string& output)
{
    std::vector<std::string> chunks;
    size_t off = 0;
    const size_t len = output.size();
    while (off < len) {
        size_t end = output.find('\n', off);
        if (end == std::string::npos) {
            end = len;
        } else {
            ++end; // 包含换行符；off 后续跳至 end 即下一行首
        }
        // 行内容 [off, end) 含换行符时 end-1 为 '\n'，去尾 \r 前先剥掉换行符长度。
        size_t lineEnd = (end > off && output[end - 1] == '\n') ? end - 1 : end;
        if (lineEnd > off && output[lineEnd - 1] == '\r') {
            --lineEnd;
        }
        const size_t lineLen = lineEnd - off;
        if (lineLen == 0) {
            off = end;
            continue;
        }
        // 块内分 chunk
        size_t pos = 0;
        while (pos < lineLen) {
            size_t chunkSize = (lineLen - pos < MAX_LOG_CHUNK_SIZE) ? (lineLen - pos) : MAX_LOG_CHUNK_SIZE;
            // UTF-8 感知切分：切点（本块最后一个字节位置）落在多字节字符的续字节上时回退到字符边界
            // （最多回退 3 字节：4 字节字符至多 3 个续字节；非法序列宁可断字节也不回退到 0，避免死循环）。
            size_t fallback = 0;
            while (chunkSize > 1 && fallback < 3 &&
                   (static_cast<unsigned char>(output[off + pos + chunkSize - 1]) & 0xC0U) == 0x80U) {
                --chunkSize;
                ++fallback;
            }
            chunks.push_back(output.substr(off + pos, chunkSize));
            pos += chunkSize;
        }
        off = end;
    }
    return chunks;
}

#ifdef __ADUMP_LLT
void KernelSourceSymbolizer::ResetLocateCacheForTest()
{
    std::lock_guard<std::mutex> lock(g_locateMutex);
    g_cachedTool.clear();
    g_toolResolved = false;
}
#endif

const std::string& KernelSourceSymbolizer::LocateSymbolizer()
{
    std::lock_guard<std::mutex> lock(g_locateMutex);
    if (g_toolResolved) {
        return g_cachedTool;
    }
    g_cachedTool = ResolveSymbolizerPath();
    g_toolResolved = true;
    return g_cachedTool;
}

bool KernelSourceSymbolizer::IsAvailable() { return !LocateSymbolizer().empty(); }

bool KernelSourceSymbolizer::HasDebugLine(const std::string& oFilePath)
{
    Path path(oFilePath);
    if (!path.RealPath()) {
        IDE_LOGD("HasDebugLine: invalid path %s.", oFilePath.c_str());
        return false;
    }
    FILE* fp = fopen(path.GetCString(), "rb");
    if (fp == nullptr) {
        IDE_LOGD("HasDebugLine: open failed %s.", path.GetCString());
        return false;
    }
    std::string buf;
    char tmp[READ_BUF_SIZE];
    size_t n = 0;
    while ((n = fread(tmp, 1, sizeof(tmp), fp)) > 0) {
        buf.append(tmp, n);
    }
    (void)fclose(fp);
    return ElfHasSection(buf.data(), buf.size(), ".debug_line");
}

bool KernelSourceSymbolizer::Symbolize(
    const std::string& oFilePath, const std::vector<uint64_t>& offsets, std::vector<SymbolizeResult>& results)
{
    results.clear();
    results.resize(offsets.size());
    if (offsets.empty()) {
        return false;
    }
    const std::string& tool = LocateSymbolizer();
    if (tool.empty()) {
        return false;
    }
    // 单 .o 一次校验：无效则整体失败，results 保持占位（默认 unknown）。
    Path path(oFilePath);
    if (oFilePath.empty() || !path.RealPath()) {
        IDE_LOGW("Symbolize: invalid .o path, skip. path=%s.", oFilePath.c_str());
        return false;
    }

    // 逐偏移独立 symbolize：单次失败只丢自身并继续，全部成功（outermost 有效）才返回 true。
    bool allResolved = true;
    size_t consecutiveFailures = 0;
    for (size_t i = 0; i < offsets.size(); ++i) {
        std::ostringstream oss;
        oss << "\"" << path.GetString() << "\" 0x" << std::hex << offsets[i] << "\n";
        if (!RunSymbolizer(tool, oss.str(), offsets[i], results[i])) {
            IDE_LOGW("Symbolize: offset 0x%lx failed, keep unknown and continue.", offsets[i]);
            allResolved = false;
            ++consecutiveFailures;
            if (consecutiveFailures >= MAX_CONSECUTIVE_SYMBOLIZE_FAILURES && i + 1 < offsets.size()) {
                IDE_LOGW(
                    "Symbolize: %zu consecutive failures, skip remaining %zu offsets.", consecutiveFailures,
                    offsets.size() - i - 1);
                break;
            }
            continue;
        }
        consecutiveFailures = 0;
        if (!results[i].outermost.ok) {
            allResolved = false;
        }
    }
    return allResolved;
}

bool KernelSourceSymbolizer::RunSymbolizer(
    const std::string& tool, const std::string& inputLine, uint64_t offset, SymbolizeResult& result)
{
    // 写 stdin 前先忽略 SIGPIPE，子进程早退关闭读端时 write 返回 EPIPE 走降级，而非终止宿主进程。
    IgnoreSigPipeOnce();
    SymbolizerProc proc;
    if (!SpawnSymbolizer(tool, proc)) {
        return false;
    }

    std::string output;
    const bool ok = PumpSymbolizerIo(proc, inputLine, output);
    (void)close(proc.outFd);
    proc.outFd = -1;

    if (!ok) {
        IDE_LOGW(
            "Symbolize: llvm-symbolizer timed out after %ldms for offset 0x%lx, terminate child pid=%d.",
            SYMBOLIZER_TIMEOUT_MS, offset, proc.pid);
    }
    // 回收纳入宽限 deadline：先 SIGTERM 通知、限时等待、必要时 SIGKILL 兜底，
    // 即便子进程关闭 stdout 后仍挂住，也不会在此无界阻塞。
    ReapChild(proc.pid);
    if (!ok) {
        return false;
    }

    // 该偏移的原始输出独立分块打印：日志头带 offset 便于多偏移/多设备场景关联，空行跳过、超长行分块。
    const std::vector<std::string> chunks = SplitRawOutputForLog(output);
    {
        std::lock_guard<std::mutex> lock(g_rawPrintMutex);
        if (!chunks.empty()) {
            IDE_LOGE(
                "[Dump][Exception][Symbolize] llvm-symbolizer raw output for offset 0x%lx (total %zu bytes):", offset,
                output.size());
            for (const std::string& chunk : chunks) {
                IDE_LOGE("%s", chunk.c_str());
            }
        }
    }
    ParseSingleResult(output, result);
    return true;
}

} // namespace Adx
