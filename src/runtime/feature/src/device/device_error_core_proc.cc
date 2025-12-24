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

#include <array>
#include <map>
#include <utility>
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "task_submit.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "stream_sqcq_manage.hpp"
#include "ctrl_stream.hpp"
#include "stub_task.hpp"
#include "context_manage.hpp"
namespace cce {
namespace runtime {
namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
} // namespace

void DeviceErrorProc::PrintCoreErrorInfo(const DeviceErrorInfo *const coreInfo,
                                         const uint64_t errorNumber,
                                         const std::string &coreType,
                                         const uint64_t coreIdx,
                                         const Device *const dev,
                                         const std::string &errorStr)
{
    /* logs for aic tools, do not modify the item befor making a new agreement with tools */
    RT_LOG_CALL_MSG(ERR_MODULE_TBE,
           "The error from device(%hu), serial number is %" PRIu64 ", "
           "there is an error of %s, core id is %" PRIu64 ", "
           "error code = %#" PRIx64 ", dump info: "
           "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
           "vec error info: %#" PRIx64 ", mte error info: %#" PRIx64 ", "
           "ifu error info: %#" PRIx64 ", ccu error info: %#" PRIx64 ", "
           "cube error info: %#" PRIx64 ", biu error info: %#" PRIx64 ", "
           "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ", errorStr: %s",
           coreInfo->u.coreErrorInfo.deviceId, errorNumber,
           coreType.c_str(), coreInfo->u.coreErrorInfo.info[coreIdx].coreId,
           coreInfo->u.coreErrorInfo.info[coreIdx].aicError,
           coreInfo->u.coreErrorInfo.info[coreIdx].pcStart, coreInfo->u.coreErrorInfo.info[coreIdx].currentPC,
           coreInfo->u.coreErrorInfo.info[coreIdx].vecErrInfo, coreInfo->u.coreErrorInfo.info[coreIdx].mteErrInfo,
           coreInfo->u.coreErrorInfo.info[coreIdx].ifuErrInfo, coreInfo->u.coreErrorInfo.info[coreIdx].ccuErrInfo,
           coreInfo->u.coreErrorInfo.info[coreIdx].cubeErrInfo, coreInfo->u.coreErrorInfo.info[coreIdx].biuErrInfo,
           coreInfo->u.coreErrorInfo.info[coreIdx].aicErrorMask, coreInfo->u.coreErrorInfo.info[coreIdx].paraBase,
           errorStr.c_str());
    if ((dev != nullptr) && (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AICORE_ERROR)) &&
        (dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_AIC_ERR_REG_EXT))) {
        RT_LOG_CALL_MSG(ERR_MODULE_TBE,
            "The extend info from device(%hu), serial number is %" PRIu64 ", there is %s error, core id is %" PRIu64
            ", aicore int: %#" PRIx64 ", aicore error2: %#" PRIx64 ", axi clamp ctrl: %#" PRIx64
            ", axi clamp state: %#" PRIx64
            ", biu status0: %#" PRIx64 ", biu status1: %#" PRIx64
            ", clk gate mask: %#" PRIx64 ", dbg addr: %#" PRIx64
            ", ecc en: %#" PRIx64 ", mte ccu ecc 1bit error: %#" PRIx64
            ", vector cube ecc 1bit error: %#" PRIx64 ", run stall: %#" PRIx64
            ", dbg data0: %#" PRIx64 ", dbg data1: %#" PRIx64
            ", dbg data2: %#" PRIx64 ", dbg data3: %#" PRIx64 ", dfx data: %#" PRIx64,
            coreInfo->u.coreErrorInfo.deviceId, errorNumber,
            coreType.c_str(), coreInfo->u.coreErrorInfo.extend_info[coreIdx].coreId,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].aiCoreInt,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].aicError2,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].axiClampCtrl,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].axiClampState,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].biuStatus0,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].biuStatus1,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].clkGateMask,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgAddr,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].eccEn,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].mteCcuEcc1bitErr,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].vecCubeEcc1bitErr,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].runStall,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData0,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData1,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData2,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dbgData3,
            coreInfo->u.coreErrorInfo.extend_info[coreIdx].dfxData);
    }
}

