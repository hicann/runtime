/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COLLECTOR_DVVP_ACP_MANAGER_H
#define COLLECTOR_DVVP_ACP_MANAGER_H

#include <mutex>
#include "runtime/rt.h"
#include "singleton/singleton.h"
#include "acp_compute_device_job.h"
#include "acp_api_plugin.h"

namespace Collector {
namespace Dvvp {
namespace Acp {

using namespace analysis::dvvp::transport;
using RtDevBinary = rtDevBinary_t;
struct AcpDevBinary {
    uint32_t magic{0};                      // magic number
    uint32_t version{0};                    // version of binary
    uint64_t length{0};
    std::vector<uint8_t> data;
    VOID_PTR baseAddr{nullptr};
};

struct AcpBackupAttr {
    void* addr;
    uint64_t size;
    uint32_t type;
    uint16_t moduleId;
};

class AcpManager : public analysis::dvvp::common::singleton::Singleton<AcpManager> {
public:
    AcpManager();
    ~AcpManager() override;
    int32_t Init(int32_t devId);
    void UnInit();
    int32_t TaskStart();
    void SetTaskBlockDim(const uint32_t blockDim);
    int32_t TaskStop();
    // pc sampling
    void AddBinary(VOID_PTR handle, const RtDevBinary &binary);
    void RemoveBinary(VOID_PTR handle);
    void DumpBinary(VOID_PTR handle);
    void AddBinaryBaseAddr(VOID_PTR handle, VOID_PTR baseAddr);
    void SaveBinaryHandle(VOID_PTR &handle);
    VOID_PTR GetBinaryHandle() const;
    bool PcSamplingIsEnable() const;
    std::string GetBinaryObjectPath() const;
    // kernel replay
    uint32_t GetKernelReplayTime() const;
    void SetKernelReplayMetrics(const uint32_t time);
    void SaveMallocMemory(rtStream_t stream);
    void ResetMallocMemory(rtStream_t stream);
    void ClearMallocMemory();
    void RegisterRtMemcpyFunc(RtMemcpyAsyncFunc memcpyAsyncFunc);
    // rtMalloc and rtFree
    void RegisterRtMallocFunc(RtMallocFunc mallocFunc, RtFreeFunc freeFunc);
    void SaveRtMallocAttr(AcpBackupAttr &attr);
    void ReleaseRtMallocAddr(const void* ptr);

private:
    int32_t NotifyRtSwitchConfig(MsprofCommandHandleType connamdType);
    int32_t InitAcpUploader();
    int32_t JobStart();
    int32_t SaveBasicOpInfo(SHARED_PTR_ALIA<Uploader> uploader);
    int32_t JobStop();
    int32_t GetAndCheckParams(int32_t devId);
    void SetDefaultParams(int32_t devId);
    void HandleAcpMetrics();
    void ClearMallocAddr();
    // rtMalloc and rtFree
    void SaveRtMallocMemory(rtStream_t stream);
    void ResetRtMallocMemory(rtStream_t stream);
    void ClearRtMallocMemory();
    void ClearRtMallocAddr();

private:
    uint32_t blockDim_;
    VOID_PTR binaryHandle_;
    std::string binaryObjectPath_;
    SHARED_PTR_ALIA<AcpComputeDeviceJob> jobAdapter_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
    std::mutex binaryMtx_;
    std::map<VOID_PTR, AcpDevBinary> devBinaryMap_;
    std::vector<AcpBackupAttr> mallocVec_;
    std::vector<AcpBackupAttr> memoryVec_;
    std::vector<std::string> metrics_;
    RtMallocFunc rtMallocFunc_;
    RtFreeFunc rtFreeFunc_;
    RtMemcpyAsyncFunc rtMemcpyAsyncFunc_;
};
}
}
}
#endif