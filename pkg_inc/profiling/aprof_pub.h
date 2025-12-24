/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef APROF_PUB_H
#define APROF_PUB_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define MSVP_PROF_API __declspec(dllexport)
#else
#define MSVP_PROF_API __attribute__((visibility("default")))
#endif

typedef void* VOID_PTR;
#define MSPROF_REPORT_DATA_MAGIC_NUM 0x5A5AU
#define MSPROF_EVENT_FLAG 0xFFFFFFFFFFFFFFFFULL
#define MSPROF_COMPACT_INFO_DATA_LENGTH 40
#define PATH_LEN_MAX 1023
#define PARAM_LEN_MAX 4095
#define ACC_PMU_EVENT_MAX 10
#define MSPROF_MAX_DEV_NUM 64
#define MSPROF_GE_TENSOR_DATA_SHAPE_LEN 8
#define MSPROF_GE_TENSOR_DATA_NUM 5
#define MSPROF_CTX_ID_MAX_NUM 55
/* Msprof report level */
#define MSPROF_REPORT_PYTORCH_LEVEL     30000U
#define MSPROF_REPORT_PTA_LEVEL         25000U
#define MSPROF_REPORT_TX_LEVEL          20500U
#define MSPROF_REPORT_ACL_LEVEL         20000U
#define MSPROF_REPORT_MODEL_LEVEL       15000U
#define MSPROF_REPORT_NODE_LEVEL        10000U
#define MSPROF_REPORT_AICPU_LEVEL       6000U
#define MSPROF_REPORT_HCCL_NODE_LEVEL   5500U
#define MSPROF_REPORT_RUNTIME_LEVEL     5000U
#define MSPROF_REPORT_PROF_LEVEL        4500U
#define MSPROF_REPORT_DPU_LEVEL         4000U
#define MSPROF_REPORT_AIC_LEVEL         3000U

/*Msprof report type of tx(20500) level, offset: 0x000000 */
#define MSPROF_REPORT_TX_BASE_TYPE                0x000000U

/* Msprof report type of acl(20000) level(acl), offset: 0x000000 */
#define MSPROF_REPORT_ACL_OP_BASE_TYPE            0x010000U
#define MSPROF_REPORT_ACL_MODEL_BASE_TYPE         0x020000U
#define MSPROF_REPORT_ACL_RUNTIME_BASE_TYPE       0x030000U
#define MSPROF_REPORT_ACL_OTHERS_BASE_TYPE        0x040000U


/* Msprof report type of acl(20000) level(host api), offset: 0x050000 */
#define MSPROF_REPORT_ACL_NN_BASE_TYPE            0x050000U
#define MSPROF_REPORT_ACL_ASCENDC_TYPE            0x060000U
#define MSPROF_REPORT_ACL_HOST_HCCL_BASE_TYPE     0x070000U
#define MSPROF_REPORT_ACL_DVPP_BASE_TYPE          0x090000U
#define MSPROF_REPORT_ACL_GRAPH_BASE_TYPE         0x0A0000U
#define MSPROF_REPORT_ACL_ATB_BASE_TYPE           0x0B0000U

/* Msprof report type of model(15000) level, offset: 0x000000 */
#define MSPROF_REPORT_MODEL_GRAPH_ID_MAP_TYPE    0U         /* type info: graph_id_map */
#define MSPROF_REPORT_MODEL_EXECUTE_TYPE         1U         /* type info: execute */
#define MSPROF_REPORT_MODEL_LOAD_TYPE            2U         /* type info: load */
#define MSPROF_REPORT_MODEL_INPUT_COPY_TYPE      3U         /* type info: IntputCopy */
#define MSPROF_REPORT_MODEL_OUTPUT_COPY_TYPE     4U         /* type info: OutputCopy */
#define MSPROF_REPORT_MODEL_LOGIC_STREAM_TYPE    7U         /* type info: logic_stream_info */
#define MSPROF_REPORT_MODEL_EXEOM_TYPE           8U         /* type info: exeom */
#define MSPROF_REPORT_MODEL_UDF_BASE_TYPE        0x010000U  /* type info: udf_info */
#define MSPROF_REPORT_MODEL_AICPU_BASE_TYPE      0x020000U  /* type info: aicpu */

