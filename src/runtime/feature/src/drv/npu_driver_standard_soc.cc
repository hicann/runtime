/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "driver.hpp"
#include "runtime.hpp"
#ifdef CFG_DEV_PLATFORM_PC
#include "cmodel_driver.h"
#endif
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "npu_driver_record.hpp"
namespace cce {
namespace runtime {
rtError_t NpuDriver::CreateAsyncDmaWqe(uint32_t devId, const AsyncDmaWqeInputInfo &input, AsyncDmaWqeOutputInfo *output,
                                       bool isUbMode, bool isSqeUpdate)
{
    struct halAsyncDmaOutputPara wqeDmaOutput;
    (void)memset_s(&wqeDmaOutput, sizeof(struct halAsyncDmaOutputPara), 0U, sizeof(struct halAsyncDmaOutputPara));
    struct halAsyncDmaInputPara wqeDmaInput;
    (void)memset_s(&wqeDmaInput, sizeof(struct halAsyncDmaInputPara), 0U, sizeof(struct halAsyncDmaInputPara));
    wqeDmaInput.type = DRV_NORMAL_TYPE;
    wqeDmaInput.src = static_cast<uint8_t *>(input.src);
    wqeDmaInput.len = input.size;
    wqeDmaInput.tsId = input.tsId;
    wqeDmaInput.sqId = input.sqId;
    wqeDmaInput.dir = input.cpyType;
    if (isSqeUpdate) {
        wqeDmaInput.info.sqe_pos = input.info.sqe_pos;
        wqeDmaInput.async_dma_type = DRV_ASYNC_DMA_TYPE_SQE_UPDATE;
        wqeDmaInput.info.sq_id = input.info.sqId;
    } else {
        if (isUbMode) {
            wqeDmaInput.dst = static_cast<uint8_t *>(input.destPtr);
            wqeDmaInput.async_dma_type = DRV_ASYNC_DMA_TYPE_NORMAL;
        } else {
            RT_LOG(RT_LOG_ERROR, "pcie does not support");
            return RT_ERROR_INVALID_VALUE;
        }
    }

    const drvError_t drvRet = halAsyncDmaCreate(devId, &wqeDmaInput, &wqeDmaOutput);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halAsyncDmaCreate failed, device_id=%u, ts_id=%u, sq_id=%u, is_ub_mode=%d, is_sqe_update=%d,"
            " drvRetCode=%d.",
            devId, input.tsId, input.sqId, isUbMode, isSqeUpdate, static_cast<int32_t>(drvRet));
        return RT_ERROR_DRV_ERR;
    }

