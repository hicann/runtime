/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROFILER_PROF_COMMON_H
#define MSPROFILER_PROF_COMMON_H

#include <stdint.h>
#include <stddef.h>
#include "aprof_pub.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define MSPROF_DATA_HEAD_MAGIC_NUM  0x5A5AU
#define MSPROF_TASK_TIME_L0 0x00000800ULL  // mean PROF_TASK_TIME
typedef const void* ConstVoidPtr;
typedef int32_t (*MsprofReportHandle)(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len);
typedef int32_t (*MsprofCtrlHandle)(uint32_t type, VOID_PTR data, uint32_t len);
typedef int32_t (*MsprofSetDeviceHandle)(VOID_PTR data, uint32_t len);
typedef int32_t (*MsprofCtrlCallback)(uint32_t type, void *data, uint32_t len);
typedef int32_t (*MsprofReporterCallback)(uint32_t moduleId, uint32_t type, void *data, uint32_t len);

enum ProfileCallbackType {
    PROFILE_CTRL_CALLBACK = 0,
    PROFILE_DEVICE_STATE_CALLBACK,
    PROFILE_REPORT_API_CALLBACK,
    PROFILE_REPORT_EVENT_CALLBACK,
    PROFILE_REPORT_COMPACT_CALLBACK,
    PROFILE_REPORT_ADDITIONAL_CALLBACK,
    PROFILE_REPORT_REG_TYPE_INFO_CALLBACK,
    PROFILE_REPORT_GET_HASH_ID_CALLBACK,
    PROFILE_HOST_FREQ_IS_ENABLE_CALLBACK,
    PROFILE_REPORT_API_C_CALLBACK,
    PROFILE_REPORT_EVENT_C_CALLBACK,
    PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK,
    PROFILE_REPORT_GET_HASH_ID_C_CALLBACK,
    PROFILE_HOST_FREQ_IS_ENABLE_C_CALLBACK,
    PROFILE_REPORT_REG_DATA_FORMAT_CALLBACK,
    PROFILE_REPORT_REG_DATA_FORMAT_C_CALLBACK,
};

enum MsprofDataTag {
    MSPROF_ACL_DATA_TAG = 0,            // acl data tag, range: 0~19
    MSPROF_GE_DATA_TAG_MODEL_LOAD = 20, // ge data tag, range: 20~39
    MSPROF_GE_DATA_TAG_FUSION = 21,
    MSPROF_GE_DATA_TAG_INFER = 22,
    MSPROF_GE_DATA_TAG_TASK = 23,
    MSPROF_GE_DATA_TAG_TENSOR = 24,
    MSPROF_GE_DATA_TAG_STEP = 25,
    MSPROF_GE_DATA_TAG_ID_MAP = 26,
    MSPROF_GE_DATA_TAG_HOST_SCH = 27,
    MSPROF_RUNTIME_DATA_TAG_API = 40,   // runtime data tag, range: 40~59
    MSPROF_RUNTIME_DATA_TAG_TRACK = 41,
    MSPROF_AICPU_DATA_TAG = 60,         // aicpu data tag, range: 60~79
    MSPROF_AICPU_MODEL_TAG = 61,
    MSPROF_HCCL_DATA_TAG = 80,          // hccl data tag, range: 80~99
    MSPROF_DP_DATA_TAG = 100,           // dp data tag, range: 100~119
    MSPROF_MSPROFTX_DATA_TAG = 120,     // hccl data tag, range: 120~139
    MSPROF_DATA_TAG_MAX = 65536,        // data tag value type is uint16_t
};

enum MsprofMindsporeNodeTag {
    GET_NEXT_DEQUEUE_WAIT = 1,
};

/**
 * @brief struct of mixed data
 */
#define MSPROF_MIX_DATA_RESERVE_BYTES 7
#define MSPROF_MIX_DATA_STRING_LEN 120
enum MsprofMixDataType {
    MSPROF_MIX_DATA_HASH_ID = 0,
    MSPROF_MIX_DATA_STRING,
};
struct MsprofMixData {
    uint8_t type;  // MsprofMixDataType
    uint8_t rsv[MSPROF_MIX_DATA_RESERVE_BYTES];
    union {
        uint64_t hashId;
        char dataStr[MSPROF_MIX_DATA_STRING_LEN];
    } data;
};

/**
 * @brief profiling MsprofStart config
 */
#define  MAX_DUMP_PATH_LEN 1024
#define  MAX_SAMPLE_CONFIG_LEN 4096
struct MsprofConfig {
    uint64_t profSwitch;
    uint64_t profSwitchHi;
    uint32_t devNums;
    uint32_t devIdList[MSPROF_MAX_DEV_NUM + 1];
    uint32_t modelId;
    uint32_t type;
    uint32_t cacheFlag;
    uint32_t storageLimit;
    uint32_t metrics;
    uintptr_t fd;
    char dumpPath[MAX_DUMP_PATH_LEN];
    char sampleConfig[MAX_SAMPLE_CONFIG_LEN];
};

/**
 * @brief struct of data reported by acl
 */
#define MSPROF_ACL_DATA_RESERVE_BYTES 32
#define MSPROF_ACL_API_NAME_LEN 64
enum MsprofAclApiType {
    MSPROF_ACL_API_TYPE_OP = 1,
    MSPROF_ACL_API_TYPE_MODEL,
    MSPROF_ACL_API_TYPE_RUNTIME,
    MSPROF_ACL_API_TYPE_OTHERS,
};
struct MsprofAclProfData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_ACL_DATA_TAG;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t apiType;       // enum MsprofAclApiType
    uint64_t beginTime;
    uint64_t endTime;
    uint32_t processId;
    uint32_t threadId;
    char apiName[MSPROF_ACL_API_NAME_LEN];
    uint8_t  reserve[MSPROF_ACL_DATA_RESERVE_BYTES];
};

/**
 * @brief struct of data reported by GE
 */
