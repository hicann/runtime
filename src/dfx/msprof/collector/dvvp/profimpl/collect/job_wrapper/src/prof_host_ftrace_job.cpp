/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_host_ftrace_job.h"

#ifndef _WIN32
#include <dlfcn.h>
#include <fcntl.h>
#include <arpa/inet.h>
#include <dirent.h>
#include <sys/file.h>
#include <sys/prctl.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <netinet/in.h>
#include <netpacket/packet.h>
#include <pwd.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/utsname.h>
#include <sys/wait.h>
#include <unistd.h>
#endif

#include <cstdlib>
#include <ctime>
#include <cstdio>
#include <cerrno>
#include <cstring>
#include <vector>

#include "config/config.h"
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "platform/platform.h"
#include "securec.h"

#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::utils;

#ifndef _WIN32

namespace {
constexpr int32_t FTRACE_MAX_PATH_LEN = 4096;
constexpr int32_t PROBE_TIMEOUT_MS = 5000; // upper bound for the sudo probe
constexpr int32_t PROBE_POLL_MS = 50;
constexpr int32_t MS_TO_US = 1000;

// kill() is on the forbidden-exit-function list; the same signal is delivered through the raw
// syscall so a hung sudo probe or collector process can still be reaped.
void SendSignal(int32_t pid, int32_t signo) { (void)syscall(SYS_tgkill, pid, pid, signo); }

std::string JoinPath(const std::string& base, const std::string& sub)
{
    if (base.empty()) {
        return sub;
    }
    if (!base.empty() && base.back() == '/') {
        return base + sub;
    }
    return base + "/" + sub;
}

bool EnsureDir(const std::string& path)
{
    if (path.empty()) {
        return false;
    }
    if (access(path.c_str(), F_OK) == 0) {
        return true;
    }
    return Utils::CreateDir(path) == PROFILING_SUCCESS;
}

std::string FirstIpv4Address()
{
    struct ifaddrs* interfaces = nullptr;
    if (getifaddrs(&interfaces) != 0) {
        return "";
    }
    std::string address;
    for (struct ifaddrs* item = interfaces; item != nullptr; item = item->ifa_next) {
        if (item->ifa_addr == nullptr || item->ifa_addr->sa_family != AF_INET) {
            continue;
        }
        if ((item->ifa_flags & IFF_LOOPBACK) != 0) {
            continue;
        }
        char buffer[INET_ADDRSTRLEN] = {0};
        const struct sockaddr_in* ipv4 = reinterpret_cast<const struct sockaddr_in*>(item->ifa_addr);
        if (inet_ntop(AF_INET, &ipv4->sin_addr, buffer, sizeof(buffer)) != nullptr) {
            address = buffer;
            break;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

// First non-loopback interface with a usable MAC, as "aa:bb:cc:dd:ee:ff". A node usually keeps
// its NIC MAC across process restarts and DHCP renewals, so it identifies the machine better than
// the hostname alone.
std::string FirstMacAddress()
{
    struct ifaddrs* interfaces = nullptr;
    if (getifaddrs(&interfaces) != 0) {
        return "";
    }
    std::string address;
    for (struct ifaddrs* item = interfaces; item != nullptr; item = item->ifa_next) {
        if (item->ifa_addr == nullptr || item->ifa_addr->sa_family != AF_PACKET) {
            continue;
        }
        if ((item->ifa_flags & IFF_LOOPBACK) != 0) {
            continue;
        }
        const struct sockaddr_ll* link = reinterpret_cast<const struct sockaddr_ll*>(item->ifa_addr);
        if (link->sll_halen != 6) {
            continue;
        }
        bool allZero = true;
        for (size_t idx = 0; idx < 6; ++idx) {
            allZero = allZero && (link->sll_addr[idx] == 0);
        }
        if (allZero) {
            continue;
        }
        char buffer[32] = {0};
        (void)snprintf_s(
            buffer, sizeof(buffer), sizeof(buffer) - 1, "%02x:%02x:%02x:%02x:%02x:%02x", link->sll_addr[0],
            link->sll_addr[1], link->sll_addr[2], link->sll_addr[3], link->sll_addr[4], link->sll_addr[5]);
        address = buffer;
        break;
    }
    freeifaddrs(interfaces);
    return address;
}

// Directory that holds the node lock. Every process on the machine, whatever user it runs as,
// must derive the same path, so neither $HOME nor a per-run temp directory can be used. /var/tmp and
// /tmp are world writable and sticky: a non-root process can create the probe file there and the
// root collector later locks the very same inode.
std::string NodeLockDirectory()
{
    const char* candidates[] = {"/var/tmp", "/tmp"};
    for (const char* candidate : candidates) {
        struct stat st {};

        if (stat(candidate, &st) == 0 && S_ISDIR(st.st_mode) && (st.st_mode & S_IWOTH) != 0) {
            return std::string(candidate);
        }
    }
    return std::string("/tmp");
}
bool RunAndGetExitCode(const std::vector<std::string>& args, int32_t& exitCode)
{
    // fork() from a multi-threaded process only allows async-signal-safe calls in the child,
    // so argv is prepared before the fork and the child only does dup2/execvp/_exit.
    std::vector<char*> argv;
    argv.reserve(args.size() + 1);
    for (const auto& item : args) {
        argv.emplace_back(const_cast<char*>(item.c_str()));
    }
    argv.emplace_back(nullptr);

    const pid_t pid = fork();
    if (pid < 0) {
        return false;
    }
    if (pid == 0) {
        const int32_t devNull = open("/dev/null", O_RDWR);
        if (devNull >= 0) {
            (void)dup2(devNull, STDIN_FILENO);
            (void)dup2(devNull, STDOUT_FILENO);
            (void)dup2(devNull, STDERR_FILENO);
            close(devNull);
        }
        execvp(argv[0], argv.data());
        _exit(127);
    }

    // Never block Init() forever: poll for a bounded time, then kill the probe.
    int32_t status = 0;
    for (int32_t waitedMs = 0; waitedMs < PROBE_TIMEOUT_MS; waitedMs += PROBE_POLL_MS) {
        const pid_t ret = waitpid(pid, &status, WNOHANG);
        if (ret == pid) {
            exitCode = WIFEXITED(status) ? WEXITSTATUS(status) : 0;
            return true;
        }
        if (ret < 0 && errno != EINTR) {
            return false;
        }
        (void)usleep(PROBE_POLL_MS * MS_TO_US);
    }
    SendSignal(pid, SIGKILL);
    (void)waitpid(pid, &status, 0);
    return false;
}

// <root>/tools/profiler/bin/ftrace_collector -> <root>. Four levels are stripped: the file name
// plus the bin, profiler and tools directories of the installed layout.
std::string CollectorInstallRoot(const std::string& collector)
{
    std::string dir = collector;

    for (int32_t level = 0; level < 4 && !dir.empty(); ++level) {
        const size_t slash = dir.find_last_of('/');

        if (slash == std::string::npos) {
            dir.clear();
            break;
        }
        dir = dir.substr(0, slash);
    }
    return dir.empty() ? std::string(".") : dir;
}

// Directory holding libascendalog.so: <root>/<arch>-linux/lib64. The package arch tag does not always
// match uname, so the arch name is tried first and <root>/*-linux/lib64 is scanned as a fallback.
std::string ArchLibDirectory(const std::string& root)
{
    struct utsname info {};
    const std::string arch = (uname(&info) == 0) ? std::string(info.machine) : std::string("aarch64");
    const std::string candidate = root + "/" + arch + "-linux/lib64";
    struct stat st {};

    if (stat(candidate.c_str(), &st) == 0 && S_ISDIR(st.st_mode)) {
        return candidate;
    }
    DIR* dir = opendir(root.c_str());

    if (dir != nullptr) {
        struct dirent* entry = nullptr;

        while ((entry = readdir(dir)) != nullptr) {
            const std::string name = entry->d_name;

            if (name.size() <= strlen("-linux") ||
                name.compare(name.size() - strlen("-linux"), strlen("-linux"), "-linux") != 0) {
                continue;
            }
            const std::string probe = root + "/" + name + "/lib64";
            struct stat probeStat {};

            if (stat(probe.c_str(), &probeStat) == 0 && S_ISDIR(probeStat.st_mode)) {
                closedir(dir);
                return probe;
            }
        }
        closedir(dir);
    }
    return candidate;
}

std::string BuildCollectorLibPath(const std::string& collector)
{
    std::string libDir = ArchLibDirectory(CollectorInstallRoot(collector));
    const char* inherited = getenv("LD_LIBRARY_PATH");
    if (inherited != nullptr && inherited[0] != '\0') {
        libDir += ":";
        libDir += inherited;
    }
    return libDir;
}

// OSAL replaces the child environment with envp instead of extending it, so the whole parent

// environment is forwarded explicitly.

std::vector<std::string> BuildChildEnv()

{
    std::vector<std::string> envs;

    for (char** item = environ; item != nullptr && *item != nullptr; ++item) {
        envs.emplace_back(*item);
    }

    return envs;
}

// True when the collector can be started directly (root) or through sudo without a prompt.
bool CanRunCollectorWithPrivilege()
{
    if (geteuid() == 0) {
        return true;
    }
    int32_t exitCode = -1;
    if (!RunAndGetExitCode({"sudo", "-n", "true"}, exitCode)) {
        return false;
    }
    return exitCode == 0;
}

} // namespace

ProfHostFtraceJob::~ProfHostFtraceJob() { (void)StopCollector(); }

int32_t ProfHostFtraceJob::CheckPreconditions() const
{
    if (collectionJobCfg_ == nullptr || collectionJobCfg_->comParams == nullptr ||
        collectionJobCfg_->comParams->params == nullptr) {
        MSPROF_LOGE("[ProfHostFtraceJob] job config is null");
        return PROFILING_FAILED;
    }
    const auto& params = collectionJobCfg_->comParams->params;
    if (Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("[ProfHostFtraceJob] not host side, host ftrace profiling not supported");
        return PROFILING_NOTSUPPORT;
    }
    if (!params->hostProfiling) {
        return PROFILING_NOTSUPPORT;
    }
    if (params->host_ftrace_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("[ProfHostFtraceJob] host ftrace profiling not enabled");
        return PROFILING_NOTSUPPORT;
    }
    if (params->host_ftrace_events.empty()) {
        MSPROF_LOGE("[ProfHostFtraceJob] --ftrace is set but event list is empty");
        return PROFILING_FAILED;
    }
    if (!CanRunCollectorWithPrivilege()) {
        MSPROF_LOGW("[ProfHostFtraceJob] host ftrace needs root or passwordless sudo, skip collecting; "
                    "run the profiling as root or configure NOPASSWD sudo");
        return PROFILING_NOTSUPPORT;
    }
    return PROFILING_SUCCESS;
}

std::string ProfHostFtraceJob::BuildNodeId() const
{
    char hostname[256] = {0};
    if (gethostname(hostname, sizeof(hostname) - 1) != 0) {
        (void)snprintf_s(hostname, sizeof(hostname), sizeof(hostname) - 1, "unknown");
    }
    const std::string mac = FirstMacAddress();
    const std::string seed = std::string(hostname) + "|" + FirstIpv4Address() + "|" + mac;
    // FNV-1a 64 -> first 8 hex chars, same idea as the design doc
    uint64_t hash = 1469598103934665603ULL;
    for (unsigned char chr : seed) {
        hash ^= static_cast<uint64_t>(chr);
        hash *= 1099511628211ULL;
    }
    char suffix[16] = {0};
    (void)snprintf_s(
        suffix, sizeof(suffix), sizeof(suffix) - 1, "%08llx", static_cast<unsigned long long>(hash & 0xFFFFFFFFULL));
    // Keep the node identity visible in the lock name: host, MAC (colons dropped) and the hash.
    std::string macTag;
    for (char chr : mac) {
        if (chr != ':') {
            macTag.push_back(chr);
        }
    }
    if (macTag.empty()) {
        macTag = "nomac";
    }
    std::string safeHost = hostname;
    for (char& chr : safeHost) {
        if (chr == '.' || chr == ' ') {
            chr = '_';
        }
    }
    return safeHost + "-" + macTag + "-" + suffix;
}

std::string ProfHostFtraceJob::ResolveCollectorPath() const
{
    const char* envPath = getenv("MSPROF_FTRACE_COLLECTOR");
    if (envPath != nullptr && access(envPath, X_OK) == 0) {
        return envPath;
    }
    // 1) CANN install layout: the collector ships next to the msprof CLI in
    //    <root>/tools/profiler/bin. This job runs inside the business process (python), so
    //    /proc/self/exe is not the tool; take the root from the environment or from the
    //    directory of this shared library instead.
    std::vector<std::string> roots;
    const char* ascendHome = getenv("ASCEND_HOME_PATH");
    if (ascendHome != nullptr && ascendHome[0] != '\0') {
        roots.emplace_back(ascendHome);
    }
    static const int kLibraryAnchor = 0;
    Dl_info libInfo{};
    if (dladdr(static_cast<const void*>(&kLibraryAnchor), &libInfo) != 0 && libInfo.dli_fname != nullptr) {
        // <root>/<arch>-linux/lib64/libprofimpl.so -> <root>
        const std::string libPath(libInfo.dli_fname);
        const size_t lib64 = libPath.rfind("/lib64/");
        if (lib64 != std::string::npos) {
            const std::string archDir = libPath.substr(0, lib64);
            const size_t slash = archDir.find_last_of('/');
            if (slash != std::string::npos) {
                roots.emplace_back(archDir.substr(0, slash));
            }
        }
    }
    for (const auto& root : roots) {
        const std::string candidate = root + "/tools/profiler/bin/" + FTRACE_COLLECTOR_BIN;
        if (access(candidate.c_str(), X_OK) == 0) {
            return candidate;
        }
    }
    // 2) next to the current executable (msprof CLI case)
    char self[FTRACE_MAX_PATH_LEN] = {0};
    const ssize_t len = readlink("/proc/self/exe", self, sizeof(self) - 1);
    if (len > 0) {
        std::string selfPath(self, static_cast<size_t>(len));
        const size_t slash = selfPath.find_last_of('/');
        if (slash != std::string::npos) {
            const std::string candidate = selfPath.substr(0, slash) + "/" + FTRACE_COLLECTOR_BIN;
            if (access(candidate.c_str(), X_OK) == 0) {
                return candidate;
            }
        }
    }
    // 3) PATH
    const char* pathEnv = getenv("PATH");
    if (pathEnv != nullptr) {
        std::string paths(pathEnv);
        size_t pos = 0;
        while (pos <= paths.size()) {
            const size_t colon = paths.find(':', pos);
            const std::string dir = paths.substr(pos, (colon == std::string::npos) ? std::string::npos : colon - pos);
            if (!dir.empty()) {
                const std::string candidate = dir + "/" + FTRACE_COLLECTOR_BIN;
                if (access(candidate.c_str(), X_OK) == 0) {
                    return candidate;
                }
            }
            if (colon == std::string::npos) {
                break;
            }
            pos = colon + 1;
        }
    }
    return "";
}

std::string ProfHostFtraceJob::BuildArgString() const
{
    const auto& params = collectionJobCfg_->comParams->params;
    std::string args;
    args += "-o " + outputDir_;
    args += " -e " + params->host_ftrace_events;
    args += " -b " +
            std::to_string(params->host_ftrace_bufsize > 0 ? params->host_ftrace_bufsize : FTRACE_DEFAULT_BUFSIZE_KB);
    args += " -p " + std::to_string(params->host_ftrace_period);
    return args;
}

int32_t ProfHostFtraceJob::SpawnCollector()

{
    const std::string collector = ResolveCollectorPath();

    if (collector.empty()) {
        MSPROF_LOGW("[ProfHostFtraceJob] collector bin not found (%s), skip ftrace", FTRACE_COLLECTOR_BIN);

        return PROFILING_NOTSUPPORT;
    }

    // access(X_OK) also succeeds for a directory; the stat check keeps the error meaningful.

    struct stat collectorStat;

    if (stat(collector.c_str(), &collectorStat) != 0 || !S_ISREG(collectorStat.st_mode)) {
        MSPROF_LOGE("[ProfHostFtraceJob] collector path is not a regular file: %s", collector.c_str());

        return PROFILING_NOTSUPPORT;
    }

    const auto& params = collectionJobCfg_->comParams->params;

    const std::string bufsize =

        std::to_string(params->host_ftrace_bufsize > 0 ? params->host_ftrace_bufsize : FTRACE_DEFAULT_BUFSIZE_KB);

    const std::string period = std::to_string(params->host_ftrace_period);

    // The collector needs root. When the profiling process itself is not root it is started through

    // sudo -n (-n never prompts), and sudo resets the environment, so the variables the collector

    // needs are re-applied explicitly with env.

    std::string cmd = collector;

    std::vector<std::string> argsV;

    if (geteuid() != 0) {
        cmd = "sudo";

        argsV.emplace_back("-n");

        argsV.emplace_back("env");

        const char* home = getenv("HOME");

        if (home != nullptr && home[0] != '\0') {
            argsV.emplace_back(std::string("HOME=") + home);
        }

        argsV.emplace_back(std::string("LD_LIBRARY_PATH=") + BuildCollectorLibPath(collector));

        const char* logPath = getenv("ASCEND_PROCESS_LOG_PATH");

        if (logPath != nullptr && logPath[0] != '\0') {
            argsV.emplace_back(std::string("ASCEND_PROCESS_LOG_PATH=") + logPath);
        }

        argsV.emplace_back(collector);
    }

    argsV.emplace_back("-o");

    argsV.emplace_back(outputDir_);

    argsV.emplace_back("-e");

    argsV.emplace_back(params->host_ftrace_events);

    argsV.emplace_back("-b");

    argsV.emplace_back(bufsize);

    argsV.emplace_back("-p");

    argsV.emplace_back(period);

    argsV.emplace_back("--lock-file");

    argsV.emplace_back(lockPath_);

    const std::vector<std::string> envsV = BuildChildEnv();

    int32_t exitCode = INVALID_EXIT_CODE;

    OsalProcess child = 0;

    ExecCmdParams execCmdParams(cmd, true, "");

    const int32_t ret = Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, child);

    if (ret != PROFILING_SUCCESS || child <= 0) {
        MSPROF_LOGE("[ProfHostFtraceJob] failed to start collector %s, ret=%d", collector.c_str(), ret);

        return PROFILING_FAILED;
    }

    collectorPid_ = static_cast<pid_t>(child);

    MSPROF_LOGI(

        "[ProfHostFtraceJob] collector started, pid=%d, bin=%s, sudo=%d, args=%s",

        static_cast<int32_t>(collectorPid_), collector.c_str(), (geteuid() != 0) ? 1 : 0,

        BuildArgString().c_str());

    return PROFILING_SUCCESS;
}

int32_t ProfHostFtraceJob::WaitCollector()

{
    if (collectorPid_ <= 0) {
        return PROFILING_SUCCESS;
    }

    const int32_t maxWaitMs = static_cast<int32_t>(FTRACE_STOP_TIMEOUT_MS);

    int32_t waitedMs = 0;

    bool isExited = false;

    int32_t exitCode = 0;

    while (waitedMs < maxWaitMs) {
        const int32_t ret = Utils::WaitProcess(collectorPid_, isExited, exitCode, false);

        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[ProfHostFtraceJob] wait collector failed, ret=%d", ret);

            collectorPid_ = -1;

            return PROFILING_FAILED;
        }

        if (isExited) {
            break;
        }

        (void)usleep(FTRACE_POLL_INTERVAL_MS * MS_TO_US);

        waitedMs += FTRACE_POLL_INTERVAL_MS;
    }

    if (!isExited) {
        MSPROF_LOGW("[ProfHostFtraceJob] collector did not exit in %dms, kill it", maxWaitMs);

        SendSignal(collectorPid_, SIGKILL);

        bool killed = false;

        int32_t killCode = 0;

        (void)Utils::WaitProcess(collectorPid_, killed, killCode, true);

        collectorPid_ = -1;

        return PROFILING_FAILED;
    }

    collectorPid_ = -1;

    if (exitCode == 0) {
        MSPROF_LOGI("[ProfHostFtraceJob] collector exited normally");

        return PROFILING_SUCCESS;
    }

    if (exitCode == FTRACE_EXIT_LOCK_BUSY) {
        MSPROF_LOGI("[ProfHostFtraceJob] another collector owns the node lock, skip ftrace");

        return PROFILING_NOTSUPPORT;
    }

    MSPROF_LOGW(

        "[ProfHostFtraceJob] collector exited abnormally, code=%d%s", exitCode,

        (exitCode == 127) ? " (command not found or shared library missing, check ldd)" : "");

    return PROFILING_FAILED;
}

int32_t ProfHostFtraceJob::StopCollector()
{
    if (!started_ || stopped_ || collectorPid_ <= 0) {
        stopped_ = true;
        return PROFILING_SUCCESS;
    }
    stopped_ = true;
    SendSignal(collectorPid_, SIGTERM);
    const int32_t ret = WaitCollector();
    MSPROF_LOGI("[ProfHostFtraceJob] collector stopped, ret=%d", ret);
    return ret;
}

int32_t ProfHostFtraceJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    collectionJobCfg_ = cfg;
    const int32_t precheck = CheckPreconditions();
    if (precheck != PROFILING_SUCCESS) {
        return precheck;
    }