/* Msprof report type of node(10000) level, offset: 0x000000 */
#define MSPROF_REPORT_NODE_BASIC_INFO_TYPE       0U  /* type info: node_basic_info */
#define MSPROF_REPORT_NODE_TENSOR_INFO_TYPE      1U  /* type info: tensor_info */
#define MSPROF_REPORT_NODE_FUSION_OP_INFO_TYPE   2U  /* type info: funsion_op_info */
#define MSPROF_REPORT_NODE_CONTEXT_ID_INFO_TYPE  4U  /* type info: context_id_info */
#define MSPROF_REPORT_NODE_LAUNCH_TYPE           5U  /* type info: launch */
#define MSPROF_REPORT_NODE_TASK_MEMORY_TYPE      6U  /* type info: task_memory_info */
#define MSPROF_REPORT_NODE_HOST_OP_EXEC_TYPE     8U  /* type info: op exec */
#define MSPROF_REPORT_NODE_ATTR_INFO_TYPE        9U  /* type info: node_attr_info */
#define MSPROF_REPORT_NODE_HCCL_OP_INFO_TYPE    10U  /* type info: hccl_op_info */
#define MSPROF_REPORT_NODE_STATIC_OP_MEM_TYPE   11U  /* type info: static_op_mem */
#define MSPROF_REPORT_NODE_MC2_COMMINFO_TYPE    12U  /* type info: mc2_comm_info */
#define MSPROF_REPORT_NODE_OP_INFO_TYPE         13U  /* type info: op_info */

/* Msprof report type of node(10000) level(ge api), offset: 0x010000 */
#define MSPROF_REPORT_NODE_GE_API_BASE_TYPE      0x010000U /* type info: ge api */
#define MSPROF_REPORT_NODE_HCCL_BASE_TYPE        0x020000U /* type info: hccl api */
#define MSPROF_REPORT_NODE_DVPP_API_BASE_TYPE    0x030000U /* type info: dvpp api */
/* Msprof report type of aicpu(6000), offset: 0x000000 */
#define MSPROF_REPORT_AICPU_NODE_TYPE               0U /* type info: DATA_PREPROCESS.AICPU */
#define MSPROF_REPORT_AICPU_DP_TYPE                 1U /* type info: DATA_PREPROCESS.DP */
#define MSPROF_REPORT_AICPU_MODEL_TYPE              2U /* type info: DATA_PREPROCESS.AICPU_MODEL */
#define MSPROF_REPORT_AICPU_MI_TYPE                 3U /* type info: DATA_PREPROCESS.AICPUMI */
#define MSPROF_REPORT_AICPU_MC2_EXECUTE_COMM_TIME   4U /* type info: the information of communication time */
#define MSPROF_REPORT_AICPU_MC2_EXECUTE_COMP_TIME   5U /* type info: the information of computation time */
#define MSPROF_REPORT_AICPU_MC2_HCCL_INFO           6U /* type info: task information */
#define MSPROF_REPORT_AICPU_HCCL_OP_INFO            10U /* type info: task information of hccl_op_info */
#define MSPROF_REPORT_AICPU_FILP_TASK               11U /* type info: flip task */
#define MSPROF_REPORT_AICPU_HCCL_FLAG_TASK          12U /* type info: aicpu expansion, hccl main stream start and end tasks */
#define MSPROF_REPORT_AICPU_MC2_BATCH_HCCL_INFO     13U /* type info: Batch task information */
#define MSPROF_REPORT_AICPU_AST_TYPE                14U /* Ast profiling */

/* Msprof report type of hccl(5500) level(op api), offset: 0x010000 */
#define MSPROF_REPORT_HCCL_NODE_BASE_TYPE        0x010000U
#define MSPROF_REPORT_HCCL_MASTER_TYPE           0x010001U
#define MSPROF_REPORT_HCCL_SLAVE_TYPE            0x010002U

/* Msprof report type of hccl(4000U) level(dpu), offset: 0x000000 */
#define MSPROF_REPORT_DPU_TRACK_TYPE              0U /* type info: dpu_track */

/* use with AdprofCheckFeatureIsOn */
#define ADPROF_TASK_TIME_L0 0x00000008ULL
#define ADPROF_TASK_TIME_L1 0x00000010ULL
#define ADPROF_TASK_TIME_L2 0x00000020ULL

/* Msprof report type of profiling(4500) */
#define MSPROF_REPORT_DIAGNOSTIC_INFO_TYPE       0x010000U

/* Msprof report ai core type of profiling(3000) */
#define MSPROF_REPORT_AIC_TIMESTAMP_TYPE          0x0U