#define MSPROF_GE_MODELLOAD_DATA_RESERVE_BYTES 104
struct MsprofGeProfModelLoadData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_MODEL_LOAD;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t modelId;
    struct MsprofMixData modelName;
    uint64_t startTime;
    uint64_t endTime;
    uint8_t  reserve[MSPROF_GE_MODELLOAD_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_FUSION_DATA_RESERVE_BYTES 8
#define MSPROF_GE_FUSION_OP_NUM 8
struct MsprofGeProfFusionData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_FUSION;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t modelId;
    struct MsprofMixData fusionName;
    uint64_t inputMemSize;
    uint64_t outputMemSize;
    uint64_t weightMemSize;
    uint64_t workspaceMemSize;
    uint64_t totalMemSize;
    uint64_t fusionOpNum;
    uint64_t fusionOp[MSPROF_GE_FUSION_OP_NUM];
    uint8_t  reserve[MSPROF_GE_FUSION_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_INFER_DATA_RESERVE_BYTES 64
struct MsprofGeProfInferData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_INFER;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t modelId;
    struct MsprofMixData modelName;
    uint32_t requestId;
    uint32_t threadId;
    uint64_t inputDataStartTime;
    uint64_t inputDataEndTime;
    uint64_t inferStartTime;
    uint64_t inferEndTime;
    uint64_t outputDataStartTime;
    uint64_t outputDataEndTime;
    uint8_t  reserve[MSPROF_GE_INFER_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_TASK_DATA_RESERVE_BYTES 12
#define MSPROF_GE_OP_TYPE_LEN 56

enum MsprofGeShapeType {
    MSPROF_GE_SHAPE_TYPE_STATIC = 0,
    MSPROF_GE_SHAPE_TYPE_DYNAMIC,
};
struct MsprofGeOpType {
    uint8_t type;  // MsprofMixDataType
    uint8_t rsv[MSPROF_MIX_DATA_RESERVE_BYTES];
    union {
        uint64_t hashId;
        char dataStr[MSPROF_GE_OP_TYPE_LEN];
    } data;
};
struct MsprofGeProfTaskData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_TASK;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t taskType;      // MsprofGeTaskType
    struct MsprofMixData opName;
    struct MsprofGeOpType opType;
    uint64_t curIterNum;
    uint64_t timeStamp;
    uint32_t shapeType;     // MsprofGeShapeType
    uint32_t blockDims;
    uint32_t modelId;
    uint32_t streamId;
    uint32_t taskId;
    uint32_t threadId;
    uint32_t contextId;
    uint8_t  reserve[MSPROF_GE_TASK_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_TENSOR_DATA_RESERVE_BYTES 8
struct MsprofGeTensorData {
    uint32_t tensorType;    // MsprofGeTensorType
    uint32_t format;
    uint32_t dataType;
    uint32_t shape[MSPROF_GE_TENSOR_DATA_SHAPE_LEN];
};

struct MsprofGeProfTensorData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_TENSOR;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t modelId;
    uint64_t curIterNum;
    uint32_t streamId;
    uint32_t taskId;
    uint32_t tensorNum;
    struct MsprofGeTensorData tensorData[MSPROF_GE_TENSOR_DATA_NUM];
    uint8_t  reserve[MSPROF_GE_TENSOR_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_STEP_DATA_RESERVE_BYTES 27
enum MsprofGeStepTag {
    MSPROF_GE_STEP_TAG_BEGIN = 0,
    MSPROF_GE_STEP_TAG_END,
};
struct MsprofGeProfStepData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_STEP;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t modelId;
    uint32_t streamId;
    uint32_t taskId;
    uint64_t timeStamp;
    uint64_t curIterNum;
    uint32_t threadId;
    uint8_t  tag;           // MsprofGeStepTag
    uint8_t  reserve[MSPROF_GE_STEP_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_ID_MAP_DATA_RESERVE_BYTES 6
struct MsprofGeProfIdMapData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_ID_MAP;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t graphId;
    uint32_t modelId;
    uint32_t sessionId;
    uint64_t timeStamp;
    uint16_t mode;
    uint8_t  reserve[MSPROF_GE_ID_MAP_DATA_RESERVE_BYTES];
};

#define MSPROF_GE_HOST_SCH_DATA_RESERVE_BYTES 24
struct MsprofGeProfHostSchData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_GE_DATA_TAG_HOST_SCH;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t threadId;      // record in start event
    uint64_t element;
    uint64_t event;
    uint64_t startTime;     // record in start event
    uint64_t endTime;       // record in end event
    uint8_t  reserve[MSPROF_GE_HOST_SCH_DATA_RESERVE_BYTES];
};

/**
 * @brief struct of data reported by RunTime
 */
#define MSPROF_AICPU_DATA_RESERVE_BYTES 9
struct MsprofAicpuProfData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_AICPU_DATA_TAG;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint16_t streamId;
    uint16_t taskId;
    uint64_t runStartTime;
    uint64_t runStartTick;
    uint64_t computeStartTime;
    uint64_t memcpyStartTime;
    uint64_t memcpyEndTime;
    uint64_t runEndTime;
    uint64_t runEndTick;
    uint32_t threadId;
    uint32_t deviceId;
    uint64_t submitTick;
    uint64_t scheduleTick;
    uint64_t tickBeforeRun;
    uint64_t tickAfterRun;
    uint32_t kernelType;
    uint32_t dispatchTime;
    uint32_t totalTime;
    uint16_t fftsThreadId;
    uint8_t  version;
    uint8_t  reserve[MSPROF_AICPU_DATA_RESERVE_BYTES];
};

struct MsprofAicpuModelProfData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_AICPU_MODEL_TAG;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t rsv;   // Ensure 8-byte alignment
    uint64_t timeStamp;
    uint64_t indexId;
    uint32_t modelId;
    uint16_t tagId;
    uint16_t rsv1;
    uint64_t eventId;
    uint8_t  reserve[24];
};

/**
 * @brief struct of data reported by DP
 */
#define MSPROF_DP_DATA_RESERVE_BYTES 16
#define MSPROF_DP_DATA_ACTION_LEN 16
#define MSPROF_DP_DATA_SOURCE_LEN 64

struct MsprofDpProfData {
#ifdef __cplusplus
    uint16_t magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    uint16_t dataTag = MSPROF_DP_DATA_TAG;
#else
    uint16_t magicNumber;
    uint16_t dataTag;
#endif
    uint32_t rsv;   // Ensure 8-byte alignment
    uint64_t timeStamp;
    char action[MSPROF_DP_DATA_ACTION_LEN];
    char source[MSPROF_DP_DATA_SOURCE_LEN];
    uint64_t index;
    uint64_t size;
    uint8_t  reserve[MSPROF_DP_DATA_RESERVE_BYTES];
};

struct MsprofAicpuNodeAdditionalData {
    uint16_t streamId;
    uint16_t taskId;
    uint64_t runStartTime;
    uint64_t runStartTick;
    uint64_t computeStartTime;
    uint64_t memcpyStartTime;
    uint64_t memcpyEndTime;
    uint64_t runEndTime;
    uint64_t runEndTick;
    uint32_t threadId;
    uint32_t deviceId;
    uint64_t submitTick;
    uint64_t scheduleTick;
    uint64_t tickBeforeRun;
    uint64_t tickAfterRun;
    uint32_t kernelType;
    uint32_t dispatchTime;
    uint32_t totalTime;
    uint16_t fftsThreadId;
    uint8_t version;
    uint8_t reserve[MSPROF_AICPU_DATA_RESERVE_BYTES];
};

struct MsprofAicpuModelAdditionalData {
    uint64_t indexId;
    uint32_t modelId;
    uint16_t tagId;
    uint16_t rsv1;
    uint64_t eventId;
    uint8_t reserve[24];
};

struct MsprofAicpuDpAdditionalData {
    char action[MSPROF_DP_DATA_ACTION_LEN];
    char source[MSPROF_DP_DATA_SOURCE_LEN];
    uint64_t index;
    uint64_t size;
    uint8_t reserve[MSPROF_DP_DATA_RESERVE_BYTES];
};

struct MsprofAicpuMiAdditionalData {
    uint32_t nodeTag;  // MsprofMindsporeNodeTag:1
    uint32_t reserve;
    uint64_t queueSize;
    uint64_t runStartTime;
    uint64_t runEndTime;
};

// AICPU kfc算子执行时间
struct AicpuKfcProfCommTurn {
    uint64_t serverStartTime;      // 进入KFC流程
    uint64_t waitMsgStartTime;     // 开始等待客户端消息
    uint64_t kfcAlgExeStartTime;   // 开始通信算法执行
    uint64_t sendTaskStartTime;    // 开始下发task
    uint64_t sendSqeFinishTime;    // task下发完成
    uint64_t rtsqExeEndTime;       // sq执行结束时间
    uint64_t serverEndTime;        // KFC流程结束时间
    uint64_t dataLen;              // 本轮通信数据长度
    uint32_t deviceId;
    uint16_t streamId;
    uint16_t taskId;
    uint8_t version;
    uint8_t commTurn;  // 总通信轮次
    uint8_t currentTurn;
    uint8_t reserve[5];
};

// Aicore算子执行时间
struct AicpuKfcProfComputeTurn {
    uint64_t waitComputeStartTime;  // 开始等待计算
    uint64_t computeStartTime;      // 开始计算
    uint64_t computeExeEndTime;     // 计算执行结束
    uint64_t dataLen;               // 本轮计算数据长度
    uint32_t deviceId;
    uint16_t streamId;
    uint16_t taskId;
    uint8_t version;
    uint8_t computeTurn;  // 总计算轮次
    uint8_t currentTurn;
    uint8_t reserve[5];
};

// 翻转task的上报
struct MsporfAicpuFlipTask {
	uint16_t  streamId;
	uint16_t  taskId; // 值无特殊要求
	uint32_t  flipNum;
	uint32_t reserve[2];
};

struct MsprofAicpuHcclMainStreamTask {
    uint16_t aicpuStreamId;
	uint16_t aicpuTaskId;
	uint16_t streamId;
	uint16_t taskId;
    uint16_t type; // 0是头 1是尾
	uint16_t reserve[3];
};

/**
 * @brief struct of data reported by HCCL
 */
#pragma pack(4)
struct MsprofHcclProfNotify {
    uint32_t taskID;
    uint64_t notifyID;
    uint32_t stage;
    uint32_t remoteRank;
    uint32_t transportType;
    uint32_t role; // role {0: dst, 1:src}
    double durationEstimated;
};

struct MsprofHcclProfReduce {
    uint32_t taskID;
    uint64_t src;
    uint64_t dst;
    uint64_t size;
    uint32_t op;            // {0: sum, 1: mul, 2: max, 3: min}
    uint32_t dataType;      // data type {0: INT8, 1: INT16, 2: INT32, 3: FP16, 4:FP32, 5:INT64, 6:UINT64}
    uint32_t linkType;      // link type {0: 'OnChip', 1: 'HCCS', 2: 'PCIe', 3: 'RoCE'}
    uint32_t remoteRank;
    uint32_t transportType; // transport type {0: SDMA, 1: RDMA, 2:LOCAL}
    uint32_t role;          // role {0: dst, 1:src}
    double durationEstimated;
};

struct MsprofHcclProfRDMA {
    uint32_t taskID;
    uint64_t src;
    uint64_t dst;
    uint64_t size;
    uint64_t notifyID;
    uint32_t linkType;      // link type {0: 'OnChip', 1: 'HCCS', 2: 'PCIe', 3: 'RoCE'}
    uint32_t remoteRank;
    uint32_t transportType; // transport type {0: RDMA, 1:SDMA, 2:LOCAL}
    uint32_t role;          // role {0: dst, 1:src}
    uint32_t type;          // RDMA type {0: RDMASendNotify, 1:RDMASendPayload}
    double durationEstimated;
};

struct MsprofHcclProfMemcpy {
    uint32_t taskID;
    uint64_t src;
    uint64_t dst;
    uint64_t size;
    uint64_t notifyID;
    uint32_t linkType;      // link type {0: 'OnChip', 1: 'HCCS', 2: 'PCIe', 3: 'RoCE'}
    uint32_t remoteRank;
    uint32_t transportType; // transport type {0: RDMA, 1:SDMA, 2:LOCAL}
    uint32_t role;          // role {0: dst, 1:src}
    double durationEstimated;
};

struct MsprofHcclProfStageStep {
    uint32_t rank;
    uint32_t rankSize;
};

struct MsprofHcclProfFlag {
    uint64_t cclTag;
    uint64_t groupName;
    uint32_t localRank;
    uint32_t workFlowMode;
};

#define MSPROF_HCCL_INVALID_UINT 0xFFFFFFFFU
struct MsprofHcclInfo {
    uint64_t itemId;
    uint64_t cclTag;
    uint64_t groupName;
    uint32_t localRank;
    uint32_t remoteRank;
    uint32_t rankSize;
    uint32_t workFlowMode;
    uint32_t planeID;
    uint32_t ctxId;
    uint64_t notifyID;
    uint32_t stage;
    uint32_t role; // role {0: dst, 1:src}
    double durationEstimated;
    uint64_t srcAddr;
    uint64_t dstAddr;
    uint64_t dataSize; // bytes
    uint32_t opType; // {0: sum, 1: mul, 2: max, 3: min}
    uint32_t dataType; // data type {0: INT8, 1: INT16, 2: INT32, 3: FP16, 4:FP32, 5:INT64, 6:UINT64}
    uint32_t linkType; // link type {0: 'OnChip', 1: 'HCCS', 2: 'PCIe', 3: 'RoCE'}
    uint32_t transportType; // transport type {0: SDMA, 1: RDMA, 2:LOCAL}
    uint32_t rdmaType; // RDMA type {0: RDMASendNotify, 1:RDMASendPayload}
    uint32_t reserve2;
#ifdef __cplusplus
    MsprofHcclInfo() : role(MSPROF_HCCL_INVALID_UINT), opType(MSPROF_HCCL_INVALID_UINT),
        dataType(MSPROF_HCCL_INVALID_UINT), linkType(MSPROF_HCCL_INVALID_UINT),
        transportType(MSPROF_HCCL_INVALID_UINT), rdmaType(MSPROF_HCCL_INVALID_UINT)
    {
    }
#endif
};

struct MsprofAicpuMC2HcclInfo {
    uint64_t itemId;
    uint64_t cclTag;
    uint64_t groupName;
    uint32_t localRank;
    uint32_t remoteRank;
    uint32_t rankSize;
    uint32_t workFlowMode;
    uint32_t planeID;
    uint32_t ctxId;
    uint64_t notifyID;
    uint32_t stage;
    uint32_t role; // role {0: dst, 1:src}
    double durationEstimated;
    uint64_t srcAddr;
    uint64_t dstAddr;
    uint64_t dataSize; // bytes
    uint32_t opType; // {0: sum, 1: mul, 2: max, 3: min}
    uint32_t dataType; // data type {0: INT8, 1: INT16, 2: INT32, 3: FP16, 4:FP32, 5:INT64, 6:UINT64}
    uint32_t linkType; // link type {0: 'OnChip', 1: 'HCCS', 2: 'PCIe', 3: 'RoCE'}
    uint32_t transportType; // transport type {0: SDMA, 1: RDMA, 2:LOCAL}
    uint32_t rdmaType; // RDMA type {0: RDMASendNotify, 1:RDMASendPayload}
    uint32_t taskId;
    uint16_t streamId;
    uint16_t reserve[3];
};

struct ProfilingDeviceCommResInfo {
    uint64_t groupName; // 通信域
    uint32_t rankSize; // 通信域内rank总数
    uint32_t rankId; // 当前device rankId，通信域内编号
    uint32_t usrRankId; // 当前device rankId，全局编号
    uint32_t aicpuKfcStreamId; // MC2中launch aicpu kfc算子的stream
    uint32_t commStreamSize; // 当前device侧使用的通信stream数量
    uint32_t commStreamIds[8]; // 具体streamId
    uint32_t reserve;
};

#define MSPROF_MULTI_THREAD_MAX_NUM 25
struct MsprofMultiThread {
    uint32_t threadNum;
    uint32_t threadId[MSPROF_MULTI_THREAD_MAX_NUM];
};
#pragma pack()


#pragma pack(1)

struct MsprofAicpuHCCLOPInfo {
    uint8_t relay : 1;     // 借轨通信
    uint8_t retry : 1;     // 重传标识
    uint8_t dataType;      // 跟HcclDataType类型保存一致
    uint64_t algType;      // 通信算子使用的算法,hash的key,其值是以"-"分隔的字符串
    uint64_t count;        // 发送数据个数
    uint64_t groupName;    // group hash id
    uint32_t ranksize;
    uint16_t streamId;
    uint32_t taskId;
};

struct MsprofAicpuHcclTaskInfo{
    uint64_t itemId;
    uint64_t cclTag;
    uint64_t groupName;
    uint32_t localRank;
    uint32_t remoteRank;
    uint32_t rankSize;
    uint32_t stage;
    uint64_t notifyID;
    uint64_t timeStamp;
    double durationEstimated;
    uint64_t srcAddr;
    uint64_t dstAddr;
    uint64_t dataSize; // bytes
    uint32_t taskId;
    uint32_t reserve;
    uint16_t streamId;
    uint16_t planeID;
    uint8_t opType; // {0: sum, 1: mul, 2: max, 3: min}
    uint8_t dataType; // data type {0: INT8, 1: INT16, 2: INT32, 3: FP16, 4:FP32, 5:INT64, 6:UINT64}
    uint8_t linkType; // link type {0: 'OnChip', 1: 'HCCS', 2: 'PCIe', 3: 'RoCE'}
    uint8_t transportType; // transport type {0: SDMA, 1: RDMA, 2:LOCAL}
    uint8_t rdmaType; // RDMA type {0: RDMASendNotify, 1:RDMASendPayload}
    uint8_t role; // role {0: dst, 1:src}
    uint8_t workFlowMode;
    uint8_t reserves[9];
};

struct ProfFusionOpInfo {
uint64_t opName;
uint32_t fusionOpNum;
uint64_t inputMemsize;
uint64_t outputMemsize;
uint64_t weightMemSize;
uint64_t workspaceMemSize;
uint64_t totalMemSize;
uint64_t fusionOpId[MSPROF_GE_FUSION_OP_NUM];
};

struct MsprofGraphIdInfo {
    uint64_t modelName;
    uint32_t graphId;
    uint32_t modelId;
};

struct MsprofMemoryInfo {
    uint64_t addr;
    int64_t size;
    uint64_t nodeId; // op name hash id
    uint64_t totalAllocateMemory;
    uint64_t totalReserveMemory;
    uint32_t deviceId;
    uint32_t deviceType;
};

/**
 * @name  MsprofStampInfo
 * @brief struct of data reported by msproftx
 */
#define PAYLOAD_VALUE_LEN 2
#define MAX_MESSAGE_LEN 128
struct MsprofStampInfo {
    uint16_t magicNumber;
    uint16_t dataTag;
    uint32_t processId;
    uint32_t threadId;
    uint32_t category;    // marker category
    uint32_t eventType;
    int32_t payloadType;
    union PayloadValue {
        uint64_t ullValue;
        int64_t llValue;
        double dValue;
        uint32_t uiValue[PAYLOAD_VALUE_LEN];
        int32_t iValue[PAYLOAD_VALUE_LEN];
        float fValue[PAYLOAD_VALUE_LEN];
    } payload;            // payload info for marker
    uint64_t startTime;
    uint64_t endTime;
    uint64_t markId;
    uint64_t domain;
    int32_t messageType;
    char message[MAX_MESSAGE_LEN];
};

#define MSPROF_TX_VALUE_MAX_LEN 224 // 224 + 8 = 232: additional data len
struct MsprofTxInfo {
    uint16_t infoType; // 0: Mark; 1: MarkEx
    uint16_t res0;
    uint32_t res1;
    union {
        struct MsprofStampInfo stampInfo;
        uint8_t data[MSPROF_TX_VALUE_MAX_LEN];
    } value;
};

struct MsprofStaticOpMem {
    int64_t size;        // op memory size
    uint64_t opName;     // op name hash id
    uint64_t lifeStart;  // serial number of op memory used
    uint64_t lifeEnd;    // serial number of op memory used
    uint64_t totalAllocateMemory; // static graph total allocate memory
    uint64_t dynOpName;  // 0: invalid， other： dynamic op name of root
    uint32_t graphId;    // multipe model
};

#define MSPROF_PHYSIC_STREAM_ID_MAX_NUM 56
struct MsprofLogicStreamInfo {
    uint32_t logicStreamId;
    uint32_t physicStreamNum;
    uint32_t physicStreamId[MSPROF_PHYSIC_STREAM_ID_MAX_NUM];
};

struct MsprofExeomLoadInfo {
    uint32_t modelId;
    uint32_t reserve;
    uint64_t modelName; /* name hash */
};
#pragma pack()

#define MSPROF_ENGINE_MAX_TAG_LEN (63)

/**
 * @name  ReporterData
 * @brief struct of data to report
 */
struct ReporterData {
    char tag[MSPROF_ENGINE_MAX_TAG_LEN + 1];  // the sub-type of the module, data with different tag will be writen
    int32_t deviceId;                         // the index of device
    size_t dataLen;                           // the length of send data
    uint8_t *data;                            // the data content
};

/**
 * @name  MsprofHashData
 * @brief struct of data to hash
 */
struct MsprofHashData {
    int32_t deviceId;                         // the index of device
    size_t dataLen;                           // the length of data
    uint8_t *data;                            // the data content
    uint64_t hashId;                          // the id of hashed data
};

enum MsprofConfigParamType {
    DEV_CHANNEL_RESOURCE = 0,          // device channel resource
    HELPER_HOST_SERVER                 // helper host server
};

/**
 * @name  MsprofConfigParam
 * @brief struct of set config
 */
struct MsprofConfigParam {
    uint32_t deviceId;                        // the index of device
    uint32_t type;                            // DEV_CHANNEL_RESOURCE; HELPER_HOST_SERVER
    uint32_t value;                           // DEV_CHANNEL_RESOURCE: 1 off; HELPER_HOST_SERVER: 1 on
};

/**
 * @name  MsprofReporterModuleId
 * @brief module id of data to report
 */
enum MsprofReporterModuleId {
    MSPROF_MODULE_DATA_PREPROCESS = 0,    // DATA_PREPROCESS
    MSPROF_MODULE_HCCL,                   // HCCL
    MSPROF_MODULE_ACL,                    // AclModule
    MSPROF_MODULE_FRAMEWORK,              // Framework
    MSPROF_MODULE_RUNTIME,                // runtime
    MSPROF_MODULE_MSPROF                  // msprofTx
};

/**
 * @name  MsprofReporterCallbackType
 * @brief reporter callback request type
 */
enum MsprofReporterCallbackType {
    MSPROF_REPORTER_REPORT = 0,           // report data
    MSPROF_REPORTER_INIT,                 // init reporter
    MSPROF_REPORTER_UNINIT,               // uninit reporter
    MSPROF_REPORTER_DATA_MAX_LEN,         // data max length for calling report callback
    MSPROF_REPORTER_HASH                  // hash data to id
};

enum MsprofConfigType {
    MSPROF_CONFIG_HELPER_HOST = 0
};

/**
 * @brief   Prof Chip ID
 */
enum Prof_Chip_ID {
    PROF_CHIP_ID0 = 0
};

/**
 * @brief  the struct of profiling set setp info
 */
typedef struct ProfStepInfoCmd {
    uint64_t index_id;
    uint16_t tag_id;
    void *stream;
} ProfStepInfoCmd_t;

enum RawDataType {
    API_DATA_TYPE = 0,
    EVENT_DATA_TYPE = 1,
    RUNTIMETRACK_DATA_TYPE = 3,
    PMU_DATA_TYPE = 4,
    DEFAULT_DATA_TYPE = 5
};

#define RAW_DATA_MAXSIZE (256)

typedef struct {
    bool isLastChunk;
    size_t offset;
    int32_t chunkModule;
    int32_t deviceId;
    enum RawDataType type;
    size_t chunkSize;
    char chunk[RAW_DATA_MAXSIZE];
} MsprofRawData;

typedef int32_t(*MsprofRawDataCallback)(MsprofRawData* rawData);

#ifdef __cplusplus
}
#endif
#endif  // MSPROFILER_PROF_COMMON_H_
