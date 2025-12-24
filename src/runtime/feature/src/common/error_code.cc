/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "error_code.h"
#include "errcode_manage.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {
const TsErrCode g_tsErrCodeMap[] = {
    {TS_SUCCESS, RT_ERROR_NONE, ERR_MODULE_RTS, "success"},

    {TS_ERROR_UNKNOWN, RT_ERROR_TSFW_UNKNOWN, ERR_MODULE_RTS, "unknown error"},

    {TS_ERROR_NULL_PTR, RT_ERROR_TSFW_NULL_PTR, ERR_MODULE_RTS, "NULL ptr"},

    {TS_ERROR_ILLEGAL_AI_CORE_ID, RT_ERROR_TSFW_ILLEGAL_AI_CORE_ID, ERR_MODULE_RTS, "illegal aicore id"},

    {TS_ERROR_ILLEGAL_PARAM, RT_ERROR_TSFW_ILLEGAL_PARAM, ERR_MODULE_RTS, "illegal param"},

    {TS_ERROR_TASK_CMD_QUEUE_FULL, RT_ERROR_TSFW_TASK_CMD_QUEUE_FULL, ERR_MODULE_RTS, "task cmd queue is full"},

    {TS_ERROR_TASK_CMD_QUEUE_EMPTY, RT_ERROR_TSFW_TASK_CMD_QUEUE_EMPTY, ERR_MODULE_RTS, "task cmd queue is empty"},

    {TS_ERROR_TASK_REPORT_QUEUE_FULL, RT_ERROR_TSFW_TASK_REPORT_QUEUE_FULL, ERR_MODULE_RTS,
     "task report queue is full"},

    {TS_ERROR_TASK_REPORT_QUEUE_EMPTY, RT_ERROR_TSFW_TASK_REPORT_QUEUE_EMPTY, ERR_MODULE_RTS,
     "task report queue is empty"},

    {TS_ERROR_TASK_NODE_BUFF_ALL_OCCUPYED, RT_ERROR_TSFW_TASK_NODE_BUFF_ALL_OCCUPIED, ERR_MODULE_RTS,
     "all the node of public task buff are occupied"},

    {TS_ERROR_TASK_NODE_BUFF_ALL_FREED, RT_ERROR_TSFW_TASK_NODE_BUFF_ALL_FREED, ERR_MODULE_RTS,
     "all the node of public task buff are free"},

    {TS_ERROR_L2_MEM_INSUFFICIENT_SPACE, RT_ERROR_TSFW_L2_MEM_INSUFFICIENT_SPACE, ERR_MODULE_RTS,
     "there is not enough space on l2 memory"},

    {TS_ERROR_L2_MALLOC_FAILED, RT_ERROR_TSFW_L2_MALLOC_FAILED, ERR_MODULE_RTS, "malloc l2 failed"},

    {TS_ERROR_DMA_CHANNEL_ALL_OCCUPYED, RT_ERROR_TSFW_DMA_CHANNEL_ALL_OCCUPIED, ERR_MODULE_RTS,
     "all the DMA channel are occupied"},

    {TS_ERROR_MEMCPY_OP_FAILED, RT_ERROR_TSFW_MEMCPY_OP_FAILED, ERR_MODULE_RTS, "memcpy failed"},

    {TS_ERROR_BS_SLOT_ALL_OCCUPYED, RT_ERROR_TSFW_BS_SLOT_ALL_OCCUPIED, ERR_MODULE_RTS,
     "there is not free bs slot for new task"},

    {TS_ERROR_TBS_SLOT_REPEAT_FREE, RT_ERROR_TSFW_TBS_SLOT_REPEAT_FREE, ERR_MODULE_RTS,
     "one free bs slot cannot be freed again"},

    {TS_ERROR_PRIORITY_TASK_LIST_FULL, RT_ERROR_TSFW_PRIORITY_TASK_LIST_FULL, ERR_MODULE_RTS,
     "the priority list is full"},

    {TS_ERROR_PRIORITY_TASK_LIST_EMPTY, RT_ERROR_TSFW_PRIORITY_TASK_LIST_EMPTY, ERR_MODULE_RTS,
     "the priority list is empty"},

    {TS_ERROR_NO_STREAM_LIST_NEED_TO_BE_PROCESSED, RT_ERROR_TSFW_NO_STREAM_LIST_NEED_TO_BE_PROCESSED, ERR_MODULE_RTS,
     "there is no stream list need service"},

    {TS_ERROR_REPEAT_MARK_STREAM_NEED_SERVICE, RT_ERROR_TSFW_REPEAT_MARK_STREAM_NEED_SERVICE, ERR_MODULE_RTS,
     "repeat mark the stream list need service"},

    {TS_ERROR_SYS_DMA_CHANNEL_ALL_OCCUPAPYED, RT_ERROR_TSFW_SYS_DMA_CHANNEL_ALL_OCCUPIED, ERR_MODULE_RTS,
     "system dma channel all occupied"},

    {TS_ERROR_NO_HBML2TASKNODE_FOUND, RT_ERROR_TSFW_NO_HBML2TASKNODE_FOUND, ERR_MODULE_RTS,
     "no hbm l2 task node found"},

    {TS_ERROR_SQNODE_NODE_SLOT_ALL_OCCUPAPYED, RT_ERROR_TSFW_SQNODE_NODE_SLOT_ALL_OCCUPIED, ERR_MODULE_RTS,
     "all the node of the current sq are occupied"},

    {TS_ERROR_CQNODE_NODE_SLOT_ALL_OCCUPAPYED, RT_ERROR_TSFW_CQNODE_NODE_SLOT_ALL_OCCUPIED, ERR_MODULE_RTS,
     "all the node of the current sq are occupied"},

    {TS_ERROR_SQNODE_NOT_ENOUGH, RT_ERROR_TSFW_SQNODE_NOT_ENOUGH, ERR_MODULE_RTS,
     "the sq node is not enough for data transfer"},

    {TS_ERROR_SQNODE_SLOT_REPEAT_FREE, RT_ERROR_TSFW_SQNODE_SLOT_REPEAT_FREE, ERR_MODULE_RTS,
     "sq node slot repeat free"},

    {TS_ERROR_CQNODE_SLOT_REPEAT_FREE, RT_ERROR_TSFW_CQNODE_SLOT_REPEAT_FREE, ERR_MODULE_RTS,
     "cq node slot repeat free"},

    {TS_ERROR_CQ_REPORT_FAILED, RT_ERROR_TSFW_CQ_REPORT_FAILED, ERR_MODULE_RTS, "cq report failed"},

    {TS_SYS_DMA_RESET_SUCCESS, RT_ERROR_TSFW_SYS_DMA_RESET_SUCCESS, ERR_MODULE_RTS, "sys dma reset success"},

    {TS_SYS_DMA_RESET_FAILED, RT_ERROR_TSFW_SYS_DMA_RESET_FAILED, ERR_MODULE_RTS, "sys dma reset failed"},

    {TS_SYS_DMA_TRNSFER_FAILED, RT_ERROR_TSFW_SYS_DMA_TRNSFER_FAILED, ERR_MODULE_RTS, "sys dma transfer failed"},

    {TS_SYS_DMA_MEMADDRALIGN_FAILED, RT_ERROR_TSFW_SYS_DMA_MEMADDRALIGN_FAILED, ERR_MODULE_RTS,
     "sys dma mem address align failed"},

    {TS_SYS_DMA_ERROR_QUEUE_FULL, RT_ERROR_TSFW_SYS_DMA_ERROR_QUEUE_FULL, ERR_MODULE_RTS, "sys dma queue full"},

    {TS_SYS_DMA_ERROR_QUEUE_EMPTY, RT_ERROR_TSFW_SYS_DMA_ERROR_QUEUE_EMPTY, ERR_MODULE_RTS, "sys dma queue empty"},

    {TS_ERROR_TIMER_EVENT_FULL, RT_ERROR_TSFW_TIMER_EVENT_FULL, ERR_MODULE_RTS, "timer event full"},

    {TS_TASK_L2_DESC_ENTRY_NOT_ENOUGH, RT_ERROR_TSFW_TASK_L2_DESC_ENTRY_NOT_ENOUGH, ERR_MODULE_RTS,
     "l2 description enter not enough"},

    {TS_ERROR_AICORE_TIMEOUT, RT_ERROR_TSFW_AICORE_TIMEOUT, ERR_MODULE_TBE, "aicore timeout"},

    {TS_ERROR_AICORE_EXCEPTION, RT_ERROR_TSFW_AICORE_EXCEPTION, ERR_MODULE_TBE, "aicore exception"},

    {TS_ERROR_AICORE_TRAP_EXCEPTION, RT_ERROR_TSFW_AICORE_TRAP_EXCEPTION, ERR_MODULE_TBE, "aicore trap exception"},

    {TS_ERROR_VECTOR_CORE_TIMEOUT, RT_ERROR_TSFW_VECTOR_CORE_TIMEOUT, ERR_MODULE_TBE, "vector core timeout"},

    {TS_ERROR_VECTOR_CORE_EXCEPTION, RT_ERROR_TSFW_VECTOR_CORE_EXCEPTION, ERR_MODULE_TBE, "vector core exception"},

    {TS_ERROR_VECTOR_CORE_TRAP_EXCEPTION, RT_ERROR_TSFW_VECTOR_CORE_TRAP_EXCEPTION, ERR_MODULE_TBE,
     "vector core trap exception"},

    {TS_ERROR_AICPU_TIMEOUT, RT_ERROR_TSFW_AICPU_TIMEOUT, ERR_MODULE_AICPU, "aicpu timeout"},

    {TS_ERROR_SDMA_L2_TO_DDR_MALLOC_FAIL, RT_ERROR_TSFW_SDMA_L2_TO_DDR_MALLOC_FAIL, ERR_MODULE_RTS,
     "sdma move l2 to ddr malloc failed"},

    {TS_ERROR_AICPU_EXCEPTION, RT_ERROR_TSFW_AICPU_EXCEPTION, ERR_MODULE_AICPU, "aicpu exception"},

    {TS_ERROR_AICPU_DATADUMP_RSP_ERR, RT_ERROR_TSFW_AICPU_DATADUMP_RSP_ERR, ERR_MODULE_AICPU,
     "aicpu datadump response error"},

    {TS_ERROR_AICPU_INFO_LOAD_RSP_ERR, RT_ERROR_TSFW_AICPU_INFO_LOAD_RSP_ERR, ERR_MODULE_AICPU,
     "aicpu info load response error"},

    {TS_ERROR_AICORE_MTE_ERROR, RT_ERROR_DEVICE_MEM_ERROR, ERR_MODULE_RTS, "aicore mem error"},

    {TS_ERROR_AICORE_ERROR_SW, RT_ERROR_DEVICE_AICORE_ERROR_SW, ERR_MODULE_RTS, "aicore software error"},

    {TS_ERROR_AICORE_ERROR_HW_L, RT_ERROR_DEVICE_AICORE_ERROR_HW_L, ERR_MODULE_RTS, "aicore hardware local error"},

    {TS_ERROR_SDMA_DDRC_ERROR, RT_ERROR_SDMA_POISON_ERROR, ERR_MODULE_RTS, "sdma poison error"},

    {TS_ERROR_SDMA_LINK_ERROR, RT_ERROR_SUSPECT_REMOTE_ERROR, ERR_MODULE_RTS, "suspect remote error"},

    {TS_ERROR_SDMA_POISON_ERROR, RT_ERROR_SDMA_POISON_ERROR, ERR_MODULE_RTS, "sdma poison error"},

    {TS_ERROR_SUSPECT_MTE_ERROR, RT_ERROR_SUSPECT_DEVICE_MEM_ERROR, ERR_MODULE_RTS, "suspect mem error"},

    {TS_ERROR_AICPU_MODEL_RSP_ERR, RT_ERROR_TSFW_AICPU_MODEL_RSP_ERR, ERR_MODULE_AICPU,
     "aicpu model operate response error"},

    {TS_ERROR_REPEAT_ACTIVE_MODEL_STREAM, RT_ERROR_TSFW_REPEAT_ACTIVE_MODEL_STREAM, ERR_MODULE_GE,
     "active stream already in running"},

    {TS_ERROR_REPEAT_NOTIFY_WAIT, RT_ERROR_TSFW_REPEAT_NOTIFY_WAIT, ERR_MODULE_GE, "repeat stream notify wait"},

    {TS_ERROR_AICORE_OVERFLOW, RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL, ERR_MODULE_TBE, "aicore overflow"},

    {TS_ERROR_DEBUG_INVALID_SQCQ, RT_ERROR_TSFW_DEBUG_INVALID_SQCQ, ERR_MODULE_RTS, "debug invalid sqcq"},

    {TS_ERROR_DEBUG_WRONG_COMMAND_TYPE, RT_ERROR_TSFW_DEBUG_WRONG_COMMAND_TYPE, ERR_MODULE_RTS,
     "debug wrong command type"},

    {TS_ERROR_DEBUG_CMD_PROCESS, RT_ERROR_TSFW_DEBUG_CMD_PROCESS, ERR_MODULE_RTS, "dbg cmd process"},

    {TS_ERROR_DEBUG_INVALID_DEVICE_STATUS, RT_ERROR_TSFW_DEBUG_INVALID_DEVICE_STATUS, ERR_MODULE_RTS,
     "debug invalid device status"},

    {TS_ERROR_DEBUG_NOT_IN_DEBUG_STATUS, RT_ERROR_TSFW_DEBUG_NOT_IN_DEBUG_STATUS, ERR_MODULE_RTS,
     "debug not in debug status"},

    {TS_ERROR_DEBUG_INVALID_TASK_STATUS, RT_ERROR_TSFW_DEBUG_INVALID_TASK_STATUS, ERR_MODULE_RTS,
     "debug invalid task status"},

    {TS_ERROR_DEBUG_TASK_EMPTY, RT_ERROR_TSFW_DEBUG_TASK_EMPTY, ERR_MODULE_RTS, "debug task empty"},

    {TS_ERROR_DEBUG_TASK_FULL, RT_ERROR_TSFW_DEBUG_TASK_FULL, ERR_MODULE_RTS, "debug task full"},

    {TS_ERROR_DEBUG_TASK_NOT_EXIST, RT_ERROR_TSFW_DEBUG_TASK_NOT_EXIST, ERR_MODULE_RTS, "debug task not exist"},

    {TS_ERROR_DEBUG_AI_CORE_FULL, RT_ERROR_TSFW_DEBUG_AI_CORE_FULL, ERR_MODULE_RTS, "debug aicore full"},

    {TS_ERROR_DEBUG_AI_CORE_NOT_EXIST, RT_ERROR_TSFW_DEBUG_AI_CORE_NOT_EXIST, ERR_MODULE_RTS,
     "debug aicore not exist"},

    {TS_ERROR_DEBUG_AI_CORE_EXCEPTION, RT_ERROR_TSFW_DEBUG_AI_CORE_EXCEPTION, ERR_MODULE_RTS,
     "debug aicore exception"},

    {TS_ERROR_DEBUG_AI_CORE_TIMEOUT, RT_ERROR_TSFW_DEBUG_AI_CORE_TIMEOUT, ERR_MODULE_RTS, "debug aicore timeout"},

    {TS_ERROR_DEBUG_BREAKPOINT_FULL, RT_ERROR_TSFW_DEBUG_BREAKPOINT_FULL, ERR_MODULE_RTS, "debug breakpoint full"},

    {TS_ERROR_DEBUG_READ_ERROR, RT_ERROR_TSFW_DEBUG_READ_ERROR, ERR_MODULE_RTS, "debug read error"},

    {TS_ERROR_DEBUG_WRITE_FAIL, RT_ERROR_TSFW_DEBUG_WRITE_FAIL, ERR_MODULE_RTS, "debug write fail"},

    {TS_QUEUE_FULL, RT_ERROR_TSFW_QUEUE_FULL, ERR_MODULE_RTS, "ts queue full"},

    {TS_QUEUE_EMPTY, RT_ERROR_TSFW_QUEUE_EMPTY, ERR_MODULE_RTS, "ts queue empty"},

    {TS_QUEUE_ALLOC_MEM_FAIL, RT_ERROR_TSFW_QUEUE_ALLOC_MEM_FAIL, ERR_MODULE_RTS, "ts queue alloc mem fail"},

    {TS_QUEUE_DATA_SIZE_UNMATCH, RT_ERROR_TSFW_QUEUE_DATA_SIZE_UNMATCH, ERR_MODULE_RTS, "ts queue data size unmatch"},

    {TS_PCIE_DMA_INVLD_CPY_TYPE, RT_ERROR_TSFW_PCIE_DMA_INVLD_CPY_TYPE, ERR_MODULE_GE, "pcie dma invalid copy type"},

    {TS_INVLD_CPY_DIR, RT_ERROR_TSFW_INVLD_CPY_DIR, ERR_MODULE_GE, "invalid copy dir"},

    {TS_PCIE_DMA_INVLD_CQ_DES, RT_ERROR_TSFW_PCIE_DMA_INVLD_CQ_DES, ERR_MODULE_RTS, "pcie dma invalid cq des"},

    {TS_PCIE_DMA_CPY_ERR, RT_ERROR_TSFW_PCIE_DMA_CPY_ERR, ERR_MODULE_RTS, "pcie dma copy error"},

    {TS_PCIE_DMA_LNK_CHN_BUSY, RT_ERROR_TSFW_PCIE_DMA_LNK_CHN_BUSY, ERR_MODULE_RTS, "pcie dima link channal busy"},

    {TS_ERROR_PROFILE_BUFF_FULL, RT_ERROR_TSFW_PROFILE_BUFF_FULL, ERR_MODULE_RTS, "profile buff full"},

    {TS_ERROR_PROFILE_MODE_CONFLICT, RT_ERROR_TSFW_PROFILE_MODE_CONFLICT, ERR_MODULE_RTS, "profile mode conflict"},

    {TS_ERROR_PROFILE_OTHER_PID_ON, RT_ERROR_TSFW_PROFILE_OTHER_PID_ON, ERR_MODULE_RTS, "profile other pid on"},

    {TS_ERROR_SCHD_AIC_TASK_PRELOAD_FAILED, RT_ERROR_TSFW_SCHD_AIC_TASK_PRELOAD_FAILED, ERR_MODULE_RTS,
     "sched aic task preload failed"},

    {TS_ERROR_TSCPU_CLOSE_FAILED, RT_ERROR_TSFW_TSCPU_CLOSE_FAILED, ERR_MODULE_RTS, "tscpu close failed"},

    {TS_ERROR_EXPECT_FAIL, RT_ERROR_TSFW_EXPECT_FAIL, ERR_MODULE_RTS, "expect failed"},

    {TS_ERROR_REPEAT_MODEL_STREAM, RT_ERROR_TSFW_REPEAT_MODEL_STREAM, ERR_MODULE_RTS, "repeat model stream"},

    {TS_ERROR_STREAM_MODEL_UNBIND, RT_ERROR_TSFW_STREAM_MODEL_UNBIND, ERR_MODULE_RTS,
     "the model stream unbind failed"},

    {TS_MODEL_STREAM_EXE_FAILED, RT_ERROR_TSFW_MODEL_EXE_FAILED, ERR_MODULE_RTS, "the model stream execute failed"},

    {TS_ERROR_IPC_SEND_FAILED, RT_ERROR_TSFW_IPC_SEND_FAILED, ERR_MODULE_RTS, "ipc send failed"},

    {TS_ERROR_IPC_PROC_REG_FAILED, RT_ERROR_TSFW_IPC_PROC_REG_FAILED, ERR_MODULE_RTS, "ipc process register failed"},

    {TS_STREAM_SQ_FULL, RT_ERROR_TSFW_STREAM_FULL, ERR_MODULE_RTS, "stream sq full"},

    {TS_ERROR_END_OF_SEQUENCE, RT_ERROR_TSFW_END_OF_SEQUENCE, ERR_MODULE_RTS, "end of sequence"},

    {TS_ERROR_SWITCH_STREAM_LABEL, RT_ERROR_TSFW_SWITCH_STREAM_LABEL, ERR_MODULE_RTS, "switch stream label failed"},

    {TS_ERROR_TASK_TYPE_NOT_SUPPORT, RT_ERROR_TASK_NOT_SUPPORT, ERR_MODULE_RTS, "task type not support"},

    {TS_ERROR_TRANS_SQE_FAIL, RT_ERROR_TSFW_TRANS_SQE_FAIL, ERR_MODULE_RTS, "translate sqe fail"},

    {TS_MODEL_ABORT_NORMAL, RT_ERROR_MODEL_ABORT_NORMAL, ERR_MODULE_RTS, "model abort normal"},

    {TS_ERROR_MODEL_ABORTED, RT_ERROR_MODEL_ABORT_NORMAL, ERR_MODULE_RTS, "model is aborted"},

    {TS_ERROR_TASK_EXCEPTION, RT_ERROR_TSFW_TASK_EXCEPTION, ERR_MODULE_RTS, "task exception"},

    {TS_ERROR_SDMA_COPY_ERROR, RT_ERROR_TSFW_SDMA_COPY_ERROR, ERR_MODULE_GE, "sdma copy error"},

    {TS_ERROR_SDMA_REDUCE_ERROR, RT_ERROR_TSFW_SDMA_REDUCE_ERROR, ERR_MODULE_HCCL, "sdma reduce error"},

    {TS_ERROR_TASK_TRAP, RT_ERROR_TSFW_TASK_TRAP, ERR_MODULE_RTS, "task trap exception"},

    {TS_ERROR_TASK_TIMEOUT, RT_ERROR_TSFW_TASK_TIMEOUT, ERR_MODULE_RTS, "task timeout"},

    {TS_ERROR_SDMA_TIMEOUT, RT_ERROR_TSFW_TASK_TIMEOUT, ERR_MODULE_RTS, "memcpy timeout"},

    {TS_ERROR_SDMA_ERROR, RT_ERROR_TSFW_TASK_EXCEPTION, ERR_MODULE_RTS, "memcpy exception"},

    {TS_ERROR_TASK_SQE_ERROR, RT_ERROR_TSFW_TASK_SQE_ERROR, ERR_MODULE_RTS, "task sqe error"},

    {TS_ERROR_TASK_BUS_ERROR, RT_ERROR_TSFW_TASK_BUS_ERROR, ERR_MODULE_RTS, "task bus error"},

    {TS_ERROR_TASK_RES_CONFLICT_ERROR, RT_ERROR_TSFW_TASK_RES_CONFLICT_ERROR, ERR_MODULE_RTS,
        "task res conflict error"},

    {TS_ERROR_TASK_SW_STATUS_ERROR, RT_ERROR_TSFW_TASK_SW_STATUS_ERROR, ERR_MODULE_RTS, "task sw status error"},

    {TS_ERROR_VF_SLOT_ALLOC_FAIL, RT_ERROR_TSFW_VF_SLOT_ALLOC_FAIL, ERR_MODULE_RTS, "vf slot alloc fail"},

    {TS_ERROR_DEBUG_REGISTER_CONFLICT, RT_ERROR_TSFW_DEBUG_REGISTER_CONFLICT, ERR_MODULE_RTS,
     "debug register conflict, only one pid can be registered at the same time"},
    {TS_ERROR_AIVEC_OVERFLOW, RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL, ERR_MODULE_TBE, "aivec overflow"},

    {TS_ERROR_AICPU_OVERFLOW, RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL, ERR_MODULE_AICPU, "aicpu overflow"},

    {TS_ERROR_SDMA_OVERFLOW, RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL, ERR_MODULE_HCCL, "sdma overflow"},

    {TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED, RT_ERROR_AICPU_HCCL_OP_RETRY_FAILED, ERR_MODULE_HCCL, "hccl op retry failed"},

    {TS_ERROR_AIC_TRAP_RD_OVERFLOW, RT_ERROR_TSFW_AIC_TRAP_RD_OVERFLOW, ERR_MODULE_TBE, "aic trap read overflow"},

    {TS_ERROR_AIC_TRAP_WR_OVERFLOW, RT_ERROR_TSFW_AIC_TRAP_WR_OVERFLOW, ERR_MODULE_TBE, "aic trap write overflow"},

    {TS_ERROR_AIV_TRAP_RD_OVERFLOW, RT_ERROR_TSFW_AIV_TRAP_RD_OVERFLOW, ERR_MODULE_TBE, "aiv trap read overflow"},

    {TS_ERROR_AIV_TRAP_WR_OVERFLOW, RT_ERROR_TSFW_AIV_TRAP_WR_OVERFLOW, ERR_MODULE_TBE, "aiv trap write overflow"},

    {TS_ERROR_RESERVED, RT_ERROR_TSFW_RESERVED, ERR_MODULE_RTS, "unknown error"},

    {TS_ERROR_FFTSPLUS_TASK_TIMEOUT, RT_ERROR_TSFW_FFTS_PLUS_TIMEOUT, ERR_MODULE_RTS, "fftsplus task timeout"},

    {TS_ERROR_FFTSPLUS_TASK_EXCEPTION, RT_ERROR_TSFW_FFTS_PLUS_EXCEPTION, ERR_MODULE_RTS, "fftsplus task exception"},

    {TS_ERROR_FFTSPLUS_TASK_TRAP, RT_ERROR_TSFW_FFTS_PLUS_TRAP_EXCEPTION, ERR_MODULE_RTS,
     "fftsplus task trap exception"},
    {TS_ERROR_TS_CLOSED, RT_ERROR_TSFW_TS_CLOSED, ERR_MODULE_RTS,
     "TS is closed"},
};