// DataTypeConfig MASK
#define PROF_ACL_API_MASK              0x00000001ULL
#define PROF_TASK_TIME_L1_MASK         0x00000002ULL
#define PROF_AICORE_METRICS_MASK       0x00000004ULL
#define PROF_AICPU_TRACE_MASK          0x00000008ULL
#define PROF_L2CACHE_MASK              0x00000010ULL
#define PROF_HCCL_TRACE_MASK           0x00000020ULL
#define PROF_TRAINING_TRACE_MASK       0x00000040ULL
#define PROF_MSPROFTX_MASK             0x00000080ULL
#define PROF_RUNTIME_API_MASK          0x00000100ULL
#define PROF_TASK_FRAMEWORK_MASK       0x00000200ULL
#define PROF_FWK_SCHEDULE_L0_MASK      0x00000200ULL
#define PROF_GE_API_L0_MASK            0x00000200ULL
#define PROF_TASK_TSFW_MASK            0x00000400ULL
#define PROF_TASK_TIME_MASK            0x00000800ULL
#define PROF_TASK_MEMORY_MASK          0x00001000ULL
#define PROF_TASK_TIME_L2_MASK         0x00002000ULL
#define PROF_OP_ATTR_MASK              0x00004000ULL
#define PROF_TASK_TIME_L3_MASK         0x00008000ULL

// system profiling mask
#define PROF_CPU_MASK                  0x00010000ULL
#define PROF_HARDWARE_MEMORY_MASK      0x00020000ULL
#define PROF_IO_MASK                   0x00040000ULL
#define PROF_INTER_CONNECTION_MASK     0x00080000ULL
#define PROF_DVPP_MASK                 0x00100000ULL
#define PROF_SYS_AICORE_SAMPLE_MASK    0x00200000ULL
#define PROF_AIVECTORCORE_SAMPLE_MASK  0x00400000ULL
#define PROF_INSTR_MASK                0x00800000ULL

#define PROF_MODEL_EXECUTE_MASK        0x0000001000000ULL
#define PROF_FWK_SCHEDULE_L1_MASK      0x0000001000000ULL
#define PROF_GE_API_L1_MASK            0x0000001000000ULL
#define PROF_RUNTIME_TRACE_MASK        0x0000004000000ULL
#define PROF_SCHEDULE_TIMELINE_MASK    0x0000008000000ULL
#define PROF_SCHEDULE_TRACE_MASK       0x0000010000000ULL
#define PROF_AIVECTORCORE_METRICS_MASK 0x0000020000000ULL
#define PROF_SUBTASK_TIME_MASK         0x0000040000000ULL
#define PROF_OP_DETAIL_MASK            0x0000080000000ULL
#define PROF_OP_TIMESTAMP_MASK         0x0000100000000ULL

#define PROF_AICPU_MODEL_MASK          0x4000000000000000ULL
#define PROF_MODEL_LOAD_MASK           0x8000000000000000ULL

#define MSPROF_OPTIONS_DEF_LEN_MAX (2048U)

/**
 * @name  MsprofErrorCode
 * @brief error code
 */
enum MsprofErrorCode {
    MSPROF_ERROR_NONE = 0,
    MSPROF_ERROR_MEM_NOT_ENOUGH,
    MSPROF_ERROR_GET_ENV,
    MSPROF_ERROR_CONFIG_INVALID,
    MSPROF_ERROR_ACL_JSON_OFF,
    MSPROF_ERROR,
    MSPROF_ERROR_UNINITIALIZE,
};

/**
 * @name  MsprofCtrlCallbackType
 * @brief ctrl callback request type
 */
enum MsprofCtrlCallbackType {
    MSPROF_CTRL_INIT_ACL_ENV = 0,           // start profiling with acl env
    MSPROF_CTRL_INIT_ACL_JSON = 1,          // start pro with acl.json
    MSPROF_CTRL_INIT_GE_OPTIONS = 2,        // start profiling with ge env and options
    MSPROF_CTRL_FINALIZE = 3,               // stop profiling
    MSPROF_CTRL_INIT_HELPER = 4,            // start profiling in helper device
    MSPROF_CTRL_INIT_PURE_CPU = 5,          // start profiling in pure cpu
    MSPROF_CTRL_INIT_AICPU = 6,             // start profiling with aicpu
    MSPROF_CTRL_INIT_DYNA = 0xFF,           // start profiling for dynamic profiling
};

/**
 * @name  MsprofCommandHandleType
 * @brief Identification codes representing various callback statuses
 */
