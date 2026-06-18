/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device/device_error_proc.hpp"
#include <memory>
#include <string>
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "task_submit.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "stream_sqcq_manage.hpp"
#include "stub_task.hpp"
#include "context_manage.hpp"
#include "davinci_kernel_task.h"
#include "npu_driver.hpp"
#include "ringbuffer_maintain_task.h"

namespace cce {
namespace runtime {

// alloc a huge page size

const std::map<uint64_t, DeviceErrorProc::ErrorInfoProc> DeviceErrorProc::funcMap_ = {
    {AICORE_ERROR, &DeviceErrorProc::ProcessCoreErrorInfo},
    {AIVECTOR_ERROR, &DeviceErrorProc::ProcessCoreErrorInfo},
    {SDMA_ERROR,   &DeviceErrorProc::ProcessSdmaErrorInfo},
    {AICPU_ERROR,  &DeviceErrorProc::ProcessAicpuErrorInfo}
};
AicErrorInfo DeviceErrorProc::error_pc[MAX_DEV_ID] = {{}};

const std::map<uint64_t, std::string> DeviceErrorProc::errMsgCommMap_ = {
    {AICORE_ERROR, RT_NPU_COMMON_INNER_ERROR},
    {AIVECTOR_ERROR, RT_NPU_COMMON_INNER_ERROR},
    {AICPU_ERROR, RT_AICPU_INNER_ERROR}};

const std::map<uint64_t, std::string> DeviceErrorProc::cqeErrorMapInfo_ = {
    {0,  "SUCCESS"},
    {1,  "One of the following errors may occur: 1)Submission Descriptor read response error, "
         "2)Invalid OPCODE in the SQE."},
    {2,  "When the SQE translates a page table, the SMMU returns a Terminate error."},
    {3,  "Reserved."},
    {4,  "An error reported by the SDMA: can't access the DDR space."},
    {5,  "An error is reported by the SDMA: the transfer address delivered by the SDMA is not mapped in the DAW."},
    {6,  "An error is reported by the SDMA: the operation type is incorrect."},
    {7,  "An error is reported by the SDMA: a DDRC error occurs during the SDMA transfer."},
    {8,  "An error is reported by the SDMA: an ECC error occurs during the SDMA transfer."},
    {9,  "An error is reported by the SDMA: a COMPERR error occurs during the SDMA transfer."},
    {10, "An error is reported by the SDMA: a COMPDATAERR error occurs during the SDMA transfer."},
    {11, "An error is reported by the SDMA: an overflow error occurs during the reduce operation."},
    {12, "An error is reported by the SDMA: an underflow error occurs during the reduce operation."},
    {13, "An error is reported by the SDMA: the format of the reduce source data does not meet requirements."},
    {14, "An error is reported by the SDMA: the format of the reduce destination data does not meet requirements."},
    {15, "An error is reported by the SDMA: "
         "the formats of the reduce source and destination data do not meet requirements."},
};

const std::map<uint64_t, std::string> DeviceErrorProc::channelErrorMapInfo_ = {
    {SDMA_SQE_READ_RSP_ERR, "Submission Descriptor read response error."},
    {SDMA_SMMU_TERMINATE, "The SMMU returns a Terminate error during page table translation."},
    {SDMA_DMAA_ERR1, "DMAA Error"},
    {SDMA_DMAA_ERR2, "Reserved"},
    {SDMA_DMAA_ERR3, "Reserved"},
    {SDMA_AXIM_BERR, "AXIM Berr."},
    {SDMA_SQ_TABLE_ALL_ZERO, ""},
    {SDMA_ERROR_TIMEOUT, "time out"}
};

static const std::map<uint64_t, std::string> g_aicpuErrorMapInfo = {
    {KERNEL_EXECUTE_PARAM_INVLID, "execute kernel param invalid"},
    {KERNEL_EXECUTE_INNER_ERROR, "execute kernel inner error"},
    {KERNEL_EXECUTE_TIMEOUT, "execute kernel timeout"},
    {AE_END_OF_SEQUENCE, "end of sequence"},
    {AE_STATUS_SILENT_FAULT, "convergence sensitivity feature abnormal"},
    {AE_STATUS_STRESS_DETECT_FAULT, "stress detect feature abnormal"},
    {AE_STATUS_STRESS_DETECT_FAULT_LOW, "The AICPU operator detects that the low-bit precision is abnormal"},
    {AE_STATUS_STRESS_DETECT_FAULT_LOW_OFFLINE,
        "The AICPU operator detects that the low-bit precision is abnormal for offline scenarios "},
    {AE_STATUS_STRESS_DETECT_FAULT_NORAS, "stress detect feature abnormal noras"},
    {AE_TASK_WAIT, "task wait for aicpu super task"},
    {AE_BAD_PARAM, "bad param"},
    {AE_OPEN_SO_FAILED, "open so failed"},
    {AE_GET_KERNEL_NAME_FAILED, "get kernel failed"},
    {AE_KERNEL_API_PARAM_INVALID, "execute kernel api param invalid"},
    {AE_KERNEL_API_INNER, "execute kernel api failed"},
    {AE_INNER, "inner error"},
    {AICPU_PARAMETER_NOT_VALID, "param invalid"},
    {AICPU_DUMP_FAILED, "dump failed"},
    {AICPU_FROM_DRV, "drv error"},
    {AICPU_TOOL_ERR, "tool error"},
    {AICPU_NOT_FOUND_LOGICAL_TASK, "logical task not found"},
    {AICPU_TASK_EXECUTE_FAILED, "task execute failed"},
    {AICPU_TASK_EXECUTE_TIMEOUT, "task execute timeout"},
    {AICPU_INNER, "inner error"},
    {AICPU_IN_WORKING, "current resource or model is working"},
    {AICPU_MODEL_NOT_FOUND, "model not found"},
    {AICPU_STREAM_NOT_FOUND, "stream not found"},
    {AICPU_MODEL_STATUS_NOT_ALLOW_OPERATE, "operate not allowed with current model status"},
    {AICPU_MODEL_EXIT_ERR, "model exit error"},
    {AICPU_RESERVED, "reserved: inner error"},
    {AICPU_CUST_PARAMETER_NOT_VALID, "param invalid"},
    {AICPU_CUST_DRV_ERR, "driver error"},
    {AICPU_CUST_TOOL_ERR, "tool error"},
    {AICPU_CUST_TASK_EXECUTE_FAILED, "custom task execute failed"},
    {AICPU_CUST_TASK_EXECUTE_TIMEOUT, "custom task execute timeout"},
    {AICPU_CUST_TASK_EXECUTE_PARAM_INVALID, "custom task execute param invalid"},
    {AICPU_CUST_INNER, "inner error"},
    {AICPU_CUST_RESERVED, "reserved: inner error"}
};

DeviceErrorProc::DeviceErrorProc(Device *dev, uint32_t ringBufferSize)
    : device_(dev), deviceRingBufferAddr_(nullptr), needProcNum_(0ULL), consumeNum_(0ULL),
      ringBufferSize_(ringBufferSize), realFaultTaskPtr_(nullptr)
{
}

DeviceErrorProc::DeviceErrorProc(Device *dev)
    : device_(dev), deviceRingBufferAddr_(nullptr), needProcNum_(0ULL), consumeNum_(0ULL),
      ringBufferSize_(DEVICE_RINGBUFFER_SIZE), realFaultTaskPtr_(nullptr)
{
}

DeviceErrorProc::~DeviceErrorProc() noexcept
{
    const std::lock_guard<std::mutex> mutexLock(mutex_);

    if ((deviceRingBufferAddr_ != nullptr)) {
        Driver * const devDrv = device_->Driver_();
        (void)devDrv->DevMemFree(deviceRingBufferAddr_, device_->Id_());
        deviceRingBufferAddr_ = nullptr;
    }
    if ((fastRingBufferAddr_ != nullptr)) {
        Driver * const devDrv = device_->Driver_();
        devDrv->FreeFastRingBuffer(fastRingBufferAddr_, fastRingBufferSize_, device_->Id_());
        fastRingBufferAddr_ = nullptr;
    }
}

rtError_t DeviceErrorProc::GetQosInfoFromRingbuffer()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_DRV_MEMORY);
    constexpr uint32_t len = RTS_TIMEOUT_STREAM_SNAPSHOT_LEN + RUNTME_TSCH_CAPABILITY_LEN + QOS_INFO_LEN;
    COND_RETURN_ERROR(len >= ringBufferSize_, RT_ERROR_INVALID_VALUE,
        "The length of ring buffer is invalid, ringBufferSize=%u(bytes), len=%u(bytes).", ringBufferSize_, len);
    const uint32_t qosOffset = ringBufferSize_ - len;
    RtQos_t *devRtQos = RtValueToPtr<RtQos_t *>(RtPtrToValue<const void *>(deviceRingBufferAddr_) + qosOffset);
    
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[sizeof(RtQos_t)]);
    COND_RETURN_AND_MSG_OUTER(hostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        sizeof(RtQos_t));

    Driver * const devDrv = device_->Driver_();
    rtError_t error = devDrv->MemCopySync(hostAddr.get(), sizeof(RtQos_t), devRtQos,
        sizeof(RtQos_t), RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy from dev to host, len=%u(bytes)", sizeof(RtQos_t));

    RtQos_t *hostRtQos = RtPtrToPtr<RtQos_t *, char_t *>(hostAddr.get());
    if ((hostRtQos->header.magic != RINGBUFFER_QOS_MAGIC) ||
        (hostRtQos->header.len != sizeof(hostRtQos->qos)) ||
        ((hostRtQos->header.depth * sizeof(TsQosCfg_t)) > hostRtQos->header.len) ||
        (hostRtQos->header.depth <= (static_cast<uint32_t>(QosMasterType::MASTER_AIV_INS) -
            static_cast<uint32_t>(QosMasterType::MASTER_AIC_DAT)))) {
        // 二包不兼容或者ringbuffer中的数据异常
        RT_LOG(RT_LOG_WARNING, "The qosinfo in ringbuffer is invalid, use ipc channel.");
        return RT_ERROR_INVALID_VALUE;
    }

    TsQosCfg_t tsQosCfgArray[hostRtQos->header.depth];
    errno_t ret = memcpy_s(tsQosCfgArray, sizeof(tsQosCfgArray), hostRtQos->qos, hostRtQos->header.depth * sizeof(TsQosCfg_t));
    COND_RETURN_WARN(ret != EOK, RT_ERROR_SEC_HANDLE, "Call memcpy_s failed, dst length=%zu, src length=%u, retCode=%d!",
        sizeof(tsQosCfgArray), hostRtQos->header.depth * sizeof(TsQosCfg_t), ret);
    uint32_t index = 0;
    QosMasterConfigType_t aicoreQosCfg = {};
    for (size_t i = 0; i < hostRtQos->header.depth; i++) {
        if (tsQosCfgArray[i].type >= static_cast<uint8_t>(QosMasterType::MASTER_AIC_DAT)
            && tsQosCfgArray[i].type <= static_cast<uint8_t>(QosMasterType::MASTER_AIV_INS)) {
            aicoreQosCfg.type = static_cast<QosMasterType>(tsQosCfgArray[i].type);
            aicoreQosCfg.mpamId = tsQosCfgArray[i].mpamId;
            aicoreQosCfg.qos = tsQosCfgArray[i].qos;
            aicoreQosCfg.pmg = tsQosCfgArray[i].pmg;
            // replace_en、vf_en 和 mode 的映射关系维护在驱动中，这里值关注replace_en=1的场景，其他场景下mode继续保持非法值
            if (tsQosCfgArray[i].replaceEn == 1) {
                aicoreQosCfg.mode = 0U;
            }
            index = static_cast<uint32_t>(tsQosCfgArray[i].type) - static_cast<uint32_t>(QosMasterType::MASTER_AIC_DAT);
            RT_LOG(RT_LOG_INFO, "The QOS info from ringbuffer is: type=%u, mpamId=%u, qos=%u, pmg=%u, replaceEn=%u, index=%u.",
                static_cast<QosMasterType>(tsQosCfgArray[i].type), tsQosCfgArray[i].mpamId, tsQosCfgArray[i].qos,
                tsQosCfgArray[i].pmg, tsQosCfgArray[i].replaceEn, index);
            device_->SetQosCfg(aicoreQosCfg, index);
            aicoreQosCfg.mode = MAX_UINT32_NUM;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::GetTschCapability(const void *devMem) const
{
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_TSCH_PACAGE_COMPATABLE)) {
        return RT_ERROR_NONE;
    }
    constexpr uint32_t len = RTS_TIMEOUT_STREAM_SNAPSHOT_LEN + TSCH_CAPABILITY_LEN;
    COND_RETURN_ERROR(len >= ringBufferSize_, RT_ERROR_INVALID_VALUE,
        "ring buffer length invalid, ringBufferSize=%u(bytes), len=%u(bytes)",
        ringBufferSize_, len);
    const uint32_t tschOffset = ringBufferSize_ - len;
    TschCapability *devTschCapa = RtValueToPtr<TschCapability *>(RtPtrToValue<const void *>(devMem) + tschOffset);

    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[sizeof(TschCapability)]);
    COND_RETURN_AND_MSG_OUTER(hostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        sizeof(TschCapability));
    Driver * const devDrv = device_->Driver_();
    const rtError_t error = devDrv->MemCopySync(hostAddr.get(), sizeof(TschCapability), devTschCapa,
        sizeof(TschCapability), RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy from dev to host, len=%u(bytes)", ringBufferSize_);

    TschCapability *tschCapa = RtPtrToPtr<TschCapability *, char_t *>(hostAddr.get());
    if ((tschCapa->header.magic != RINGBUFFER_CAPABILITY_MAGIC) ||
        (tschCapa->header.depth != sizeof(tschCapa->capability)) ||
        (tschCapa->header.head == tschCapa->header.tail)) {
        RT_LOG(RT_LOG_EVENT, "Tsch not support capability feature, use old solution.");
        return RT_ERROR_NONE;
    }

    uint32_t capaLen;
    if (likely(tschCapa->header.tail > tschCapa->header.head)) {
        capaLen = tschCapa->header.tail;
    } else { // ring queue inversion
        capaLen = static_cast<uint32_t>(sizeof(tschCapa->capability));
    }
    uint8_t *capa = new (std::nothrow) uint8_t[capaLen];
    COND_RETURN_AND_MSG_OUTER(capa == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        capaLen * sizeof(uint8_t));
    const int32_t ret = memcpy_s(capa, capaLen, tschCapa->capability, capaLen);
    if (ret != EOK) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Failed to call memcpy_s to copy tschCapa->capability, src=%p, dest=%p, dest_max=%u, count=%u, retCode=%d.",
            tschCapa->capability, capa, capaLen, capaLen, ret);
        DELETE_A(capa);
        return RT_ERROR_SEC_HANDLE;
    }
    device_->InitTschCapability(capa, capaLen, tschCapa->header.depth);
    device_->SetSupportFlipVersionSwitch();
    Runtime::Instance()->SetTilingkeyFlag(
        static_cast<uint8_t>(device_->CheckFeatureSupport(TS_FEATURE_TILING_KEY_SINK)));
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::WriteRuntimeCapability(const void *hostAddr) const
{
    if (!(device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SET_RUNTIME_CAPABLITY))) {
        return RT_ERROR_NONE;
    }
    constexpr uint32_t len = RTS_TIMEOUT_STREAM_SNAPSHOT_LEN + RUNTME_TSCH_CAPABILITY_LEN;
    COND_RETURN_ERROR(len >= ringBufferSize_, RT_ERROR_INVALID_VALUE,
        "ring buffer length invalid, ringBufferSize=%u(bytes), len=%u(bytes)",
        ringBufferSize_, len);
    const uint32_t rtsOffset = ringBufferSize_ - len;
    RuntimeCapability *hostRtCapa = RtValueToPtr<RuntimeCapability *>(RtPtrToValue<const void *>(hostAddr) + rtsOffset);
    const uint32_t *capa = GetRtCapabilityTbl();
    const uint32_t capaLen = GetRtCapabilityTblLen();
    uint32_t posMax = 0;
    hostRtCapa->header.depth = sizeof(hostRtCapa->capability);
    for (uint32_t i = 0; i < capaLen; i++) {
        const uint32_t pos = (capa[i] / ONE_BYTE_BITS ) % hostRtCapa->header.depth;
        hostRtCapa->capability[pos] |= 1U << (capa[i] % ONE_BYTE_BITS);
        posMax = pos > posMax ? pos : posMax;
    }
    hostRtCapa->header.magic = RINGBUFFER_CAPABILITY_MAGIC;
    hostRtCapa->header.head = 0U;
    hostRtCapa->header.tail = (posMax + 1U) % hostRtCapa->header.depth;

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::SendTaskToStopUseRingBuffer()
{
    void *devMem = nullptr;
    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        if ((fastRingBufferAddr_ != nullptr)) {
            device_->Driver_()->FreeFastRingBuffer(fastRingBufferAddr_, fastRingBufferSize_, device_->Id_());
            fastRingBufferAddr_ = nullptr;
        }
        if (deviceRingBufferAddr_ == nullptr) {
            return RT_ERROR_NONE;
        }
        devMem = deviceRingBufferAddr_;
    }
    rtError_t error = RT_ERROR_NONE;
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        error = ProcRingBufferTaskDavid(device_, devMem, true, RINGBUFFER_LEN_DAVID);
    } else {
        error = ProcRingBufferTask(devMem, true, RINGBUFFER_LEN);
    }
    ERROR_RETURN(error, "Failed to pass the buffer addr to device.");

    RT_LOG(RT_LOG_DEBUG, "End to send destroy task for deleting device ringbuffer.");
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::RingBufferRestore()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_INVALID_VALUE);
    }

    // 申请host内存并设置capability信息
    std::vector<uint8_t> hostdata(ringBufferSize_, 0);
    rtError_t error = WriteRuntimeCapability(hostdata.data());
    ERROR_RETURN(error, "Failed to write runtime capability, errorcode=%u.", error);

    // 将结果拷贝的device侧
    Driver * const devDrv = device_->Driver_();
    error = devDrv->MemCopySync(deviceRingBufferAddr_, static_cast<uint64_t>(ringBufferSize_), hostdata.data(),
        static_cast<uint64_t>(ringBufferSize_), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_RETURN(error, "Failed to memcpy from host to dev, len=%u(bytes), errorcode=%u.",
        ringBufferSize_, error);

    // create task to transfer the addr to device.
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        error = ProcRingBufferTaskDavid(device_, deviceRingBufferAddr_, false, RINGBUFFER_LEN_DAVID);
    } else {
        error = ProcRingBufferTask(deviceRingBufferAddr_, false, RINGBUFFER_LEN);
    }
    ERROR_RETURN(error, "Failed to create ring buffer, errorcode=%u.", error);

    if (fastRingBufferAddr_ != nullptr) {
        NpuDriver *npuDrv = dynamic_cast<NpuDriver*>(devDrv);
        if (npuDrv != nullptr) {
            error = npuDrv->SetMemSharing(fastRingBufferAddr_, fastRingBufferSize_, device_->Id_());
            ERROR_RETURN(error, "Failed to set fast ring buffer, errorcode=%u.", error);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::CreateDeviceRingBufferAndSendTask()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        COND_RETURN_WITH_NOLOG(deviceRingBufferAddr_ != nullptr, RT_ERROR_NONE)
    }
    void *devMem = nullptr;
    Driver * const devDrv = device_->Driver_();
    Runtime * const rtInstance = Runtime::Instance();
    const rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, ringBufferSize_);
    rtError_t error = devDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(ringBufferSize_), memType, device_->Id_());
    COND_RETURN_WARN(error != RT_ERROR_NONE, RT_ERROR_DRV_MEMORY,
                     "Failed to alloc huge page device memory for ring buffer in device, size=%u(bytes)."
                     " ring buffer feature can't work.", ringBufferSize_);
    NULL_PTR_RETURN(devMem, RT_ERROR_DRV_MEMORY);

    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[ringBufferSize_]);
    COND_GOTO_MSG_OUTER(hostAddr == nullptr, ERROR_FREE, error, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        ringBufferSize_);
    (void)memset_s(hostAddr.get(), ringBufferSize_, 0U, ringBufferSize_);

    error = WriteRuntimeCapability(hostAddr.get());
    ERROR_GOTO(error, ERROR_FREE, "Failed to write runtime capability, errorcode=%u.", error);
    error = devDrv->MemCopySync(devMem, static_cast<uint64_t>(ringBufferSize_), hostAddr.get(),
        static_cast<uint64_t>(ringBufferSize_), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_GOTO(error, ERROR_FREE, "Failed to memcpy from host to dev, len=%u(bytes), errorcode=%u.",
        ringBufferSize_, error);

    // create task to transfer the addr to device.
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        error = ProcRingBufferTaskDavid(device_, devMem, false, RINGBUFFER_LEN_DAVID);
    } else {
        error = ProcRingBufferTask(devMem, false, RINGBUFFER_LEN);
    }
    ERROR_GOTO(error, ERROR_FREE, "Failed to create ring buffer, errorcode=%u.", error);

    error = GetTschCapability(devMem);
    ERROR_GOTO(error, ERROR_FREE, "Failed to get tsch capability, errorcode=%u.", error);

    {
        const std::lock_guard<std::mutex> mutexLock(mutex_);
        deviceRingBufferAddr_ = devMem;
    }
    RT_LOG(RT_LOG_DEBUG, "End to Create device ringbuffer and send task, ringbuffer size=%u(bytes).", ringBufferSize_);
    return RT_ERROR_NONE;