void DeviceErrorProc::PrintCoreInfoErrMsg(const DeviceErrorInfo *const coreInfo)
{
    std::string errLevel(RT_TBE_INNER_ERROR);
    const auto it = errMsgCommMap_.find(coreInfo->u.coreErrorInfo.type);
    if (unlikely(it != errMsgCommMap_.end())) {
        errLevel = it->second;
    }
    std::array<char_t, MSG_LENGTH> buffer {};

    std::string errorCode;
    if (coreInfo->u.coreErrorInfo.coreNum == 0U) {
        errorCode = "none";
    } else {
        errorCode = std::string("0-") + std::to_string(coreInfo->u.coreErrorInfo.coreNum - 1U);
    }

    (void)snprintf_truncated_s(&(buffer[0]), static_cast<size_t>(MSG_LENGTH),
        "The device(%u), core list[%s], error code is:", static_cast<uint32_t>(coreInfo->u.coreErrorInfo.deviceId),
        errorCode.c_str());
    uint16_t coreIdx;
    int32_t countTotal = 0;
    int32_t cnt = 0;
    for (coreIdx = 0U; coreIdx < coreInfo->u.coreErrorInfo.coreNum; ++coreIdx) {
        if ((static_cast<int32_t>(coreIdx) % 4) == 0) {   // 4 表示每4个core一组
            REPORT_INNER_ERROR(errLevel.c_str(), "%s", &(buffer[0]));
            countTotal = sprintf_s(&(buffer[0]), static_cast<size_t>(MSG_LENGTH), "coreId(%2lu):",
                static_cast<uint64_t>(coreIdx));
            COND_RETURN_VOID(countTotal < 0, "sprintf_s failed, cnt=%d.", cnt);
        }
        if ((countTotal >= MSG_LENGTH) || (coreIdx >= MAX_RECORD_CORE_NUM)) {
            break;
        }
        cnt = sprintf_s(&(buffer[countTotal]), static_cast<size_t>(MSG_LENGTH) - static_cast<size_t>(countTotal),
                        "%#16" PRIx64 "    ", coreInfo->u.coreErrorInfo.info[coreIdx].aicError);
        COND_RETURN_VOID(cnt < 0, "sprintf_s failed, cnt=%d, countTotal=%d.", cnt, countTotal);
        countTotal += cnt;
    }
    if (static_cast<int32_t>(coreIdx) > 0) {   // 4 表示每4个core一组, 最后只要cordIdx > 0, 总是会有最后一组没打印
        REPORT_INNER_ERROR(errLevel.c_str(), "%s", &(buffer[0]));
    }
}

