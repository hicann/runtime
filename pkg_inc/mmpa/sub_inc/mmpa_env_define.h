/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MMPA_ENV_DEFINE_H
#define MMPA_ENV_DEFINE_H

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif // __cpluscplus
#endif // __cpluscplus

typedef enum {
    // ASCEND COMMON
    MM_ENV_ASCEND_WORK_PATH                = 0,
    MM_ENV_ASCEND_HOSTPID                  = 1,
    MM_ENV_RANK_ID                         = 2,
    MM_ENV_ASCEND_HOME_PATH                = 3,
    MM_ENV_ASCEND_LATEST_INSTALL_PATH      = 4,
    MM_ENV_ASCEND_AICPU_PATH               = 5,
    MM_ENV_DATAMASTER_RUN_MODE             = 6,
    MM_ENV_REGISTER_TO_ASCENDMONITOR       = 7,
    MM_ENV_ASAN_RUN_MODE                   = 8,
    MM_ENV_ASCEND_ENGINE_PATH              = 9,
    MM_ENV_ASCEND_ENHANCE_ENABLE           = 10,
    MM_ENV_ASCEND_TOOLKIT_HOME             = 11,
    // GE
    MM_ENV_DUMP_GRAPH_PATH                   = 1000,
    MM_ENV_DUMP_GE_GRAPH                     = 1001,
    MM_ENV_DUMP_GRAPH_LEVEL                  = 1002,
    MM_ENV_ENABLE_AUTO_FUSE                  = 1003,
    MM_ENV_ENABLE_DYNAMIC_SHAPE_MULTI_STREAM = 1004,
    MM_ENV_ENABLE_MBUF_ALLOCATOR             = 1005,
    MM_ENV_ENABLE_NETWORK_ANALYSIS_DEBUG     = 1006,
    MM_ENV_ENABLE_RUNTIME_V2                 = 1007,
    MM_ENV_ENABLE_TILING_CACHE               = 1008,
    MM_ENV_ESCLUSTER_CONFIG_PATH             = 1009,
    MM_ENV_EXPERIMENTAL_ENABLE_AUTOFUSE      = 1010,
    MM_ENV_GE_DAVINCI_MODEL_PROFILING        = 1011,
    MM_ENV_GE_PROFILING_TO_STD_OUT           = 1012,
    MM_ENV_GE_USE_STATIC_MEMORY              = 1013,
    MM_ENV_HBM_RATIO                         = 1014,
    MM_ENV_HELPER_RES_CONFIG                 = 1015,
    MM_ENV_HELPER_RES_FILE_PATH              = 1016,
    MM_ENV_HELP_CLUSTER                      = 1017,
    MM_ENV_HOST_CACHE_CAPACITY               = 1018,
    MM_ENV_HYBRID_PROFILING_LEVEL            = 1019,
    MM_ENV_IGNORE_INFER_ERROR                = 1020,
    MM_ENV_ITER_NUM                          = 1021,
    MM_ENV_MAX_RUNTIME_CORE_NUMBER           = 1022,
    MM_ENV_MULTI_THREAD_COMPILE              = 1023,
    MM_ENV_NPU_COLLECT_PATH                  = 1024,
    MM_ENV_NPU_COLLECT_PATH_EXE              = 1025,
    MM_ENV_OFF_CONV_CONCAT_SPLIT             = 1026,
    MM_ENV_OP_NO_REUSE_MEM                   = 1027,
    MM_ENV_PROFILING_OPTIONS                 = 1028,
    MM_ENV_RANK_SIZE                         = 1029,
    MM_ENV_RESOURCE_CONFIG_PATH              = 1030,
    MM_ENV_REUSE_GRAPH                       = 1031,
    MM_ENV_SKT_ENABLE                        = 1032,
    MM_ENV_AUTOFUSE_FLAGS                    = 1033,
    MM_ENV_AUTOFUSE_DFX_FLAGS                = 1034,
    MM_ENV_DUMP_GRAPH_FORMAT                 = 1035,
    // ACLNN
    MM_ENV_ACLNN_CACHE_LIMIT               = 2000,
    MM_ENV_DISABLE_L2_CACHE                = 2001,
    MM_ENV_OPS_PRODUCT_NAME                = 2002,
    MM_ENV_OPS_PROJECT_NAME                = 2003,
    MM_ENV_OPS_DIRECT_ACCESS_PREFIX        = 2004,
    MM_ENV_OPS_ACLNN_GEN                   = 2005,
    // RUNTIME
    MM_ENV_ASCEND_RT_VISIBLE_DEVICES       = 3000,
    MM_ENV_CAMODEL_LOG_PATH                = 3001,
    // ATRACE
    MM_ENV_ASCEND_COREDUMP_SIGNAL          = 4000,
    // ADUMP
    MM_ENV_ASCEND_CACHE_PATH               = 5000,
    MM_ENV_ASCEND_OPP_PATH                 = 5001,
    MM_ENV_ASCEND_CUSTOM_OPP_PATH          = 5002,
    // SLOG
    MM_ENV_ASCEND_LOG_DEVICE_FLUSH_TIMEOUT = 6000,
    MM_ENV_ASCEND_LOG_SAVE_MODE            = 6001,
    MM_ENV_ASCEND_SLOG_PRINT_TO_STDOUT     = 6002,
    MM_ENV_ASCEND_GLOBAL_EVENT_ENABLE      = 6003,
    MM_ENV_ASCEND_GLOBAL_LOG_LEVEL         = 6004,
    MM_ENV_ASCEND_MODULE_LOG_LEVEL         = 6005,
    MM_ENV_ASCEND_HOST_LOG_FILE_NUM        = 6006,
    MM_ENV_ASCEND_PROCESS_LOG_PATH         = 6007,
    MM_ENV_ASCEND_LOG_SYNC_SAVE            = 6008,
    // PROIFILING
    MM_ENV_PROFILER_SAMPLECONFIG           = 7000,
    MM_ENV_ACP_PIPE_FD                     = 7001,
    MM_ENV_PROFILING_MODE                  = 7002,
    MM_ENV_DYNAMIC_PROFILING_KEY_PID       = 7003,
    // SYSTEM ENVIRONMENT
    MM_ENV_HOME                            = 8000,
    MM_ENV_AOS_TYPE                        = 8001,
    MM_ENV_LD_LIBRARY_PATH                 = 8002,
    // AICPU
    MM_ENV_MAX_COMPILE_CORE_NUMBER         = 9000,
    MM_ENV_EMBEDDING_MAX_THREAD_CORE_NUMBER = 9001,
    MM_ENV_AICPU_PROFILING_MODE            = 9002,
    MM_ENV_QS_RESCHED_INTEVAL              = 9003,
    MM_ENV_AICPU_APP_LOG_SWITCH            = 9004,
    // ACL
    MM_ENV_AUTO_USE_UC_MEMORY              = 10000,
    MM_ENV_SHAREGROUP_PRECONFIG            = 10001,
    // HCCL
    MM_ENV_HCCL_RDMA_PCIE_DIRECT_POST_NOSTRICT = 11000,
    MM_ENV_HCCL_EXEC_TIMEOUT = 11001,
    MM_ENV_HCCL_CONNECT_TIMEOUT = 11002,
    MM_ENV_HCCL_DETERMINISTIC = 11003,
    MM_ENV_HCCL_INTRA_PCIE_ENABLE = 11004,
    MM_ENV_HCCL_INTRA_ROCE_ENABLE = 11005,
    MM_ENV_HCCL_WHITELIST_FILE = 11006,
    MM_ENV_HCCL_RDMA_QP_PORT_CONFIG_PATH = 11007,
    MM_ENV_HCCL_WHITELIST_DISABLE = 11008,
    MM_ENV_HCCL_IF_BASE_PORT = 11009,
    MM_ENV_HCCL_IF_IP = 11010,
    MM_ENV_HCCL_SOCKET_FAMILY = 11011,
    MM_ENV_HCCL_SOCKET_IFNAME = 11012,
    MM_ENV_HCCL_ALGO = 11013,
    MM_ENV_HCCL_RDMA_TC = 11014,
    MM_ENV_HCCL_RDMA_SL = 11015,
    MM_ENV_HCCL_RDMA_TIMEOUT = 11016,
    MM_ENV_HCCL_RDMA_RETRY_CNT = 11017,
    MM_ENV_HCCL_BUFFSIZE = 11018,
    MM_ENV_HCCL_DIAGNOSE_ENABLE = 11019,
    MM_ENV_HCCL_RDMA_QPS_PER_CONNECTION = 11020,
    MM_ENV_HCCL_MULTI_QP_THRESHOLD = 11021,
    MM_ENV_HCCL_ENTRY_LOG_ENABLE = 11022,
    MM_ENV_HCCL_OP_EXPANSION_MODE = 11023,
    MM_ENV_HCCL_INTER_HCCS_DISABLE = 11024,
    MM_ENV_HCCL_DEBUG_CONFIG = 11025,
    MM_ENV_HCCL_OP_RETRY_ENABLE = 11026,
    MM_ENV_HCCL_CONCURRENT_ENABLE = 11027,
    MM_ENV_HCCL_OP_RETRY_PARAMS = 11028,
    MM_ENV_HCCL_LOGIC_SUPERPOD_ID = 11029,
    MM_ENV_HCCL_HOST_SOCKET_PORT_RANGE = 11030,
    MM_ENV_HCCL_NPU_SOCKET_PORT_RANGE = 11031,
    MM_ENV_HCCL_DFS_CONFIG = 11032,
    // AOE
    MM_ENV_TUNE_BANK_PATH = 12000,
    // FE
    MM_ENV_ENABLE_ACLNN                                = 13000,
    MM_ENV_MIN_COMPILE_RESOURCE_USAGE_CTRL             = 13001,
    MM_ENV_OP_DYNAMIC_COMPILE_STATIC                   = 13002,
    // TE
    MM_ENV_ASCEND_MAX_OP_CACHE_SIZE                    = 14000,
    MM_ENV_ASCEND_REMAIN_CACHE_SIZE_RATIO              = 14001,
    MM_ENV_ASCEND_OP_COMPILER_WORK_PATH_IN_KERNEL_META = 14002,
    MM_ENV_TE_PARALLEL_COMPILER                        = 14003,
    MM_ENV_TEFUSION_NEW_DFXINFO                        = 14004,
    MM_ENV_TE_AUTO_RESTART_COUNTER                     = 14005,
    MM_ENV_PYTHONPATH                                  = 14006,
    MM_ENV_PARA_DEBUG_PATH                             = 14007,
    MM_ENV_PATH                                        = 14008,
    MM_ENV_CONTEXT_MODELCOMPILING                      = 14009,
    // AMCT
    MM_ENV_AMCT_LOG_DUMP = 15000,
} mmEnvId;


#ifdef __cplusplus
#if __cplusplus
}
#endif // __cpluscplus
#endif // __cpluscplus
#endif // MMPA_TYPEDEF_LINUX_H_
