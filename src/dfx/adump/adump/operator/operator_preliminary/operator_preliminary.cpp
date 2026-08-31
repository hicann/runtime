/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_preliminary.h"

#include <cinttypes>
#include <fstream>
#include <algorithm>
#include "securec.h"
#include "lib_path.h"
#include "file_utils.h"
#include "log/adx_log.h"
#include "adump_platform_api.h"
#include "adump_platform_manager.h"
#include "runtime/kernel.h"
#include "runtime/mem.h"
#include "runtime/dev.h"

namespace Adx {
constexpr uint32_t SINGLE_STATS_BYTE = 8;   // 单个统计项的占用大小
constexpr uint32_t BLOCK_MIN_SIZE = 32;     // 最小搬运单元
constexpr uint32_t DCCI_SYNC_SIZE = 64;     // DCCI强制同步数据64B
constexpr uint32_t MAX_STATS_NUM = 64;      // 最大统计项个数
constexpr uint32_t INTEGER_KILOBYTE = 1024; // 表示1KB

constexpr const char* const KFC_OPERATOR_STUB_NAME = "kfc_dump_stat_stub";
constexpr const char* const KFC_OPERATOR_NAME = "kfc_dump_stat";

static const std::vector<PlatformType> AICORE_RELATED = {PlatformType::CHIP_DC_TYPE};

OperatorPreliminary::OperatorPreliminary(const DumpSetting& setting, const uint32_t deviceId)
    : deviceId_(deviceId), setting_(setting), opData_({})
{}

OperatorPreliminary::~OperatorPreliminary() {}

uint64_t OperatorPreliminary::CalcWorkspaceSize(uint64_t statsCnt)
{
    PlatformType platform = setting_.GetPlatformType();
    uint32_t coreSize = opData_.vectCoreCnt;
    auto coreIter = std::find(AICORE_RELATED.begin(), AICORE_RELATED.end(), platform);
    if (coreIter != AICORE_RELATED.cend()) {
        return DCCI_SYNC_SIZE * opData_.aiCoreCnt * statsCnt;
    }
    return BLOCK_MIN_SIZE * (coreSize + 1) * statsCnt; // + 1 用于当做同步空间
}

std::vector<std::string> OperatorPreliminary::GetBinNames() const
{
    auto plat = PlatformReflection<DataDumpInterface>::CreatePlatform(setting_.GetPlatformType());
    if (plat == nullptr) {
        return {};
    }
    return plat->GetKfcBinNames();
}

int32_t OperatorPreliminary::GetStreamInfo()
{
    IDE_LOGI("Start GetStreamInfo on device %u.", deviceId_);
    rtError_t ret = rtSetDevice(deviceId_);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "Execute rtSetDevice on device %u failed with result %d", deviceId_,
        ret);
    opData_.setDevice = true;

    ret = rtStreamCreateWithFlags(&opData_.deviceStm, 0, RT_STREAM_CP_PROCESS_USE);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "Execute rtStreamCreateWithFlags on device %u failed with result %d",
        deviceId_, ret);

    ret = rtGetStreamId(opData_.deviceStm, &opData_.streamId);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "Execute rtGetStreamId on device %u failed with result %d",
        deviceId_, ret);

    ret = rtStreamGetSqid(opData_.deviceStm, &opData_.sqId);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "Execute rtStreamGetSqid on device %u failed with result %d",
        deviceId_, ret);

    ret = rtStreamGetCqid(opData_.deviceStm, &opData_.cqIds, &opData_.logicCqIds);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "Execute rtStreamGetCqid on device %u failed with result %d",
        deviceId_, ret);

    IDE_LOGI(
        "Success to get stream id=%d, sqId=%u, cqId=%u, logic cqId=%u on device %u.", opData_.streamId, opData_.sqId,
        opData_.cqIds, opData_.logicCqIds, deviceId_);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::GetUBSizeAndCoreNum()
{
    char version[SOC_VERSION_LEN] = {};
    IDE_CTRL_VALUE_FAILED(
        rtGetSocVersion(version, SOC_VERSION_LEN) == RT_ERROR_NONE, return ADUMP_FAILED, "Failed to get soc version");
    const std::string socVersion(version);

    PlatformData platformData;
    IDE_CTRL_VALUE_FAILED(
        AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, setting_.GetPlatformType(), platformData),
        return ADUMP_FAILED, "Failed to read platform information from fe api.");

    opData_.ubSize = platformData.ubSize;
    opData_.aiCoreCnt = platformData.aiCoreCnt;
    opData_.vectCoreCnt = platformData.vectCoreCnt;
    IDE_LOGI(
        "Get ub size:%" PRIu64 ", ai core count:%" PRIu64 ", vector core count:%" PRIu64 " on device %u.",
        opData_.ubSize, opData_.aiCoreCnt, opData_.vectCoreCnt, deviceId_);
    return ADUMP_SUCCESS;
}