rtError_t DeviceErrorProc::ProcessCoreErrorInfo(const DeviceErrorInfo * const coreInfo,
                                                const uint64_t errorNumber,
                                                const Device *const dev)
{
    std::string coreType;
    uint32_t offset = 0U;
    if (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AICORE_ERROR)) {
        coreType = "aicore";
    } else if (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AIVECTOR_ERROR)) {
        coreType = "aivec";
        offset = MAX_AIC_ID;
    } else {
        return RT_ERROR_NONE;
    }

    uint16_t coreIdx;
    const uint16_t coreNum = coreInfo->u.coreErrorInfo.coreNum;
    const uint32_t deviceId = coreInfo->u.coreErrorInfo.deviceId;
    for (coreIdx = 0U; (coreIdx < coreNum) && (static_cast<uint32_t>(coreIdx) < MAX_RECORD_CORE_NUM); ++coreIdx) {
        uint32_t devCoreId = coreInfo->u.coreErrorInfo.info[coreIdx].coreId + offset;
        if ((devCoreId < MAX_AIC_ID + MAX_AIV_ID) && (deviceId < MAX_DEV_ID)) {
            error_pc[deviceId].last_error_pc[devCoreId] = coreInfo->u.coreErrorInfo.info[coreIdx].pcStart;
        }
        std::string errorString;
        uint64_t err = coreInfo->u.coreErrorInfo.info[coreIdx].aicError;
        if (err == 0ULL) {
            errorString = "timeout or trap error.";
            PrintCoreErrorInfo(coreInfo, errorNumber, coreType, static_cast<uint64_t>(coreIdx), dev, errorString);
            continue;
        }
        for (uint64_t i = BitScan(err); i < static_cast<uint64_t>(MAX_BIT_LEN); i = BitScan(err)) {
            BITMAP_CLR(err, i);
            const auto it = errorMapInfo_.find(i);
            if (it == errorMapInfo_.end()) {
                continue;
            }
            // if the string is too long, the log will truncate to 1024.
            // so the error string only show 400.
            if (unlikely((it->second.size() + errorString.size()) > 400UL)) {
                RT_LOG(RT_LOG_WARNING, "The error info is too long.");
                break;
            }
            errorString += it->second;
        }
        PrintCoreErrorInfo(coreInfo, errorNumber, coreType, static_cast<uint64_t>(coreIdx), dev, errorString);
    }

    if ((dev != nullptr) && (coreInfo->u.coreErrorInfo.type == static_cast<uint16_t>(AICORE_ERROR))
        && (dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_AIC_ERR_DHA_INFO))) {
        const uint16_t dhaNum = coreInfo->u.coreErrorInfo.dhaNum;
        RT_LOG(RT_LOG_DEBUG, "dha num:%hu", dhaNum);
        for (uint16_t dhaIndex = 0U; (dhaIndex < dhaNum) && (dhaIndex < MAX_RECORD_DHA_NUM); ++dhaIndex) {
            RT_LOG_CALL_MSG(ERR_MODULE_TBE,
                "The dha(mata) info from device(%hu), dha id is %u, dha status 1 info:0x%x",
                coreInfo->u.coreErrorInfo.deviceId, coreInfo->u.coreErrorInfo.dhaInfo[dhaIndex].regId,
                coreInfo->u.coreErrorInfo.dhaInfo[dhaIndex].status1);
        }
    }
    PrintCoreInfoErrMsg(coreInfo);

    return RT_ERROR_NONE;
}

const std::string GetStarsRingBufferHeadMsg(const uint16_t errType)
{
    static const std::map<uint64_t, std::string> starsRingBufferHeadMsgMap = {
        {AICORE_ERROR, "aicore error"},
        {AIVECTOR_ERROR, "aivec error"},
        {FFTS_PLUS_AICORE_ERROR, "fftsplus aicore error"},
        {FFTS_PLUS_AIVECTOR_ERROR, "fftsplus aivector error"},
        {FFTS_PLUS_SDMA_ERROR, "fftsplus sdma error"},
        {FFTS_PLUS_AICPU_ERROR, "fftsplus aicpu error"},
        {FFTS_PLUS_DSA_ERROR, "fftsplus dsa error"},
        {HCCL_FFTSPLUS_TIMEOUT_ERROR, "hccl fftsplus timeout"},
    };
    const auto it = starsRingBufferHeadMsgMap.find(errType);
    if (it != starsRingBufferHeadMsgMap.end()) {
        return it->second;
    } else {
        return "undefine errType";
    }
}

/* 检查200ms内是否存在HBM RAS告警 */
bool HasMteErr(const Device * const dev)
{
    // 检测到告警后200ms，会设置device状态
    bool hasMteErr = dev->GetDeviceRas();
    uint32_t count = 0;
    while ((!hasMteErr) && (count < GetMteErrWaitCount()) &&  // 每10ms判断一次，最多等待1.2s或0.2s (算子ms超时不等待)
        (!Runtime::Instance()->IsSupportOpTimeoutMs())) {
        (void)mmSleep(10U); // 每10ms判断一次
        hasMteErr = dev->GetDeviceRas();
        count++;
    }
    return hasMteErr;
}

// 封装 SMMU 故障检查逻辑
static bool CheckSmmuFault(const uint32_t deviceId)
{
    bool isSmmuFault = false;
    rtError_t error = NpuDriver::GetSmmuFaultValid(deviceId, isSmmuFault);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        RT_LOG(RT_LOG_EVENT, "Not support get fault smmu valid");
        return false;
    } else if (error == RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get isSmmuFault is %d.", isSmmuFault);
        return isSmmuFault;
    } else {
        RT_LOG(RT_LOG_EVENT, "Get NpuDriver::GetSmmuFaultValid ret %d.", error);
    }
    return false;
}