ERROR_FREE:
    (void)devDrv->DevMemFree(devMem, device_->Id_());
    return error;
}

rtError_t DeviceErrorProc::DestroyDeviceRingBuffer()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);

    RT_LOG(RT_LOG_DEBUG, "begin to delete device ringbuffer.");
    {
        const std::unique_lock<std::mutex> mutexLock(mutex_);
        // if addr is nullptr ,it don`t need to relase, directly to return.
        NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_NONE);
        Driver * const devDrv = device_->Driver_();
        const rtError_t error = devDrv->DevMemFree(deviceRingBufferAddr_, device_->Id_());
        ERROR_RETURN(error, "Failed to release device memory, device_id=%u.", device_->Id_());
        deviceRingBufferAddr_ = nullptr;
    }

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcRingBufferTask(const void * const devMem, const bool delFlag, const uint32_t len)
{
    /* ctrl stream  */
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    auto * const factory = device_->GetTaskFactory();

    TaskInfo taskSubmit = {};
    TaskInfo *tsk = &taskSubmit;
    Stream* stm = device_->GetCtrlStream(device_->PrimaryStream_());
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    tsk->stream = stm;
    rtError_t error = RT_ERROR_TASK_NEW;
    if (stm->taskResMang_ == nullptr) {
        tsk = factory->Alloc(stm, TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, error);
        NULL_PTR_RETURN(tsk, error);
    }
    error = RingBufferMaintainTaskInit(tsk, devMem, delFlag, len);
    ERROR_GOTO(error, ERROR_TASK, "Failed to init create ringbuffer task.");

    error = device_->SubmitTask(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to SubmitTask task.");

    error = stm->Synchronize();
    ERROR_GOTO(error, ERROR_TASK, "Failed to Synchronize.");

    return RT_ERROR_NONE;
ERROR_TASK:
    (void)factory->Recycle(tsk);
    return error;
}

rtError_t DeviceErrorProc::ProcessSdmaErrorInfo(const DeviceErrorInfo * const info,
                                                const uint64_t errorNumber,
                                                const Device *const dev)
{
    UNUSED(dev);
    std::string str = "the channel exist the following problems:";
    if ((info->u.sdmaErrorInfo.channelStatus & static_cast<uint64_t>(SDMA_ERROR_TIMEOUT)) ==
        static_cast<uint64_t>(SDMA_ERROR_TIMEOUT)) {
        str += "time out";
    } else {
        uint64_t err = info->u.sdmaErrorInfo.channelStatus;
        for (uint32_t i = static_cast<uint32_t>(BitScan(err)); i < MAX_BIT_LEN;
             i = static_cast<uint32_t>(BitScan(err))) {
            BITMAP_CLR(err, static_cast<uint64_t>(i));
            str += " ";
            const auto it = channelErrorMapInfo_.find(i);
            if (it == channelErrorMapInfo_.end()) {
                continue;
            }
            // if the string is too long, the log will truncate to 1024.
            // so the error string only show 400.
            if (unlikely((it->second.size() + str.size())) > 400UL) {
                RT_LOG(RT_LOG_WARNING, "The error info is too long.");
                break;
            }
            str += it->second;
        }

        str += ". the value of CQE status is " + std::to_string(info->u.sdmaErrorInfo.cqeStatus);
        str += ". the description of CQE status: ";
        const auto it = cqeErrorMapInfo_.find(info->u.sdmaErrorInfo.cqeStatus);
        if (it != cqeErrorMapInfo_.end()) {
            str += it->second;
        }
    }
    RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(%u), serial number is %" PRIu64 ". "
        "there is a sdma error, sdma channel is %#" PRIx64 ", "
        "%s"
        "it's config include: "
        "setting1=%#" PRIx64 ", setting2=%#" PRIx64 ", setting3=%#" PRIx64 ", sq base addr=%#" PRIx64,
        info->u.sdmaErrorInfo.deviceId, errorNumber,
        info->u.sdmaErrorInfo.channel, str.c_str(),
        info->u.sdmaErrorInfo.setting1, info->u.sdmaErrorInfo.setting2,
        info->u.sdmaErrorInfo.setting3, info->u.sdmaErrorInfo.sqBaseAddr);

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessAicpuErrorInfo(const DeviceErrorInfo * const info,
                                                 const uint64_t errorNumber,
                                                 const Device *const dev)
{
    UNUSED(dev);
    UNUSED(errorNumber);
    std::string msg = "aicpu execute failed";
    const uint64_t errcode = info->u.aicpuErrorInfo.errcode;
    const auto it = g_aicpuErrorMapInfo.find(errcode);
    if (it != g_aicpuErrorMapInfo.end()) {
        msg = (it->second).c_str();
    }
    RT_LOG_CALL_MSG(ERR_MODULE_AICPU,
        "An exception occurred during AI CPU execution, stream_id:%u, task_id:%u, errcode:%" PRIu64 ", msg:%s.",
        info->u.aicpuErrorInfo.stream_id,
        info->u.aicpuErrorInfo.task_id,
        errcode, msg.c_str());
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessOneElementInRingBuffer(const DevRingBufferCtlInfo * const ctlInfo,
    uint32_t head, const uint32_t tail) const
{
    const uint32_t tschVer = device_->GetTschVersion();
    size_t headSize = sizeof(DevRingBufferCtlInfo);
    size_t elementSize;
    if (tschVer < static_cast<uint32_t>(TS_VERSION_AIC_ERR_REG_EXT)) {
        headSize = sizeof(DevRingBufferCtlInfo) - sizeof(uint64_t); // old tsch version head is 8bytes small
        elementSize = RINGBUFFER_ONE_ELEMENT_LENGTH;  // default is 4K, extern size should use tsch's size
    } else {
        elementSize = ctlInfo->elementSize;
    }

    RT_LOG(RT_LOG_DEBUG, "it needs process %u errorMessages, tschVer=%u, headSize=%zu, elementSize=%zu.",
           ((tail - head) + ctlInfo->ringBufferLen) % ctlInfo->ringBufferLen, tschVer, headSize, elementSize);

    while (head != tail) {
        const uint8_t * const infoAddr = RtPtrToPtr<const uint8_t *, const DevRingBufferCtlInfo *>(ctlInfo) + headSize + (head * elementSize);
        const RingBufferElementInfo * const info = RtPtrToPtr<const RingBufferElementInfo *, const uint8_t *>(infoAddr);

        RT_LOG(RT_LOG_INFO, "head info %u, tail info %u.", head, tail);

        head = (head + 1U) % (ctlInfo->ringBufferLen);

        if (info->errorType > static_cast<uint32_t>(FFTS_PLUS_SDMA_ERROR)) {
            RT_LOG(RT_LOG_WARNING, "Failed to get error information from device, error type=%u.", info->errorType);
            continue;
        }

        const DeviceErrorInfo * const errorInfo = RtPtrToPtr<const DeviceErrorInfo *, const RingBufferElementInfo *>(info + 1);
        const auto it = funcMap_.find(info->errorType);
        if (it != funcMap_.end()) {
            ErrorInfoProc const func = it->second;
            const rtError_t error = func(errorInfo, info->errorNumber, device_);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_WARNING, "Failed to get error information from device.");
            }
        } else {
            RT_LOG(RT_LOG_WARNING, "Failed to find function to process the error information.");
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::PrintRingbufferErrorInfo(const DevRingBufferCtlInfo *const ctrlInfo) const
{
    RT_LOG(RT_LOG_ERROR, "The error from device(%u), tsId(%u)."
        "the ringbuffer magic is %u, the ringBufferLen is %u, the head of ringbuffer is %u,"
        "the tail of ringbuffer is %u, the pid of ringbuffer is %u,"
        "the elementSize of ringbuffer is %u",
        device_->Id_(),
        device_->DevGetTsId(),
        ctrlInfo->magic,
        ctrlInfo->ringBufferLen,
        ctrlInfo->head,
        ctrlInfo->tail,
        ctrlInfo->pid,
        ctrlInfo->elementSize);
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::CheckValid(const DevRingBufferCtlInfo *const ctrlInfo)
{
    if (ctrlInfo->ringBufferLen == 0U) {
        RT_LOG(RT_LOG_ERROR, "The length of ringbuffer is invalid.");
        PrintRingbufferErrorInfo(ctrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }

    if (ctrlInfo->magic != RINGBUFFER_MAGIC) {
        RT_LOG(RT_LOG_ERROR, "The magic(%u) of ringbuffer is invalid.", ctrlInfo->magic);
        PrintRingbufferErrorInfo(ctrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }

    if ((ctrlInfo->head >= GetRingbufferElementNum()) || (ctrlInfo->tail >= GetRingbufferElementNum())) {
        RT_LOG(RT_LOG_ERROR, "The head(%u) or tail(%u) of ringbuffer is invalid.", ctrlInfo->head, ctrlInfo->tail);
        PrintRingbufferErrorInfo(ctrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcErrorInfoWithoutLock(const TaskInfo * const taskPtr, const bool isPrintTaskInfo)
{
    RT_LOG(RT_LOG_INFO, "Begin to process device abnormal info.");
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[ringBufferSize_]);
    COND_RETURN_AND_MSG_OUTER(hostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        ringBufferSize_);
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);

    // 1. memcpy ringbuffer to host
    const uint64_t destMax = ringBufferSize_;
    const uint64_t copySize = ringBufferSize_;
    NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_DEVICE_NULL);
    void * const devMem = deviceRingBufferAddr_;
    rtError_t error;
    uint32_t cycleTimes;
    DevRingBufferCtlInfo *tmpCtrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *, char_t *>(hostAddr.get());
    Driver *devDrv = nullptr;

    if (Runtime::Instance()->ChipIsHaveStars() == true) {
        cycleTimes = device_->IsAddrFlatDev() ? 25000U : 50000U;  // Number of cyclic waiting times for stars 6s
        if (taskPtr != nullptr && taskPtr->stream->isForceRecycle_) {
            cycleTimes = 1U;
        }
    } else {
        cycleTimes = device_->GetDevProperties().ringBufferMemCopyCycleTimes;
    }
    const uint64_t beginTime = static_cast<uint64_t>(GetWallUs());
    while (cycleTimes != 0U) {
        devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN(devDrv, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);
        error = devDrv->MemCopySync(hostAddr.get(), destMax, devMem, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
        ERROR_RETURN(error, "Failed to Memcpy from dev to host, destMax=%" PRIu64
            ", copy size=%" PRIu64, destMax, copySize);
        if ((tmpCtrlInfo->tail != tmpCtrlInfo->head) || (GetWallUs() - beginTime > 12000000ULL) ||  // 尝试12s后退出
            (Runtime::Instance()->IsSupportOpTimeoutMs())) { // 算子ms超时时故障上报不等待
            break;
        }
        if ((taskPtr != nullptr) && (taskPtr->isRingbufferGet)) {
            return RT_ERROR_NONE;
        }
        cycleTimes--;
    }

    DevRingBufferCtlInfo * const ctrlInfo = tmpCtrlInfo;
    error = DeviceErrorProc::CheckValid(ctrlInfo);
    ERROR_RETURN(error, "Find error in ringbuffer!");

    devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN(devDrv, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);

    const uint32_t tail = ctrlInfo->tail;
    const uint32_t head = ctrlInfo->head;
    if (head == tail) {
        RT_LOG(RT_LOG_INFO, "There isn't errInfo of device.");
        return RT_ERROR_DEVICE_RINGBUFFER_NO_DATA;
    }

    // Set error device status
    device_->SetHasTaskError(true);
    (void)Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);

    // 2. memset read pointer
    ctrlInfo->head = tail;
    error = devDrv->MemCopySync(devMem, static_cast<uint64_t>(ringBufferSize_), hostAddr.get(),
        sizeof(uint32_t) + sizeof(uint32_t), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_RETURN(error, "Failed to Memcpy from host to device, max len=%u,"
        " copy size=%zu.", ringBufferSize_, sizeof(uint32_t) + sizeof(uint32_t));

    const uint32_t procNum = ((tail - head) + ctrlInfo->ringBufferLen) % ctrlInfo->ringBufferLen;
    ConsumeProcNum(procNum);

    // 3. record device error info to log in host
    if (Runtime::Instance()->ChipIsHaveStars()) {
        if (device_->IsDavidPlatform()) {
            error = ProcessStarv2OneElementInRingBuffer(ctrlInfo, head, tail, isPrintTaskInfo, taskPtr);
        } else {
            error = ProcessStarsOneElementInRingBuffer(ctrlInfo, head, tail, isPrintTaskInfo, taskPtr);
        }
    } else {
        error = ProcessOneElementInRingBuffer(ctrlInfo, head, tail); // isPrintTaskInfo is false
    }

    RT_LOG(RT_LOG_INFO, "Finished to process device errInfo, retCode=%#x.", error);
    return error;
}

rtError_t DeviceErrorProc::ProcTaskErrorWithoutLock(const TaskInfo * const taskPtr, const bool isPrintTaskInfo)
{
    const uint64_t beginTime = GetWallUs();
    bool isTimeOut = false;
    rtError_t error = RT_ERROR_NONE;
    // stream 已经强制回收，就只读一次。
    const bool needCheck = (taskPtr == nullptr) ? (false) :
        ((taskPtr->type != TS_TASK_TYPE_KERNEL_AICPU) && !taskPtr->stream->isForceRecycle_);
    // 至少执行一次，返回失败、或尝试超时12s、或传入task为null，或为aicputask，或取到task的ringbuffer信息后，退出
    const bool isTimeoutMs = Runtime::Instance()->IsSupportOpTimeoutMs();
    do {
        error = ProcErrorInfoWithoutLock(taskPtr, isPrintTaskInfo);
        isTimeOut = (GetWallUs() - beginTime) > 12000000ULL; // 12s
    } while ((error == RT_ERROR_NONE) && !isTimeOut && needCheck && (taskPtr->isRingbufferGet == 0U) && (!isTimeoutMs));
    return error;
}

rtError_t DeviceErrorProc::ProcErrorInfo(const TaskInfo * const taskPtr)
{
    if ((device_->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) ||
        ((taskPtr != nullptr) && (taskPtr->isNoRingbuffer == 1U))) {
        return RT_ERROR_NONE;
    }
    const std::lock_guard<std::mutex> mutexLock(mutex_);
    return ProcTaskErrorWithoutLock(taskPtr);
}

template <typename ErrorInfo>
static void GetStreamAndTaskIdFromErrorInfo(const uint32_t errorType,
    const ErrorInfo* const errorInfo, StreamTaskId &streamTaskId)
{
    switch (errorType) {
        case AICORE_ERROR:
        case AIVECTOR_ERROR:
        case FFTS_PLUS_AICORE_ERROR:
        case FFTS_PLUS_AIVECTOR_ERROR:
            streamTaskId.streamId = errorInfo->u.coreErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.coreErrorInfo.comm.taskId;
            break;
        case SDMA_ERROR:
        case FFTS_PLUS_SDMA_ERROR:
            streamTaskId.streamId = errorInfo->u.sdmaErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.sdmaErrorInfo.comm.taskId;
            break;
        case AICPU_ERROR:
        case FFTS_PLUS_AICPU_ERROR:
            streamTaskId.streamId = errorInfo->u.aicpuErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.aicpuErrorInfo.comm.taskId;
            break;
        case DVPP_ERROR:
            streamTaskId.streamId = errorInfo->u.dvppErrorInfo.streamId;
            streamTaskId.taskId = errorInfo->u.dvppErrorInfo.taskId;
            break;
        case DSA_ERROR:
        case FFTS_PLUS_DSA_ERROR:
            streamTaskId.streamId = errorInfo->u.dsaErrorInfo.sqe.sqeHeader.rt_stream_id;
            streamTaskId.taskId = errorInfo->u.dsaErrorInfo.sqe.sqeHeader.task_id;
            break;
        case SQE_ERROR:
            streamTaskId.streamId = errorInfo->u.sqeErrorInfo.streamId;
            streamTaskId.taskId = errorInfo->u.sqeErrorInfo.taskId;
            break;
        case WAIT_TIMEOUT_ERROR:
            streamTaskId.streamId = errorInfo->u.timeoutErrorInfo.streamId;
            streamTaskId.taskId = errorInfo->u.timeoutErrorInfo.taskId;
            break;
        case HCCL_FFTSPLUS_TIMEOUT_ERROR:
            streamTaskId.streamId = errorInfo->u.hcclFftsplusTimeoutInfo.common.streamId;
            streamTaskId.taskId = errorInfo->u.hcclFftsplusTimeoutInfo.common.taskId;
            break;
        case FUSION_KERNEL_ERROR:
            streamTaskId.streamId = errorInfo->u.fusionKernelErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.fusionKernelErrorInfo.comm.taskId;
            break;
        case CCU_ERROR:
            streamTaskId.streamId = errorInfo->u.ccuErrorInfo.comm.streamId;
            streamTaskId.taskId = errorInfo->u.ccuErrorInfo.comm.taskId;
            break;
        default:
            streamTaskId.streamId = 0xFFFFU;
            streamTaskId.taskId = 0xFFFFU;
            break;
    }
}

static void CopyRingBufferPayload(
    StarsDeviceErrorInfo& dstErrorInfo, const StarsDeviceErrorInfoRingBuffer* const rbErrorInfo,
    const size_t elementSize)
{
    // elementSize 包含 RingBufferElementInfo 头，这里只计算后面的设备错误 payload 大小。
    const size_t payloadSize = elementSize - sizeof(RingBufferElementInfo);
    // payload 可能来自不同协议版本，拷贝时按源结构、目的结构和实际 payload 三者最小值截断。
    const size_t rbPayloadCopySize = std::min(sizeof(StarsDeviceErrorInfoRingBuffer), payloadSize);
    const size_t payloadCopySize = std::min(sizeof(StarsDeviceErrorInfo), rbPayloadCopySize);
    (void)memcpy_s(&dstErrorInfo, sizeof(StarsDeviceErrorInfo), rbErrorInfo, payloadCopySize);
}

rtError_t DeviceErrorProc::ProcessReportRingBuffer(const DevRingBufferCtlInfo * const tmpCtrlInfo,
    Driver * const devDrv, uint16_t *errorStreamId)
{
    // copy element
    size_t copySize  = sizeof(RingBufferElementInfo) + sizeof(StarsDeviceErrorInfoRingBuffer);
    std::unique_ptr<char[]> elementHostAddr(new (std::nothrow) char[copySize]);
    COND_RETURN_AND_MSG_OUTER(elementHostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        copySize);

    const size_t elementSize = (device_->IsDavidPlatform()) ? \
        static_cast<size_t>(tmpCtrlInfo->elementSize) : \
        static_cast<size_t>(RINGBUFFER_EXT_ONE_ELEMENT_LENGTH);
    if (elementSize == 0U) {
        RT_LOG(RT_LOG_ERROR, "The element size in ringbuffer is invalid.");
        PrintRingbufferErrorInfo(tmpCtrlInfo);
        return RT_ERROR_INVALID_VALUE;
    }
    uint32_t head = tmpCtrlInfo->head;
    const uint32_t tail = tmpCtrlInfo->tail;
    const uint32_t depth = tmpCtrlInfo->ringBufferLen;
    RT_LOG(RT_LOG_INFO, "head=%u, tail=%u, depth=%u, elementSize=%zu, infoSize=%zu",
        head, tail, depth, elementSize, copySize);

    copySize = (copySize < elementSize) ? copySize : elementSize;
    StreamTaskId sTaskId;
    std::shared_ptr<Stream> stm = nullptr;
    RingBufferElementInfo *info = nullptr;
    while (head != tail) {
        const uint64_t elementOffset =
            static_cast<uint64_t>(sizeof(DevRingBufferCtlInfo)) + static_cast<uint64_t>(head * elementSize);
        void* const copyBase =
            RtPtrToPtr<void*, uint8_t*>(RtPtrToPtr<uint8_t*, void*>(deviceRingBufferAddr_) + elementOffset);
        rtError_t error = devDrv->MemCopySync(elementHostAddr.get(), copySize, copyBase, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
        ERROR_RETURN(error, "failed to Memcpy from, copy size=%" PRIu64 "(bytes), ret=%#x.", copySize, error);

        stm = nullptr;
        info = RtPtrToPtr<RingBufferElementInfo*, char_t*>(elementHostAddr.get());
        const StarsDeviceErrorInfoRingBuffer* const rbErrorInfo =
            RtPtrToPtr<const StarsDeviceErrorInfoRingBuffer*, RingBufferElementInfo*>(info + 1);
        NULL_PTR_RETURN(rbErrorInfo, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);
        if (IsRingBufferExtErrorType(info->errorType)) {
            head = (head + 1U) % depth;
            continue;
        }
        GetStreamAndTaskIdFromErrorInfo(info->errorType, rbErrorInfo, sTaskId);
        error = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(sTaskId.streamId), stm);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), RT_ERROR_TASK_MONITOR);

        if ((stm->Flags() & RT_STREAM_CP_PROCESS_USE) == 0U) {
            break;
        }
        head = (head + 1U) % depth;
    }

    COND_RETURN_WITH_NOLOG((stm == nullptr), RT_ERROR_TASK_MONITOR);
    if (stm->Model_() != nullptr && stm->Model_()->GetExeStream() != nullptr) {
        sTaskId.streamId = stm->Model_()->GetExeStream()->Id_();
    }
    *errorStreamId = sTaskId.streamId;

    if (stm->Model_() != nullptr && stm->Model_()->GetModelExecutorType() == MODEL_EXECUTOR_AICPU) {
        (void)ProcTaskErrorWithoutLock(nullptr, true);
    }

    bool monitorFlag = false;
    if (stm->Device_() == nullptr) {
        monitorFlag = false;
    } else {
        monitorFlag = stm->Device_()->GetMonitorExitFlag();
    }

    RT_LOG(RT_LOG_INFO, "Monitor get stream_id=%hu, type=%u, device=%p, monitorflag=%u",
        sTaskId.streamId, info->errorType, stm->Device_(), monitorFlag);
    stm.reset();
    return RT_ERROR_TASK_MONITOR;
}

rtError_t DeviceErrorProc::ReportRingBuffer(uint16_t *errorStreamId)
{
    // read ringbuffer obtain the device status
    rtError_t error;
    constexpr uint64_t headSize = sizeof(DevRingBufferCtlInfo);
    std::unique_ptr<uint8_t[]> hostAddr(new (std::nothrow) uint8_t[headSize]);
    COND_RETURN_AND_MSG_OUTER(hostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        headSize);
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    Driver * const devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN(devDrv, RT_ERROR_DRV_NULL);

    const std::lock_guard<std::mutex> mutexLock(mutex_);
    if (deviceRingBufferAddr_ == nullptr) {
        return RT_ERROR_NONE;
    }
    void * const devMem = deviceRingBufferAddr_;
    error = devDrv->MemCopySync(hostAddr.get(), headSize, devMem, headSize, RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "failed to Memcpy, copy size=%" PRIu64 "(bytes), ret=%#x.", headSize, error);
    
    DevRingBufferCtlInfo *tmpCtrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *, uint8_t *>(hostAddr.get());
    if (tmpCtrlInfo->magic != RINGBUFFER_MAGIC) {
        return RT_ERROR_NONE;
    }
    
    // 2. ringbuffer is not nullptr
    if (tmpCtrlInfo->tail == tmpCtrlInfo->head) {
        return RT_ERROR_NONE;
    }

    error = DeviceErrorProc::CheckValid(tmpCtrlInfo);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_TS_RING_BUFFER)) {
        return ProcessReportRingBuffer(tmpCtrlInfo, devDrv, errorStreamId);
    }
    return RT_ERROR_TASK_MONITOR;
}

void ConvertErrorCodeForFastReport(StarsOpExceptionInfo* report)
{
    const uint32_t sqeType = report->sqeType;
    const uint32_t errorCode = report->errorCode;
    // 定义映射表 [任务类型][原错误码] -> 新错误码
    std::unordered_map<uint32_t, std::unordered_map<uint32_t, uint32_t>> errorMap;
    GetFastRingBufferErrorMap(errorMap);

    auto taskIt = errorMap.find(sqeType);
    if (taskIt != errorMap.end()) {
        auto errorIt = taskIt->second.find(errorCode);
        if (errorIt != taskIt->second.end()) {
            report->errorCode = errorIt->second;
        }
    }
}

rtError_t DeviceErrorProc::ProcCleanRingbuffer()
{
    std::unique_ptr<char[]> hostAddr(new (std::nothrow)  char[ringBufferSize_]);
    COND_RETURN_AND_MSG_OUTER(hostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        ringBufferSize_);
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    (void)memset_s(hostAddr.get(), ringBufferSize_, 0U, ringBufferSize_);
    // 1. memcpy ringbuffer to host
    const uint64_t copySize = ringBufferSize_;
    const uint64_t destMax = ringBufferSize_;
    const std::lock_guard<std::mutex> mutexLock(mutex_);
    NULL_PTR_RETURN(deviceRingBufferAddr_, RT_ERROR_DEVICE_NULL);
    void * const devMem = deviceRingBufferAddr_;
    rtError_t error;
    DevRingBufferCtlInfo *tmpCtrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *, char_t *>(hostAddr.get());
    Driver *devDrv = nullptr;

    devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN(devDrv, RT_ERROR_DEVICE_RINGBUFFER_NO_DATA);
    error = devDrv->MemCopySync(hostAddr.get(), destMax, devMem, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy from dev to host, destMax=%" PRIu64
        ", copy size=%" PRIu64, destMax, copySize);
    
    if (tmpCtrlInfo->ringBufferLen == 0U) {
        RT_LOG(RT_LOG_EVENT, "The D2H copied data may be inconsistent. Try again.");
        error = devDrv->MemCopySync(hostAddr.get(), destMax, devMem, copySize, RT_MEMCPY_DEVICE_TO_HOST, false);
        ERROR_RETURN(error, "Failed to Memcpy from dev to host, destMax=%" PRIu64
            ", copy size=%" PRIu64, destMax, copySize);
    }

    DevRingBufferCtlInfo * const ctrlInfo = tmpCtrlInfo;
    error = DeviceErrorProc::CheckValid(ctrlInfo);
    ERROR_RETURN(error, "Find error in ringbuffer!");

    // 2. memset read pointer
    ctrlInfo->head = ctrlInfo->tail;
    error = devDrv->MemCopySync(devMem, static_cast<uint64_t>(ringBufferSize_), hostAddr.get(),
        sizeof(uint32_t) + sizeof(uint32_t), RT_MEMCPY_HOST_TO_DEVICE, false);
    ERROR_RETURN(error, "Failed to Memcpy from host to device, max len=%u,"
        " copy size=%zu.", ringBufferSize_, sizeof(uint32_t) + sizeof(uint32_t));

    RT_LOG(RT_LOG_INFO, "finished to clean ringbuffer.");
    return error;
}

static bool JudgeChipTypeforSnapshot(DevProperties properties, uint32_t tschVersion)
{
    bool snapshotFlag = false;
    if (properties.supportSnapshot == SupportSnapshot::SUPPORT) {
        snapshotFlag = true;
    } else if (properties.supportSnapshot == SupportSnapshot::SUPPORT_ON_HIGH_TS_VERSION &&
        tschVersion >= TS_VERSION_STREAM_TIMEOUT_SNAPSHOT) {
        snapshotFlag = true;
    }
    // other snapshotFlag don't support snapshot
    return snapshotFlag;
}

bool DeviceErrorProc::IsPrintStreamTimeoutSnapshot()
{
    if (device_ == nullptr) {
        return false;
    }
    NULL_PTR_RETURN(deviceRingBufferAddr_, false);
    const std::unique_lock<std::mutex> lk(device_->GetErrProLock());
    if (!JudgeChipTypeforSnapshot(device_->GetDevProperties(), device_->GetTschVersion()) ||
        !device_->GetSnapshotFlag()) {
        RT_LOG(RT_LOG_INFO, "do not snapshot: chiptype=%d ts_version=%u snapshotflag=%d",
            Runtime::Instance()->GetChipType(), device_->GetTschVersion(), device_->GetSnapshotFlag());
        return false;
    }
    RT_LOG(RT_LOG_DEBUG, "check snapshot para ok: chiptype=%d ts_version=%u snapshotflag=%d",
        Runtime::Instance()->GetChipType(), device_->GetTschVersion(), device_->GetSnapshotFlag());
    return true;
}

static void PrintSnapshotInfo(TaskInfo * const tsk, char_t * const errStr, int32_t countNum)
{
    int32_t ret = 0;
    switch (tsk->type) {
        case TS_TASK_TYPE_EVENT_RECORD: {
            EventRecordTaskInfo * const recTask = &(tsk->u.eventRecordTaskInfo);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", EventId=%d", recTask->eventid);
            break;
        }
        case TS_TASK_TYPE_STREAM_WAIT_EVENT: {
            EventWaitTaskInfo * const eventWaitTask = &(tsk->u.eventWaitTaskInfo);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", EventId=%d", eventWaitTask->eventId);
            break;
        }
        case TS_TASK_TYPE_NOTIFY_RECORD: {
            NotifyRecordTaskInfo * const notifyRecordTask = &(tsk->u.notifyrecordTask);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", NotifyId=%d", notifyRecordTask->notifyId);
            break;
        }
        case TS_TASK_TYPE_NOTIFY_WAIT: {
            NotifyWaitTaskInfo * const notifyWaitTask = &(tsk->u.notifywaitTask);
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", NotifyId=%u", notifyWaitTask->notifyId);
            break;
        }
        case TS_TASK_TYPE_KERNEL_AICORE: {
            std::string kernelNameStr;
            AicTaskInfo * const aicTask = &(tsk->u.aicTaskInfo);
            if ((aicTask != nullptr) && (aicTask->kernel != nullptr)) {
                kernelNameStr = aicTask->kernel->Name_();
            }
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", kernel_name=%s", kernelNameStr.c_str());
            break;
        }
        case TS_TASK_TYPE_KERNEL_AICPU: {
            ret = sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", OpName=%s", tsk->stream->GetTaskTag(tsk->id).c_str());
            break;
        }
        default:
            break;
    }

    COND_RETURN_VOID_AND_MSG_INNER(ret < 0, "Failed to call sprintf_s, count=%d.", ret);
}

rtError_t DeviceErrorProc::PrintStreamTimeoutSnapshotInfo()
{
    char_t errMsg[MSG_LENGTH + 1U] = {0U};
    char_t * const errStr = errMsg;
    int32_t countNum;
    rtError_t error;
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    Driver * const devDrv = device_->Driver_();

    if (!IsPrintStreamTimeoutSnapshot()) {
        return RT_ERROR_NONE;
    }

    const std::unique_lock<std::mutex> lk(device_->GetErrProLock());
    std::unique_ptr<char[]> hostAddr(new (std::nothrow) char[sizeof(RtsTimeoutStreamSnapshot)]);
    COND_RETURN_AND_MSG_OUTER(hostAddr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        sizeof(RtsTimeoutStreamSnapshot));
    error = devDrv->MemCopySync(hostAddr.get(), static_cast<uint64_t>(snapshotLen_),
        device_->GetSnapshotAddr(), static_cast<uint64_t>(snapshotLen_), RT_MEMCPY_DEVICE_TO_HOST, false);
    ERROR_RETURN(error, "Failed to Memcpy snapshot from dev to host");
    RtsTimeoutStreamSnapshot *streamTaskInfo = RtPtrToPtr<RtsTimeoutStreamSnapshot *,  char_t *>(hostAddr.get());
    if ((streamTaskInfo->stream_num == 0U) || (streamTaskInfo->stream_num > MAX_STREAM_NUM_CLOUD)) {
        RT_LOG(RT_LOG_INFO, "get stream wait timeout snapshot stream_num:%hu", streamTaskInfo->stream_num);
        return RT_ERROR_NONE;
    }
    RT_LOG(RT_LOG_DEBUG, "get stream wait timeout snapshot stream_num:%hu ok", streamTaskInfo->stream_num);
    for (uint32_t i = 0U; i < streamTaskInfo->stream_num; i++) {
        (void)memset_s(errStr, sizeof(errMsg), 0U, sizeof(errMsg));
        const uint16_t streamId = streamTaskInfo->detailInfo[i].stream_id;
        const uint16_t taskId = streamTaskInfo->detailInfo[i].task_id;
        TaskInfo *tsk = GetTaskInfo(device_, static_cast<uint32_t>(streamId), static_cast<uint32_t>(taskId), true);
        if (tsk == nullptr) {
            RT_LOG(RT_LOG_ERROR, "stream_id=%hu task_id=%hu cannot find", streamId, taskId);
            continue;
        }
        countNum = sprintf_s(errStr, static_cast<size_t>(MSG_LENGTH),
            "stream_id=%hu, task_id=%hu, taskType=%d (%s)",
            streamId, taskId, tsk->type, tsk->typeName);
        if ((countNum < 0) || (countNum > MSG_LENGTH)) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call sprintf_s, count=%d.", countNum);
            continue;
        }
        PrintSnapshotInfo(tsk, errStr, countNum);
        RT_LOG(RT_LOG_ERROR, "%s.", errStr);
    }

    device_->SetSnapshotFlag(false);
    RT_LOG(RT_LOG_INFO, "get stream wait timeout snapshot suc, snapshotFlag=%d", device_->GetSnapshotFlag());
    return RT_ERROR_NONE;
}

void DeviceErrorProc::ProduceProcNum()
{
    (void)needProcNum_++;
}

void DeviceErrorProc::ConsumeProcNum(const uint32_t procNum)
{
    const uint64_t num = procNum;
    (void)consumeNum_.fetch_add(num);
}

rtError_t DeviceErrorProc::ProcessStarsWaitTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
                                                            const uint64_t errorNumber,
                                                            const Device * const dev,
                                                            const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.timeoutErrorInfo.streamId),
        info->u.timeoutErrorInfo.taskId);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    uint8_t type = info->u.timeoutErrorInfo.waitType;

    if (type == RT_STARS_SQE_TYPE_NOTIFY_WAIT) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "notify wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_id:%hu, "
            "notify_id=%u, timeout=%us.", info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.notifyInfo.notifyId, info->u.timeoutErrorInfo.wait.notifyInfo.timeout);
    } else if (type == RT_STARS_SQE_TYPE_EVENT_WAIT) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "event wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_id:%hu, "
            "event_id=%u, timeout=%us.", info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId,
            info->u.timeoutErrorInfo.wait.eventInfo.eventId, info->u.timeoutErrorInfo.wait.eventInfo.timeout);
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM,
            "type = %hhu,The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "event wait timeout occurred during task execution, stream_id:%hu, sq_id:%hu, task_id:%hu.",
            type, info->u.timeoutErrorInfo.chipId, info->u.timeoutErrorInfo.dieId, errorNumber,
            info->u.timeoutErrorInfo.streamId, info->u.timeoutErrorInfo.sqId, info->u.timeoutErrorInfo.taskId);
    }
    if (errTaskPtr == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_RTS, "Error task reported by the device stream.");
    }
    return RT_ERROR_NONE;
}


rtError_t ProcessStarsAicpuErrorInfo(const StarsDeviceErrorInfo * const info,
                                                      const uint64_t errorNumber,
                                                      const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    if (info->u.aicpuErrorInfo.comm.coreNum == 0U) {
        return RT_ERROR_NONE;
    }
    const uint16_t type = info->u.coreErrorInfo.comm.type;
    bool isFftsPlusTask = false;
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    /* aicpu error by ffts+ */
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.aicpuErrorInfo.comm.streamId),
            static_cast<uint32_t>(info->u.aicpuErrorInfo.comm.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
        if ((errTaskPtr->type ==  TS_TASK_TYPE_FFTS_PLUS) && (type == FFTS_PLUS_AICPU_ERROR)) {
            isFftsPlusTask = true;
        }
    }
    /* aicpu error by topic scheduler */
    if (type == static_cast<uint16_t>(AICPU_ERROR)) {
        std::string msg = "aicpu execute failed";
        const uint64_t errcode = info->u.aicpuErrorInfo.aicpu.rspErrorInfo.errcode;
        const auto it = g_aicpuErrorMapInfo.find(errcode);
        if (it != g_aicpuErrorMapInfo.end()) {
            msg = it->second;
        }
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "an exception occurred during AICPU execution, stream_id:%u, %s:%u, errcode:%" PRIu64 ", msg:%s.",
            info->u.aicpuErrorInfo.comm.chipId, info->u.aicpuErrorInfo.comm.dieId, errorNumber,
            info->u.aicpuErrorInfo.aicpu.rspErrorInfo.streamId, TaskIdDesc(), info->u.aicpuErrorInfo.aicpu.rspErrorInfo.taskId,
            errcode, msg.c_str());
        return RT_ERROR_NONE;
    }

    for (uint32_t coreIdx = 0; coreIdx < static_cast<uint32_t>(info->u.aicpuErrorInfo.comm.coreNum); coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "an exception occurred during fftsplus AICPU execution, aicpuId:%hhu, "
            "aicpuState:%hhu, aicpuTslotid:%hhu, aicpuCxtid:%hu, aicpuThreadid:%hu.",
            info->u.aicpuErrorInfo.comm.chipId, info->u.aicpuErrorInfo.comm.dieId, errorNumber,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuId,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuState,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuTslotid,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuCxtid,
            info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuThreadid);
        if (isFftsPlusTask) {
            fftsPlusErrInfo.contextId = info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuCxtid;
            fftsPlusErrInfo.threadId = info->u.aicpuErrorInfo.aicpu.info[coreIdx].aicpuThreadid;
            fftsPlusErrInfo.errType = info->u.aicpuErrorInfo.comm.type;
            PushBackErrInfo(errTaskPtr, static_cast<const void *>(&fftsPlusErrInfo),
                            static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
        }
    }
    return RT_ERROR_NONE;
}

static void RecordSdmaErrorInfo(const Device * const dev, uint32_t coreNum, TaskInfo *errTaskPtr,
    const StarsDeviceErrorInfo * const info, const uint64_t errorNumber)
{
    for (uint32_t coreIdx = 0U; coreIdx < coreNum; coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
            "there is a sdma error, sdma channel is %hhu, "
            "sdmaBlkFsmState=0x%x, dfxSdmaBlkFsmOstCnt=0x%x, sdmaChFree=0x%x, "
            "irqStatus=0x%x, cqeStatus=0x%x ",
            info->u.sdmaErrorInfo.comm.chipId, info->u.sdmaErrorInfo.comm.dieId, errorNumber,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].sdmaChannelId,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].sdmaBlkFsmState,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].dfxSdmaBlkFsmOstCnt,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].sdmaChFree,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].irqStatus,
            info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].cqeStatus);
        if (errTaskPtr != nullptr) {
            const uint32_t cqeStatus = info->u.sdmaErrorInfo.sdma.starsInfo[coreIdx].cqeStatus;
            GetMteErrFromCqeStatus(errTaskPtr, dev, cqeStatus);
            RT_LOG(RT_LOG_ERROR, "Get sdma mte error, stream_id=%hu, task_id=%hu, errorCode=%u.",
                info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId, errTaskPtr->mte_error);
        }
    }
}

static void ProcessCoreErrors(const StarsDeviceErrorInfo * const info, const uint64_t errorNumber,
    const Device * const dev, TaskInfo *errTaskPtr, const uint32_t coreNum)
{
    bool isFftsPlusTask = false;
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    if ((errTaskPtr != nullptr) && (errTaskPtr->type == TS_TASK_TYPE_FFTS_PLUS)) {
        isFftsPlusTask = true;
    }
    uint32_t fftsPluscqeStatus = 0;
    for (uint32_t coreIdx = 0U; coreIdx < coreNum; coreIdx++) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
            "there is a fftsplus sdma error, sdma channel is %hhu, "
            "sdmaState=0x%x, sdmaTslotid=0x%x, sdmaCxtid=0x%x, sdmaThreadid=0x%x, "
            "irqStatus=0x%x, cqeStatus=0x%x.",
            info->u.sdmaErrorInfo.comm.chipId, info->u.sdmaErrorInfo.comm.dieId, errorNumber,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaChannelId,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaState,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaTslotid,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaCxtid,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaThreadid,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].irqStatus,
            info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].cqeStatus);
        fftsPluscqeStatus = ((info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].cqeStatus) >> 17U) & 0x1FU;
        if (errTaskPtr != nullptr) {
            GetMteErrFromCqeStatus(errTaskPtr, dev, fftsPluscqeStatus);
            RT_LOG(RT_LOG_ERROR, "Get sdma mte error=0x%x, cqeStatus=0x%x.", errTaskPtr->mte_error,
                    fftsPluscqeStatus);
        }
        if (isFftsPlusTask) {
            fftsPlusErrInfo.contextId = info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaCxtid;
            fftsPlusErrInfo.threadId = info->u.sdmaErrorInfo.sdma.fftsPlusInfo[coreIdx].sdmaThreadid;
            fftsPlusErrInfo.errType = info->u.sdmaErrorInfo.comm.type;
            PushBackErrInfo(errTaskPtr, static_cast<const void *>(&fftsPlusErrInfo),
                            static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
        }
    }
}

rtError_t DeviceErrorProc::ProcessStarsSdmaErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc *const insPtr)
{
    UNUSED(insPtr);
    RUNTIME_NULL_NO_PROC_WITH_RET(info);
    RUNTIME_NULL_NO_PROC_WITH_RET(dev);
    const uint16_t type = info->u.sdmaErrorInfo.comm.type;
    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.streamId),
            static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.taskId));
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }
    const uint32_t coreNum = static_cast<uint32_t>(info->u.sdmaErrorInfo.comm.coreNum);
    if (type == static_cast<uint16_t>(SDMA_ERROR)) {
        RecordSdmaErrorInfo(dev, coreNum, errTaskPtr, info, errorNumber);
        if (errTaskPtr == nullptr) {
            RT_LOG_CALL_MSG(ERR_MODULE_GE, "Error task reported by the device stream.");
        }
    } else {
        ProcessCoreErrors(info, errorNumber, dev, errTaskPtr, coreNum);
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsHcclFftsPlusTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
                                                                    const uint64_t errorNumber,
                                                                    const Device * const dev,
                                                                    const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    TaskInfo *errTask =
        dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.hcclFftsplusTimeoutInfo.common.streamId),
        info->u.hcclFftsplusTimeoutInfo.common.taskId);
    if (errTask != nullptr) {
        errTask->isRingbufferGet = true;
    }

    uint32_t ctxNum = info->u.hcclFftsplusTimeoutInfo.errConetxtNum < RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM ?
        info->u.hcclFftsplusTimeoutInfo.errConetxtNum : RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM;
    if (info->u.hcclFftsplusTimeoutInfo.common.timeout == RT_STARS_DEFAULT_HCCL_FFTSPLUS_TIMEOUT) {
        RT_LOG_CALL_MSG(ERR_MODULE_HCCL, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "hccl fftsplus task timeout occurred during task execution, stream_id:%hu, sq_id:%hu, "
            "task_id:%hu, stuck notify num:%u, timeout=30min(default).", info->u.hcclFftsplusTimeoutInfo.common.chipId,
            info->u.hcclFftsplusTimeoutInfo.common.dieId, errorNumber,
            info->u.hcclFftsplusTimeoutInfo.common.streamId, info->u.hcclFftsplusTimeoutInfo.common.sqId,
            info->u.hcclFftsplusTimeoutInfo.common.taskId, ctxNum);
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_HCCL, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
            "hccl fftsplus task timeout occurred during task execution, stream_id:%hu, sq_id:%hu, "
            "task_id:%hu, stuck notify num:%u, timeout=%us.", info->u.hcclFftsplusTimeoutInfo.common.chipId,
            info->u.hcclFftsplusTimeoutInfo.common.dieId, errorNumber,
            info->u.hcclFftsplusTimeoutInfo.common.streamId, info->u.hcclFftsplusTimeoutInfo.common.sqId,
            info->u.hcclFftsplusTimeoutInfo.common.taskId, ctxNum, info->u.hcclFftsplusTimeoutInfo.common.timeout);
    }
    for (uint32_t i = 0; i < ctxNum; i++) {
        fftsPlusErrInfo.errType = HCCL_FFTSPLUS_TIMEOUT_ERROR;
        fftsPlusErrInfo.contextId = info->u.hcclFftsplusTimeoutInfo.contextInfo.notifyInfo[i].contextId;
        RT_LOG_CALL_MSG(ERR_MODULE_HCCL, "The %u stuck notify wait context info:(context_id=%u, notify_id=%u).", i,
            info->u.hcclFftsplusTimeoutInfo.contextInfo.notifyInfo[i].contextId,
            info->u.hcclFftsplusTimeoutInfo.contextInfo.notifyInfo[i].notifyId);
        if (errTask != nullptr) {
            PushBackErrInfo(errTask, static_cast<const void *>(&fftsPlusErrInfo),
                static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
        }
    }

    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsDvppErrorInfo(const StarsDeviceErrorInfo * const info,
                                                     const uint64_t errorNumber,
                                                     const Device * const dev, const DeviceErrorProc *const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev,
        static_cast<uint32_t>(info->u.dvppErrorInfo.streamId),
        static_cast<uint32_t>(info->u.dvppErrorInfo.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "an exception occurred during DVPP task execution, stream_id:%u, %s:%u, errcode:%hu, sqe_type=%hu",
        info->u.dvppErrorInfo.chipId, info->u.dvppErrorInfo.dieId, errorNumber, info->u.dvppErrorInfo.streamId,
        TaskIdDesc(), info->u.dvppErrorInfo.taskId, info->u.dvppErrorInfo.exceptionType,
        info->u.dvppErrorInfo.sqeType);
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsDsaErrorInfo(const StarsDeviceErrorInfo * const info,
                                                    const uint64_t errorNumber,
                                                    const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    UNUSED(dev);

    if (info == nullptr) {
        return RT_ERROR_NONE;
    }
    if (info->u.dsaErrorInfo.type == static_cast<uint16_t>(DSA_ERROR)) {
        for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.dsaErrorInfo.coreNum); coreIdx++) {
            RT_LOG_CALL_MSG(ERR_MODULE_FE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
                "there is a dsa error, dsa channel is %hhu, error intr status=0x%x.",
                info->u.dsaErrorInfo.chipId, info->u.dsaErrorInfo.dieId, errorNumber,
                info->u.dsaErrorInfo.info[coreIdx].chanId,
                info->u.dsaErrorInfo.info[coreIdx].chanErr);
        }
        TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.dsaErrorInfo.sqe.sqeHeader.rt_stream_id),
        info->u.dsaErrorInfo.sqe.sqeHeader.task_id);
        if (errTaskPtr != nullptr) {
            errTaskPtr->isRingbufferGet = true;
        }
    } else {
        TaskInfo *realFaultTaskPtr = insPtr->GetRealFaultTaskPtr(); // maybe not match ringbuffer task.
        bool isNeedProFftsPlusErr = false;
        rtFftsPlusTaskErrInfo_t fftsPlusErr = {};
        if ((realFaultTaskPtr != nullptr) && (realFaultTaskPtr->type ==  TS_TASK_TYPE_FFTS_PLUS)) {
            isNeedProFftsPlusErr = true;
            realFaultTaskPtr->isRingbufferGet = true;
        }
        for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.dsaErrorInfo.coreNum); coreIdx++) {
            RT_LOG_CALL_MSG(ERR_MODULE_FE, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ". "
                "there is a fftsplus dsa error, dsa channel is %hhu, error intr status=0x%x, "
                "dsaCtxid=0x%x, dsaThreadid=0x%x.",
                info->u.dsaErrorInfo.chipId, info->u.dsaErrorInfo.dieId, errorNumber,
                info->u.dsaErrorInfo.info[coreIdx].chanId,
                info->u.dsaErrorInfo.info[coreIdx].chanErr,
                info->u.dsaErrorInfo.info[coreIdx].ctxId,
                info->u.dsaErrorInfo.info[coreIdx].threadId);
            if (isNeedProFftsPlusErr) {
                fftsPlusErr.contextId = info->u.dsaErrorInfo.info[coreIdx].ctxId;
                fftsPlusErr.threadId = info->u.dsaErrorInfo.info[coreIdx].threadId;
                fftsPlusErr.errType = info->u.dsaErrorInfo.type;
                fftsPlusErr.dsaSqe = info->u.dsaErrorInfo.sqe;
                PushBackErrInfo(realFaultTaskPtr, static_cast<const void *>(&fftsPlusErr),
                                static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsSqeErrorInfo(const StarsDeviceErrorInfo * const info,
                                                    const uint64_t errorNumber,
                                                    const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.sqeErrorInfo.streamId), static_cast<uint32_t>(info->u.sqeErrorInfo.taskId), true);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
    }

    RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "sqe error occurred during task execution, stream_id:%hu, %s:%hu, sq_id:%hu, sq_head:%hu.",
        info->u.sqeErrorInfo.chipId, info->u.sqeErrorInfo.dieId, errorNumber, info->u.sqeErrorInfo.streamId,
        TaskIdDesc(), info->u.sqeErrorInfo.taskId, info->u.sqeErrorInfo.sqId, info->u.sqeErrorInfo.sqHead);

    const uint32_t * const sqe = reinterpret_cast<const uint32_t *>(&(info->u.sqeErrorInfo.sqe));
    for (size_t i = 0UL; i < (sizeof(rtStarsSqe_t) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_ERROR, "sqe[%zu]=0x%08x.", i, *(sqe + i));
    }

    return RT_ERROR_NONE;
}

template <typename CoreInfo, typename ExtInfo>
static void MergeCoreExtByIndex(CoreInfo& merged, const uint32_t coreNum, const ExtInfo* const extData,
    const uint32_t maxCoreNum)
{
    if (extData == nullptr) {
        return;
    }

    using MergedCoreInfo = typename std::remove_reference<decltype(merged.info[0])>::type;
    using ExtCoreInfo = typename std::remove_reference<decltype(extData->info[0])>::type;
    // Ext 结构从 aicCond 开始才是需要合并，前面的 coreId/validSize 只用于匹配和限长。
    constexpr size_t extPayloadOffset = offsetof(ExtCoreInfo, aicCond);
    constexpr size_t mergedPayloadOffset = offsetof(MergedCoreInfo, aicCond);
    constexpr size_t extPayloadMaxSize = sizeof(ExtCoreInfo) - extPayloadOffset;
    constexpr size_t mergedPayloadMaxSize = sizeof(MergedCoreInfo) - mergedPayloadOffset;
    constexpr size_t payloadMaxCopySize = std::min(extPayloadMaxSize, mergedPayloadMaxSize);

    const uint32_t extCoreNum = std::min<uint32_t>(extData->comm.coreNum, maxCoreNum);
    const uint32_t mergeNum = std::min<uint32_t>(coreNum, extCoreNum);
    for (uint32_t i = 0U; i < mergeNum; i++) {
        // RTS 保证 base/ext core 顺序一致；coreId 校验用于防御异常协议数据。
        if (merged.info[i].coreId != extData->info[i].coreId) {
            continue;
        }

        // validSize 由 TS 上报，拷贝时再受源/目的结构容量约束，避免协议扩展或异常值导致越界。
        const size_t payloadCopySize = std::min<size_t>(extData->info[i].validSize, payloadMaxCopySize);
        if (payloadCopySize == 0U) {
            continue;
        }
        // 只把 Ext payload 合并到目标结构的 aicCond 及其后续扩展字段，不覆盖 base 原始错误字段。
        (void)memcpy_s(
            RtPtrToPtr<uint8_t *, MergedCoreInfo *>(&merged.info[i]) + mergedPayloadOffset, mergedPayloadMaxSize,
            RtPtrToPtr<const uint8_t *, const ExtCoreInfo *>(&extData->info[i]) + extPayloadOffset, payloadCopySize);
    }
}

static void MergeStarv2CoreInfo(
    DavidCoreErrorInfo& merged, const DavidCoreErrorInfoRingBuffer& base, const DavidCoreErrorInfoExt* extData)
{
    merged.comm = base.comm;
    const uint32_t coreNum = std::min<uint32_t>(base.comm.coreNum, MAX_CORE_BLOCK_NUM_ON_DAVID);
    for (uint32_t i = 0U; i < coreNum; i++) {
        (void)memcpy_s(
            &merged.info[i], sizeof(DavidOneCoreErrorInfo), &base.info[i], sizeof(DavidOneCoreErrorInfoRingBuffer));
        constexpr size_t dstOffset = offsetof(DavidOneCoreErrorInfo, aicCond);
        constexpr size_t dstMaxSize = sizeof(DavidOneCoreErrorInfo) - dstOffset;
        (void)memset_s(RtPtrToPtr<uint8_t *, DavidOneCoreErrorInfo *>(&merged.info[i]) + dstOffset,
            dstMaxSize, 0, dstMaxSize);
    }

    MergeCoreExtByIndex(merged, coreNum, extData, MAX_CORE_BLOCK_NUM_ON_DAVID);
}

static void MergeStarsCoreInfo(
    StarsCoreErrorInfo& merged, const StarsCoreErrorInfoRingBuffer& base, const StarsCoreErrorInfoExt* extData)
{
    merged.comm = base.comm;
    // base 的 coreNum 受 Stars V1 最大 core 块数保护，避免 TS 异常值导致数组越界。
    const uint32_t coreNum = std::min<uint32_t>(base.comm.coreNum, MAX_CORE_BLOCK_NUM);
    for (uint32_t i = 0U; i < coreNum; i++) {
        // 先拷贝 ringbuffer base 字段，形成后续统一处理需要的完整 core 信息前缀。
        (void)memcpy_s(
            &merged.info[i], sizeof(StarsOneCoreErrorInfo), &base.info[i], sizeof(StarsOneCoreErrorInfoRingBuffer));
        constexpr size_t dstOffset = offsetof(StarsOneCoreErrorInfo, aicCond);
        constexpr size_t dstMaxSize = sizeof(StarsOneCoreErrorInfo) - dstOffset;
        // base 不包含 Ext 字段，先清零 aicCond 及后续扩展区；没有 Ext 时这些字段保持 0。
        (void)memset_s(RtPtrToPtr<uint8_t *, StarsOneCoreErrorInfo *>(&merged.info[i]) + dstOffset,
            dstMaxSize, 0, dstMaxSize);
    }

    // 如果后续紧邻的 Ext 类型合法，则按协议顺序将 aicCond 等扩展字段补到 merged 中。
    MergeCoreExtByIndex(merged, coreNum, extData, MAX_CORE_BLOCK_NUM);
}

static void MergeExtIntoFusionKernelInfo(
    StarsDeviceErrorInfo& merged, const StarsDeviceErrorInfoRingBuffer& base, const DavidCoreErrorInfoExt* aicExtData,
    const DavidCoreErrorInfoExt* aivExtData)
{
    merged.u.fusionKernelErrorInfo.comm = base.u.fusionKernelErrorInfo.comm;
    merged.u.fusionKernelErrorInfo.sqeLength = base.u.fusionKernelErrorInfo.sqeLength;
    merged.u.fusionKernelErrorInfo.subType = base.u.fusionKernelErrorInfo.subType;
    merged.u.fusionKernelErrorInfo.cqeStatus = base.u.fusionKernelErrorInfo.cqeStatus;
    merged.u.fusionKernelErrorInfo.aicError = base.u.fusionKernelErrorInfo.aicError;
    merged.u.fusionKernelErrorInfo.aivError = base.u.fusionKernelErrorInfo.aivError;
    merged.u.fusionKernelErrorInfo.aicpuError = base.u.fusionKernelErrorInfo.aicpuError;
    merged.u.fusionKernelErrorInfo.ccuError = base.u.fusionKernelErrorInfo.ccuError;
    merged.u.fusionKernelErrorInfo.resv = base.u.fusionKernelErrorInfo.resv;
    (void)memcpy_s(
        merged.u.fusionKernelErrorInfo.davidSqe, sizeof(merged.u.fusionKernelErrorInfo.davidSqe),
        base.u.fusionKernelErrorInfo.davidSqe, sizeof(base.u.fusionKernelErrorInfo.davidSqe));
    (void)memcpy_s(
        &merged.u.fusionKernelErrorInfo.u, sizeof(merged.u.fusionKernelErrorInfo.u), &base.u.fusionKernelErrorInfo.u,
        sizeof(base.u.fusionKernelErrorInfo.u));

    MergeStarv2CoreInfo(merged.u.fusionKernelErrorInfo.aicInfo, base.u.fusionKernelErrorInfo.aicInfo, aicExtData);
    MergeStarv2CoreInfo(merged.u.fusionKernelErrorInfo.aivInfo, base.u.fusionKernelErrorInfo.aivInfo, aivExtData);
}

static const RingBufferElementInfo* GetRingBufferElement(
    const DevRingBufferCtlInfo* const ctlInfo, const size_t elementSize, const uint32_t elementIndex)
{
    constexpr size_t headSize = sizeof(DevRingBufferCtlInfo);
    // ringbuffer 内存布局为控制头 + N 个定长元素，index 对应第 index 个元素的起始地址。
    const uint8_t* const elementAddr = RtPtrToPtr<const uint8_t*, const DevRingBufferCtlInfo*>(ctlInfo) + headSize +
        (static_cast<size_t>(elementIndex) * elementSize);
    return RtPtrToPtr<const RingBufferElementInfo*, const uint8_t*>(elementAddr);
}