enum MsprofCommandHandleType {
    PROF_COMMANDHANDLE_TYPE_INIT = 0,
    PROF_COMMANDHANDLE_TYPE_START,
    PROF_COMMANDHANDLE_TYPE_STOP,
    PROF_COMMANDHANDLE_TYPE_FINALIZE,
    PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE,
    PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE,
    PROF_COMMANDHANDLE_TYPE_MAX
};

enum MsprofGeTaskType { 
    MSPROF_GE_TASK_TYPE_AI_CORE = 0,
    MSPROF_GE_TASK_TYPE_AI_CPU,
    MSPROF_GE_TASK_TYPE_AIV,
    MSPROF_GE_TASK_TYPE_WRITE_BACK,
    MSPROF_GE_TASK_TYPE_MIX_AIC,
    MSPROF_GE_TASK_TYPE_MIX_AIV,
    MSPROF_GE_TASK_TYPE_FFTS_PLUS,
    MSPROF_GE_TASK_TYPE_DSA,
    MSPROF_GE_TASK_TYPE_DVPP,
    MSPROF_GE_TASK_TYPE_HCCL,
    MSPROF_GE_TASK_TYPE_FUSION,
    MSPROF_GE_TASK_TYPE_INVALID
};

enum MsprofGeTensorType {
    MSPROF_GE_TENSOR_TYPE_INPUT = 0,
    MSPROF_GE_TENSOR_TYPE_OUTPUT,
};

/**
 * @brief   profiling command type
 */
enum ProfCtrlType {
    PROF_CTRL_INVALID = 0,
    PROF_CTRL_SWITCH,
    PROF_CTRL_REPORTER,
    PROF_CTRL_STEPINFO,
    PROF_CTRL_BUTT
};

enum AttrType {
    OP_ATTR = 0,
};

enum MsprofReportBatchType {
    MSPROF_BATCH_ADDITIONAL_INFO = 0
};

struct MsprofCommandHandleParams {
    uint32_t pathLen;
    uint32_t storageLimit;  // MB
    uint32_t profDataLen;
    char path[PATH_LEN_MAX + 1];
    char profData[PARAM_LEN_MAX + 1];
};

/**
 * @brief profiling command info
 */
struct MsprofCommandHandle {
    uint64_t profSwitch;
    uint64_t profSwitchHi;
    uint32_t devNums;
    uint32_t devIdList[MSPROF_MAX_DEV_NUM];
    uint32_t modelId;
    uint32_t type;
    uint32_t cacheFlag;
    struct MsprofCommandHandleParams params;
};

#pragma pack(1)

struct MsprofAttrInfo {
    uint64_t opName;
    uint32_t attrType;
    uint64_t hashId;
};

/**
 * @name  MsprofGeOptions
 * @brief struct of MSPROF_CTRL_INIT_GE_OPTIONS
 */
struct MsprofGeOptions {
    char jobId[MSPROF_OPTIONS_DEF_LEN_MAX];
    char options[MSPROF_OPTIONS_DEF_LEN_MAX];
};

struct MsprofNodeBasicInfo {
    uint64_t opName;
    uint32_t taskType;
    uint64_t opType;
    uint32_t blockDim;
    uint32_t opFlag;
};

struct MsprofHCCLOPInfo {  // for MsprofReportCompactInfo buffer data
    uint8_t relay : 1;     // Communication
    uint8_t retry : 1;     // Retransmission flag
    uint8_t dataType;      // Consistent with Type HcclDataType preservation
    uint64_t algType;      // The algorithm used by the communication operator, the hash key, whose value is a string separated by "-".
    uint64_t count;        // Number of data sent
    uint64_t groupName;    // group hash id
};

struct MsrofTensorData {
    uint32_t tensorType;
    uint32_t format;
    uint32_t dataType;
    uint32_t shape[MSPROF_GE_TENSOR_DATA_SHAPE_LEN];
};

struct MsprofTensorInfo {
    uint64_t opName;
    uint32_t tensorNum;
    struct MsrofTensorData tensorData[MSPROF_GE_TENSOR_DATA_NUM];
};

struct MsprofContextIdInfo {
    uint64_t opName;
    uint32_t ctxIdNum;
    uint32_t ctxIds[MSPROF_CTX_ID_MAX_NUM];
};

#pragma pack()

struct MsprofAicTimeStampInfo {
    uint64_t syscyc;   // dotting timestamp with system cycle
    uint32_t blockId;  // core block id
    uint32_t descId;   // dot Id for description
    uint64_t curPc;   // currrent pc for source line
};