static bool HasUceErr(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    constexpr uint32_t maxFaultNum = 128U;
    std::vector<rtDmsFaultEvent> faultEventInfo(maxFaultNum);
    uint32_t eventCount = 0U;
    rtError_t error = NpuDriver::GetAllFaultEvent(deviceId, &faultEventInfo[0U], maxFaultNum, &eventCount);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        RT_LOG(RT_LOG_EVENT, "Not support get all fault event");
    } else if (error == RT_ERROR_NONE) {
        for (size_t faultIndex = 0U; faultIndex < eventCount; faultIndex++) {
            const uint32_t eventId = faultEventInfo[faultIndex].eventId;
            RT_LOG(RT_LOG_INFO, "eventId=%#" PRIx32, eventId);
            if (eventIdBlkList.find(eventId) != eventIdBlkList.end()) {
                RT_LOG(RT_LOG_ERROR, "Get uce error, eventId=%#" PRIx32 ".", eventId);
                return true;
            }
        }
    } else {
        RT_LOG(RT_LOG_EVENT, "Get NpuDriver::GetAllFaultEvent ret %d.", error);
    }
    return false;
}

/* 检查是否存在黑名单中的UCE错误 */
bool HasMemUceErr(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    Context *curCtx = Runtime::Instance()->CurrentContext();
    if (curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return HasUceErr(deviceId, eventIdBlkList);
    }
    return HasUceErr(deviceId, eventIdBlkList) || CheckSmmuFault(deviceId);
}

void SetTaskMteErr(TaskInfo *errTaskPtr, const Device * const dev,
    const std::map<uint32_t, std::string>& eventIdBlkList)
{
    // 若不支持ras上报接口，直接返回内存错误
    if (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT) {
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::MTE_ERROR);
        errTaskPtr->mte_error = TS_ERROR_AICORE_MTE_ERROR;
    } else {
        errTaskPtr->mte_error = HasMteErr(dev) ? TS_ERROR_AICORE_MTE_ERROR : TS_ERROR_SDMA_LINK_ERROR;
        if (errTaskPtr->mte_error == TS_ERROR_AICORE_MTE_ERROR) {
            SetMteError(errTaskPtr, dev, RT_ERROR_DEVICE_MEM_ERROR);
        } else if (HasMemUceErr(dev->Id_(), eventIdBlkList)) {
            errTaskPtr->mte_error = 0U;
        }
    }
}

void GetMteErrFromCqeStatus(TaskInfo *errTaskPtr, const Device * const dev, const uint32_t cqeStatus,
    const std::map<uint32_t, std::string>& eventIdBlkList)
{
    if ((cqeStatus == TS_SDMA_STATUS_DDRC_ERROR) || (cqeStatus == TS_SDMA_STATUS_LINK_ERROR) ||
        (cqeStatus == TS_SDMA_STATUS_POISON_ERROR)) {
        // 若不支持ras上报接口，处理0x8、0x9和0xa直接返回内存错误
        if (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT) {
            (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::MTE_ERROR);
            errTaskPtr->mte_error = TS_ERROR_SDMA_POISON_ERROR;
        } else {
            errTaskPtr->mte_error = HasMteErr(dev) ? TS_ERROR_SDMA_POISON_ERROR : TS_ERROR_SDMA_LINK_ERROR;
            if (errTaskPtr->mte_error == TS_ERROR_SDMA_POISON_ERROR) {
                SetMteError(errTaskPtr, dev, RT_ERROR_SDMA_POISON_ERROR);
            } else if (HasMemUceErr(dev->Id_(), eventIdBlkList)) {
                errTaskPtr->mte_error = 0U;
            }
        }
    }
}