std::unique_ptr<char[]> OperatorPreliminary::LoadBinFile(const std::string& filename, size_t& fileSize) const
{
    std::string realPath;
    IDE_CTRL_VALUE_FAILED(
        FileUtils::FileNameIsReal(filename, realPath) == IDE_DAEMON_OK, return nullptr,
        "LoadBinFile failed. The real path is %s.", filename.c_str());

    std::ifstream iFile(realPath, std::ios::binary | std::ios::ate);
    IDE_CTRL_VALUE_FAILED(iFile.is_open(), return nullptr, "Failed to open file: %s", realPath.c_str());

    auto pos = iFile.tellg();
    if (pos <= 0) {
        IDE_LOGE("Failed to get file size. file: %s, size: %ld", realPath.c_str(), pos);
        return nullptr;
    }
    fileSize = static_cast<size_t>(pos);
    iFile.seekg(0, std::ios::beg);
    char* buffer = new (std::nothrow) char[fileSize];
    IDE_CTRL_VALUE_FAILED(buffer != nullptr, return nullptr, "Failed to new file buffer");
    IDE_CTRL_VALUE_FAILED(
        iFile.read(buffer, fileSize),
        {
            delete[] buffer;
            return nullptr;
        },
        "Failed to read file data. file: %s, size: %ld", filename.c_str(), fileSize);
    return std::unique_ptr<char[]>(buffer);
}