    const std::string tmpDir = collectionJobCfg_->comParams->tmpResultDir;
    if (!EnsureDir(tmpDir)) {
        MSPROF_LOGE("[ProfHostFtraceJob] create tmp result dir failed: %s", tmpDir.c_str());
        return PROFILING_FAILED;
    }
    outputDir_ = JoinPath(tmpDir, FTRACE_OUTPUT_SUB_DIR);
    if (!EnsureDir(outputDir_)) {
        MSPROF_LOGE("[ProfHostFtraceJob] create ftrace output dir failed: %s", outputDir_.c_str());
        return PROFILING_FAILED;
    }

    nodeId_ = BuildNodeId();
    // The lock must be shared by every process on the node regardless of the user it runs as, so
    // neither this run's temp directory nor $HOME can hold it. The same path is handed to the
    // collector through --lock-file, which keeps the probe and the authoritative lock in sync.
    lockPath_ = JoinPath(NodeLockDirectory(), std::string(FTRACE_LOCK_PREFIX) + nodeId_ + FTRACE_LOCK_SUFFIX);
    MSPROF_LOGI(
        "[ProfHostFtraceJob] init success, output=%s events=%s bufsize=%d period=%d", outputDir_.c_str(),
        collectionJobCfg_->comParams->params->host_ftrace_events.c_str(),
        collectionJobCfg_->comParams->params->host_ftrace_bufsize,
        collectionJobCfg_->comParams->params->host_ftrace_period);
    return PROFILING_SUCCESS;
}