static void AddExceptionRegInfo(const StarsDeviceErrorInfo * const starsInfo, const uint32_t coreIdx,
    const uint16_t type, const TaskInfo *errTaskPtr)
{
    COND_RETURN_NORMAL(type != AICORE_ERROR && type != AIVECTOR_ERROR && type != FFTS_PLUS_AICORE_ERROR &&
        type != FFTS_PLUS_AIVECTOR_ERROR, "the type[%hu] not match", type);
    COND_RETURN_VOID(errTaskPtr == nullptr || errTaskPtr->stream == nullptr ||
        errTaskPtr->stream->Device_() == nullptr, "cannot get the device by errTaskPtr");

    const uint8_t errCoreType = (type == AICORE_ERROR || type == FFTS_PLUS_AICORE_ERROR) ?
        AICORE_ERROR : AIVECTOR_ERROR;
    const StarsOneCoreErrorInfo& info = starsInfo->u.coreErrorInfo.info[coreIdx];
    rtExceptionErrRegInfo_t regInfo = {};
    regInfo.coreId = static_cast<uint32_t>(info.coreId);
    regInfo.coreType = static_cast<rtCoreType_t>(errCoreType);
    regInfo.startPC = info.pcStart;
    regInfo.currentPC = info.currentPC;
    const uint8_t REG_OFFSET = 32;
    regInfo.errReg[RT_V100_AIC_ERR_0] = static_cast<uint32_t>(info.aicError[0]);
    regInfo.errReg[RT_V100_AIC_ERR_1] = static_cast<uint32_t>(info.aicError[0] >> REG_OFFSET);
    regInfo.errReg[RT_V100_AIC_ERR_2] = static_cast<uint32_t>(info.aicError[1]);
    regInfo.errReg[RT_V100_AIC_ERR_3] = static_cast<uint32_t>(info.aicError[1] >> REG_OFFSET);
    regInfo.errReg[RT_V100_AIC_ERR_4] = static_cast<uint32_t>(info.aicError[2]);
    regInfo.errReg[RT_V100_AIC_ERR_5] = static_cast<uint32_t>(info.aicError[2] >> REG_OFFSET);
    regInfo.errReg[RT_V100_BIU_ERR_0] = static_cast<uint32_t>(info.biuErrInfo);
    regInfo.errReg[RT_V100_BIU_ERR_1] = static_cast<uint32_t>(info.biuErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_CCU_ERR_0] = static_cast<uint32_t>(info.ccuErrInfo);
    regInfo.errReg[RT_V100_CCU_ERR_1] = static_cast<uint32_t>(info.ccuErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_CUBE_ERR_0] = static_cast<uint32_t>(info.cubeErrInfo);
    regInfo.errReg[RT_V100_CUBE_ERR_1] = static_cast<uint32_t>(info.cubeErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_IFU_ERR_0] = static_cast<uint32_t>(info.ifuErrInfo);
    regInfo.errReg[RT_V100_IFU_ERR_1] = static_cast<uint32_t>(info.ifuErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_MTE_ERR_0] = static_cast<uint32_t>(info.mteErrInfo);
    regInfo.errReg[RT_V100_MTE_ERR_1] = static_cast<uint32_t>(info.mteErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_VEC_ERR_0] = static_cast<uint32_t>(info.vecErrInfo);
    regInfo.errReg[RT_V100_VEC_ERR_1] = static_cast<uint32_t>(info.vecErrInfo >> REG_OFFSET);
    regInfo.errReg[RT_V100_FIXP_ERR_0] = info.fixPError0;
    regInfo.errReg[RT_V100_FIXP_ERR_1] = info.fixPError1;

    Device *dev = errTaskPtr->stream->Device_();
    uint32_t taskId = starsInfo->u.coreErrorInfo.comm.taskId;
    uint32_t streamId = starsInfo->u.coreErrorInfo.comm.streamId;
    RT_LOG(RT_LOG_ERROR, "add error register: core_id=%u, stream_id=%u, task_id=%u", regInfo.coreId, streamId, taskId);
    std::pair<uint32_t, uint32_t> key = {streamId, taskId};
    auto& exceptionRegMap = dev->GetExceptionRegMap();
    std::lock_guard<std::mutex> lock(dev->GetExceptionRegMutex());
    exceptionRegMap[key].push_back(regInfo);
}