    if (isUbMode) {
        output->dieId = wqeDmaOutput.dieId;
        output->functionId = static_cast<uint16_t>(wqeDmaOutput.functionId);
        output->jettyId = static_cast<uint16_t>(wqeDmaOutput.jettyId);
        output->wqe = wqeDmaOutput.wqe;
        output->wqeLen = wqeDmaOutput.size;
        RT_LOG(RT_LOG_INFO, "halAsyncDmaCreate success, die_id=%u, functionId=%u, jettyId=%u, wqeLen=%d.",
            output->dieId, output->functionId, output->jettyId, output->wqeLen);
    } else {
            output->dmaAddr = wqeDmaOutput.dma_addr;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DestroyAsyncDmaWqe(uint32_t devId, struct AsyncDmaWqeDestroyInfo *destroyPara, bool isUbMode)
{
    struct halAsyncDmaDestoryPara para;
    (void)memset_s(&para, sizeof(struct halAsyncDmaDestoryPara), 0U, sizeof(struct halAsyncDmaDestoryPara));
    para.type = DRV_NORMAL_TYPE;
    para.tsId = destroyPara->tsId;
    para.sqId = destroyPara->sqId;
    if (isUbMode) {
        para.size = destroyPara->size;
        para.wqe = destroyPara->wqe;
    } else {
        para.dma_addr = destroyPara->dmaAddr;
    }

    const drvError_t drvRet = halAsyncDmaDestory(devId, &para);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halAsyncDmaDestory failed:drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Destroy wqe or dma success.");
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetStarsInfo(const uint32_t deviceId, const uint32_t tsId, uint64_t &addr)
{
    ts_ctrl_msg_body_t queryIn = {};
    ts_ctrl_msg_body_t queryAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    queryIn.type = OP_QUERY_STARS_REG_BASE_ADDR;
    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = static_cast<uint32_t>(sizeof(ts_ctrl_msg_body_t));
    para.msg = static_cast<void *>(&queryIn);
    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, head=%zu, ackCount=%u.",
        deviceId, tsId, sizeof(ts_ctrl_msg_head_t), ackCount);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void *>(&para), sizeof(struct tsdrv_ctrl_msg), static_cast<void *>(&queryAck), &ackCount);
    COND_RETURN_ERROR_MSG_INNER(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, drvRetCode=%d.",
        deviceId, tsId, static_cast<int32_t>(drvRet));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (ackCount != sizeof(ts_ctrl_msg_body_t)),
        RT_GET_DRV_ERRCODE(DRV_ERROR_PARA_ERROR),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, drvRetCode=%d.",
        deviceId, tsId, static_cast<int32_t>(drvRet));
    addr = queryAck.u.query_ack_info.reg_base_addr;

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetTsfwVersion(const uint32_t deviceId, const uint32_t tsId, uint32_t &version)
{
    ts_ctrl_msg_body_t queryIn = {};
    ts_ctrl_msg_body_t queryAck = {};
    queryIn.type = OP_QUERY_TSFW_VERSION;
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = static_cast<uint32_t>(ackCount);
    para.msg = static_cast<void *>(&queryIn);

    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halTsdrvCtl does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, head=%zu, ackCount=%zu.",
        deviceId, tsId, sizeof(ts_ctrl_msg_head_t), ackCount);
    const drvError_t drvRet = halTsdrvCtl(deviceId, TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void *>(&para), sizeof(struct tsdrv_ctrl_msg), static_cast<void *>(&queryAck), &ackCount);
    COND_RETURN_ERROR_MSG_INNER(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] call halTsdrvCtl failed, device_id=%u, ts_id=%u, drvRetCode=%d.",
        deviceId, tsId, static_cast<int32_t>(drvRet));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (ackCount != sizeof(ts_ctrl_msg_body_t)),
        RT_GET_DRV_ERRCODE(DRV_ERROR_PARA_ERROR),
        "[drv api] halTsdrvCtl device_id=%u, ts_id=%u, drvRetCode=%d.",
        deviceId, tsId, static_cast<int32_t>(drvRet));
    version = queryAck.u.query_tsfw_info.tsfw_version;
    RT_LOG(RT_LOG_INFO, "tsfw_version=%u.", version);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::UnmapSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    if(IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_MAP_SQ_ADDR_TO_USER_SPACE)) {
        struct res_addr_info resInfo;
        (void)memset_s(&resInfo, sizeof(resInfo), 0U, sizeof(resInfo));
        resInfo.id = tsId;
        resInfo.res_type = RES_ADDR_TYPE_STARS_RTSQ;
        resInfo.res_id = sqId;
        COND_RETURN_WARN(halResAddrUnmap == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
                         "[drv api] halResAddrUnmap does not exist");
        const drvError_t drvRet = halResAddrUnmap(static_cast<uint32_t>(deviceId), &resInfo);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet,
                "[drv api] halResAddrUnmap unmap SqSimple Virtual Addr failed device_id=%d, ts_id=%u, "
                "sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
                return RT_GET_DRV_ERRCODE(drvRet);
        }
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::WriteNotifyRecord(const uint32_t deviceId, const uint32_t tsId, const uint32_t notifyId)
{
    struct halResourceIdInputInfo in = {};
    in.type = DRV_NOTIFY_ID;
    in.tsId = tsId;
    in.resourceId = notifyId;
    in.res[1U] = 0U;

    struct halResourceConfigInfo configInfo = {};
    configInfo.prop = DRV_ID_RECORD;
    configInfo.value[0U] = 1U;

    const drvError_t drvRet = halResourceConfig(deviceId, &in, &configInfo);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halResourceConfig not support for notify record.");
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halResourceConfig fail, device_id=%u, ts_id=%u, notifyId=%u, drvRetCode=%d.",
        deviceId, tsId, notifyId, static_cast<int32_t>(drvRet));

    RT_LOG(RT_LOG_INFO, "success: device_id=%u, ts_id=%u, notifyId=%u.", deviceId, tsId, notifyId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryUbInfo(const uint32_t deviceId, rtUbDevQueryCmd cmd, void * const devInfo)
{
    uint32_t ubInfoType[QUERY_TYPE_BUFF] = {
        MEM_INFO_TYPE_UB_TOKEN_INFO
    };
    struct MemInfo info;
    rtMemUbTokenInfo *tokenInfo = RtPtrToPtr<rtMemUbTokenInfo *>(devInfo);
    info.ub_token_info.va = tokenInfo->va;
    info.ub_token_info.size = tokenInfo->size;
    const uint32_t type = ubInfoType[cmd];

    const drvError_t drvRet = halMemGetInfo(static_cast<DVdevice>(deviceId), type, &info);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halMemGetInfo does not support");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halMemGetInfo failed: device_id=%u, type=%u, va=%lu, size=%lu, drvRetCode=%d!",
            deviceId, type, tokenInfo->va, tokenInfo->size, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    tokenInfo->tokenId = info.ub_token_info.token_id;
    tokenInfo->tokenValue = info.ub_token_info.token_value;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDevResAddress(const uint32_t deviceId, const rtDevResInfo * const resInfo,
                                      uint64_t *resAddr, uint32_t *resLen)
{
    struct res_addr_info devResInfo;
    (void)memset_s(&devResInfo, sizeof(devResInfo), 0U, sizeof(devResInfo));
    devResInfo.id = resInfo->dieId;
    devResInfo.target_proc_type = processType_t(static_cast<int32_t>(resInfo->procType));
    devResInfo.res_type = res_addr_type(static_cast<int32_t>(resInfo->resType));
    devResInfo.res_id = resInfo->resId;
    COND_RETURN_WARN(&halResAddrMap == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halResAddrMap does not exist");
    const drvError_t drvRet = halResAddrMap(deviceId, &devResInfo, resAddr, resLen);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halResAddrMap does not support");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halResAddrMap resourse addr failed: device_id=%u, processType=%d, resType=%d, resId=%u, "
            "udieId=%u, drvRetCode=%d!", deviceId, static_cast<int32_t>(resInfo->procType),
            static_cast<int32_t>(resInfo->resType), resInfo->resId, resInfo->dieId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReleaseDevResAddress(const uint32_t deviceId, const rtDevResInfo * const resInfo)
{
    struct res_addr_info devResInfo;
    (void)memset_s(&devResInfo, sizeof(devResInfo), 0U, sizeof(devResInfo));
    devResInfo.id = resInfo->dieId;
    devResInfo.target_proc_type = processType_t(static_cast<int32_t>(resInfo->procType));
    devResInfo.res_type = res_addr_type(static_cast<int32_t>(resInfo->resType));
    devResInfo.res_id = resInfo->resId;
    COND_RETURN_WARN(&halResAddrUnmap == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halResAddrUnmap does not exist");
    const drvError_t drvRet = halResAddrUnmap(deviceId, &devResInfo);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halResAddrUnmap does not support");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halResAddrUnmap resourse addr failed: device_id=%u, processType=%d, resType=%d, resId=%u, "
            "udieId=%u, drvRetCode=%d!", deviceId, static_cast<int32_t>(resInfo->procType),
            static_cast<int32_t>(resInfo->resType), resInfo->resId, resInfo->dieId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqAddrInfo(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, 
    uint64_t &sqAddr)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_MEM_ATTR;
    COND_RETURN_WARN(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist.");
    drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halSqCqQuery device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
        static_cast<int32_t>(drvRet));
    const bool sqMemHostFlag = ((queryInfoIn.value[0] & static_cast<uint32_t>(DRV_SQ_MEM_ATTR_LOCAL_MASK)) == 1U) ? true : false;
    if (sqMemHostFlag == false) {
        RT_LOG(RT_LOG_INFO, "dev_id=%u, sq_id=%u, sq is device memory.", deviceId, sqId);
        return RT_ERROR_NONE;
    }
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_BASE;

    drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halSqCqQuery sq addr device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId,
        static_cast<int32_t>(drvRet));
    sqAddr = (static_cast<uint64_t>(queryInfoIn.value[1]) << 32U) | queryInfoIn.value[0];
    RT_LOG(RT_LOG_INFO, "dev_id=%u, sq_id=%u, sq_host_flag=%u, sqAddr=0x%llx.", deviceId, sqId, sqMemHostFlag, sqAddr);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqArgsCopyWithUb(uint32_t devId, struct halSqTaskArgsInfo *sqArgs)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    // This api does not support, should affect business
    COND_RETURN_ERROR(&halSqTaskArgsAsyncCopy == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halSqTaskArgsAsyncCopy does not exist");

    drvRet = halSqTaskArgsAsyncCopy(devId, sqArgs);
    COND_RETURN_ERROR(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halSqTaskArgsAsyncCopy does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halSqTaskArgsAsyncCopy failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::SetSqTail(const uint32_t deviceId, const uint32_t tsId,
                               const uint32_t sqId, const uint32_t tail)
{
    struct halSqCqConfigInfo configInfo = {};
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = sqId;
    configInfo.prop = DRV_SQCQ_PROP_SQ_TAIL;
    configInfo.value[0] = tail;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%u, tail=%u.", deviceId, tsId, sqId, tail);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halSqCqConfig DRV_NORMAL_TYPE DRV_SQCQ_PROP_SQ_STATUS value=%u, "
            "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
            tail, deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StopSqSend(const uint32_t deviceId, const uint32_t tsId)
{
    struct halSqCqConfigInfo configInfo = {};
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = MAX_UINT32_NUM;
    configInfo.cqId = MAX_UINT32_NUM;
    configInfo.prop = DRV_SQCQ_PROP_SQ_PAUSE;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u.", deviceId, tsId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "device_id=%u, ts_id=%u, drvRetCode=%d.",
            deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ResumeSqSend(const uint32_t deviceId, const uint32_t tsId)
{
    struct halSqCqConfigInfo configInfo = {};
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = MAX_UINT32_NUM;
    configInfo.cqId = MAX_UINT32_NUM;
    configInfo.prop = DRV_SQCQ_PROP_SQ_RESUME;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u.", deviceId, tsId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "device_id=%u, ts_id=%u, drvRetCode=%d.",
            deviceId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamTaskFill(uint32_t devId, uint32_t streamId, void *streamMem,
                                    void *taskInfo, uint32_t taskCnt)
{
    COND_RETURN_WARN(&halStreamTaskFill == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halStreamTaskFill does not exist.");

    const drvError_t drvRet = halStreamTaskFill(devId, streamId, streamMem, taskInfo, taskCnt);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "device_id=%u, stream_id=%u, taskCnt=%u, drvRetCode=%d.",
            devId, streamId, taskCnt, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "stream fill task success, device_id=%u, stream_id=%u, taskCnt=%u.", devId, streamId, taskCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ResetSqCq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
    const uint32_t streamFlag)
{
    struct halSqCqConfigInfo configInfo = {};
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.tsId = tsId;
    configInfo.sqId = sqId;
    configInfo.prop = DRV_SQCQ_PROP_SQCQ_RESET;
    configInfo.value[SQCQ_CONFIG_INFO_FLAG] = ((streamFlag & RT_STREAM_CP_PROCESS_USE) != 0U) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%u.", deviceId, tsId, sqId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "device_id=%u, ts_id=%u, sq_id=%u, drvRetCode=%d.",
            deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ResetLogicCq(const uint32_t deviceId, const uint32_t tsId, const uint32_t logicCqId,
    const uint32_t streamFlag)
{
    struct halSqCqConfigInfo configInfo = {};
    configInfo.type = DRV_LOGIC_TYPE;
    configInfo.tsId = tsId;
    configInfo.cqId = logicCqId;
    configInfo.prop = DRV_SQCQ_PROP_SQCQ_RESET;
    configInfo.value[SQCQ_CONFIG_INFO_FLAG] = ((streamFlag & RT_STREAM_CP_PROCESS_USE) != 0U) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;

    COND_RETURN_WARN(&halSqCqConfig == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halSqCqConfig does not exist.");
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, logic cq_id=%u.", deviceId, tsId, logicCqId);
    const drvError_t drvRet = halSqCqConfig(deviceId, &configInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "device_id=%u, ts_id=%u, logic cq_id=%u, drvRetCode=%d.",
            deviceId, tsId, logicCqId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqRegVirtualAddrBySqidForDavid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId,
    uint64_t * const addr) const
{
    struct res_addr_info resInfo;
    uint32_t resLen = 0;
    uint64_t resAddr = 0;
    (void)memset_s(&resInfo, sizeof(resInfo), 0U, sizeof(resInfo));
    resInfo.id = tsId;
    resInfo.res_type = RES_ADDR_TYPE_STARS_RTSQ;
    resInfo.res_id = sqId;
    RT_LOG(RT_LOG_INFO, "sq_id=%u, res_type=%u.", sqId, resInfo.res_type);

    COND_RETURN_WARN(&halResAddrMap == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halResAddrMap does not exist");
    const drvError_t drvRet = halResAddrMap(static_cast<uint32_t>(deviceId), &resInfo, &resAddr, &resLen);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halResAddrMap get SqSimple Virtual Addr failed device_id=%d, ts_id=%u, "
            "sq_id=%u, drvRetCode=%d.", deviceId, tsId, sqId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
    }
    *addr = resAddr;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetTsegInfoByVa(uint32_t devid, uint64_t va, uint64_t size, uint32_t flag,
    struct halTsegInfo *tsegInfo)
{
    COND_RETURN_WARN(&halGetTsegInfoByVa == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halGetTsegInfoByVa does not exist.");

    const drvError_t drvRet = halGetTsegInfoByVa(devid, va, size, flag, tsegInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halGetTsegInfoByVa faild, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "GetTsegInfoByVa success, device_id=%u, size=%llu.", devid, size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PutTsegInfo(uint32_t devid, struct halTsegInfo *tsegInfo)
{
    COND_RETURN_WARN(&halPutTsegInfo == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halPutTsegInfo does not exist.");

    const drvError_t drvRet = halPutTsegInfo(devid, tsegInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halPutTsegInfo faild, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "PutTsegInfo success, device_id=%u.", devid);
    return RT_ERROR_NONE;
}
}
}