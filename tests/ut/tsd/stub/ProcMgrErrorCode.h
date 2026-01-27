/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROCMGR_ERROR_CODE_H
#define PROCMGR_ERROR_CODE_H
#include <cinttypes>

namespace ProcMgr {
// =============================================================
// SUCCESS  CODE
// =============================================================
static constexpr uint32_t PROCMGR_SUCCESS = 0x0000U; // Success code

// =============================================================
// common
// =============================================================
static constexpr uint32_t PM_ERR_COMMON_INPUT_ERR = 0xF10000U;
static constexpr uint32_t PM_ERR_COMMON_NULL_PTR = 0xF10001U;
static constexpr uint32_t PM_ERR_COMMON_STRCPY_FAILED = 0xF10002U;
static constexpr uint32_t PM_ERR_COMMON_MEM_COPY_FAILED = 0xF10003U;
static constexpr uint32_t PM_ERR_COMMON_NEW_FAILED = 0xF10004U;
static constexpr uint32_t PM_ERR_COMMON_IAM_OPEN_FAILED = 0xF10005U;
static constexpr uint32_t PM_ERR_COMMON_IAM_IOCTL_FAILED = 0xF10006U;
static constexpr uint32_t PM_ERR_COMMON_EASYCOMMON_OPEN_PIPE_FAILED = 0xF10007U;
static constexpr uint32_t PM_ERR_COMMON_EASYCOMMON_OPEN_PIPE_TIMEOUT = 0xF10008U;
static constexpr uint32_t PM_ERR_COMMON_EASYCOMMON_REGISTER_SERVICE_FAILED = 0xF10009U;
static constexpr uint32_t PM_ERR_COMMON_EASYCOMMON_RPC_SYNC_FAILED = 0xF1000AU;

// =============================================================
// sys_operator
// =============================================================
static constexpr uint32_t PM_ERR_SYS_OPERATOR_GET_THREAD_NAME_FAILED = 0xF10600U;
static constexpr uint32_t PM_ERR_SYS_OPERATOR_CTRL_CPU_IS_NULL = 0xF10601U;
static constexpr uint32_t PM_ERR_SYS_OPERATOR_SET_CORE_AFFINITY_FAILED = 0xF10602U;

// =============================================================
// parse_depend
// =============================================================
static constexpr uint32_t PM_ERR_PARSE_DEPEND_INIT_YAML_NODE_FAILED = 0xF10400U;
static constexpr uint32_t PM_ERR_PARSE_DEPEND_INVALID_YAML = 0xF10401U;
static constexpr uint32_t PM_ERR_PARSE_DEPEND_SUBFILE_COUNT_BEYOND_MAX_SUPPORTED = 0xF10402U;
static constexpr uint32_t PM_ERR_PARSE_DEPEND_GRAPH_IS_NOT_LOAD = 0xF10403U;
static constexpr uint32_t PM_ERR_PARSE_DEPEND_HAS_CYCLE = 0xF10404U;
static constexpr uint32_t PM_ERR_PARSE_DEPEND_CFG_GET_FAILED = 0xF10405U;

// =============================================================
// pm_agent
// =============================================================
static constexpr uint32_t PM_ERR_PM_AGENT_GET_PM_PROCNAME_FAILED = 0xF10500U;
static constexpr uint32_t PM_ERR_PM_AGENT_IS_NOT_OK = 0xF10501U;
static constexpr uint32_t PM_ERR_PM_AGENT_SERIALIZATION_FAILED = 0xF10502U;
static constexpr uint32_t PM_ERR_PM_AGENT_EASYCOMMON_SEND_MSG_FAILED = 0xF10503U;
static constexpr uint32_t PM_ERR_PM_AGENT_RES_IS_NULL = 0xF10504U;
static constexpr uint32_t PM_ERR_PM_AGENT_RES_IS_FAILURE = 0xF10505U;

// =============================================================
// fault_event/report_event F10200-F10300
// =============================================================
static constexpr uint32_t PM_ERR_FTE_INPUT_NULL = 0xF10200U;
static constexpr uint32_t PM_ERR_FTE_HASH_CONFLICT = 0xF10201U;
static constexpr uint32_t PM_ERR_FTE_WRONG_UDSINFO = 0xF10202U;
static constexpr uint32_t PM_ERR_FTE_OWNER_CB_NULL = 0xF10203U;
static constexpr uint32_t PM_ERR_FTE_INPUT_BUF_NULL = 0xF10204U;
static constexpr uint32_t PM_ERR_FTE_INPUT_BUFSIZE = 0xF10205U;
static constexpr uint32_t PM_ERR_FTE_SECVFS_INVALID = 0xF10206U;
static constexpr uint32_t PM_ERR_FTE_IAMREG_RT_FAIL = 0xF10207U;
static constexpr uint32_t PM_ERR_IAMREGPOOL_FAIL = 0xF10208U;
static constexpr uint32_t PM_ERR_IAMMALLOC_FAIL = 0xF10209U;
static constexpr uint32_t PM_ERR_FTE_IAMSHMWRITE_FAIL = 0xF1020AU;
static constexpr uint32_t PM_ERR_IAMDATAENQUE_FAIL = 0xF1020BU;

// =============================================================
// sstoowner F10300-F10400
// =============================================================
static constexpr uint32_t PM_ERR_SET_STATE_BUSY = 0xF10300U;
static constexpr uint32_t PM_ERR_SET_STATE_RESULT_FAIL = 0xF10301U; // merge the results of all groupowners
static constexpr uint32_t PM_ERR_CHANGE_APP_BUSY = 0xF10302U;
static constexpr uint32_t PM_ERR_CHANGE_APP_RESULT_FAIL = 0xF10303U; // merge the results of all apps
static constexpr uint32_t PM_ERR_STOP_ALLAPP_RESULT_FAIL = 0xF10304U; // merge the results of all apps
static constexpr uint32_t PM_ERR_QUERY_APPLIST_RESULT_FAIL = 0xF10305U; // merge the results of all apps
static constexpr uint32_t PM_ERR_DUMP_RESULT_FAIL = 0xF10306U; // merge the results of all apps
static constexpr uint32_t PM_ERR_CFG_RELOAD_RESULT_FAIL = 0xF10307U; // merge the results of all apps
static constexpr uint32_t PM_ERR_IAMREG_QFS_FAIL = 0xF10308U;
static constexpr uint32_t PM_ERR_CTRL_CMD_INVALID = 0xF10309U;
static constexpr uint32_t PM_ERR_IAMREG_VFS_FAIL = 0xF1030AU;
static constexpr uint32_t PM_ERR_START_DELAY_CORE_AFFINITY_BUSY = 0xF1030BU;
static constexpr uint32_t PM_ERR_DELAY_CORE_AFFINITY_RESULT_FAIL = 0xF1030CU;
}
#endif
