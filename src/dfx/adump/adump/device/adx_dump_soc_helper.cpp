/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adx_dump_soc_helper.h"
#include <dlfcn.h>
#include <atomic>
#include "adx_dump_record.h"
#include "adx_datadump_callback.h"
#include "memory_utils.h"
#include "common_utils.h"
#include "log/adx_log.h"
#include "string_utils.h"
#include "adx_datadump_server_soc.h"

// device 库侧的 host 直调解析（判定口径：host 库是否在本进程；否则一律走 HDC，EP/MDC 同路）。
// 快路径弱符号 AdumpHandleDumpRequest：host 库先于 device 库加载时由加载期重定位绑定，零开销；
// 未绑定（device 库先加载，GOT 已填 0 且不回填）走慢路径 dlopen(RTLD_NOLOAD) 查已加载表兜底。
// 弱符号不产生 DT_NEEDED 动态依赖，"device 库不依赖 host 库"的约束成立。
// 【检视修复】慢路径解析成功即缓存原子指针（host 库常驻不卸载，地址不变）；RTLD_NOLOAD 命中
// 同样 +1 引用计数，dlsym 后统一 dlclose 归还；失败不缓存，保留 host 库晚加载时的重试语义。
namespace {
constexpr char HOST_DUMP_LIB[] = "libascend_dump.so";
constexpr char HOST_DUMP_ENTRY[] = "AdumpHandleDumpRequest";
using AdumpHandleDumpRequestFunc = int32_t (*)(const struct IdeDumpChunk*);
std::atomic<bool> g_hostEntryLogged{false}; // 仅用于日志去重，不参与判定
// 慢路径解析结果缓存（仅成功值，nullptr=未解析过）：失败不缓存，host 库可能晚于首次探测加载。
std::atomic<AdumpHandleDumpRequestFunc> g_hostEntryCache{nullptr};
} // namespace

// host 库导出的统一处理入口（host 侧 adx_dump_receive.h 定义；两侧解耦不链头，此处等价重声明）。
// 弱符号语义：同进程内 host 库在 device 库加载前已就位 → 非空；否则恒为 null（由慢路径兜底）。
extern "C" int32_t AdumpHandleDumpRequest(const struct IdeDumpChunk* dumpChunk) __attribute__((weak));

// 取 host 直调入口（仅数据回传新 flag 走，老分片仍走本地落盘零改动）。
// 返回 nullptr = 本进程无 host 库（EP/MDC）或老 host 库无此符号——aicpu 回退 HDC 老链路。
AdumpHandleDumpRequestFunc GetHostDumpEntry()
{
    // 快路径：弱符号已绑定 ⇔ host 库在 device 库加载前已就位（SOC 常态）
    if (AdumpHandleDumpRequest != nullptr) {
        if (!g_hostEntryLogged.exchange(true)) {
            IDE_LOGI("host dump entry bound in-process (SOC), flag-driven requests go direct.");
        }
        return AdumpHandleDumpRequest;
    }

    // 次快路径：慢路径曾解析成功过，直接用缓存
    const AdumpHandleDumpRequestFunc cached = g_hostEntryCache.load(std::memory_order_acquire);
    if (cached != nullptr) {
        return cached;
    }

    // 慢路径兜底：RTLD_NOLOAD 只查不加载（MDC 下未加载 ⇒ 返回空 ⇒ 判定非本进程）
    void* handle = dlopen(HOST_DUMP_LIB, RTLD_NOW | RTLD_NOLOAD);
    if (handle == nullptr) {
        if (!g_hostEntryLogged.exchange(true)) {
            IDE_LOGI("host dump lib not loaded in this process, keep hdc path.");
        }
        return nullptr;
    }
    dlerror();
    void* sym = dlsym(handle, HOST_DUMP_ENTRY);
    (void)dlclose(handle); // 归还 NOLOAD 引用计数；符号指针由库的原加载引用保活
    handle = nullptr;
    if (sym == nullptr) {
        if (!g_hostEntryLogged.exchange(true)) {
            IDE_LOGW("symbol %s not found in %s, old host lib, aicpu falls back.", HOST_DUMP_ENTRY, HOST_DUMP_LIB);
        }
        return nullptr;
    }
    if (!g_hostEntryLogged.exchange(true)) {
        IDE_LOGI("host dump entry resolved via dlopen fallback (SOC, weak symbol unbound), go direct.");
    }
    const AdumpHandleDumpRequestFunc entry = reinterpret_cast<AdumpHandleDumpRequestFunc>(sym);
    g_hostEntryCache.store(entry, std::memory_order_release);
    return entry;
}

// device 库侧新 flag 分流：新 flag（REQ_WITH_ID/REQ_WITH_OPINFO/CHECKSUPPORT）先试 host 直调，
// 不支持则原路返回错误码（aicpu 收到后回退 HDC 老链路）；老 flag（NONE/FILE_CHUNK）零改动走本地落盘。
bool ShouldTryHostDirect(const IdeDumpChunk& dumpChunk)
{
    return (dumpChunk.flag == IDE_DUMP_CHECKSUPPORT) || (dumpChunk.flag == IDE_DUMP_REQ_WITH_ID) ||
           (dumpChunk.flag == IDE_DUMP_REQ_WITH_OPINFO);
}
namespace Adx {
AdxDumpSocHelper::AdxDumpSocHelper() {}

AdxDumpSocHelper::~AdxDumpSocHelper() { UnInit(); }

/**
 * @brief      parse connect info
 * @param [in] connectInfo: string of connect info
 *
 * @return
 *      IDE_DAEMON_NONE_ERROR: parse connect info success
 *      IDE_DAEMON_INVALID_PARAM_ERROR: parse connect info failed
 */
IdeErrorT AdxDumpSocHelper::ParseConnectInfo(const std::string& connectInfo) const
{
    std::string hostId;
    std::string hostPid;
    bool ret = StringUtils::ParseConnectInfo(connectInfo, hostId, hostPid);
    IDE_CTRL_VALUE_FAILED(ret == true, return IDE_DAEMON_INVALID_PARAM_ERROR, "ParseConnectInfo failed");
    return IDE_DAEMON_NONE_ERROR;
}

bool AdxDumpSocHelper::Init(const std::string& hostPid)
{
    if (!init_.test_and_set()) {
        if (AdxSocDataDumpInit(hostPid) == IDE_DAEMON_ERROR) {
            init_.clear();
            return false;
        }
    }
    return true;
}

void AdxDumpSocHelper::UnInit()
{
    if (init_.test_and_set()) {
        AdxSocDataDumpUnInit();
        init_.clear();
    }
}

IdeErrorT AdxDumpSocHelper::HandShake(const std::string& info, IDE_SESSION& session) const
{
    IdeErrorT err = ParseConnectInfo(info);
    if (err == IDE_DAEMON_NONE_ERROR) {
        session = DEFAULT_SOC_SESSION;
    }
    IDE_LOGD("soc handshake success");
    return err;
}

IdeErrorT AdxDumpSocHelper::DataProcess(const IDE_SESSION& session, const IdeDumpChunk& dumpChunk) const
{
    UNUSED(session);
    // 新 flag 走 host 直调；无 host 库回 CHANNEL_ERROR，aicpu 按"不支持"回退 HDC 老链路；
    // 老 flag（NONE/FILE_CHUNK）走本地落盘
    if (ShouldTryHostDirect(dumpChunk)) {
        AdumpHandleDumpRequestFunc hostEntry = GetHostDumpEntry();
        if (hostEntry != nullptr) {
            // CHECKSUPPORT 特判：SOC 直调无应答通道，弱符号已绑定本进程即是能力答案。
            // 前提：host 侧能力集当前为编译期常量（两项全开），"符号在"与"位图 ⊇ 请求位"等价；
            // 若 host 位图将来改为按开关/形态部分开放，此处需改为透传请求位做交集判定。
            if (dumpChunk.flag == IDE_DUMP_CHECKSUPPORT) {
                IDE_LOGI("soc checksupport: host entry in-process, reply supported directly.");
                return IDE_DAEMON_NONE_ERROR;
            }
            const int32_t hostRet = hostEntry(&dumpChunk);
            IDE_LOGI("host direct dump request ret: %d, flag: %d.", hostRet, dumpChunk.flag);
            return static_cast<IdeErrorT>(hostRet);
        }
        IDE_LOGW("host direct entry unavailable (not in-process or old lib), flag: %d.", dumpChunk.flag);
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    uint32_t dataLen = 0;
    // 老 flag 为文件分片：fileName 必须是真实路径（先判空再查首字符，顺序不可颠倒）
    IDE_CTRL_VALUE_FAILED(
        dumpChunk.fileName != nullptr && dumpChunk.fileName[0] != '\0', return IDE_DAEMON_INVALID_PARAM_ERROR,
        "fileName is null or empty");
    IDE_CTRL_VALUE_FAILED(dumpChunk.dataBuf != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "dataBuf is null");
    IDE_CTRL_VALUE_FAILED(dumpChunk.bufLen > 0, return IDE_DAEMON_INVALID_PARAM_ERROR, "bufLen is 0");
    IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(
        sizeof(DumpChunk), dumpChunk.bufLen, dataLen, return IDE_DAEMON_INTERGER_REVERSED_ERROR);
    DumpChunk* data = reinterpret_cast<DumpChunk*>(IdeXmalloc(dataLen));
    IDE_CTRL_VALUE_FAILED(data != nullptr, return IDE_DAEMON_MALLOC_ERROR, "malloc failed");
    std::unique_ptr<DumpChunk, decltype(&IdeXfree)> dataPtr(data, IdeXfree);
    IDE_CTRL_VALUE_FAILED(
        strnlen(dumpChunk.fileName, MAX_FILE_PATH_LENGTH) < MAX_FILE_PATH_LENGTH, return IDE_DAEMON_INVALID_PATH_ERROR,
        "fileName is too long or not null-terminated, max=%u", MAX_FILE_PATH_LENGTH);
    int32_t err = strcpy_s(data->fileName, MAX_FILE_PATH_LENGTH, dumpChunk.fileName);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_INVALID_PATH_ERROR, "copy file name failed, err=%d", err);
    data->bufLen = dumpChunk.bufLen;
    data->flag = dumpChunk.flag;
    data->isLastChunk = dumpChunk.isLastChunk;
    data->offset = dumpChunk.offset;
    IDE_LOGI(
        "dataLen: %u, bufLen: %u, flag: %d, isLastChunk: %u, offset: %ld, fileName: %s", dataLen, data->bufLen,
        data->flag, data->isLastChunk, data->offset, data->fileName);
    err = memcpy_s(data->dataBuf, data->bufLen, dumpChunk.dataBuf, dumpChunk.bufLen);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_UNKNOW_ERROR, "memcpy_s data buffer failed");
    bool ret = AdxDumpRecord::Instance().RecordDumpDataToDisk(*data);
    IDE_CTRL_VALUE_FAILED(ret, return IDE_DAEMON_WRITE_ERROR, "record dump data to disk failed");
    IDE_LOGD("dump data process normal");
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT AdxDumpSocHelper::Finish(IDE_SESSION& session) const
{
    session = nullptr;
    return IDE_DAEMON_NONE_ERROR;
}

/**
 * @brief dump start api,create a HDC session for dump
 * @param [in] connectInfo: remote connect info
 *
 * @return
 *      not NULL: Handle used by hdc
 *      NULL:     dump start failed
 */
IDE_SESSION SocDumpStart(const char* connectInfo)
{
    IDE_LOGI("Soc dump start, connectInfo: %s", connectInfo);
    std::string connectInfoStr = connectInfo;
    std::string::size_type idx = connectInfoStr.find_last_of(";");
    if (idx == std::string::npos) {
        IDE_LOGE("invalid info str: %s", connectInfoStr.c_str());
        return nullptr;
    }
    std::string hostPid = connectInfoStr.substr(idx + 1);
    if (!Adx::AdxDumpSocHelper::Instance().Init(hostPid)) {
        return nullptr;
    }
    IDE_SESSION session = nullptr;
    Adx::AdxDumpSocHelper::Instance().HandShake(std::string(connectInfo), session);
    return session;
}

/**
 * @brief dump data to remote server
 * @param [in] session: HDC session to dump data
 * @param [in] dumpChunk: Dump information
 * @return
 *      IDE_DAEMON_INVALID_PARAM_ERROR: invalid parameter
 *      IDE_DAEMON_UNKNOW_ERROR: write data failed
 *      IDE_DAEMON_NONE_ERROR:   write data succ
 *      IDE_DAEMON_WRITE_ERROR: write file failed
 *      IDE_DAEMON_MALLOC_ERROR: malloc memory failed
 *      IDE_DAEMON_INVALID_PATH_ERROR:  invalid dump path
 *      IDE_DAEMON_INTERGER_REVERSED_ERROR: integer overflow
 */
IdeErrorT SocDumpData(const IDE_SESSION session, const IdeDumpChunk* dumpChunk)
{
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_CTRL_VALUE_FAILED(dumpChunk != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "IdeDumpChunk is nullptr");
    IDE_LOGD("dump data process entry");
    IdeErrorT ret = Adx::AdxDumpSocHelper::Instance().DataProcess(session, *dumpChunk);
    IDE_LOGD("dump data process exit");
    return ret;
}

/**
 * @brief send dump end msg
 * @param [in] session: HDC session to dump data
 * @return
 *      IDE_DAEMON_UNKNOW_ERROR: send dump end msg failed
 *      IDE_DAEMON_NONE_ERROR:   send dump end msg success
 */
IdeErrorT SocDumpEnd(IDE_SESSION session)
{
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_LOGI("dump data finish");
    return Adx::AdxDumpSocHelper::Instance().Finish(session);
}
} // namespace Adx
