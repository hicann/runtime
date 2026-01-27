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

const std::map<uint32_t, std::string> g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err."},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x813B8002U, "AIC Dispatch Input Error."},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error."},
    {0x81478004U, "DVPP Dispatch Config Error."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x813D8009U, "AIC AA Bus Error."},
    {0x81AF8008U, "UB multiple bit ecc error."},
    {0x81B18008U, "UB PORT multiple bit ecc error."}
};

const std::map<uint32_t, std::string> g_hcclRemoteMulBitEccEventIdBlkList = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err."},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x813B8002U, "AIC Dispatch Input Error."},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error."},
    {0x81478004U, "DVPP Dispatch Config Error."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x813D8009U, "AIC AA Bus Error."},
    {0x81B78009U, "UB AA bus error."},
    {0x81AF8000U, "UB Module error."},
    {0x81AF8004U, "UB software configuration error."},
    {0x81AF8008U, "UB Multi Bit Ecc."},
    {0x81B18008U, "UB_PORT Multi Bit Ecc."},
    {0x81B1800DU, "UB_PORT link error."}
};

const std::vector<EventRasFilter> g_ubNonMemPoisonRasList = {
    {0x81AF8009U, 0x03, 0x02, 0x10000000, "poison."},
    {0x81AF8009U, 0x03, 0x03, 0x40000000, "cpu seq data poison."},
    {0x81AF8009U, 0x03, 0x03, 0x20000000, "dwqe data poison."},
    {0x81AF8009U, 0x03, 0x03, 0x04000000, "P2P opertion poison."},
    {0x81AF8009U, 0x03, 0x03, 0x02000000, "UB IO traffic atomic operation poison."},
    {0x81AF8009U, 0x03, 0x03, 0x01000000, "UB IO traffic store operation poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00020000, "UB: RX DMA 2-bit ECC error in IO read returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00008000, "Read/atomic request address hitting DWQE space returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00002000, "Atomic write data poisoning / Atomic lookup table exception / Atomic timeout exception / Atomic packet header assembly exception returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00000800, "Read timeout exception / Read lookup table exception / Read packet header assembly exception returns poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00000200, "CCUA read operation returns poison."}
};

const std::vector<EventRasFilter> g_ubMemPoisonRasList = {
    {0x81AF8009U, 0x03, 0x03, 0x80000000, "UB MEM Atomic data Poison."},
    {0x81AF8009U, 0x03, 0x03, 0x08000000, "UB MEM traffic poison."},
    {0x81AF8009U, 0x03, 0x03, 0x00800000, "UB MEM read operation returned poison due to abnormal traffic."}
};

const std::vector<EventRasFilter> g_ubMemPoisonRasOnlyPosisonList = {
    {0x81AF8009U, 0x03, 0x02, 0x10000000, "poison."}
};

const std::map<uint32_t, std::string> g_mulBitEccEventId = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err"},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x81338008U, "TS Dispatch Multi Bit Ecc."},
    {0x813B8002U, "AIC Dispatch Input Error"},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x813B8008U, "AIC Dispatch Multi Bit Ecc."},
    {0x81478002U, "DVPP Dispatch Input Error"},
    {0x81478004U, "DVPP Dispatch Config Error"},
    {0x81478008U, "DVPP Dispatch Multi Bit Ecc."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error"},
    {0x815F8008U, "PERI Dispatch Multi Bit Ecc."},
    {0x81938002U, "DSA Dispatch Input Error."},
    {0x81938004U, "DSA Dispatch Config Error."},
    {0x81938008U, "DSA Dispatch Multi Bit Ecc."},
    {0x81958002U, "NIC Dispatch Input Error."},
    {0x81958004U, "NIC Dispatch Config Error."},
    {0x81958008U, "NIC Dispatch Multi Bit Ecc."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81978008U, "PCIE Dispatch Multi Bit Ecc."}
};

