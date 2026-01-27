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
#include "lib_path.h"
#include "file_utils.h"
#include "log/adx_log.h"
#include "adump_platform_api.h"
#include "runtime/kernel.h"
#include "runtime/mem.h"
#include "runtime/dev.h"

namespace Adx {
constexpr uint32_t SINGLE_STATS_BYTE = 8;   // 单个统计项的占用大小
constexpr uint32_t BLOCK_MIN_SIZE = 32;     // 最小搬运单元
constexpr uint32_t DCCI_SYNC_SIZE = 64;     // DCCI强制同步数据64B
constexpr uint32_t MAX_STATS_NUM = 64;      // 最大统计项个数
constexpr uint32_t INTEGER_KILOBYTE = 1024; // 表示1KB

constexpr const char *const KFC_OPERATOR_STUB_NAME = "kfc_dump_stat_stub";
constexpr const char *const KFC_OPERATOR_NAME = "kfc_dump_stat";

static const std::vector<PlatformType> AICORE_RELATED = {PlatformType::CHIP_DC_TYPE};

OperatorPreliminary::OperatorPreliminary(const DumpSetting &setting, const uint32_t deviceId)
    : deviceId_(deviceId), setting_(setting), opData_({})
{
}

OperatorPreliminary::~OperatorPreliminary()
{
}

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

std::string OperatorPreliminary::GetBinName() const
{
    auto it = BIN_NAME_MAP.find(setting_.GetPlatformType());
    if (it != BIN_NAME_MAP.cend()) {
        return it->second;
    }
    return "UNKNOW_FILENAME";
}

int32_t OperatorPreliminary::GetStreamInfo()
{
    IDE_LOGI("Start GetStreamInfo on device %u.", deviceId_);
    rtError_t ret = rtSetDevice(deviceId_);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtSetDevice on device %u failed with result %d", deviceId_, ret);
    opData_.setDevice = true;

    ret = rtStreamCreateWithFlags(&opData_.deviceStm, 0, RT_STREAM_CP_PROCESS_USE);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtStreamCreateWithFlags on device %u failed with result %d", deviceId_, ret);

    ret = rtGetStreamId(opData_.deviceStm, &opData_.streamId);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtGetStreamId on device %u failed with result %d", deviceId_, ret);

    ret = rtStreamGetSqid(opData_.deviceStm, &opData_.sqId);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtStreamGetSqid on device %u failed with result %d", deviceId_, ret);

    ret = rtStreamGetCqid(opData_.deviceStm, &opData_.cqIds, &opData_.logicCqIds);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtStreamGetCqid on device %u failed with result %d", deviceId_, ret);

    IDE_LOGI("Success to get stream id=%d, sqId=%u, cqId=%u, logic cqId=%u on device %u.", opData_.streamId,
        opData_.sqId, opData_.cqIds, opData_.logicCqIds, deviceId_);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::GetUBSizeAndCoreNum()
{
    char version[SOC_VERSION_LEN] = {};
    IDE_CTRL_VALUE_FAILED(rtGetSocVersion(version, SOC_VERSION_LEN) == RT_ERROR_NONE, return ADUMP_FAILED,
        "Failed to get soc version");
    const std::string socVersion(version);

    PlatformData platformData;
    IDE_CTRL_VALUE_FAILED(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, setting_.GetPlatformType(), platformData),
        return ADUMP_FAILED, "Failed to read platform info from fe api.");

    opData_.ubSize = platformData.ubSize;
    opData_.aiCoreCnt = platformData.aiCoreCnt;
    opData_.vectCoreCnt = platformData.vectCoreCnt;
    IDE_LOGI("Get ub size:%" PRIu64 ", ai core count:%" PRIu64 ", vector core count:%" PRIu64 " on device %u.",
        opData_.ubSize, opData_.aiCoreCnt, opData_.vectCoreCnt, deviceId_);
    return ADUMP_SUCCESS;
}

std::unique_ptr<char[]> OperatorPreliminary::LoadBinFile(const std::string &filename, size_t &fileSize) const
{
    std::string realPath;
    IDE_CTRL_VALUE_FAILED(FileUtils::FileNameIsReal(filename, realPath) == IDE_DAEMON_OK, return nullptr,
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
    char* buffer = new(std::nothrow) char[fileSize];
    IDE_CTRL_VALUE_FAILED(buffer != nullptr, return nullptr, "Failed to new file buffer");
    IDE_CTRL_VALUE_FAILED(iFile.read(buffer, fileSize), {delete[] buffer; return nullptr;},
        "Failed to read file data. file: %s, size: %ld", filename.c_str(), fileSize);
    return std::unique_ptr<char []>(buffer);
}

int32_t OperatorPreliminary::GetOperatorPCAddr()
{
    static std::unique_ptr<char[]> binData = nullptr;
    rtError_t ret = RT_ERROR_NONE;

    if (binData == nullptr) {
        std::string opName = GetBinName();
        IDE_CTRL_VALUE_FAILED(!opName.empty(), return ADUMP_FAILED, "Failed to find kfc operator file.");

        const std::string opPath = LibPath::Instance().GetTargetPath(opName);
        IDE_CTRL_VALUE_FAILED(!opPath.empty(), return ADUMP_FAILED, "Received an empty path for file %s.", opName.c_str());
        IDE_CTRL_VALUE_FAILED(FileUtils::IsFileExist(opPath), return ADUMP_FAILED,
            "Failed to binary file from %s.", opPath.c_str());

        size_t fileSize = 0;
        binData = LoadBinFile(opPath, fileSize);
        IDE_CTRL_VALUE_FAILED(binData != nullptr, return ADUMP_FAILED, "Get binary handle failed");

        rtDevBinary_t bin{.magic = RT_DEV_BINARY_MAGIC_ELF_AIVEC, .version = 0,
            .data = static_cast<void*>(binData.get()), .length = fileSize};

        ret = rtDevBinaryRegister(&bin, &opData_.binHandle);
        IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
            "Failed to parse bin data into handle, ret is %d", ret);

        ret = rtFunctionRegister(opData_.binHandle, KFC_OPERATOR_STUB_NAME, KFC_OPERATOR_NAME, KFC_OPERATOR_NAME, 0U);
        IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
            "Failed to register handle into stub kernel name %s, ret is %d", KFC_OPERATOR_STUB_NAME, ret);
    }