static void PrintCoreInfo(const StarsDeviceErrorInfo * const info, const uint32_t coreIdx, const uint64_t errorNumber,
    std::string& errorString, std::string& headMsg)
{
    /* logs for aic tools, do not modify the item befor making a new agreement with tools */
    RT_LOG_CALL_MSG(ERR_MODULE_TBE,
        "The error from device(chipId:%u, dieId:%u), serial number is %" PRIu64 ", "
        "there is an exception of %s, core id is %" PRIu64 ", "
        "error code = %#" PRIx64 ", dump info: "
        "pc start: %#" PRIx64 ", current: %#" PRIx64 ", "
        "vec error info: %#" PRIx64 ", mte error info: %#" PRIx64 ", "
        "ifu error info: %#" PRIx64 ", ccu error info: %#" PRIx64 ", "
        "cube error info: %#" PRIx64 ", biu error info: %#" PRIx64 ", "
        "aic error mask: %#" PRIx64 ", para base: %#" PRIx64 ".",
        info->u.coreErrorInfo.comm.chipId, info->u.coreErrorInfo.comm.dieId, errorNumber, headMsg.c_str(),
        info->u.coreErrorInfo.info[coreIdx].coreId, info->u.coreErrorInfo.info[coreIdx].aicError[0],
        info->u.coreErrorInfo.info[coreIdx].pcStart, info->u.coreErrorInfo.info[coreIdx].currentPC,
        info->u.coreErrorInfo.info[coreIdx].vecErrInfo, info->u.coreErrorInfo.info[coreIdx].mteErrInfo,
        info->u.coreErrorInfo.info[coreIdx].ifuErrInfo, info->u.coreErrorInfo.info[coreIdx].ccuErrInfo,
        info->u.coreErrorInfo.info[coreIdx].cubeErrInfo, info->u.coreErrorInfo.info[coreIdx].biuErrInfo,
        info->u.coreErrorInfo.info[coreIdx].aicErrorMask, info->u.coreErrorInfo.info[coreIdx].paraBase);

    RT_LOG_CALL_MSG(ERR_MODULE_TBE,
        "The extend info: errcode:(%#" PRIx64 ", %#" PRIx64 ", %#" PRIx64 ") "
        "errorStr: %s "
        "fixp_error0 info: %#x, fixp_error1 info: %#x, "
        "fsmId:%u, tslot:%u, thread:%u, ctxid:%u, blk:%u, sublk:%u, subErrType:%u.",
        info->u.coreErrorInfo.info[coreIdx].aicError[0], info->u.coreErrorInfo.info[coreIdx].aicError[1],
        info->u.coreErrorInfo.info[coreIdx].aicError[2], errorString.c_str(),
        info->u.coreErrorInfo.info[coreIdx].fixPError0, info->u.coreErrorInfo.info[coreIdx].fixPError1,
        info->u.coreErrorInfo.info[coreIdx].fsmId, info->u.coreErrorInfo.info[coreIdx].fsmTslotId,
        info->u.coreErrorInfo.info[coreIdx].fsmThreadId, info->u.coreErrorInfo.info[coreIdx].fsmCxtId,
        info->u.coreErrorInfo.info[coreIdx].fsmBlkId, info->u.coreErrorInfo.info[coreIdx].fsmSublkId,
        info->u.coreErrorInfo.info[coreIdx].subErrType);
}

static void ProcessMteAndFfts(const StarsDeviceErrorInfo * const info, const uint32_t coreIdx, bool& isMteErr,
    const bool isCloudV2, const bool isFftsPlusTask, TaskInfo *errTaskPtr)
{
    // 取mteErrInfo[26:24]
    const uint64_t mteErrBit = (info->u.coreErrorInfo.info[coreIdx].mteErrInfo >> 24U) & 0x7U;
    const bool mteErr = (mteErrBit == 0b110U) || (mteErrBit == 0b111U) || (mteErrBit == 0b11U) || (mteErrBit == 0b10U);
    // 若返回的错误码不是0x800000, 或mte error不是0b110 or 0b111 (write bus error or write decode error)
    // or 0b11 or 0b10 (read bus error or read decode error)，则不认为是远端出错
    if ((info->u.coreErrorInfo.info[coreIdx].aicError[0] != 0x800000U) || (!mteErr) || (!isCloudV2)) {
        isMteErr = false;
    }

    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = rtFftsPlusTaskErrInfo_t();
    if (isFftsPlusTask) {
        fftsPlusErrInfo.contextId = info->u.coreErrorInfo.info[coreIdx].fsmCxtId;
        fftsPlusErrInfo.threadId = static_cast<uint16_t>(info->u.coreErrorInfo.info[coreIdx].fsmThreadId);
        fftsPlusErrInfo.errType = info->u.coreErrorInfo.comm.type;
        fftsPlusErrInfo.pcStart = info->u.coreErrorInfo.info[coreIdx].pcStart;
        PushBackErrInfo(errTaskPtr, static_cast<const void *>(&fftsPlusErrInfo),
                        static_cast<uint32_t>(sizeof(rtFftsPlusTaskErrInfo_t)));
    }
}