int32_t OperatorPreliminary::GetOperatorPCAddr()
{
    static std::unique_ptr<char[]> binData = nullptr;
    rtError_t ret = RT_ERROR_NONE;

    if (binData == nullptr) {
        const std::vector<std::string> opNames = GetBinNames();
        std::string hitPath;
        for (const auto& opName : opNames) {
            const std::string opPath = LibPath::Instance().GetTargetPath(opName);
            IDE_CTRL_VALUE_FAILED(
                !opPath.empty(), continue, "Failed to get the path of the kfc operator. opName=%s", opName.c_str());
            if (FileUtils::IsFileExist(opPath)) {
                hitPath = opPath;
                break;
            }
        }
        IDE_CTRL_VALUE_FAILED(
            !hitPath.empty(), return ADUMP_FAILED, "Failed to find an existing kfc operator file. candidates=%zu",
            opNames.size());

        size_t fileSize = 0;
        binData = LoadBinFile(hitPath, fileSize);
        IDE_CTRL_VALUE_FAILED(
            binData != nullptr, return ADUMP_FAILED, "Failed to load the kfc operator data. opPath=%s",
            hitPath.c_str());
        IDE_LOGI("Success to load the kfc operator data. opPath=%s, fileSize=%zu", hitPath.c_str(), fileSize);

        rtDevBinary_t bin{
            .magic = RT_DEV_BINARY_MAGIC_ELF_AIVEC,
            .version = 0,
            .data = static_cast<void*>(binData.get()),
            .length = fileSize};

        ret = rtDevBinaryRegister(&bin, &opData_.binHandle);
        IDE_CTRL_VALUE_FAILED(
            ret == RT_ERROR_NONE, return ADUMP_FAILED, "Failed to register the kfc operator binary. ret=%d", ret);

        ret = rtFunctionRegister(opData_.binHandle, KFC_OPERATOR_STUB_NAME, KFC_OPERATOR_NAME, KFC_OPERATOR_NAME, 0U);
        IDE_CTRL_VALUE_FAILED(
            ret == RT_ERROR_NONE, return ADUMP_FAILED,
            "Failed to register the kfc operator function. stubFunc=%s, stubName=%s, ret=%d", KFC_OPERATOR_STUB_NAME,
            KFC_OPERATOR_NAME, ret);
    }

    ret = rtGetAddrByFun(KFC_OPERATOR_STUB_NAME, &opData_.pcAddr);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Failed to get the kfc pc address with stubFunc. stubFunc=%s, ret=%d", KFC_OPERATOR_STUB_NAME, ret);

    IDE_LOGI("Success to get the kfc pc address on device %u. pcAddr=%p", deviceId_, opData_.pcAddr);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::CreateMemory()
{
    opData_.msgQSize = INTEGER_KILOBYTE * INTEGER_KILOBYTE; // 1M 消息轮询、参数保存、多核同步空间
    opData_.outputSize = MAX_STATS_NUM * SINGLE_STATS_BYTE;
    uint64_t statsCnt = 0;
    for (uint64_t idx = 0; idx < MAX_STATS_NUM; idx++) {
        if ((setting_.GetDumpStatsItem() & (1LLU << idx)) != 0) {
            statsCnt++; // 统计项个数
        }
    }
    opData_.workspaceSize = CalcWorkspaceSize(statsCnt);
    opData_.stackBaseSize = CalcStackSize();

    IDE_CTRL_VALUE_FAILED(
        opData_.workspaceSize != 0 && opData_.stackBaseSize != 0, return ADUMP_FAILED,
        "workspaceSize=%" PRIu64 " bytes, stackBaseSize=%" PRIu64 " bytes, both must be non-zero",
        opData_.workspaceSize, opData_.stackBaseSize);
    IDE_LOGI(
        "Calculate MsgQ Size:%" PRIu64 "Byte, output size:%" PRIu64 "Byte, workspace size:%" PRIu64 "Byte,"
        "stack base size:%" PRIu64 "Byte on device %u.",
        opData_.msgQSize, opData_.outputSize, opData_.workspaceSize, opData_.stackBaseSize, deviceId_);

    uint64_t memSize = opData_.msgQSize + opData_.outputSize + opData_.workspaceSize + opData_.stackBaseSize;
    rtError_t ret = rtMalloc(&opData_.memoryAddr, memSize, RT_MEMORY_DEFAULT, AICPU);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED, "rtMalloc failed. ret=%d", ret);
    IDE_LOGI("rtMalloc success for the kfc operator. memAddr=%p, memSize=%llu", opData_.memoryAddr, memSize);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::KFCKernelLaunch()
{
    IDE_LOGD("Start to initialize the kfc kernel information on device %u.", deviceId_);
    KfcDumpOpInitParam kfcParam;
    kfcParam.kfcWorkSpace.msgQ = reinterpret_cast<uint64_t>(opData_.memoryAddr);
    kfcParam.kfcWorkSpace.msgQSize = opData_.msgQSize;
    kfcParam.kfcWorkSpace.output = kfcParam.kfcWorkSpace.msgQ + opData_.msgQSize;
    kfcParam.kfcWorkSpace.outputSize = opData_.outputSize;
    kfcParam.kfcWorkSpace.workspace = kfcParam.kfcWorkSpace.output + opData_.outputSize;
    kfcParam.kfcWorkSpace.workspaceSize = opData_.workspaceSize;
    kfcParam.kfcWorkSpace.stackBase = kfcParam.kfcWorkSpace.workspace + opData_.workspaceSize;
    kfcParam.kfcWorkSpace.stackBaseSize = opData_.stackBaseSize;

    kfcParam.config.aiCoreNum = opData_.aiCoreCnt;
    kfcParam.config.vectorCoreNum = opData_.vectCoreCnt;
    kfcParam.config.ubSize = opData_.ubSize;
    kfcParam.config.dumpStatPcAddr = reinterpret_cast<uint64_t>(opData_.pcAddr);
    kfcParam.config.statsType = setting_.GetDumpStatsItem();
    kfcParam.config.chipType = static_cast<uint64_t>(setting_.GetPlatformType());

    kfcParam.streamInfo.streamId = opData_.streamId;
    kfcParam.streamInfo.sqIds = opData_.sqId;
    kfcParam.streamInfo.cqIds = opData_.cqIds;
    kfcParam.streamInfo.logicCqIds = opData_.logicCqIds;
    kfcParam.streamInfo.deviceId = deviceId_;

    if (UpdateKFCLaunchInfo(kfcParam) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }

    rtAicpuArgsEx_t argsInfo;
    argsInfo.args = static_cast<void*>(&kfcParam);
    argsInfo.argsSize = sizeof(kfcParam);
    argsInfo.soNameAddrOffset = static_cast<uint16_t>(offsetof(KfcDumpOpInitParam, soName));
    argsInfo.kernelNameAddrOffset = static_cast<uint16_t>(offsetof(KfcDumpOpInitParam, kernelName));
    argsInfo.hostInputInfoPtr = nullptr;
    argsInfo.kernelOffsetInfoPtr = nullptr;
    argsInfo.hostInputInfoNum = 0;
    argsInfo.kernelOffsetInfoNum = 0;
    argsInfo.isNoNeedH2DCopy = false;

    rtError_t ret =
        rtAicpuKernelLaunchExWithArgs(KERNEL_TYPE_AICPU_KFC, "VectorStats", 1, &argsInfo, nullptr, nullptr, 0);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED, "Failed to launch kfc kernel, ret=%d", ret);

    ret = rtStreamSynchronize(nullptr); // Use the default flow to ensure successful execution.
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "Execute rtStreamSynchronize failed for kfc kernel. ret=%d", ret);

    IDE_LOGI("Success to initialize the kfc kernel information on device %u.", deviceId_);
    return ADUMP_SUCCESS;
}