    ret = rtGetAddrByFun(KFC_OPERATOR_STUB_NAME, &opData_.pcAddr);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Failed to get pc addr from stub kernel name %s, ret is %d", KFC_OPERATOR_STUB_NAME, ret);

    IDE_LOGI("Success to get pc address %p on device %u.", opData_.pcAddr, deviceId_);
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

    IDE_CTRL_VALUE_FAILED(opData_.workspaceSize != 0 && opData_.stackBaseSize != 0, return ADUMP_FAILED,
        "The size of the workspaceSize is 0");
    IDE_LOGI("Calculate MsgQ Size:%" PRIu64 "Byte, output size:%" PRIu64 "Byte, workspace size:%" PRIu64 "Byte,"
        "stack base size:%" PRIu64 "Byte on device %u.", opData_.msgQSize, opData_.outputSize,
        opData_.workspaceSize, opData_.stackBaseSize, deviceId_);

    rtError_t ret = rtMalloc(&opData_.memoryAddr, opData_.msgQSize + opData_.outputSize +
        opData_.workspaceSize + opData_.stackBaseSize, RT_MEMORY_DEFAULT, AICPU);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtMalloc failed with result %d", ret);
    IDE_LOGI("Rt malloc success on device %u.", deviceId_);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::KFCKernelLaunch()
{
    IDE_LOGD("Start to init kfc kernel information for device %u.", deviceId_);
    KfcDumpOpInitParam kfcParam;
    kfcParam.kfcWorkSpace.msgQ = reinterpret_cast<uint64_t>(opData_.memoryAddr);
    kfcParam.kfcWorkSpace.msgQSize = opData_.msgQSize;
    kfcParam.kfcWorkSpace.output = kfcParam.kfcWorkSpace.msgQ  + opData_.msgQSize;
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

    rtError_t ret = rtAicpuKernelLaunchExWithArgs(KERNEL_TYPE_AICPU_KFC, "VectorStats", 1, &argsInfo, nullptr,
        nullptr, 0);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Failed to launch kernel for KFC, ret is %d", ret);

    ret = rtStreamSynchronize(nullptr); // Use the default flow to ensure successful execution.
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
        "Execute rtStreamSynchronize for kernel launch failed with result %d", ret);

    IDE_LOGI("Success to init kfc kernel information on device %u.", deviceId_);
    return ADUMP_SUCCESS;
}

int32_t OperatorPreliminary::OperatorInit()
{
    int32_t version = AdumpDsmi::DrvGetAPIVersion();
    if (version != 0 && version < SUPPORTED_DRV_VERSION) {
        IDE_LOGW("Current driver version %d does not support this feature.", version);
        return ADUMP_SUCCESS;
    }
    // If version is 0, it indicates that the interface is obsolete and the current operator continues to execute.

    IDE_LOGI("Prepare to initialize the resources of kfc kernel on device %u.", deviceId_);
    do {
        int32_t ret = GetStreamInfo();
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, break, "OperatorInit fails at GetStreamInfo when executed.");

        ret = GetUBSizeAndCoreNum();
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, break,
            "OperatorInit fails at GetUBSizeAndCoreNum when executed.");

        ret = GetOperatorPCAddr();
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, break,
            "OperatorInit fails at GetOperatorPCAddr when executed.");

        ret = CreateMemory();
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, break, "OperatorInit fails at CreateMemory when executed.");

        ret = KFCKernelLaunch();
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, break, "OperatorInit fails at kernel launch when executed.");
        return ADUMP_SUCCESS;
    } while (0);
    IDE_LOGW("Start to destroy rt api resources on device %u.", deviceId_);
    return ADUMP_FAILED;
}

} // namespace Adx