const std::map<uint32_t, std::string> g_mulBitEccEventIdBlkList = {
    {0x80CD8008U, "L2BUFF multi bit Err."},
    {0x80F2180DU, "HBMA/MATA Os Err."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Err."},
    {0x81338004U, "TS Dispatch Config Err."},
    {0x813B8002U, "AIC Dispatch Input Error."},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error."},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x81AF8008U, "UB Multi Bit Ecc."},
    {0x81B18008U, "UB_PORT Multi Bit Ecc."}
};

const std::map<uint32_t, std::string> g_l2MulBitEccEventIdBlkList = {
    {0x80E01801U, "HBM Multi Bit Error."},
    {0x80F2180DU, "HBMA/MATA Os Error."},
    {0x80F38008U, "HBMA Multi Bit Ecc."},
    {0x81338002U, "TS Dispatch Input Error"},
    {0x81338004U, "TS Dispatch Config Error."},
    {0x81338008U, "TS Dispatch Multi Bit Ecc."},
    {0x813B8002U, "AIC Dispatch Input Error"},
    {0x813B8004U, "AIC Dispatch Config Error."},
    {0x81478002U, "DVPP Dispatch Input Error"},
    {0x81478004U, "DVPP Dispatch Config Error"},
    {0x815F8002U, "PERI Dispatch Input Error."},
    {0x815F8004U, "PERI Dispatch Config Error"},
    {0x81978002U, "PCIE Dispatch Input Error."},
    {0x81978004U, "PCIE Dispatch Config Error."},
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x813D8009U, "AIC AA Ring Parity Error."},
    {0x81AF8009U, "UB Posion Error."}
};

const std::map<uint32_t, std::string> g_ubMemTimeoutEventIdBlkList = {
    {0x81B58002U, "UB Dispatch Input Error."},
    {0x81B58004U, "UB Dispatch Config Error."},
    {0x81B78009U, "UB AA Bus Error."},
    {0x81AF8000U, "UB Module Excerption."},
    {0x81AF8004U, "UB Software Config Error."},
    {0x81AF8008U, "UB Multi Bit Ecc."},
    {0x81B18008U, "UB_PORT Multi Bit Ecc."},
    {0x81B1800DU, "UB_PORT Link Error."}
};

const EventRasFilter g_ubMemTrafficTimeoutFilter = {
    .eventId = UB_POISON_ERROR_EVENT_ID,
    .subModuleId = 0x03,
    .errorRegisterIndex = 0x03,
    .bitMask = 0x100000,
    .description = "UB MEM traffic timeout exception"
};

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

bool HasBlacklistEventOnDevice(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_ERROR((faultEventInfo == nullptr), false, "new rtDmsFaultEvent failed.");
    const size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    (void)memset_s(faultEventInfo, totalSize, 0, totalSize);

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(deviceId, faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        return false;
    }
    return IsHitBlacklist(faultEventInfo, eventCount, eventIdBlkList);
}

/* 检查是否存在黑名单中的UCE错误 */
bool HasMemUceErr(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, false);
    NULL_PTR_RETURN(curCtx->Device_(), false);
    if (curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return HasBlacklistEventOnDevice(deviceId, eventIdBlkList);
    }
    return HasBlacklistEventOnDevice(deviceId, eventIdBlkList) || CheckSmmuFault(deviceId);
}

bool IsHitBlacklist(const rtDmsFaultEvent *faultEventInfo, const uint32_t eventCount, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    if (faultEventInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "faultEventInfo is nullptr.");
        return false;
    }
    std::string faultInfo;
    for (uint32_t faultIndex = 0U; faultIndex < eventCount; faultIndex++) {
        if (eventIdBlkList.find(faultEventInfo[faultIndex].eventId) != eventIdBlkList.end()) {
            std::ostringstream oss;
            oss << std::hex << faultEventInfo[faultIndex].eventId;
            faultInfo = faultInfo + "[0x" + oss.str() + "]" + faultEventInfo[faultIndex].eventName;
            RT_LOG(RT_LOG_INFO, "Fault message is: [%s].", faultInfo.c_str());
            return true;
        }
    }
    return false;
}

bool IsFaultEventOccur(const uint32_t faultEventId, const rtDmsFaultEvent * const faultEventInfo, const uint32_t eventCount)
{
    if (faultEventInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "faultEventInfo is nullptr.");
        return false;
    }
    for (uint32_t faultIndex = 0; faultIndex < eventCount; faultIndex++) {
        if (faultEventInfo[faultIndex].eventId == faultEventId) {
            return true;
        }
    }
    return false;
}

rtError_t GetDeviceFaultEvents(const uint32_t deviceId, rtDmsFaultEvent *faultEventInfo,
    uint32_t &eventCount, const uint32_t maxFaultNum)
{
    rtError_t error = RT_ERROR_NONE;
    error = NpuDriver::GetAllFaultEvent(deviceId, faultEventInfo, maxFaultNum, &eventCount);
    COND_RETURN_ERROR(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support get fault event.");
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (eventCount > maxFaultNum), (error == RT_ERROR_NONE) ? RT_ERROR_DRV_ERR : error,
        "Get fault event error, device_id=%u, eventCount=%u, maxFaultNum=%u, error=%#x.", deviceId,
            eventCount, maxFaultNum, static_cast<uint32_t>(error));
    return error;
}

void SetTaskMteErr(TaskInfo *errTaskPtr, const Device * const dev,
    const std::map<uint32_t, std::string>& eventIdBlkList)
{
    // 若不支持ras上报接口，直接返回内存错误
    bool hasSpecialErrorCode = false;
    if (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT) {
        SetDeviceFaultTypeByErrorType(dev, AICORE_ERROR, hasSpecialErrorCode);
        RT_LOG(RT_LOG_WARNING, "Task Hbm Ras reporting is not supported.");
        errTaskPtr->mte_error = (hasSpecialErrorCode ? TS_ERROR_AICORE_MTE_ERROR : TS_SUCCESS);
    } else {
        errTaskPtr->mte_error = HasMteErr(dev) ? TS_ERROR_AICORE_MTE_ERROR : TS_ERROR_SDMA_LINK_ERROR;
        if (errTaskPtr->mte_error == TS_ERROR_AICORE_MTE_ERROR) {
            MteErrorProc(errTaskPtr, dev, RT_ERROR_DEVICE_MEM_ERROR, hasSpecialErrorCode);
            errTaskPtr->mte_error = (hasSpecialErrorCode ? TS_ERROR_AICORE_MTE_ERROR : TS_SUCCESS);
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
        bool hasSpecialErrorCode= false;
        if (Runtime::Instance()->GetHbmRasProcFlag() == HBM_RAS_NOT_SUPPORT) {
            SetDeviceFaultTypeByErrorType(dev, SDMA_ERROR, hasSpecialErrorCode);
            errTaskPtr->mte_error = (hasSpecialErrorCode ? TS_ERROR_SDMA_POISON_ERROR : TS_SUCCESS);
        } else {
            errTaskPtr->mte_error = HasMteErr(dev) ? TS_ERROR_SDMA_POISON_ERROR : TS_ERROR_SDMA_LINK_ERROR;
            if (errTaskPtr->mte_error == TS_ERROR_SDMA_POISON_ERROR) {
                SetDeviceFaultTypeByErrorType(dev, SDMA_ERROR, hasSpecialErrorCode);
                errTaskPtr->mte_error = (hasSpecialErrorCode ? TS_ERROR_SDMA_POISON_ERROR : TS_SUCCESS);
            } else if (HasMemUceErr(dev->Id_(), eventIdBlkList)) {
                errTaskPtr->mte_error = 0U;
            }
        }
    }
}

bool IsEventRasMatch(const rtDmsFaultEvent &event, const EventRasFilter &filter)
{
    uint32_t rasCode = 0;
    rasCode |= static_cast<uint32_t>(event.rasCode[0]) << 24;
    rasCode |= static_cast<uint32_t>(event.rasCode[1]) << 16;
    rasCode |= static_cast<uint32_t>(event.rasCode[2]) << 8;
    rasCode |= static_cast<uint32_t>(event.rasCode[3]);
    return (event.eventId == filter.eventId) && (event.subModuleId == filter.subModuleId) &&
           (event.errorRegisterIndex == filter.errorRegisterIndex) && ((filter.bitMask & rasCode) != 0);
}

bool IsEventIdAndRasCodeMatch( const uint32_t deviceId, const std::vector<EventRasFilter>& ubNonMemPoisonRasList)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_ERROR((faultEventInfo == nullptr), false, "new rtDmsFaultEvent failed.");
    const size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    (void)memset_s(faultEventInfo, totalSize, 0, totalSize);

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(deviceId, faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        return false;
    }
    // UB Bus Access Exception eventId
    const uint32_t targetEventId = ubNonMemPoisonRasList.front().eventId;

    for (uint32_t faultIndex = 0U; faultIndex < eventCount; faultIndex++) {
        const auto& currentEvent = faultEventInfo[faultIndex];
        const uint32_t eventId = currentEvent.eventId;
        RT_LOG(RT_LOG_INFO, "eventId=%#" PRIx32, eventId);
        if (eventId != targetEventId) {
            continue;
        }
        for (const auto& filter : ubNonMemPoisonRasList) {
            if (IsEventRasMatch(currentEvent, filter)) {
                RT_LOG(RT_LOG_INFO,
                    "[UB Security Event] Device: %u, Event ID: %#" PRIx32 ", subModuleId: 0x%02X, errorRegisterIndex: 0x%02X, bitMask: %u",
                    deviceId,
                    currentEvent.eventId,
                    currentEvent.subModuleId,
                    currentEvent.errorRegisterIndex, 
                    filter.bitMask);

                return true;
            }
        }
    }
    return false;
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