struct MsprofRuntimeTrack {  // for MsprofReportCompactInfo buffer data
    uint16_t deviceId;
    uint16_t streamId;
    uint32_t taskId;
    uint64_t taskType;       // task message hash id
    uint64_t kernelName;     // kernelname hash id
};

struct MsprofCaptureStreamInfo {  // for MsprofReportCompactInfo buffer data
    uint16_t captureStatus;     // Whether the mark is destroyed: 0 indicates normal, 1 indicates destroyed.
    uint16_t modelStreamId;     // capture stream id. Destroy the stream ID of the record, set it to UINT16_MAX.
    uint16_t originalStreamId;  // ori stream id. Destroy the stream ID of the record, set it to UINT16_MAX.
    uint16_t modelId;           // capture model id, independent of GE
    uint16_t deviceId;
};

struct MsprofDpuTrack {  // for MsprofReportCompactInfo buffer data
    uint16_t deviceId;   // high 4 bits, devType: dpu: 1, low 12 bits device id
    uint16_t streamId;
    uint32_t taskId;
    uint32_t taskType;    // task type enum
    uint32_t res;
    uint64_t startTime;   // start time
};

struct MsprofStreamExpandSpecInfo {
    uint8_t expandStatus;
    uint8_t reserve1;
    uint16_t reserve2;
};

struct MsprofApi { // for MsprofReportApi
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
#else
    uint16_t magicNumber;
#endif
    uint16_t level;
    uint32_t type;
    uint32_t threadId;
    uint32_t reserve;
    uint64_t beginTime;
    uint64_t endTime;
    uint64_t itemId;
};

struct MsprofEvent {  // for MsprofReportEvent
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
#else
    uint16_t magicNumber;
#endif
    uint16_t level;
    uint32_t type;
    uint32_t threadId;
    uint32_t requestId; // 0xFFFF means single event
    uint64_t timeStamp;
#ifdef __cplusplus
    uint64_t eventFlag = MSPROF_EVENT_FLAG;
#else
    uint64_t eventFlag;
#endif
    uint64_t itemId;
};

struct MsprofCompactInfo {  // for MsprofReportCompactInfo buffer data
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
#else
    uint16_t magicNumber;
#endif
    uint16_t level;
    uint32_t type;
    uint32_t threadId;
    uint32_t dataLen;
    uint64_t timeStamp;
    union {
        uint8_t info[MSPROF_COMPACT_INFO_DATA_LENGTH];
        struct MsprofRuntimeTrack runtimeTrack;
        struct MsprofCaptureStreamInfo captureStreamInfo;
        struct MsprofNodeBasicInfo nodeBasicInfo;
        struct MsprofHCCLOPInfo hcclopInfo;
        struct MsprofDpuTrack dpuTack;
        struct MsprofStreamExpandSpecInfo streamExpandInfo;
    } data;
};

#define MSPROF_ADDTIONAL_INFO_DATA_LENGTH (232)
struct MsprofAdditionalInfo {  // for MsprofReportAdditionalInfo buffer data
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
#else
    uint16_t magicNumber;
#endif
    uint16_t level;
    uint32_t type;
    uint32_t threadId;
    uint32_t dataLen;
    uint64_t timeStamp;
    uint8_t  data[MSPROF_ADDTIONAL_INFO_DATA_LENGTH];
};

struct MsprofShapeInfo {  // for MsprofReportShapeInfo buffer data
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
#else
    uint16_t magicNumber;
#endif
    uint16_t level;
    uint32_t type;
    uint32_t threadId;
    uint32_t dataLen;
    uint64_t timeStamp;
    uint8_t  data[0];
};

/**
 * @name  ProfCommandHandle
 * @brief callback to start/stop profiling
 * @param[in] type  enum call back type
 * @param[in] data  callback data
 * @param[in] len   callback data size
 * @return enum MsprofErrorCode
 */
typedef int32_t (*ProfCommandHandle)(uint32_t type, void *data, uint32_t len);

typedef int32_t (*MsprofReporterCallback)(uint32_t moduleId, uint32_t type, void *data, uint32_t len);

/**
 * @ingroup libprofapi
 * @name  MsprofInit
 * @brief Profiling module init
 * @param[in] dataType  profiling type: ACL Env/ACL Json/GE Option
 * @param[in] data      profiling switch data
 * @param[in] dataLen   Length of data
 * @return 0:SUCCESS, >0:FAILED
 */
