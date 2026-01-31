/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_with_dqs.hpp"
#include "ioctl_utils.hpp"

namespace cce {
namespace runtime {
StreamWithDqs::~StreamWithDqs()
{
    (void)DestroyDqsCtrlSpace();
    (void)DestroyAccSubInfo();

    DELETE_O(dqsNotify_);
    DELETE_O(dqsCountNotify_);
}

rtError_t StreamWithDqs::SetupByFlagAndCheck(void)
{
    rtError_t error = DavidStream::SetupByFlagAndCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    if ((flags_ & RT_STREAM_DQS_CTRL) != 0U) {
        error = CreateDqsCtrlSpace(); // use stream id to alloc
        ERROR_RETURN(error, "Failed to create dqs ctrl space, retCode=%#x.", static_cast<uint32_t>(error));
    }

    if ((flags_ & RT_STREAM_DQS_INTER_CHIP) != 0U) {
        COND_RETURN_ERROR(Device_()->DevGetTsId() == RT_TSC_ID, RT_ERROR_INVALID_VALUE,
            "Cannot create dqs inter chip stream with ts_id(%u), should use ts_id(%u)", RT_TSC_ID, RT_TSV_ID);
        error = InitDqsInterChipSpace();
        ERROR_RETURN(error, "Failed to init dqs inter chip space, retCode=%#x.", static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;
}


rtError_t StreamWithDqs::Setup()
{
    rtError_t error = SetupByFlagAndCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    SetMaxTaskId(true);
    ClearFlowCtrlFlag();

    error = EschedManage(true);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_INFO, "stream setup end, stream_id=%d, sq_id=%u, cq_id=%u, device_id=%u, isHasArgPool_=%d.",
           streamId_, sqId_, cqId_, device_->Id_(), isHasArgPool_);

    return RT_ERROR_NONE;
}

rtError_t StreamWithDqs::TearDown(const bool terminal, bool flag)
{
    /* dqs ctrl stream and dqs inter chip stream are special. cannot be destroyed in normal way. */
    if (((flags_ & RT_STREAM_DQS_CTRL) != 0U) || ((flags_ & RT_STREAM_DQS_INTER_CHIP) != 0U)) {
        flag = true; /* force destroy */
    }
    return DavidStream::TearDown(terminal, flag);
}

rtError_t StreamWithDqs::CreateDqsCtrlSpace()
{
    stars_ioctl_cmd_args_t args = {};
    stars_dqs_ctrl_space_param_t param = {};
    param.stream_id = streamId_;
    param.ts_id = Device_()->DevGetTsId();
    param.op_type = 0U;  // create
    stars_dqs_ctrl_space_result_t res = {};
    args.input_ptr = &param;
    args.input_len = sizeof(stars_dqs_ctrl_space_param_t);
    args.output_ptr = &res;
    args.output_len = sizeof(stars_dqs_ctrl_space_result_t);

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_DQS_CONTROL_SPACE, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ioctl failed, retCode=%#x", static_cast<uint32_t>(error));

    COND_RETURN_ERROR((res.cs_va == nullptr) || (res.status != 0U), RT_ERROR_DRV_IOCTRL, "ioctl failed, retCode=%#x",
        static_cast<uint32_t>(RT_ERROR_DRV_IOCTRL));

    RT_LOG(RT_LOG_INFO, "ioctl success, ctrl space va=%p, status=%u, stream_id=%d", res.cs_va, res.status, streamId_);

    SetDqsCtrlSpace(RtPtrToPtr<stars_dqs_ctrl_space_t *>(res.cs_va));
    return RT_ERROR_NONE;
}

rtError_t StreamWithDqs::DestroyAccSubInfo()
{
    // If the subscription is not performed,
    // the system does not need to be moved down to the kernel mode for judgment and no error is reported.
    COND_RETURN_WITH_NOLOG(accSubInfo_.count == 0U, RT_ERROR_NONE);

    stars_ioctl_cmd_args_t args = {};
    stars_queue_subscribe_acc_param_t accSubInfo = {};
    accSubInfo = accSubInfo_;
    accSubInfo.op_type = 1U;  // destroy
    accSubInfo.stream_id = static_cast<uint8_t>(streamId_);
    args.input_ptr = &accSubInfo;
    args.input_len = sizeof(stars_queue_subscribe_acc_param_t);
    args.output_len = 0U;

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_ACC_SUBSCRIBE_QUEUE, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "acc subscribe queue ioctl failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t StreamWithDqs::DestroyDqsCtrlSpace()
{
    COND_RETURN_WITH_NOLOG(dqsCtrlSpace_ == nullptr, RT_ERROR_NONE);

    stars_ioctl_cmd_args_t args = {};
    stars_dqs_ctrl_space_param_t param = {};
    param.stream_id = streamId_;
    param.ts_id = Device_()->DevGetTsId();
    param.op_type = 1U;  // destroy
    stars_dqs_ctrl_space_result_t res = {};
    args.input_ptr = &param;
    args.input_len = sizeof(stars_dqs_ctrl_space_param_t);
    args.output_ptr = &res;
    args.output_len = sizeof(stars_dqs_ctrl_space_result_t);

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_DQS_CONTROL_SPACE, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ioctl failed, retCode=%#x", static_cast<uint32_t>(error));
    dqsCtrlSpace_ = nullptr;

    return RT_ERROR_NONE;
}

static rtError_t UpdateCtrlSpaceFrameAlignInfo(const uint8_t inputQueNum, const int32_t streamId, const uint32_t tsId)
{
    // 1代表单路, 单路不适用帧对齐信息，不用刷新，直接返回
    COND_RETURN_WITH_NOLOG(inputQueNum <= 1U, RT_ERROR_NONE);

    stars_ioctl_cmd_args_t args = {};
    stars_dqs_update_cs_frame_align_info_t param = {};
    param.stream_id = static_cast<uint8_t>(streamId);
    param.ts_id = static_cast<uint8_t>(tsId);
    args.input_ptr = &param;
    args.input_len = sizeof(stars_dqs_update_cs_frame_align_info_t);
    args.output_len = 0U;

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_UPDATE_CS_FRAME_ALIGN_INFO, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ioctl failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;  
}

rtError_t StreamWithDqs::SetCtrlSpaceInputQueInfo(const rtDqsSchedCfg_t * const dqsSchedCfg)
{
    dqsCtrlSpace_->input_queue_num = dqsSchedCfg->inputQueueNum;

    const errno_t err = memcpy_s(dqsCtrlSpace_->input_queue_ids, sizeof(dqsCtrlSpace_->input_queue_ids),
        dqsSchedCfg->inputQueueIds, sizeof(dqsSchedCfg->inputQueueIds));
    COND_RETURN_ERROR(err != EOK, RT_ERROR_SEC_HANDLE, "memcpy_s failed, retCode=%d", err);

    // set input queue gqm base addr to control space
    DqsQueueInfo queInfo = {};
    const auto dev = Device_();
    rtError_t ret = RT_ERROR_NONE;
    for (uint32_t i = 0U; i < dqsSchedCfg->inputQueueNum; i++) {
        const uint32_t qid = dqsCtrlSpace_->input_queue_ids[i];
        ret = dev->Driver_()->GetDqsQueInfo(dev->Id_(), qid, &queInfo);
        ERROR_RETURN(ret, "get dqs que info failed, ret=%#x.", static_cast<uint32_t>(ret));
        COND_RETURN_ERROR(queInfo.queType != GQM_ENTITY_TYPE, RT_ERROR_INVALID_VALUE,
            "qid[%u] is invalid, queType=%d", qid, static_cast<int32_t>(queInfo.queType));
        dqsCtrlSpace_->input_queue_gqm_base_addrs[i] = queInfo.dequeOpAddr;
        RT_LOG(RT_LOG_INFO, "input queue id=%hu, gqm base=%#llx", qid, dqsCtrlSpace_->input_queue_gqm_base_addrs[i]);
    }

    // 内核态会从ctrl space中读取input queue id，所以此处的接口应该放在input_queue_ids更新之后
    ret = UpdateCtrlSpaceFrameAlignInfo(dqsCtrlSpace_->input_queue_num, streamId_, Device_()->DevGetTsId());
    ERROR_RETURN(ret, "update ctrl space frame align info failed, ret=%#x.", static_cast<uint32_t>(ret));

    return RT_ERROR_NONE;
}

static rtError_t GetOutputQueMbufPoolInfo(const uint16_t *queueIds, uint8_t queueNum, stars_dqs_queue_mbuf_pool_result_t *res)
{
    stars_ioctl_cmd_args_t args = {};
    stars_get_queue_mbuf_pool_info_param_t param = {};
    param.count = queueNum;
    errno_t err = memcpy_s(param.queue_list, sizeof(param.queue_list), queueIds, sizeof(param.queue_list));
    COND_RETURN_ERROR(err != EOK, RT_ERROR_SEC_HANDLE, "memcpy_s failed, retCode=%d", err);

    args.input_ptr = &param;
    args.input_len = sizeof(stars_get_queue_mbuf_pool_info_param_t);
    args.output_ptr = res;
    args.output_len = sizeof(stars_dqs_queue_mbuf_pool_result_t);

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_GET_QUEUE_MBUF_POOL, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ioctl failed, retCode=%#x", static_cast<uint32_t>(error));

    COND_RETURN_ERROR((res->count == 0U) || (res->count > STARS_DQS_MAX_OUTPUT_QUEUE_NUM),
        RT_ERROR_DRV_IOCTRL, "ioctl failed, count=%u", res->count);

    return RT_ERROR_NONE;    
}

static stars_queue_bind_mbuf_pool_item_t* GetMbufPoolInfoByPid(const uint16_t qid,
    stars_dqs_queue_mbuf_pool_result_t &result)
{
    for (uint8_t idx = 0U; idx < result.count; idx++) {
        if (result.queue_mbuf_pool_list[idx].qid == qid) {
            return &result.queue_mbuf_pool_list[idx];
        }
    }

    return nullptr;
}

static void DumpCtrlSpaceDfx(const uint32_t qid, const int32_t streamId, uint32_t idx,
    const stars_dqs_ctrl_space_t * const ctrlSpace)
{
    RT_LOG(RT_LOG_INFO, 
        "output queue info: qid=%u, queue manager enqueue addr=%#llx, queue ow addr=%#llx;"
        "output mbuf pool info: stream_id=%d, pool_id=%u, head_pool_base_addr=%#llx, head_pool_block_size=%u,"
        " data_pool_base_addr=%#llx, data_pool_block_size=%u, mbuf_alloc_addr=%#llx, mbuf_free_addr=%#llx",
        qid, ctrlSpace->output_qmngr_enqueue_addrs[idx], ctrlSpace->output_qmngr_ow_addrs[idx],
        streamId, ctrlSpace->output_mbuf_pool_ids[idx], ctrlSpace->output_head_pool_base_addrs[idx],
        ctrlSpace->output_head_pool_block_size_list[idx], ctrlSpace->output_data_pool_base_addrs[idx],
        ctrlSpace->output_data_pool_block_size_list[idx], ctrlSpace->output_mbuf_alloc_addrs[idx],
        ctrlSpace->output_mbuf_free_addrs[idx]);

    return;
}

rtError_t StreamWithDqs::SetCtrlSpaceOutputQueInfo(const rtDqsSchedCfg_t * const dqsSchedCfg)
{
    // dss 不支持output 直接返回成功
    COND_RETURN_WITH_NOLOG((dqsSchedCfg->type == static_cast<uint8_t>(RT_DQS_SCHED_TYPE_DSS)), RT_ERROR_NONE);
    dqsCtrlSpace_->output_queue_num = dqsSchedCfg->outputQueueNum;
    const errno_t err = memcpy_s(dqsCtrlSpace_->output_queue_ids, sizeof(dqsCtrlSpace_->output_queue_ids),
       dqsSchedCfg->outputQueueIds, sizeof(dqsSchedCfg->outputQueueIds));
    COND_RETURN_ERROR(err != EOK, RT_ERROR_SEC_HANDLE, "memcpy_s failed, retCode=%d", err);

    stars_dqs_queue_mbuf_pool_result_t result = {};
    rtError_t ret = GetOutputQueMbufPoolInfo(dqsSchedCfg->outputQueueIds, dqsCtrlSpace_->output_queue_num, &result);
    ERROR_RETURN(ret, "get output que mbuf failed, ret=%#x.", static_cast<uint32_t>(ret));

    // set output mbuf pool detail info to control space
    DqsQueueInfo queInfo = {};
    const auto dev = Device_();
    for (uint32_t i = 0U; i < dqsCtrlSpace_->output_queue_num; i++) {
        const uint32_t qid = dqsCtrlSpace_->output_queue_ids[i];
        ret = dev->Driver_()->GetDqsQueInfo(dev->Id_(), qid, &queInfo);
        ERROR_RETURN(ret, "get dqs que info failed, ret=%#x.", static_cast<uint32_t>(ret));
        COND_RETURN_ERROR(queInfo.queType != QMNGR_ENTITY_TYPE, RT_ERROR_INVALID_VALUE,
            "qid[%u] is invalid, queType=%d", qid, static_cast<int32_t>(queInfo.queType));
        dqsCtrlSpace_->output_qmngr_enqueue_addrs[i] = queInfo.enqueOpAddr;
        dqsCtrlSpace_->output_qmngr_ow_addrs[i] = queInfo.prodqOwAddr;

        const stars_queue_bind_mbuf_pool_item_t * const item = GetMbufPoolInfoByPid(qid, result);
        COND_RETURN_ERROR(item == nullptr, RT_ERROR_INVALID_VALUE,
            "mbuf pool info of qid[%u] is not exist. please check config flow.", qid);

        dqsCtrlSpace_->output_mbuf_pool_ids[i] = item->mbuf_pool_id;
        dqsCtrlSpace_->output_head_pool_base_addrs[i] = item->mbuf_head_pool_base_addr + item->mbuf_head_pool_offset;
        dqsCtrlSpace_->output_head_pool_block_size_list[i] = item->mbuf_head_pool_blk_size;
        dqsCtrlSpace_->output_mbuf_alloc_addrs[i] = item->mbuf_alloc_op_addr;
        dqsCtrlSpace_->output_data_pool_base_addrs[i] = item->mbuf_data_pool_base_addr + item->mbuf_data_pool_offset;
        dqsCtrlSpace_->output_data_pool_block_size_list[i] = item->mbuf_data_pool_blk_size;
        dqsCtrlSpace_->output_mbuf_free_addrs[i] = item->mbuf_free_op_addr;
        DumpCtrlSpaceDfx(qid, streamId_, i, dqsCtrlSpace_);
    }

    return RT_ERROR_NONE;
}

rtError_t StreamWithDqs::SetStreamCtrlSpaceInfo(const rtDqsSchedCfg_t * const dqsSchedCfg)
{
    NULL_PTR_RETURN(dqsCtrlSpace_, RT_ERROR_INVALID_VALUE);

    rtError_t error = SetCtrlSpaceInputQueInfo(dqsSchedCfg);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = SetCtrlSpaceOutputQueInfo(dqsSchedCfg);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    return RT_ERROR_NONE;
}

rtError_t StreamWithDqs::SetDqsSchedCfg(const rtDqsSchedCfg_t * const cfg)
{
    const rtError_t ret = SetStreamCtrlSpaceInfo(cfg);
    ERROR_RETURN(ret, "set stream ctrl space info failed, ret=%#x.", static_cast<uint32_t>(ret));

    RT_LOG(RT_LOG_INFO, "set dqs cfg and ctrl space info success");

    return RT_ERROR_NONE;
}

rtError_t StreamWithDqs::InitDqsInterChipSpace(void)
{
    stars_ioctl_cmd_args_t args = {};
    stars_dqs_inter_chip_space_result_t res = {};
    args.output_ptr = &res;
    args.output_len = sizeof(stars_dqs_inter_chip_space_result_t);

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_DQS_INTER_CHIP_SPACE, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ioctl failed, retCode=%#x", static_cast<uint32_t>(error));

    if (res.inter_chip_space_va == nullptr) {
        RT_LOG(RT_LOG_ERROR, "ctrl space va is invalid, stream_id=%d", streamId_);
        return RT_ERROR_DRV_IOCTRL;
    }

    SetDqsInterChipSpace(RtPtrToPtr<stars_dqs_inter_chip_space_t *>(res.inter_chip_space_va));
    RT_LOG(RT_LOG_INFO, "ioctl success, dqs inter chip space va=%p, stream_id=%d", res.inter_chip_space_va, streamId_);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce