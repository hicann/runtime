/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include "acl_dump.h"
#include "adump_pub.h"
#include "adump_api.h"
#include "dump_manager.h"
#include "dump_printf.h"
#include "adump_error_manager.h"
#include "str_utils.h"
#include "common/path.h"

namespace Adx {
uint64_t g_chunk[RING_CHUNK_SIZE + MAX_TENSOR_NUM] = {0};
bool g_setAssert = false;
static std::mutex g_setAssertMtx;
namespace {
uint32_t g_atomicIndex = 0x2000;
std::atomic<uint64_t> g_writeIdx{0};

void ConvertAclDumpTensorInner(const acldumpTensorInfo &src, size_t index, TensorInfo &dst)
{
    dst.type = static_cast<TensorType>(src.type);
    dst.tensorSize = src.tensorSize;
    dst.format = src.format;
    dst.dataType = src.dataType;
    dst.tensorAddr = src.tensorAddr;
    dst.addrType = static_cast<AddressType>(src.addrType);
    dst.placement = static_cast<int32_t>(src.placement);
    dst.argsOffSet = static_cast<uint32_t>(index);

    for (uint32_t i = 0; i < src.shapeNum; ++i) {
        dst.shape.emplace_back(static_cast<int64_t>(src.shape[i]));
    }
    for (uint32_t i = 0; i < src.originShapeNum; ++i) {
        dst.originShape.emplace_back(static_cast<int64_t>(src.originShape[i]));
    }
}

bool ReportInvalidTensorField(size_t index, const char *field, const std::string &reason)
{
    std::string param = StrUtils::Format("tensors[%zu].%s", index, field);
    REPORT_EP0006_INVALID_ARGUMENT(FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, param,
        FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_TENSORS, reason);
    return false;
}

bool ReportUnsupportedTensorField(size_t index, const char *field, int32_t value, const char *expected)
{
    return ReportInvalidTensorField(index, field,
        StrUtils::Format(ADUMP_REASON_PARAM_VALUE_NOT_SUPPORTED, std::to_string(value).c_str(), expected));
}

bool CheckAclDumpTensorShape(const acldumpTensorInfo &src, size_t index)
{
    const std::string maxShapeNum = std::to_string(ACL_DUMP_MAX_SHAPE_NUM);
    if (src.shapeNum > ACL_DUMP_MAX_SHAPE_NUM) {
        return ReportInvalidTensorField(index, "shapeNum",
            StrUtils::Format(ADUMP_REASON_PARAM_VALUE_EXCEED_LIMIT, 
                std::to_string(src.shapeNum).c_str(), maxShapeNum.c_str()));
    }
    if (src.originShapeNum > ACL_DUMP_MAX_SHAPE_NUM) {
        return ReportInvalidTensorField(index, "originShapeNum",
            StrUtils::Format(ADUMP_REASON_PARAM_VALUE_EXCEED_LIMIT, 
                std::to_string(src.originShapeNum).c_str(), maxShapeNum.c_str()));
    }
    return true;
}

bool CheckAclDumpTensorEnum(const acldumpTensorInfo &src, size_t index)
{
    if (src.type != ACL_DUMP_TENSOR_INPUT
        && src.type != ACL_DUMP_TENSOR_OUTPUT
        && src.type != ACL_DUMP_TENSOR_WORKSPACE) {
        return ReportUnsupportedTensorField(index, "type", static_cast<int32_t>(src.type),
            "ACL_DUMP_TENSOR_INPUT/ACL_DUMP_TENSOR_OUTPUT/ACL_DUMP_TENSOR_WORKSPACE");
    }
    if (src.addrType != ACL_DUMP_ADDR_RAW) {
        return ReportUnsupportedTensorField(
            index, "addrType", static_cast<int32_t>(src.addrType), "ACL_DUMP_ADDR_RAW");
    }
    if (src.placement != ACL_DUMP_PLACEMENT_DEVICE) {
        return ReportUnsupportedTensorField(
            index, "placement", static_cast<int32_t>(src.placement), "ACL_DUMP_PLACEMENT_DEVICE");
    }
    return true;
}

bool CheckAclDumpTensorData(const acldumpTensorInfo &src, size_t index)
{
    if (src.tensorAddr == nullptr) {
        std::string param = StrUtils::Format("tensors[%zu].tensorAddr", index);
        REPORT_EP0007_NULL_POINTER(FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, param);
        return false;
    }
    if (src.tensorSize == 0) {
        return ReportInvalidTensorField(
            index, "tensorSize", StrUtils::Format(ADUMP_REASON_PARAM_MUST_BE_GREATER_THAN, "0"));
    }
    return true;
}

bool ConvertAclDumpTensor(const acldumpTensorInfo &src, size_t index, TensorInfo &dst)
{
    if (!CheckAclDumpTensorShape(src, index)
        || !CheckAclDumpTensorEnum(src, index)
        || !CheckAclDumpTensorData(src, index)) {
        return false;
    }

    ConvertAclDumpTensorInner(src, index, dst);
    return true;
}
}  // namespace

void *AdumpGetSizeInfoAddr(uint32_t space, uint32_t &atomicIndex)
{
    if (!g_setAssert) {
        const std::lock_guard<std::mutex> lock(g_setAssertMtx);
        if (!g_setAssert) {
            (void)rtSetTaskFailCallback(AdxAssertCallBack);
            g_setAssert = true;
        }
    }
    if (space > MAX_TENSOR_NUM) {
        return nullptr;
    }

    atomicIndex = g_atomicIndex++;
    auto nextWriteCursor = g_writeIdx.fetch_add(space);
    return g_chunk + (nextWriteCursor % RING_CHUNK_SIZE);
}

int32_t AdumpRegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc)
{
    return DumpManager::Instance().RegisterCallback(moduleId, enableFunc, disableFunc);
}

int32_t AdumpSaveToFile(const char *data, size_t dataLen, const char *filename, SaveType type)
{
    return DumpManager::Instance().SaveFile(data, dataLen, filename, type);
}
}  // namespace Adx

/**
 * @ingroup AscendCL
 * @brief Enable the dump function of the corresponding dump type.
 *
 * @param dumpType [IN]  type of dump
 * @param path     [IN]  dump path
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
{
    if (path == nullptr) {
        REPORT_EP0007_NULL_POINTER(
            Adx::FUNC_NAME_ACL_OP_START_DUMP_ARGS, Adx::FUNC_ACL_OP_START_DUMP_ARGS_PARAM_PATH);
        return ACL_ERROR_FAILURE;
    }

    if ((dumpType & ACL_OP_DUMP_OP_AICORE_ARGS) != ACL_OP_DUMP_OP_AICORE_ARGS) {
        std::string dumpTypeStr = std::to_string(dumpType);
        std::string expTypeStr = std::to_string(ACL_OP_DUMP_OP_AICORE_ARGS);
        std::string reason = Adx::StrUtils::Format(
            Adx::ADUMP_REASON_RESERVED_PARAM_MUST_EQUAL, expTypeStr.c_str());
        REPORT_EP0006_INVALID_ARGUMENT(
            Adx::FUNC_NAME_ACL_OP_START_DUMP_ARGS, dumpTypeStr,
            Adx::FUNC_ACL_OP_START_DUMP_ARGS_PARAM_DUMPTYPE, reason);
        return ACL_ERROR_FAILURE;
    }

    std::string dumpPath(path);
    int32_t ret = Adx::DumpManager::Instance().StartDumpArgs(dumpPath);
    if (ret != 0) {
        return ACL_ERROR_FAILURE;
    }

    return ACL_SUCCESS;
}

/**
 * @ingroup AscendCL
 * @brief Disable the dump function of the corresponding dump type.
 *
 * @param dumpType [IN]  type of dump
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError aclopStopDumpArgs(uint32_t dumpType)
{
    if ((dumpType & ACL_OP_DUMP_OP_AICORE_ARGS) == ACL_OP_DUMP_OP_AICORE_ARGS) {
        if (Adx::DumpManager::Instance().StopDumpArgs() != 0) {
            return ACL_ERROR_FAILURE;
        }
    }
    return ACL_SUCCESS;
}

/**
 * @ingroup AscendCL
 * @brief Get Exception Dump path.
 *
 * @retval path for success
 * @retval NULL for failed
 */
const char* acldumpGetPath(acldumpType dumpType)
{
    switch (dumpType) {
        case acldumpType::AIC_ERR_BRIEF_DUMP:
        case acldumpType::AIC_ERR_NORM_DUMP:
        case acldumpType::AIC_ERR_DETAIL_DUMP:
            return Adx::DumpManager::Instance().GetExtraExceptionDumpPath();
        case acldumpType::DATA_DUMP:
        case acldumpType::OVERFLOW_DUMP:
            return Adx::DumpManager::Instance().GetDataDumpPath();
        default:
            return nullptr;
    }
}