uint32_t GetTsErrModuleType(const uint32_t type)
{
    const uint32_t errCodeCount = sizeof(g_tsErrCodeMap) / sizeof(g_tsErrCodeMap[0]);
    for (uint32_t idx = 0U; idx < errCodeCount; idx++) {
        if (type == g_tsErrCodeMap[idx].errCode) {
            return g_tsErrCodeMap[idx].moduleType;
        }
    }

    return ERR_MODULE_RTS;
}

const char_t *GetTsErrCodeDesc(const uint32_t type)
{
    const uint32_t errCodeCount = sizeof(g_tsErrCodeMap) / sizeof(g_tsErrCodeMap[0]);
    for (uint32_t idx = 0U; idx < errCodeCount; idx++) {
        if (type == g_tsErrCodeMap[idx].errCode) {
            return g_tsErrCodeMap[idx].codeString;
        }
    }

    return "unknown error";
}

const char_t *GetTsErrDescByRtErr(const rtError_t rtErrCode)
{
    const uint32_t errCodeCount = sizeof(g_tsErrCodeMap) / sizeof(g_tsErrCodeMap[0]);
    for (uint32_t idx = 0U; idx < errCodeCount; idx++) {
        if (rtErrCode == g_tsErrCodeMap[idx].rtErrCode) {
            return g_tsErrCodeMap[idx].codeString;
        }
    }

    return "unknown error";
}

const char_t *GetTsErrCodeMap(const uint32_t type, rtError_t * const rtErrCode)
{
    *rtErrCode = RT_ERROR_TSFW_RESERVED;
    const uint32_t errCodeCount = sizeof(g_tsErrCodeMap) / sizeof(g_tsErrCodeMap[0]);
    for (uint32_t idx = 0U; idx < errCodeCount; idx++) {
        if (type == g_tsErrCodeMap[idx].errCode) {
            *rtErrCode = g_tsErrCodeMap[idx].rtErrCode;
            return g_tsErrCodeMap[idx].codeString;
        }
    }

    return "unknown error";
}
}  // namespace runtime
}  // namespace cce
