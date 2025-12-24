/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "random_num_task.h"

#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"

namespace cce {
namespace runtime {

constexpr uint32_t VAL_TRUNCATED_NORMAL_DIS = 0b011;
constexpr uint32_t VLD_NORMAL_DIS = 0b11000;
constexpr uint32_t VLD_DROPOUT_BITMASK = 0b00001U;
constexpr uint32_t VLD_UNIFORM_DISTRIBUTIO = 0b00110U;
constexpr uint32_t RANDOM_SINGLE_PARAM_MAX_SIZE = 8U;
constexpr uint32_t RANDOM_INPUT_PARAM_SIZE = 16U;
constexpr uint32_t RANDOM_DROPOUT_RATION_INDEX = 0U;
constexpr uint32_t RANDOM_MIN_INDEX = 1U;
constexpr uint32_t RANDOM_MAX_INDEX = 2U;
constexpr uint32_t RANDOM_MEAN_INDEX = 3U;
constexpr uint32_t RANDOM_STDDEV_INDEX = 4U;
constexpr uint32_t RANDOM_SEED_INDEX = 5U;
constexpr uint32_t RANDOM_NUM_INDEX = 6U;
constexpr uint8_t RANDOM_VALUE_FLAG = 0U;
constexpr uint8_t RANDOM_ADDR_FLAG = 1U;

const std::map<rtRandomNumDataType, size_t> RANDOM_DATATYPE_SIZE_MAP = {
    {RT_RANDOM_NUM_DATATYPE_INT32, sizeof(int32_t)},
    {RT_RANDOM_NUM_DATATYPE_INT64, sizeof(int64_t)},
    {RT_RANDOM_NUM_DATATYPE_UINT32, sizeof(uint32_t)},
    {RT_RANDOM_NUM_DATATYPE_UINT64, sizeof(uint64_t)},
    {RT_RANDOM_NUM_DATATYPE_BF16, 2U}, // BF16 is 2 bytes
    {RT_RANDOM_NUM_DATATYPE_FP16, 2U}, // FP16 is 2 bytes
    {RT_RANDOM_NUM_DATATYPE_FP32, 4U}  // FP32 is 4 bytes
};

// Philox4_32_10支持dropout bitmask生成，随机失活比例dropout ratio支持bf16、fp16、fp32三种数据类型，硬件按照该比例生成bitmask；
// Philox4_32_10支持bf16、fp16、fp32的截断正态分布随机数生成；
// Philox4_32_10和MT19937支持bf16、fp16、fp32的正态分布随机数生成；
// Philox4_32_10和MT19937支持bf16、fp16、fp32、int32、int64、uint32、uint64的均匀分布
const std::map<rtRandomNumFuncType, std::string> FUNCTYPE_DATATYPE_STR_MAP = {
    {RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK, "bf16,fp16,fp32"},
    {RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS, "bf16,fp16,fp32,int32,int64,uint32,uint64"},
    {RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS, "bf16,fp16,fp32"},
    {RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS, "bf16,fp16,fp32"}
};

const std::map<rtRandomNumFuncType, std::set<rtRandomNumDataType>> FUNCTYPE_DATATYPE_MAP = {
    {
        RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK,
        {
            RT_RANDOM_NUM_DATATYPE_BF16,
            RT_RANDOM_NUM_DATATYPE_FP16,
            RT_RANDOM_NUM_DATATYPE_FP32
        }
    },
    {
        RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS,
        {
            RT_RANDOM_NUM_DATATYPE_BF16,
            RT_RANDOM_NUM_DATATYPE_FP16,
            RT_RANDOM_NUM_DATATYPE_FP32,
            RT_RANDOM_NUM_DATATYPE_INT32,
            RT_RANDOM_NUM_DATATYPE_INT64,
            RT_RANDOM_NUM_DATATYPE_UINT32,
            RT_RANDOM_NUM_DATATYPE_UINT64
        }
    },
    {
        RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS,
        {
            RT_RANDOM_NUM_DATATYPE_BF16,
            RT_RANDOM_NUM_DATATYPE_FP16,
            RT_RANDOM_NUM_DATATYPE_FP32
        }
    },
    {
        RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS,
        {
            RT_RANDOM_NUM_DATATYPE_BF16,
            RT_RANDOM_NUM_DATATYPE_FP16,
            RT_RANDOM_NUM_DATATYPE_FP32
        }
    }
};

static inline rtError_t
    GetRandomNumDataSize(rtRandomNumDataType dataType, size_t &dataSize)
{
    const auto iter = RANDOM_DATATYPE_SIZE_MAP.find(dataType);
    COND_RETURN_ERROR_MSG_INNER(iter == RANDOM_DATATYPE_SIZE_MAP.end(), RT_ERROR_INVALID_VALUE,
        "dataType[%d] is invalid, range=[0,%d)", dataType, RT_RANDOM_NUM_DATATYPE_MAX);

    dataSize = iter->second;

    return RT_ERROR_NONE;
}

static rtError_t CheckRandomParam(const rtRandomParaInfo_t &paramInfo, const std::string &paramName, size_t dataSize)
{
    if ((paramInfo.isAddr != RANDOM_VALUE_FLAG) && (paramInfo.isAddr != RANDOM_ADDR_FLAG)) { // 0: value, 1: addr
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "%s isAddr para is invalid, range=[0,1]", paramName.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    if ((paramInfo.size == 0U) || (paramInfo.size > dataSize)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "%s size is exceed, current size=%hhu, range=[1,%zu]", paramName.c_str(), paramInfo.size, dataSize);
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

static rtError_t CheckUniDisTaskInfo(const rtRandomNumTaskInfo_t *taskInfo, const size_t dataSize)
{
    const rtUniformDisInfo_t uniDisParam = taskInfo->randomNumFuncParaInfo.paramInfo.uniformDisInfo;
    const rtRandomParaInfo_t min = uniDisParam.min;
    size_t realDataSize = (min.isAddr == RANDOM_ADDR_FLAG) ? sizeof(uint64_t) : dataSize;
    rtError_t error = CheckRandomParam(min, "min", realDataSize);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "min check error info: dataType=%u, dataSize=%zu, isAddr=%hhu",
        static_cast<uint32_t>(taskInfo->dataType), dataSize, min.isAddr);

    const rtRandomParaInfo_t max = uniDisParam.max;
    realDataSize = (max.isAddr == RANDOM_ADDR_FLAG) ? sizeof(uint64_t) : dataSize;
    error = CheckRandomParam(max, "max", realDataSize);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "max check error info: dataType=%u, dataSize=%zu, isAddr=%hhu",
        static_cast<uint32_t>(taskInfo->dataType), dataSize, max.isAddr);

    return RT_ERROR_NONE;
}

static rtError_t CheckoutDropoutBitmaskTaskInfo(const rtRandomNumTaskInfo_t *taskInfo, const size_t dataSize)
{
    const rtDropoutBitMaskInfo_t dropoutBitmaskPara = taskInfo->randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo;
    const rtRandomParaInfo_t ration = dropoutBitmaskPara.dropoutRation;

    const size_t realDataSize = (ration.isAddr == RANDOM_ADDR_FLAG) ? sizeof(uint64_t) : dataSize;
    const rtError_t error = CheckRandomParam(ration, "dropoutRation", realDataSize);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "dropoutRation check error info:dataType=%u, dataSize=%zu, isAddr=%hhu",
        static_cast<uint32_t>(taskInfo->dataType), dataSize,
        ration.isAddr);

    return RT_ERROR_NONE;
}

static rtError_t CheckNorDisTaskInfo(const rtRandomNumTaskInfo_t *taskInfo, const size_t dataSize)
{
    const rtNormalDisInfo_t norDisParam = taskInfo->randomNumFuncParaInfo.paramInfo.normalDisInfo;
    const rtRandomParaInfo_t mean = norDisParam.mean;
    size_t realDataSize = (mean.isAddr == RANDOM_ADDR_FLAG) ? sizeof(uint64_t) : dataSize;
    rtError_t error = CheckRandomParam(mean, "mean", realDataSize);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "mean check error info: dataType=%u, dataSize=%zu, isAddr=%hhu",
        static_cast<uint32_t>(taskInfo->dataType), dataSize, mean.isAddr);

    const rtRandomParaInfo_t stddev = norDisParam.stddev;
    realDataSize = (stddev.isAddr == RANDOM_ADDR_FLAG) ? sizeof(uint64_t) : dataSize;
    error = CheckRandomParam(stddev, "stddev", realDataSize);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "stddev check error info: dataType=%u, dataSize=%zu, isAddr=%hhu",
        static_cast<uint32_t>(taskInfo->dataType), dataSize, stddev.isAddr);

    return RT_ERROR_NONE;
}

static rtError_t SetDropoutBitmaskDiffSqeInfo(const rtRandomNumTaskInfo_t *taskInfo, rtStarsDsaSqe_t &sqe,
    RandomParamCfgInfo &randomParam)
{
    const rtRandomParaInfo_t paraInfo = taskInfo->randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo.dropoutRation;
    sqe.paramVldBitmap = VLD_DROPOUT_BITMASK;
    if (paraInfo.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_DROPOUT_RATION_INDEX);
        RT_LOG(RT_LOG_INFO, "dropoutRation is not addr, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }

    const uint64_t *addr = RtPtrToPtr<const uint64_t *, const uint8_t *>(paraInfo.valueOrAddr);
    RT_LOG(RT_LOG_INFO, "dropoutRation value=0x%llx, size=%hhu", *addr, paraInfo.size);

    const errno_t rc = memcpy_s(RtPtrToPtr<void *, uint64_t*>(&randomParam.firstParam),
        RANDOM_SINGLE_PARAM_MAX_SIZE, RtPtrToPtr<const void *, const uint8_t *>(paraInfo.valueOrAddr), paraInfo.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        rc != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s failed, retCode=%d, size=%hhu",
        rc, paraInfo.size);

    return RT_ERROR_NONE;
}

static rtError_t SetUniDisDiffSqeInfo(const rtRandomNumTaskInfo_t *taskInfo, rtStarsDsaSqe_t &sqe, RandomParamCfgInfo &randomParam)
{
    const rtUniformDisInfo_t paraInfo = taskInfo->randomNumFuncParaInfo.paramInfo.uniformDisInfo;
    sqe.paramVldBitmap = VLD_UNIFORM_DISTRIBUTIO;
    if (paraInfo.min.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_MIN_INDEX);
        RT_LOG(RT_LOG_INFO, "minIsAddr is false, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }

    if (paraInfo.max.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_MAX_INDEX);
        RT_LOG(RT_LOG_INFO, "maxIsAddr is false, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }

    const uint64_t *minAddr = RtPtrToPtr<const uint64_t *, const uint8_t *>(paraInfo.min.valueOrAddr);
    RT_LOG(RT_LOG_INFO, "paraInfo.min.addr val=0x%llx, size=%hhu", *minAddr, paraInfo.min.size);

    const uint64_t *maxAddr = RtPtrToPtr<const uint64_t *, const uint8_t *>(paraInfo.max.valueOrAddr);
    RT_LOG(RT_LOG_INFO, "paraInfo.max.addr val=0x%llx, size=%hhu", *maxAddr, paraInfo.max.size);

    errno_t rc = memcpy_s(RtPtrToPtr<void *, uint64_t*>(&randomParam.firstParam),
        RANDOM_SINGLE_PARAM_MAX_SIZE, RtPtrToPtr<const void *, const uint8_t *>(paraInfo.min.valueOrAddr),
        paraInfo.min.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, rc != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy_s failed, retCode=%d, size=%hhu", rc, paraInfo.min.size);
    RT_LOG(RT_LOG_INFO, "min val=0x%llx, size=%hhu", randomParam.firstParam, paraInfo.min.size);

    rc = memcpy_s(RtPtrToPtr<void *, uint64_t*>(&randomParam.secondParam),
        RANDOM_SINGLE_PARAM_MAX_SIZE, RtPtrToPtr<const void *, const uint8_t *>(paraInfo.max.valueOrAddr),
        paraInfo.max.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        rc != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s failed, retCode=%d, size=%hhu",
        rc, paraInfo.max.size);
    RT_LOG(RT_LOG_INFO, "max val=0x%llx, size=%hhu", randomParam.secondParam, paraInfo.max.size);

    return RT_ERROR_NONE;
}

static rtError_t SetNorDisDiffSqeInfo(const rtRandomNumTaskInfo_t *taskInfo, rtStarsDsaSqe_t &sqe, RandomParamCfgInfo &randomParam)
{
    const rtRandomNumFuncType funcType = taskInfo->randomNumFuncParaInfo.funcType;
    sqe.paramVldBitmap = (funcType == RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS) ? VLD_NORMAL_DIS : VAL_TRUNCATED_NORMAL_DIS;

    const rtNormalDisInfo_t paraInfo = taskInfo->randomNumFuncParaInfo.paramInfo.normalDisInfo;
    if (paraInfo.mean.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_MEAN_INDEX);
        RT_LOG(RT_LOG_INFO, "meanIsAddr is false, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }

    if (paraInfo.stddev.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_STDDEV_INDEX);
        RT_LOG(RT_LOG_INFO, "stddevIsAddr is false, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }
    errno_t rc = memcpy_s(RtPtrToPtr<void *, uint64_t*>(&randomParam.firstParam),
        RANDOM_SINGLE_PARAM_MAX_SIZE, RtPtrToPtr<const void *, const uint8_t *>(paraInfo.mean.valueOrAddr),
        paraInfo.mean.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        rc != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s failed, retCode=%d, size=%hhu",
        rc, paraInfo.mean.size);

    RT_LOG(RT_LOG_INFO, "mean val=0x%llx, size=%hhu", randomParam.firstParam, paraInfo.mean.size);
    rc = memcpy_s(RtPtrToPtr<void *, uint64_t*>(&randomParam.secondParam),
        RANDOM_SINGLE_PARAM_MAX_SIZE, RtPtrToPtr<const void *, const uint8_t *>(paraInfo.stddev.valueOrAddr),
        paraInfo.stddev.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, rc != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy_s failed, retCode=%d, size=%hhu", rc, paraInfo.stddev.size);
    RT_LOG(RT_LOG_INFO, "stddev val=0x%llx, size=%hhu", randomParam.secondParam, paraInfo.stddev.size);

    return RT_ERROR_NONE;
}

static rtError_t SetRandomSqeCommonInfo(const rtRandomNumTaskInfo_t * const taskInfo, const TaskInfo * const commonTask,
    rtStarsDsaSqe_t &sqe, const RandomParamCfgInfo &randomParam, void *devMem)
{
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_DSA;
    sqe.start = 1U;
    sqe.functionType = taskInfo->randomNumFuncParaInfo.funcType;
    sqe.dataType = static_cast<uint32_t>(taskInfo->dataType);
    sqe.algoType = 0U;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    rtError_t error = RT_ERROR_NONE;
    if (taskInfo->randomSeed.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_SEED_INDEX);
        RT_LOG(RT_LOG_INFO, "seedIsAddr is false, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }

    if (taskInfo->randomNum.isAddr == RANDOM_VALUE_FLAG) {
        sqe.paramAddrValBitmap |= (1U << RANDOM_NUM_INDEX);
        RT_LOG(RT_LOG_INFO, "numIsAddr is false, paramAddrValBitmap=%u", sqe.paramAddrValBitmap);
    }

    void *addr = (taskInfo->randomParaAddr == nullptr) ? devMem : taskInfo->randomParaAddr;
    const auto dev = commonTask->stream->Device_();
    error = dev->Driver_()->MemCopySync(addr, RANDOM_INPUT_PARAM_SIZE, &randomParam,
        RANDOM_INPUT_PARAM_SIZE, RT_MEMCPY_HOST_TO_DEVICE);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "mem copy fail, ret=%u", error);

    sqe.dsaCfgParamAddrLow =
        static_cast<uint32_t>(static_cast<uint64_t>(MASK_32_BIT) & RtPtrToPtr<uint64_t, void *>(addr));
    sqe.dsaCfgParamAddrHigh =
        static_cast<uint32_t>(RtPtrToPtr<uint64_t, void *>(addr) >> static_cast<uint64_t>(UINT32_BIT_NUM));

    sqe.dsaCfgResultAddrLow = static_cast<uint32_t>(
        static_cast<uint64_t>(MASK_32_BIT) & RtPtrToPtr<uint64_t, void *>(taskInfo->randomResultAddr));
    sqe.dsaCfgResultAddrHigh = static_cast<uint32_t>(
        RtPtrToPtr<uint64_t, void *>(taskInfo->randomResultAddr) >> static_cast<uint64_t>(UINT32_BIT_NUM));

    sqe.dsaCfgStateAddrLow = static_cast<uint32_t>(
        static_cast<uint64_t>(MASK_32_BIT) & RtPtrToPtr<uint64_t, void *>(taskInfo->randomCounterAddr));
    sqe.dsaCfgStateAddrHigh = static_cast<uint32_t>(
        RtPtrToPtr<uint64_t, void *>(taskInfo->randomCounterAddr) >> static_cast<uint64_t>(UINT32_BIT_NUM));

    uint64_t randomSeed = 0ULL;
    errno_t ret =
        memcpy_s(&randomSeed, sizeof(uint64_t), taskInfo->randomSeed.valueOrAddr, taskInfo->randomSeed.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        ret != EOK, RT_ERROR_SEC_HANDLE, "memcpy_s failed, retCode=%d, size=%hhu", ret, taskInfo->randomSeed.size);
    sqe.dsaCfgSeedLow = static_cast<uint32_t>(static_cast<uint64_t>(MASK_32_BIT) & randomSeed);
    sqe.dsaCfgSeedHigh = static_cast<uint32_t>(randomSeed >> static_cast<uint64_t>(UINT32_BIT_NUM));

    uint64_t randomNum = 0ULL;
    ret = memcpy_s(&randomNum, sizeof(uint64_t), taskInfo->randomNum.valueOrAddr, taskInfo->randomNum.size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        ret != EOK, RT_ERROR_SEC_HANDLE, "memcpy_s failed, retCode=%d, size=%hhu", ret, taskInfo->randomNum.size);
    sqe.dsaCfgNumberLow = static_cast<uint32_t>(static_cast<uint64_t>(MASK_32_BIT) & randomNum);
    sqe.dsaCfgNumberHigh= static_cast<uint32_t>(randomNum >> static_cast<uint64_t>(UINT32_BIT_NUM));

    return RT_ERROR_NONE;
}

static rtError_t SetRandomSqeDiffInfo(const rtRandomNumTaskInfo_t *taskInfo, rtStarsDsaSqe_t &sqe, RandomParamCfgInfo &randomParam)
{
    rtError_t error = RT_ERROR_NONE;
    switch (taskInfo->randomNumFuncParaInfo.funcType) {
        case RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK:
            error = SetDropoutBitmaskDiffSqeInfo(taskInfo, sqe, randomParam);
            break;
        case RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS:
            error = SetUniDisDiffSqeInfo(taskInfo, sqe, randomParam);
            break;
        case RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS:
        case RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS:
            error = SetNorDisDiffSqeInfo(taskInfo, sqe, randomParam);
            break;
        default:
            error = RT_ERROR_INVALID_VALUE;
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "funcType[%d] is invalid, should be [0, %d)",
                taskInfo->randomNumFuncParaInfo.funcType, RT_RANDOM_NUM_FUNC_TYPE_MAX);
            break;
    }

    return error;
}

rtError_t GetDsaSqeByRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, TaskInfo *commonTask, rtStarsDsaSqe_t &sqe)
{
    rtError_t error = RT_ERROR_NONE;
    void *devMem = nullptr;
    const auto dev = commonTask->stream->Device_();

    error = dev->Driver_()->DevMemAlloc(&devMem,
        static_cast<uint64_t>(RANDOM_INPUT_PARAM_SIZE + sizeof(rtStarsDsaSqe_t)),
        RT_MEMORY_DEFAULT,
        dev->Id_(),
        MODULEID_RUNTIME,
        true,
        false,
        false);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "malloc mem fail, ret=%u", error);
    RT_LOG(RT_LOG_INFO, "mem alloc by runtime, mem ptr=0x%llx", RtPtrToPtr<uint64_t, void *>(devMem));

    StarsCommonTaskInfo *starsCommonTask = &commonTask->u.starsCommTask;
    starsCommonTask->randomDevAddr = devMem;
    RandomParamCfgInfo randomParam = {};
    error = SetRandomSqeDiffInfo(taskInfo, sqe, randomParam);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "set dsa sqe diff info failed, retCode=%#x", static_cast<uint32_t>(error));

    error = SetRandomSqeCommonInfo(taskInfo, commonTask, sqe, randomParam, devMem);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "set dsa sqe common info failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;

ERROR_FREE:
    if (devMem != nullptr) {
        (void)dev->Driver_()->DevMemFree(devMem, dev->Id_());
        devMem = nullptr;
    }

    return error;
}

static inline rtError_t CheckDataTypeByFuncType(rtRandomNumDataType dataType, rtRandomNumFuncType funcType)
{
    const auto iter = FUNCTYPE_DATATYPE_MAP.find(funcType);
    COND_RETURN_ERROR_MSG_INNER(iter == FUNCTYPE_DATATYPE_MAP.end(), RT_ERROR_INVALID_VALUE,
        "funcType[%d] is invalid, range=[0,%d)", funcType, RT_RANDOM_NUM_FUNC_TYPE_MAX);

    const auto strMapIter = FUNCTYPE_DATATYPE_STR_MAP.find(funcType);
    COND_RETURN_ERROR_MSG_INNER(strMapIter == FUNCTYPE_DATATYPE_STR_MAP.end(), RT_ERROR_INVALID_VALUE,
        "funcType[%d] is invalid, range=[0,%d)", funcType, RT_RANDOM_NUM_FUNC_TYPE_MAX);

    auto sets = iter->second;
    std::string dataStr = strMapIter->second;
    COND_RETURN_ERROR_MSG_INNER(sets.count(dataType) == 0U, RT_ERROR_INVALID_VALUE,
        "The dataType[%d] of funcType[%d] is invalid, range=[%s]", dataType, funcType, dataStr.c_str());

    return RT_ERROR_NONE;
}

rtError_t CheckRandomNumTaskInfo(const rtRandomNumTaskInfo_t *taskInfo)
{
    const rtRandomNumFuncType funcType = taskInfo->randomNumFuncParaInfo.funcType;
    rtError_t error = CheckDataTypeByFuncType(taskInfo->dataType, funcType);
    ERROR_RETURN_MSG_INNER(error,"check data type by funcType failed,dataType=%d,funcType=%d,retCode=%#x",
        taskInfo->dataType, funcType, static_cast<uint32_t>(error));

    size_t dataSize = 0U;
    error = GetRandomNumDataSize(taskInfo->dataType, dataSize);
    ERROR_RETURN_MSG_INNER(error,
        "get random num data size failed, dataType=%d, retCode=%d", taskInfo->dataType, error);

    if ((taskInfo->randomCounterAddr == nullptr) || (taskInfo->randomResultAddr == nullptr)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                         "randomCounterAddr or randomResultAddr is nullptr");
        return RT_ERROR_INVALID_VALUE;
    }

    // 随机种子和随机数个数均为64bit
    const rtRandomParaInfo_t seed = taskInfo->randomSeed;
    error = CheckRandomParam(seed, "randomSeed", sizeof(uint64_t));
    ERROR_RETURN_MSG_INNER(error, "randomSeed check failed, retCode=%#x", static_cast<uint32_t>(error));

    const rtRandomParaInfo_t num = taskInfo->randomNum;
    error = CheckRandomParam(num, "randomNum", sizeof(uint64_t));
    ERROR_RETURN_MSG_INNER(error, "randomNum check failed, retCode=%#x", static_cast<uint32_t>(error));

    // 通过funcType检查Random param
    switch (funcType) {
        case RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK:
            error = CheckoutDropoutBitmaskTaskInfo(taskInfo, dataSize);
            break;
        case RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS:
            error = CheckUniDisTaskInfo(taskInfo, dataSize);
            break;
        case RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS:
        case RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS:
            error = CheckNorDisTaskInfo(taskInfo, dataSize);
            break;
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                "funcType[%u] is invalid, ", static_cast<uint32_t>(taskInfo->randomNumFuncParaInfo.funcType));
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    ERROR_RETURN_MSG_INNER(error, "check task info by func type failed, retCode=%#x", static_cast<uint32_t>(error));

    return error;
}

}  // namespace runtime
}  // namespace cce