MSVP_PROF_API int32_t MsprofInit(uint32_t dataType, void *data, uint32_t dataLen);

/**
 * @ingroup libprofapi
 * @name  MsprofFinalize
 * @brief profiling finalize
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofFinalize(void);

/**
 * @ingroup libprofapi
 * @name  MsprofRegisterCallback
 * @brief register profiling switch callback for module
 * @param[in] moduleId  Report ID of the component
 * @param[in] handle    Callback function for component registration
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle);

/**
 * @ingroup libprofapi
 * @name  MsprofReportApi
 * @brief report api timestamp
 * @param[in] nonPersistantFlag  0 isn't aging, !0 is aging
 * @param[in] api                api of timestamp data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofReportApi(uint32_t nonPersistantFlag, const struct MsprofApi *api);

/**
 * @ingroup libprofapi
 * @name  MsprofReportEvent
 * @brief report event timestamp
 * @param[in] nonPersistantFlag  0 isn't aging, !0 is aging
 * @param[in] event              event of timestamp data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofReportEvent(uint32_t nonPersistantFlag, const struct MsprofEvent *event);

/**
 * @ingroup libprofapi
 * @name  MsprofReportCompactInfo
 * @brief report profiling compact infomation
 * @param[in] nonPersistantFlag  0 isn't aging, !0 is aging
 * @param[in] data               profiling data of compact infomation
 * @param[in] length             length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofReportCompactInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length);

/**
 * @ingroup libprofapi
 * @name  MsprofReportAdditionalInfo
 * @brief report profiling additional infomation
 * @param[in] nonPersistantFlag  0 isn't aging, !0 is aging
 * @param[in] data               profiling data of additional infomation
 * @param[in] length             length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length);

/**
 * @ingroup libprofapi
 * @name  MsprofReportAdditionalInfo
 * @brief report profiling additional infomation
 * @param[in] nonPersistantFlag  0 isn't aging, !0 is aging
 * @param[in] data               profiling data of additional infomation
 * @param[in] length             length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length);

/**
 * @ingroup libascend_devprof
 * @name  AdprofGetBatchReportMaxSize
 * @brief get max batch report size
 * @param[in] type  type of batch report
 * @return >0:SUCCESS, <=0:FAILED
 */
MSVP_PROF_API size_t MsprofGetBatchReportMaxSize(uint32_t type);

/**
 * @ingroup libprofapi
 * @name  MsprofRegTypeInfo
 * @brief reg mapping info of type id and type name
 * @param[in] level     level is the report struct's level
 * @param[in] typeId    type id is the report struct's type
 * @param[in] typeName  label of type id for presenting user
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName);

/**
 * @ingroup libprofapi
 * @name  MsprofRegDataFormat
 * @brief reg mapping info of type id and type name
 * @param[in] level     level is the report struct's level
 * @param[in] typeId    type id is the report struct's type
 * @param[in] dataFormat data format
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofRegDataFormat(uint16_t level, uint32_t typeId, const char *dataFormat);

/**
 * @ingroup libprofapi
 * @name  MsprofGetHashId
 * @brief return hash id of hash info
 * @param[in] hashInfo  infomation to be hashed
 * @param[in] length    the length of infomation to be hashed
 * @return hash id
 */
MSVP_PROF_API uint64_t MsprofGetHashId(const char *hashInfo, size_t length);

/**
 * @ingroup libprofapi
 * @name  MsprofStr2Id
 * @brief Return the corresponding hash id code of the input string.
 * @param[in] hashInfo  string infomation to be hashed
 * @param[in] length    the length of string infomation
 * @return hash id
 */
MSVP_PROF_API uint64_t MsprofStr2Id(const char *hashInfo, size_t length);

/**
 * @ingroup libprofapi
 * @name  MsprofSetDeviceIdByGeModelIdx
 * @brief insert device id by model id
 * @param[in] geModelIdx  ge model id
 * @param[in] deviceId    device id
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);

/**
 * @ingroup libprofapi
 * @name  MsprofUnsetDeviceIdByGeModelIdx
 * @brief delete device id by model id
 * @param[in] geModelIdx  ge model id
 * @param[in] deviceId    device id
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofUnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);

/**
 * @ingroup libprofapi
 * @name  MsprofSysCycleTime
 * @brief get systime cycle time of CPU
 * @return system cycle time of CPU
 */
MSVP_PROF_API uint64_t MsprofSysCycleTime(void);

#ifdef __cplusplus
}
#endif
#endif