rtError_t DeviceErrorProc::ProcessStarsCoreErrorInfo(const StarsDeviceErrorInfo * const info,
                                                     const uint64_t errorNumber,
                                                     const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    bool isFftsPlusTask = false;
    const uint16_t type = info->u.coreErrorInfo.comm.type;

    TaskInfo *errTaskPtr = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(info->u.coreErrorInfo.comm.streamId),
        info->u.coreErrorInfo.comm.taskId);
    if (errTaskPtr != nullptr) {
        errTaskPtr->isRingbufferGet = true;
        if ((errTaskPtr->type ==  TS_TASK_TYPE_FFTS_PLUS) &&
            ((type == FFTS_PLUS_AICORE_ERROR) || (type == FFTS_PLUS_AIVECTOR_ERROR))) {
            isFftsPlusTask = true;
        }

        if (info->u.coreErrorInfo.comm.flag == 1U) {
            SetTaskMteErr(errTaskPtr, dev);
        }
    }

    const bool isSupportFastRecover = dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_MTE_ERROR);
    const uint32_t inputcoreNum = info->u.coreErrorInfo.comm.coreNum;
    // info->u.coreErrorInfo.comm.flag等于1的场景在上述流程已经判断过，不需要再重复判断
    bool isMteErr = (inputcoreNum > 0U) && (info->u.coreErrorInfo.comm.flag != 1U) && isSupportFastRecover; 
    for (uint32_t coreIdx = 0U; coreIdx < inputcoreNum; coreIdx++) {
        if (isFftsPlusTask == false && errTaskPtr != nullptr && errTaskPtr->u.aicTaskInfo.kernel == nullptr) {
            AicTaskInfo *aicTask = &errTaskPtr->u.aicTaskInfo;
            RT_LOG(RT_LOG_ERROR, "stream_id=%u, task_id=%u not with kernel info.", info->u.coreErrorInfo.comm.streamId,
                info->u.coreErrorInfo.comm.taskId);
            if (aicTask->progHandle != nullptr && coreIdx < MAX_CORE_BLOCK_NUM) {
                aicTask->kernel =aicTask->progHandle->SearchKernelByPcAddr(info->u.coreErrorInfo.info[coreIdx].pcStart);
            }
        }
        std::string errorString;
        DeviceErrorProc::ProcessStarsCoreErrorMapInfo(&(info->u.coreErrorInfo.info[coreIdx]), errorString);
        std::string headMsg = GetStarsRingBufferHeadMsg(info->u.coreErrorInfo.comm.type);
        AddExceptionRegInfo(info, coreIdx, type, errTaskPtr);
        PrintCoreInfo(info, coreIdx, errorNumber, errorString, headMsg);
        ProcessMteAndFfts(info, coreIdx, isMteErr, isSupportFastRecover, isFftsPlusTask, errTaskPtr);
    }
    // 本地没有其他告警，且报错写mte错误，认为疑似是远端出错
    if (isMteErr && (errTaskPtr != nullptr) && (!HasMteErr(dev)) && (!HasMemUceErr(dev->Id_()))) {
        errTaskPtr->mte_error = TS_ERROR_SDMA_LINK_ERROR;
    }
    if (errTaskPtr != nullptr) {
        RT_LOG(RT_LOG_ERROR, "devId=%u, streamId=%u, taskId=%u, MTE errorCode=%u.", dev->Id_(),
               info->u.coreErrorInfo.comm.streamId, info->u.coreErrorInfo.comm.taskId, errTaskPtr->mte_error);
    }
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce