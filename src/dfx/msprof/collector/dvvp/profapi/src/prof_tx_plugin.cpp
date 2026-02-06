/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_tx_plugin.h"
#include "errno/error_code.h"
#include "utils/utils.h"
#include "runtime/rts/rts_stream.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

namespace ProfAPI {
void ProfTxPlugin::ProftxApiInit(VOID_PTR handle)
{
    loadApi_.ProfLoadApiInit(handle);
}

VOID_PTR ProfTxPlugin::ProftxCreateStamp()
{
    if (proftxCreateStamp_ == nullptr) {
        proftxCreateStamp_ = loadApi_.LoadProfTxApi<decltype(proftxCreateStamp_)>("ProfAclCreateStamp");
        if (proftxCreateStamp_ == nullptr) {
            return nullptr;
        }
    }

    return proftxCreateStamp_();
}

void ProfTxPlugin::ProftxDestroyStamp(VOID_PTR stamp)
{
    if (proftxDestroyStamp_ == nullptr) {
        proftxDestroyStamp_ = loadApi_.LoadProfTxApi<decltype(proftxDestroyStamp_)>("ProfAclDestroyStamp");
        if (proftxDestroyStamp_ == nullptr) {
            return;
        }
    }

    proftxDestroyStamp_(stamp);
}

int32_t ProfTxPlugin::ProftxPush(VOID_PTR stamp)
{
    if (proftxPush_ == nullptr) {
        proftxPush_ = loadApi_.LoadProfTxApi<decltype(proftxPush_)>("ProfAclPush");
        if (proftxPush_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxPush_(stamp);
}

int32_t ProfTxPlugin::ProftxPop()
{
    if (proftxPop_ == nullptr) {
        proftxPop_ = loadApi_.LoadProfTxApi<decltype(proftxPop_)>("ProfAclPop");
        if (proftxPop_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxPop_();
}

int32_t ProfTxPlugin::ProftxRangeStart(VOID_PTR stamp, uint32_t *rangeId)
{
    if (proftxRangeStart_ == nullptr) {
        proftxRangeStart_ = loadApi_.LoadProfTxApi<decltype(proftxRangeStart_)>("ProfAclRangeStart");
        if (proftxRangeStart_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxRangeStart_(stamp, rangeId);
}

int32_t ProfTxPlugin::ProftxRangeStop(uint32_t rangeId)
{
    if (proftxRangeStop_ == nullptr) {
        proftxRangeStop_ = loadApi_.LoadProfTxApi<decltype(proftxRangeStop_)>("ProfAclRangeStop");
        if (proftxRangeStop_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxRangeStop_(rangeId);
}

int32_t ProfTxPlugin::ProftxSetStampTraceMessage(VOID_PTR stamp, const char *msg, uint32_t msgLen)
{
    if (proftxSetStampTraceMessage_ == nullptr) {
        proftxSetStampTraceMessage_ = loadApi_.LoadProfTxApi<decltype(proftxSetStampTraceMessage_)>(
            "ProfAclSetStampTraceMessage");
        if (proftxSetStampTraceMessage_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxSetStampTraceMessage_(stamp, msg, msgLen);
}

int32_t ProfTxPlugin::ProftxMark(VOID_PTR stamp)
{
    if (proftxMark_ == nullptr) {
        proftxMark_ = loadApi_.LoadProfTxApi<decltype(proftxMark_)>("ProfAclMark");
        if (proftxMark_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxMark_(stamp);
}

int32_t ProfTxPlugin::ProftxMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
{
    if (proftxMarkEx_ == nullptr) {
        proftxMarkEx_ = loadApi_.LoadProfTxApi<decltype(proftxMarkEx_)>("ProfAclMarkEx");
        if (proftxMarkEx_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxMarkEx_(msg, msgLen, stream);
}

int32_t ProfTxPlugin::ProftxSetCategoryName(uint32_t category, const char *categoryName)
{
    if (proftxSetCategoryName_ == nullptr) {
        proftxSetCategoryName_ = loadApi_.LoadProfTxApi<decltype(proftxSetCategoryName_)>("ProfAclSetCategoryName");
        if (proftxSetCategoryName_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxSetCategoryName_(category, categoryName);
}

int32_t ProfTxPlugin::ProftxSetStampCategory(VOID_PTR stamp, uint32_t category)
{
    if (proftxSetStampCategory_ == nullptr) {
        proftxSetStampCategory_ = loadApi_.LoadProfTxApi<decltype(proftxSetStampCategory_)>("ProfAclSetStampCategory");
        if (proftxSetStampCategory_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxSetStampCategory_(stamp, category);
}

int32_t ProfTxPlugin::ProftxSetStampPayload(VOID_PTR stamp, const int32_t type, VOID_PTR value)
{
    if (proftxSetStampPayload_ == nullptr) {
        proftxSetStampPayload_ = loadApi_.LoadProfTxApi<decltype(proftxSetStampPayload_)>("ProfAclSetStampPayload");
        if (proftxSetStampPayload_ == nullptr) {
            return PROFILING_FAILED;
        }
    }

    return proftxSetStampPayload_(stamp, type, value);
}

int32_t ProfTxPlugin::ProftxRangePushEx(ACLPROF_EVENT_ATTR_PTR attr)
{
    if (attr == nullptr) {
        MSPROF_LOGE("Param attr is nullptr");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (attr->messageType != MESSAGE_TYPE_TENSOR_INFO) {
        MSPROF_LOGE("Invalid message type, messageType=%d", attr->messageType);
        return PROFILING_FAILED;
    }
    attr_ = attr;
    timeStampPush_ = MsprofSysCycleTime();
    return PROFILING_SUCCESS;
}

int32_t ProfTxPlugin::ProftxRangePop()
{
    if (attr_ == nullptr) {
        MSPROF_LOGE("Param attr is nullptr, Please call ProftxRangePushEx");
        return ACL_ERROR_INVALID_PARAM;
    }
    uint64_t timeStampPop = MsprofSysCycleTime();
    uint64_t timeStampPush = timeStampPush_;
    rtStreamAttr stmAttrId = RT_STREAM_ATTR_CACHE_OP_INFO;
    rtStreamAttrValue_t value;
    const aclprofTensorInfo* tensorInfo = attr_->message.tensorInfo;
    rtStream_t stream = static_cast<rtStream_t>(tensorInfo->stream);
    int32_t ret = ProfAPI::ProfRuntimePlugin::instance()->ProfRtsStreamGetAttribute(stream, stmAttrId, &value);
    if (ret != RT_ERROR_NONE) {
        MSPROF_LOGE("Failed to execute rtsStreamGetAttribute, ret=%d", ret);
        return PROFILING_FAILED;
    }
    if (static_cast<bool>(value.cacheOpInfoSwitch)) {
        return ReportCacheOpInfo2RT(tensorInfo);
    } else {
        return ReportAdditionalInfo(tensorInfo, timeStampPush, timeStampPop);
    }
}

int32_t ProfTxPlugin::ReportAdditionalInfo(const aclprofTensorInfo* tensorInfo, 
                                           uint64_t timeStampPush, uint64_t timeStampPop)
{
    MsprofAdditionalInfo addInfo;
    addInfo.level = MSPROF_REPORT_NODE_LEVEL;
    addInfo.type = MSPROF_REPORT_NODE_TENSOR_INFO_TYPE;
    addInfo.threadId = static_cast<uint32_t>(OsalGetTid());
    addInfo.dataLen = sizeof(tensorInfo->opNameId) + sizeof(tensorInfo->tensorNum) + 
                      (sizeof(aclprofTensor) * tensorInfo->tensorNum);
    addInfo.timeStamp = (timeStampPush >> 1) + (timeStampPop >> 1) + ((timeStampPush & 1) & (timeStampPop & 1));
    uint8_t *dest = static_cast<uint8_t *>(addInfo.data);
    uint64_t destOffset = 0;
    errno_t err = memcpy_s(dest + destOffset, sizeof(tensorInfo->opNameId), 
                           &tensorInfo->opNameId, sizeof(tensorInfo->opNameId));
    if (err != EOK) {
        MSPROF_LOGE("memcpy_s tensorInfo->opNameId failed, result=%d.", err);
        return PROFILING_FAILED;
    }
    destOffset += sizeof(tensorInfo->opNameId);
    err = memcpy_s(dest + destOffset, sizeof(tensorInfo->tensorNum), &tensorInfo->tensorNum, sizeof(tensorInfo->tensorNum));
    if (err != EOK) {
        MSPROF_LOGE("memcpy_s tensorInfo->tensorNum failed, result=%d.", err);
        return PROFILING_FAILED;
    }
    destOffset += sizeof(tensorInfo->tensorNum);
    for (uint32_t i = 0; i < tensorInfo->tensorNum && i <= 5; ++i) {
        aclprofTensor& tensor = tensorInfo->tensors[i];
        err = memcpy_s(dest + destOffset, sizeof(aclprofTensor), &tensor, sizeof(aclprofTensor));
        if (err != EOK) {
            MSPROF_LOGE("memcpy_s tensor failed, result=%d.", err);
            return PROFILING_FAILED;
        }
        destOffset += sizeof(aclprofTensor);
    }
    return MsprofReportAdditionalInfo(0, (void *)(&addInfo), sizeof(MsprofAdditionalInfo));
}

int32_t ProfTxPlugin::ReportCacheOpInfo2RT(const aclprofTensorInfo* tensorInfo)
{
    CacheOpInfoBasic cacheOpInfoBasic;
    size_t infoSize = sizeof(CacheOpInfoBasic) + (sizeof(MsrofTensorData) * tensorInfo->tensorNum);
    void *infoPtr = Utils::ProfMalloc(infoSize);
    if (infoPtr == nullptr) {
        MSPROF_LOGE("malloc CacheOpInfoBasic failed");
        return PROFILING_FAILED;
    }
    uint8_t *dest = static_cast<uint8_t *>(infoPtr);
    uint64_t destOffset = 0;
    cacheOpInfoBasic.taskType = tensorInfo->kernelType;
    cacheOpInfoBasic.blockdim = tensorInfo->blockNums;
    cacheOpInfoBasic.nodeId = tensorInfo->opNameId;
    cacheOpInfoBasic.opType = tensorInfo->opTypeId;
    cacheOpInfoBasic.tensorNum = tensorInfo->tensorNum;
    errno_t err = memcpy_s(dest + destOffset, infoSize - destOffset, &cacheOpInfoBasic, sizeof(cacheOpInfoBasic));
    if (err != EOK) {
        void *freeInfoPtr = static_cast<void *>(infoPtr);
        Utils::ProfFree(freeInfoPtr);
        MSPROF_LOGE("memcpy_s cacheOpInfoBasic failed, result=%d.", err);
        return PROFILING_FAILED;
    }
    destOffset += sizeof(CacheOpInfoBasic);
    for (size_t i = 0; i < tensorInfo->tensorNum && i <= 5; ++i) {
        aclprofTensor& tensor = tensorInfo->tensors[i];
        MsrofTensorData msTensor;
        msTensor.tensorType = tensor.type;
        msTensor.format = tensor.format;
        msTensor.dataType = tensor.dataType;
        for (size_t j = 0; j < MSPROF_GE_TENSOR_DATA_SHAPE_LEN; ++j) {
            msTensor.shape[j] = tensor.shape[j];
        }
        err = memcpy_s(dest + destOffset, infoSize - destOffset, &msTensor, sizeof(MsrofTensorData));
        if (err != EOK) {
            void *freeInfoPtr = static_cast<void *>(infoPtr);
            Utils::ProfFree(freeInfoPtr);
            MSPROF_LOGE("memcpy_s msTensor failed, result=%d.", err);
            return PROFILING_FAILED;
        }
        destOffset += sizeof(MsrofTensorData);
    }
    int32_t ret = ProfAPI::ProfRuntimePlugin::instance()->ProfRtCacheLastTaskOpInfo(infoPtr, infoSize);
    if (ret != RT_ERROR_NONE) {
        void *freeInfoPtr = static_cast<void *>(infoPtr);
        Utils::ProfFree(freeInfoPtr);
        MSPROF_LOGE("Failed to execute rtCacheLastTaskOpInfo, ret=%d", ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void LoadProftxApiInit(VOID_PTR handle)
{
    ProfTxPlugin::GetProftxInstance().ProftxApiInit(handle);
}
}