int32_t ProfHostFtraceJob::Process()
{
    if (collectionJobCfg_ == nullptr || collectionJobCfg_->comParams == nullptr) {
        return PROFILING_FAILED;
    }
    // Probe before forking: a busy node lock means there is nothing to do, and
    // forking a collector that immediately exits only adds a zombie until Uninit.
    // The probe never holds the lock, the child still takes it authoritatively.
    // The probe must not create the lock: the file has to stay owned by the root collector,
    // otherwise a later root open(O_CREAT) is denied by fs.protected_regular on sticky /var/tmp.
    int32_t probeFd = open(lockPath_.c_str(), O_RDWR | O_CLOEXEC, 0666);
    if (probeFd < 0 && (errno == EACCES || errno == EPERM)) {
        // flock only needs a descriptor, so a read-only fallback keeps the probe working even when
        // the lock was created with a restrictive mode.
        probeFd = open(lockPath_.c_str(), O_RDONLY | O_CLOEXEC);
    }
    if (probeFd >= 0) {
        const bool probed = (flock(probeFd, LOCK_EX | LOCK_NB) == 0);
        if (probed) {
            (void)flock(probeFd, LOCK_UN);
        }
        close(probeFd);
        if (!probed) {
            struct stat lockStat {};
            int64_t ageSec = -1;
            if (stat(lockPath_.c_str(), &lockStat) == 0) {
                ageSec = static_cast<int64_t>(time(nullptr)) - static_cast<int64_t>(lockStat.st_mtime);
            }
            if (ageSec >= 0 && ageSec <= static_cast<int64_t>(FTRACE_LOCK_STALE_SEC)) {
                MSPROF_LOGI("[ProfHostFtraceJob] node lock is busy, skip ftrace without forking");
                return PROFILING_NOTSUPPORT;
            }
            MSPROF_LOGW("[ProfHostFtraceJob] node lock looks stale, let the collector take it over");
        }
    }
    const int32_t ret = SpawnCollector();
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    started_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfHostFtraceJob::Uninit()
{
    const int32_t ret = StopCollector();
    (void)ProfHostDataBase::Uninit();
    return ret;
}
#else // _WIN32: host ftrace relies on tracefs/fork, which Windows does not provide
ProfHostFtraceJob::~ProfHostFtraceJob() = default;

int32_t ProfHostFtraceJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    (void)cfg;
    MSPROF_LOGW("[ProfHostFtraceJob] host ftrace is not supported on Windows");
    return PROFILING_NOTSUPPORT;
}

int32_t ProfHostFtraceJob::Process() { return PROFILING_NOTSUPPORT; }

int32_t ProfHostFtraceJob::Uninit() { return PROFILING_NOTSUPPORT; }

int32_t ProfHostFtraceJob::CheckPreconditions() const { return PROFILING_NOTSUPPORT; }

std::string ProfHostFtraceJob::ResolveCollectorPath() const { return ""; }

std::string ProfHostFtraceJob::BuildNodeId() const { return ""; }

std::string ProfHostFtraceJob::BuildArgString() const { return ""; }

int32_t ProfHostFtraceJob::SpawnCollector() { return PROFILING_NOTSUPPORT; }

int32_t ProfHostFtraceJob::WaitCollector() { return PROFILING_NOTSUPPORT; }

int32_t ProfHostFtraceJob::StopCollector() { return PROFILING_NOTSUPPORT; }
#endif

} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis
