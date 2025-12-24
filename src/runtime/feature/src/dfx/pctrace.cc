/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "pctrace.hpp"
#include "mmpa/mmpa_api.h"
#include "securec.h"
#include "runtime.hpp"
#include "module.hpp"
#include "error_message_manage.hpp"

namespace {
constexpr char_t const *PC_TRACE_FILE_NAME = "/home/ascend/pctrace/pctraceFile";
}

namespace cce {
namespace runtime {
PCTrace::~PCTrace()
{
    (void)FreePCTraceMemory();
    if ((device_ != nullptr) && (module_ != nullptr)) {
        (void)device_->ModuleRelease(module_);
    }
}

rtError_t PCTrace::Init(Device * const dev, Module * const mdl)
{
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODULE_NULL);
    device_ = dev;
    module_ = mdl;
    (void)device_->ModuleRetain(module_);
    return RT_ERROR_NONE;
}

rtError_t PCTrace::WritePCTraceFile()
{
    const rtError_t error = RT_ERROR_NONE;
    RT_LOG(RT_LOG_INFO, "WritePCTraceFile:Task done!");
    constexpr int32_t len = 128;
    char_t filename[len] = {};
    // get pctrace file length from base addr
    const uint64_t pctraceFileAddr = tspctrace_.pctraceAddr;
    COND_RETURN_ERROR_MSG_INNER(pctraceFileAddr == 0U, RT_ERROR_PCTRACE_FILE,
        "Write pc trace file failed, pctrace address is NULL.");

    RT_LOG(RT_LOG_INFO, "write pc trace file start, first flush!");
    (void)device_->Driver_()->DevMemFlushCache(pctraceFileAddr, sizeof(uint64_t));
    const uint32_t pcTraceFileLen =
            static_cast<uint32_t>(*(RtValueToPtr<uint64_t *>(pctraceFileAddr)));
    if (pcTraceFileLen > tspctrace_.pctraceAddrSize) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "PC trace file length=%u can't bigger than PC trace address size=%" PRIu64,
            pcTraceFileLen, tspctrace_.pctraceAddrSize);
        return RT_ERROR_PCTRACE_FILE;
    }

    (void)device_->Driver_()->DevMemFlushCache(pctraceFileAddr,
        static_cast<size_t>(pcTraceFileLen));

    mmSystemTime_t currentTime;
    if (mmGetLocalTime(&currentTime) != EN_OK) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "mmGetLocalTime error.");
        return RT_ERROR_PCTRACE_TIME;
    }

    const int32_t ret = sprintf_s(filename, static_cast<size_t>(len), "%s_%d%02d%02d%02d%02d%02d%" PRId64 ".bin",
        PC_TRACE_FILE_NAME, currentTime.wYear, currentTime.wMonth, currentTime.wDay, currentTime.wHour,
        currentTime.wMinute, currentTime.wSecond, currentTime.wMilliseconds * 1000);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret == -1, RT_ERROR_PCTRACE_TIME,
        "Write pc trace file failed, sprintf_s failed, len=%d, retCode=%d", len, ret);

    auto fd = mmOpen2(filename, M_CREAT | M_WRONLY, M_UMASK_USRREAD | M_UMASK_USRWRITE);
    if (fd == -1) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "Open file failed, filename=%s.", filename);
        return RT_ERROR_PCTRACE_FILE;
    }

    mmSsize_t writeRet = mmWrite(fd, &tspctrace_.baseAddr, sizeof(uint64_t));
    if (writeRet != static_cast<mmSsize_t>(sizeof(uint64_t))) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "Write baseAddr failed, need write size=%zu, writeRet=%zd.",
            sizeof(uint64_t), writeRet);
        (void) mmClose(fd);
        fd = -1;
        return RT_ERROR_PCTRACE_FILE;
    }
    writeRet = mmWrite(fd, RtValueToPtr<void *>(pctraceFileAddr), pcTraceFileLen);
    if (writeRet != static_cast<mmSsize_t>(pcTraceFileLen)) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "Write pcTraceFile failed, need write size=%u, writeRet=%zd.",
            pcTraceFileLen, writeRet);
        (void) mmClose(fd);
        fd = -1;
        return RT_ERROR_PCTRACE_FILE;
    }
    (void) mmClose(fd);
    fd = -1;
    RT_LOG(RT_LOG_INFO, "Write file end, pcTraceFileLen=%d", pcTraceFileLen);
    return error;
}

rtError_t PCTrace::AllocPCTraceMemory(void **addr, uint64_t addrSize)
{
    RT_LOG(RT_LOG_INFO, "AllocPCTraceMemory:Alloc memory start");
    void *addrTempt = nullptr;

    rtError_t error = device_->Driver_()->DevMemAllocForPctrace(&addrTempt, addrSize, device_->Id_());
    ERROR_RETURN_MSG_INNER(error, "Alloc pctrace memory failed, size=%" PRIu64 ", retCode=%#x!",
                           addrSize, static_cast<uint32_t>(error));

    const errno_t ret = memset_s(addrTempt, addrSize, 0, addrSize);
    if (ret != EOK) {
        error = device_->Driver_()->DevMemFreeForPctrace(addrTempt);
        ERROR_RETURN_MSG_INNER(error, "Free pctrace memory failed, retCode=%#x!", static_cast<uint32_t>(error));
        return RT_ERROR_SEC_HANDLE;
    }

    (void)device_->Driver_()->DevMemFlushCache(RtPtrToValue(addrTempt), static_cast<size_t>(addrSize));

    tspctrace_.pctraceAddr = RtPtrToValue(addrTempt);
    *addr = addrTempt;

    tspctrace_.pctraceAddrSize = addrSize;
    tspctrace_.baseAddr = RtPtrToValue(module_->GetBaseAddr());
    return RT_ERROR_NONE;
}

rtError_t PCTrace::FreePCTraceMemory()
{
    RT_LOG(RT_LOG_INFO, "FreePCTraceMemory:Free memory start");
    if (device_ == nullptr) {
        RT_LOG(RT_LOG_INFO, "PCTrace is not init,no need free");
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "vir_addr=%" PRIx64 ", addr_size=%" PRIu64, tspctrace_.pctraceAddr, tspctrace_.pctraceAddrSize);
    void * const pcTraceAddr = RtValueToPtr<void *>(tspctrace_.pctraceAddr);
    if (pcTraceAddr == nullptr) {
        RT_LOG(RT_LOG_INFO, "PCTrace addr is null,no need free");
        return RT_ERROR_NONE;
    }

    const rtError_t error = device_->Driver_()->DevMemFreeForPctrace(pcTraceAddr);
    ERROR_RETURN_MSG_INNER(error, "Free pctrace mem failed, retCode=%#x!", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}
}
}