template <typename ExtInfo>
static uint32_t CollectCoreExtInfos(
    const DevRingBufferCtlInfo* ctlInfo, size_t elementSize, uint32_t head, uint32_t tail,
    uint32_t baseType, uint32_t maxExt, const ExtInfo** aicExt, const ExtInfo** aivExt)
{
    *aicExt = nullptr;
    *aivExt = nullptr;
    uint32_t extElementCount = 0U;

    for (uint32_t i = 0U; i < maxExt; i++) {
        // 从当前 base 后的 head 位置开始预读连续 Ext 元素，已确认的 Ext 数量决定下一个预读槽位。
        const uint32_t extElementIndex = (head + extElementCount) % (ctlInfo->ringBufferLen);
        if (extElementIndex == tail) {
            break;
        }
        const RingBufferElementInfo* nextInfo = GetRingBufferElement(ctlInfo, elementSize, extElementIndex);
        if (!IsMatchedRingBufferExtType(baseType, nextInfo->errorType)) {
            break;
        }
        const ExtInfo* extData = RtPtrToPtr<const ExtInfo*, const RingBufferElementInfo*>(nextInfo + 1);
        if (nextInfo->errorType == static_cast<uint32_t>(AICORE_EXT_ERROR) && *aicExt == nullptr) {
            *aicExt = extData;
            extElementCount++;
        } else if (nextInfo->errorType == static_cast<uint32_t>(AIVECTOR_EXT_ERROR) && *aivExt == nullptr) {
            *aivExt = extData;
            extElementCount++;
        } else {
            break;
        }
    }
    return extElementCount;
}

static uint32_t CollectStarv2ExtInfos(
    const DevRingBufferCtlInfo* ctlInfo, size_t elementSize, uint32_t head, uint32_t tail,
    uint32_t baseType, const DavidCoreErrorInfoExt** aicExt, const DavidCoreErrorInfoExt** aivExt)
{
    const uint32_t maxExt = (baseType == static_cast<uint32_t>(FUSION_KERNEL_ERROR)) ? 2U : 1U;
    return CollectCoreExtInfos(ctlInfo, elementSize, head, tail, baseType, maxExt, aicExt, aivExt);
}

static uint32_t CollectStarsExtInfos(
    const DevRingBufferCtlInfo* ctlInfo, size_t elementSize, uint32_t head, uint32_t tail,
    uint32_t baseType, const StarsCoreErrorInfoExt** aicExt, const StarsCoreErrorInfoExt** aivExt)
{
    return CollectCoreExtInfos(ctlInfo, elementSize, head, tail, baseType, 1U, aicExt, aivExt);
}

void DeviceErrorProc::ProcessStarsRingBufferErrorInfo(const RingBufferElementInfo * const info,
    const bool isPrintTaskInfo, const StarsDeviceErrorInfo * const errorInfo) const
{
    if (isPrintTaskInfo) {
        PrintTaskErrorInfo(info->errorType, errorInfo);
    }

    std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> funcMap;
    UpdateDeviceErrorProcFunc(funcMap);
    const auto it = funcMap.find(info->errorType);
    if (it != funcMap.end()) {
        const rtError_t error = it->second(errorInfo, info->errorNumber, device_, this);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "Failed to get error information from device.");
        }
    } else {
        RT_LOG(RT_LOG_WARNING, "Failed to find function to process the error information.");
    }
}

void DeviceErrorProc::PrintTaskErrorInfo(const uint32_t errorType,
    const StarsDeviceErrorInfo * const errorInfo) const
{
    StreamTaskId sTaskId;
    GetStreamAndTaskIdFromErrorInfo(errorType, errorInfo, sTaskId);
    TaskInfo *errTaskPtr = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(sTaskId.streamId),
        static_cast<uint16_t>(sTaskId.taskId));
    if (errTaskPtr != nullptr) {
        PrintErrorInfo(errTaskPtr, device_->Id_());
    }
}

rtError_t DeviceErrorProc::ProcessOneElementInRingBufferImpl(
    const DevRingBufferCtlInfo* const ctlInfo, uint32_t head, const uint32_t tail, const bool isPrintTaskInfo,
    const TaskInfo* const taskPtr, size_t elementSize, const ExtProcessorFn& extMergeProcessor) const
{
    constexpr size_t headSize = sizeof(DevRingBufferCtlInfo);
    if (elementSize == 0U) {
        RT_LOG(RT_LOG_ERROR, "The element size in ringbuffer is invalid.");
        (void)PrintRingbufferErrorInfo(ctlInfo);
        return RT_ERROR_INVALID_VALUE;
    }
    RT_LOG(RT_LOG_INFO, "it need to process %u errMessages, headSize=%zu, elementSize=%zu.",
        (tail + ctlInfo->ringBufferLen - head) % ctlInfo->ringBufferLen, headSize, elementSize);

    while (head != tail) {
        // 先按当前 head 获取元素，再推进 head；Ext 合并逻辑可继续消费后续紧邻的 Ext 元素。
        const RingBufferElementInfo* const elementInfo = GetRingBufferElement(ctlInfo, elementSize, head);

        RT_LOG(RT_LOG_INFO, "head info %u, tail info=%u, type=%u.", head, tail,
            (taskPtr == nullptr ? 0xFFU : static_cast<uint32_t>(taskPtr->type)));

        head = (head + 1U) % (ctlInfo->ringBufferLen);

        if (elementInfo->errorType > static_cast<uint32_t>(ERROR_TYPE_BUTT)) {
            RT_LOG(RT_LOG_WARNING, "Failed to get error information from device, error type=%u.", elementInfo->errorType);
            continue;
        }

        const StarsDeviceErrorInfoRingBuffer* const rbErrorInfo =
            RtPtrToPtr<const StarsDeviceErrorInfoRingBuffer*, const RingBufferElementInfo*>(elementInfo + 1);

        // base-with-ext 类型需要把当前 base payload 和后续紧邻 Ext payload 先合并，再进入统一错误处理。
        if (IsRingBufferBaseErrorType(elementInfo->errorType)) {
            StarsDeviceErrorInfo mergedErrorInfo = {};
            extMergeProcessor(ctlInfo, elementSize, head, tail, elementInfo->errorType, rbErrorInfo, mergedErrorInfo);
            ProcessStarsRingBufferErrorInfo(elementInfo, isPrintTaskInfo, &mergedErrorInfo);
            continue;
        }

        // Ext 只作为 base 的补充信息存在；如果单独出现，说明前面没有可合并 base，直接跳过。
        if (IsRingBufferExtErrorType(elementInfo->errorType)) {
            RT_LOG(RT_LOG_WARNING, "Standalone ext error type=%u without base, skip.", elementInfo->errorType);
            continue;
        }

        StarsDeviceErrorInfo procErrorInfo = {};
        // 普通错误没有 Ext，直接将 ringbuffer payload 安全拷贝到统一处理结构。
        CopyRingBufferPayload(procErrorInfo, rbErrorInfo, elementSize);

        ProcessStarsRingBufferErrorInfo(elementInfo, isPrintTaskInfo, &procErrorInfo);
    }
    return RT_ERROR_NONE;
}

rtError_t DeviceErrorProc::ProcessStarsOneElementInRingBuffer(const DevRingBufferCtlInfo * const ctlInfo,
    uint32_t head, const uint32_t tail, const bool isPrintTaskInfo, const TaskInfo * const taskPtr) const
{
    // Stars V1 的 Ext 处理器：从当前 base 后面尝试收集一个匹配的 AIC/AIV Ext 元素。
    auto starsExtProcessor = [](
                                 const DevRingBufferCtlInfo* ctlInfo, size_t elementSize,
                                 uint32_t& head, uint32_t tail, uint32_t errorType,
                                 const StarsDeviceErrorInfoRingBuffer* rbErrorInfo,
                                 StarsDeviceErrorInfo& mergedOut) {
        const StarsCoreErrorInfoExt* aicExtData = nullptr;
        const StarsCoreErrorInfoExt* aivExtData = nullptr;
        const uint32_t extConsumed = CollectStarsExtInfos(
            ctlInfo, elementSize, head, tail, errorType, &aicExtData, &aivExtData);
        // 已被合并的 Ext 元素不再作为独立错误处理，需要推进 head 跳过它们。
        if (extConsumed > 0U) {
            head = (head + extConsumed) % (ctlInfo->ringBufferLen);
        }
        // Stars V1 每个 base 最多合并一个 Ext，AIC/AIV 二选一取实际收集到的那个。
        const StarsCoreErrorInfoExt* extData = (aicExtData != nullptr) ? aicExtData : aivExtData;
        MergeStarsCoreInfo(mergedOut.u.coreErrorInfo, rbErrorInfo->u.coreErrorInfo, extData);
    };
    // Stars V1 使用固定扩展 element size；具体遍历、类型判断和普通错误处理由公共实现完成。
    return ProcessOneElementInRingBufferImpl(
        ctlInfo, head, tail, isPrintTaskInfo, taskPtr, RINGBUFFER_EXT_ONE_ELEMENT_LENGTH, starsExtProcessor);
}

rtError_t DeviceErrorProc::ProcessStarv2OneElementInRingBuffer(
    const DevRingBufferCtlInfo* const ctlInfo, uint32_t head, const uint32_t tail, const bool isPrintTaskInfo,
    const TaskInfo* const taskPtr) const
{
    auto starv2ExtProcessor = [](
                                 const DevRingBufferCtlInfo* ctlInfo, size_t elementSize,
                                 uint32_t& head, uint32_t tail, uint32_t errorType,
                                 const StarsDeviceErrorInfoRingBuffer* rbErrorInfo,
                                 StarsDeviceErrorInfo& mergedOut) {
        const DavidCoreErrorInfoExt* aicExtData = nullptr;
        const DavidCoreErrorInfoExt* aivExtData = nullptr;
        uint32_t extConsumed = CollectStarv2ExtInfos(
            ctlInfo, elementSize, head, tail, errorType, &aicExtData, &aivExtData);
        if (extConsumed > 0U) {
            head = (head + extConsumed) % (ctlInfo->ringBufferLen);
        }
        if (errorType == static_cast<uint32_t>(FUSION_KERNEL_ERROR)) {
            MergeExtIntoFusionKernelInfo(mergedOut, *rbErrorInfo, aicExtData, aivExtData);
        } else {
            const DavidCoreErrorInfoExt* extData = (aicExtData != nullptr) ? aicExtData : aivExtData;
            MergeStarv2CoreInfo(mergedOut.u.davidCoreErrorInfo, rbErrorInfo->u.davidCoreErrorInfo, extData);
        }
    };
    return ProcessOneElementInRingBufferImpl(
        ctlInfo, head, tail, isPrintTaskInfo, taskPtr, ctlInfo->elementSize, starv2ExtProcessor);
}

// alloc contiguour host mem and dispatch to tsfw
rtError_t DeviceErrorProc::CreateFastRingbuffer()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    rtError_t error = Runtime::Instance()->InitOpExecTimeout(device_);
    ERROR_RETURN(error, "failed to get op execute timeout, ret=%#x.", error);
    COND_RETURN_WITH_NOLOG(!Runtime::Instance()->IsSupportOpTimeoutMs(), RT_ERROR_NONE);
    const std::lock_guard<std::mutex> mutexLock(mutex_);
    COND_RETURN_WITH_NOLOG(fastRingBufferAddr_ != nullptr, RT_ERROR_NONE);

    void* hostMem = nullptr;
    Driver* const devDrv = device_->Driver_();
    error = devDrv->AllocFastRingBufferAndDispatch(&hostMem, fastRingBufferSize_, device_->Id_());
    ERROR_RETURN(error, "Failed to alloc fast ringbuffer memory, size=%zu(bytes).", fastRingBufferSize_);
    (void)memset_s(hostMem, fastRingBufferSize_, 0, fastRingBufferSize_);
    fastRingBufferAddr_ = hostMem;
    InitFastRingBuffer(fastRingBufferAddr_);
    RT_LOG(RT_LOG_INFO, "Create fast ringbuffer successfully, size=%zu(bytes).", fastRingBufferSize_);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