/**
 * @ingroup AscendCL
 * @brief Save custom exception info (tensors) to the Exception Dump path.
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError acldumpSaveExceptionInfo(const char *fileName, const char *userTag,
    const acldumpTensorInfo *tensors, size_t tensorCount)
{
    if (fileName == nullptr) {
        REPORT_EP0007_NULL_POINTER(
            Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, Adx::FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_FILENAME);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (fileName[0] == '\0') {
        REPORT_EP0006_INVALID_ARGUMENT(Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, "",
            Adx::FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_FILENAME, Adx::ADUMP_REASON_PARAM_PATH_EMPTY);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (Adx::Path::HasParentDirSegment(fileName)) {
        REPORT_EP0006_INVALID_ARGUMENT(Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, fileName,
            Adx::FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_FILENAME, Adx::ADUMP_REASON_PARAM_PATH_HAS_PARENT_DIR);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (tensors == nullptr) {
        REPORT_EP0007_NULL_POINTER(
            Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, Adx::FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_TENSORS);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (tensorCount == 0) {
        const std::string reason = Adx::StrUtils::Format(Adx::ADUMP_REASON_PARAM_MUST_BE_GREATER_THAN, "0");
        REPORT_EP0006_INVALID_ARGUMENT(Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, std::to_string(tensorCount),
            Adx::FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_TENSORCOUNT, reason);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (!Adx::DumpManager::Instance().IsEnabledExceptionDump()) {
        const std::string reason = Adx::StrUtils::Format(
            Adx::ADUMP_REASON_EXCEPTION_DUMP_NOT_ENABLED, Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO);
        REPORT_EP0008_API_CALL_SEQUENCE(Adx::FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO, reason);
        return ACL_ERROR_FAILURE;
    }

    std::vector<Adx::TensorInfo> tensorInfos(tensorCount);
    for (size_t i = 0; i < tensorCount; ++i) {
        if (!Adx::ConvertAclDumpTensor(tensors[i], i, tensorInfos[i])) {
            return ACL_ERROR_INVALID_PARAM;
        }
    }

    const std::string userTagStr = (userTag == nullptr) ? "" : userTag;
    const int32_t ret = Adx::DumpManager::Instance().SaveExceptionInfo(fileName, userTagStr, tensorInfos);
    return ret == 0 ? ACL_SUCCESS : ACL_ERROR_FAILURE;
}

/**
 * @ingroup AscendCL
 * @brief Get the Exception Dump root path({dump_path}/extra-info/data-dump/{deviceId}/).
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError acldumpGetExceptionInfoPath(char *path, size_t maxLen)
{
    if (path == nullptr) {
        REPORT_EP0007_NULL_POINTER(
            Adx::FUNC_NAME_ACL_DUMP_GET_EXCEPTION_INFO_PATH, Adx::FUNC_ACL_DUMP_GET_EXCEPTION_INFO_PATH_PARAM_PATH);
        return ACL_ERROR_INVALID_PARAM;
    }
    if (maxLen <= 1) {
        std::string reason = Adx::StrUtils::Format(Adx::ADUMP_REASON_PARAM_MUST_BE_GREATER_THAN, "1");
        REPORT_EP0006_INVALID_ARGUMENT(Adx::FUNC_NAME_ACL_DUMP_GET_EXCEPTION_INFO_PATH, std::to_string(maxLen),
            Adx::FUNC_ACL_DUMP_GET_EXCEPTION_INFO_PATH_PARAM_MAXLEN, reason);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (!Adx::DumpManager::Instance().IsEnabledExceptionDump()) {
        const std::string reason = Adx::StrUtils::Format(
            Adx::ADUMP_REASON_EXCEPTION_DUMP_NOT_ENABLED, Adx::FUNC_NAME_ACL_DUMP_GET_EXCEPTION_INFO_PATH);
        REPORT_EP0008_API_CALL_SEQUENCE(Adx::FUNC_NAME_ACL_DUMP_GET_EXCEPTION_INFO_PATH, reason);
        return ACL_ERROR_FAILURE;
    }

    std::string dumpPath;
    int32_t ret = Adx::DumpManager::Instance().GetExceptionDumpPath(dumpPath);
    if (ret != 0 || dumpPath.empty()) {
        IDE_LOGE("Get the exception dump path failed, path size=%zu, maxLen=%zu.", dumpPath.size(), maxLen);
        return ACL_ERROR_FAILURE;
    }

    if (dumpPath.size() + 1 > maxLen) {
        std::string reason = Adx::StrUtils::Format(Adx::ADUMP_REASON_BUFFER_SIZE_NOT_ENOUGH,
            std::to_string(maxLen).c_str(), std::to_string(dumpPath.size() + 1).c_str());
        REPORT_EP0006_INVALID_ARGUMENT(Adx::FUNC_NAME_ACL_DUMP_GET_EXCEPTION_INFO_PATH, std::to_string(maxLen),
            Adx::FUNC_ACL_DUMP_GET_EXCEPTION_INFO_PATH_PARAM_MAXLEN, reason);
        return ACL_ERROR_INVALID_PARAM;
    }
    if (strcpy_s(path, maxLen, dumpPath.c_str()) != EOK) {
        IDE_LOGE("Copy the path to buffer failed when get the exception dump path, path size=%zu, maxLen=%zu.",
            dumpPath.size(), maxLen);
        return ACL_ERROR_FAILURE;
    }
    return ACL_SUCCESS;
}