KfcLaunchMode OperatorPreliminary::DecideKFCLaunchMode(int32_t driverApiVersion)
{
    // 低于LAUNCH_MODE_AICPU，驱动版本过低(含：0(无驱动接口符号)和-1(获取驱动失败)))，统一不支持KFC算子。
    if (driverApiVersion < KFC_AICPU_DRV_VERSION) {
        return KfcLaunchMode::UNSUPPORTED;
    }
    if (driverApiVersion < KFC_ADUMP_DRV_VERSION) {
        return KfcLaunchMode::LAUNCH_MODE_AICPU;
    }
    return KfcLaunchMode::LAUNCH_MODE_ADUMP;
}

int32_t OperatorPreliminary::UpdateKFCLaunchInfo(KfcDumpOpInitParam& kfcParam) const
{
    KfcLaunchInfo launchInfo = {};
    switch (kfcLaunchMode_) {
        case KfcLaunchMode::LAUNCH_MODE_AICPU:
            launchInfo = AICPU_LAUNCH_INFO;
            break;
        case KfcLaunchMode::LAUNCH_MODE_ADUMP:
            launchInfo = ADUMP_LAUNCH_INFO;
            break;
        default:
            IDE_LOGE("Kfc launch mode is unsupported");
            return ADUMP_FAILED;
    }

    errno_t ret = strcpy_s(kfcParam.soName, FILE_NAME_MAX, launchInfo.soName);
    if (ret != EOK) {
        IDE_LOGE("Failed to set kfc soName, ret=%d", ret);
        return ADUMP_FAILED;
    }
    ret = strcpy_s(kfcParam.kernelName, FILE_NAME_MAX, launchInfo.kernelName);
    if (ret != EOK) {
        IDE_LOGE("Failed to set kfc kernelName, ret=%d", ret);
        return ADUMP_FAILED;
    }

    IDE_LOGI("Kfc operator uses soName[%s], kernelName[%s]", launchInfo.soName, launchInfo.kernelName);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::OperatorInit()
{
    int32_t version = AdumpDsmi::DrvGetAPIVersion();
    kfcLaunchMode_ = DecideKFCLaunchMode(version);
    if (kfcLaunchMode_ == KfcLaunchMode::UNSUPPORTED) {
        IDE_LOGW("Current driver version %d does not support kfc feature for dump statistics.", version);
        return ADUMP_SUCCESS;
    }

    IDE_LOGI("Prepare to initialize the resources of kfc operator on device %u.", deviceId_);
    do {
        int32_t ret = GetStreamInfo();
        IDE_CTRL_VALUE_FAILED_NODO(
            ret == ADUMP_SUCCESS, break, "OperatorInit is failed at GetStreamInfo when executed.");

        ret = GetUBSizeAndCoreNum();
        IDE_CTRL_VALUE_FAILED_NODO(
            ret == ADUMP_SUCCESS, break, "OperatorInit is failed at GetUBSizeAndCoreNum when executed.");

        ret = GetOperatorPCAddr();
        IDE_CTRL_VALUE_FAILED_NODO(
            ret == ADUMP_SUCCESS, break, "OperatorInit is failed at GetOperatorPCAddr when executed.");

        ret = CreateMemory();
        IDE_CTRL_VALUE_FAILED_NODO(
            ret == ADUMP_SUCCESS, break, "OperatorInit is failed at CreateMemory when executed.");

        ret = KFCKernelLaunch();
        IDE_CTRL_VALUE_FAILED_NODO(
            ret == ADUMP_SUCCESS, break, "OperatorInit is failed at kernel launch when executed.");
        return ADUMP_SUCCESS;
    } while (0);
    IDE_LOGW("Start to destroy rt api resources on device %u.", deviceId_);
    return ADUMP_FAILED;
}

} // namespace Adx
