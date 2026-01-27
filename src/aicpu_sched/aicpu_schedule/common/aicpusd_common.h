/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_COMMON_H
#define AICPUSD_COMMON_H

#include <sched.h>
#include <sys/types.h>
#include <map>
#include <vector>
#include "aicpu_msg.h"
#include "task_scheduler_error.h"
#include "rt_model.h"
#include "ascend_hal.h"

namespace AicpuSchedule {
#define AICPU_VISIBILITY __attribute__((visibility("default")))

using char_t = char;
using float32_t = float;
using float64_t = double;

using AicpuTaskInfo = rtAicpuTaskInfo_t;
using StreamInfo = rtModelStreamInfo_t;
using AicpuModelInfo = rtAicpuModelInfo_t;
using QueInfo = rtModelQueueInfo_t;
using TsAicpuModelOperate = ts_aicpu_model_operate_t;
using TsAicpuModelOperateMsg = ts_aicpu_model_operate_msg_t;
using TsAicpuMsgVersion =  ts_aicpu_msg_version_t;
using TsToAicpuTaskReport = ts_to_aicpu_task_report_t;
using TsToAicpuTaskReportMsg  = ts_to_aicpu_task_report_msg_t;
using TsAicpuNotify = ts_aicpu_notify_t;
using TsAicpuSqe = ts_aicpu_sqe_t; // v0
using TsAicpuMsgInfo = ts_aicpu_msg_info_t; // v1
using TsToAicpuDataDump = ts_to_aicpu_datadump_t;
using TsToAicpuNormalDataDumpMsg = ts_to_aicpu_normal_datadump_msg_t;
using TsToAicpuDebugDataDumpMsg =  ts_to_aicpu_debug_datadump_msg_t;
using TsToAicpuDataDumpInfoLoad = ts_to_aicpu_datadumploadinfo_t;
using TsToAicpuDataDumpInfoloadMsg = ts_to_aicpu_datadump_info_load_msg_t;
using TsAicpuResponseMsg =  ts_aicpu_response_msg_t;
using TsToAicpuFFTSPlusDataDump = ts_to_aicpu_ffts_plus_datadump_t;
using TsToAicpuTimeOutConfig =  ts_to_aicpu_timeout_config_t;
using TsToAicpuInfoLoad =  ts_to_aicpu_loadinfo_t;
using TsToAicpuInfoLoadMsg  =  ts_to_aicpu_info_load_msg_t;
using TsToAicpuAicErrReport = ts_to_aicpu_aic_err_report_t;
using TsToAicpuAicErrMsgReport = ts_to_aicpu_aic_err_msg_t;


struct RunContext {
    const uint32_t modelId;
    const uint32_t modelTsId;
    uint32_t streamId;
    bool pending;
    const bool executeInline;
    int32_t gotoTaskIndex;
};

#ifdef MODELID_EXT
// max model count: model id is 0-32767
constexpr uint32_t MAX_MODEL_COUNT = 32768U;
// max notify count
constexpr uint32_t MAX_NOTIFY_COUNT = 2048U;
// default queue count
constexpr uint32_t DEFAULT_QUEUE_COUNT = 8U * 2048U;
#else
// max model count: model id is 0-1023
constexpr uint32_t MAX_MODEL_COUNT = 1024U;
// max notify count
constexpr uint32_t MAX_NOTIFY_COUNT = 1024U;
// default queue count
constexpr uint32_t DEFAULT_QUEUE_COUNT = 8U * 1024U;
#endif

constexpr uint32_t CP_DEFAULT_GROUP_ID = 0U;

// stream flag: aicpu stream
constexpr uint32_t AICPU_STREAM_INDEX = 0x08U;
// stream flag: head stream
constexpr uint32_t HEAD_STREAM_INDEX = 0x20U;

// invalid number
constexpr uint32_t INVALID_NUMBER = 0xffffffffU;

constexpr uint32_t MAX_DUMP_STEP_STR = 1024U;
constexpr uint32_t MAX_MARK_STEP_RESERVE = 30U;

constexpr uint32_t MAX_REMOTE_COMMON_TASK_BUFF_LEN = 8U;
constexpr uint32_t MAX_SAVE_TASK_BUFF_LEN = 2U;

#define VM_QOS_PROCESS_STARTUP    _IOW('Q', 0x0, int32_t) // 'Q' is a magic number
#define VM_QOS_PROCESS_SUSPEND    _IOW('Q', 0x1, int32_t)
struct VfMsgInfo {
    uint32_t deviceId;
    uint32_t vfId;
};

struct AddrMapInfo {
    uint32_t addrNum;
    uint64_t srcAddrList;
    uint64_t dstAddrList;
};

struct AddrMapInfoV2 {
    uint32_t addrNum;
    uint64_t srcAddrList;
    uint64_t dstAddrList;
    uint64_t isNoTilingList;
    uint32_t len;
    char_t extendInfo[0];
};

struct InputCopyAddrMapInfo {
    uint32_t addrNum;
    uint64_t srcAddrList; // The pointers to pointers of mbuf
    uint64_t dstAddrList; // The pointers of data
    uint64_t dstAddrLenList;
    uint64_t srcFusionOffsetList;
};

struct AICPUESchedSubmitEvent {
    uint32_t deviceId;
    uint32_t modelId;
    uint32_t streamId;
    struct event_summary summary;
};

struct AICPUTsDevSendMsgAsync {
    uint32_t deviceId;
    uint32_t tsId;
    uint32_t modelId;
    TsAicpuSqe sqe;
    TsAicpuMsgInfo msgInfo;
    bool useSqe;
};

enum class AICPUSendType {
    SCHED_SUBMIT = 0,
    TS_DEV_SEND = 1,
    NO_NEED_SEND = 2,
};

enum class TSIDFlag {
    HW_TS_0 = 0,
    HW_TS_1 = 1,
    AICPU_SCHEDULE_TS_ID = 2,
};

enum class QueueDirectionFlag {
    QUEUE_INPUT_FLAG = 0,
    QUEUE_OUTPUT_FLAG = 1,
    QUEUE_CLIENT_INPUT_FLAG = 2,
    QUEUE_CLIENT_OUTPUT_FLAG = 3,
};

enum class AicpuKernelType {
    CCE_KERNEL = 0,
    FWK_KERNEL = 1,
    CCE_KERNEL_HWTS = 2,
};

struct AicpuPrepareInfo {
    uint32_t aicpuPareInfoSize; // for compare with sizeof(AicpuPareInfo)
    uint32_t modelId;           // modelId

    uint32_t inputAddrNum;      // the address number for model input
    uint64_t inputAddrList;     // the address list of data pointers for model input
    uint64_t inputIndexList;    // the index list for mbuf data pointers to copy to inputAddrList sequential
                                // use as this: mbufDataPtrs[inputIndexList[N] copy to inputAddrList[N]

    uint32_t outputAddrNum;     // the address number for model output
    uint64_t outputAddrList;    // the address list of data pointers for model output
    uint64_t outputIndexList;   // the index list for mbuf data pointers to copy to outputAddrList sequential
    uint32_t outputMbufNum;     // the number of mbuf for model ouput
    uint64_t outDataSizeList;   // the size list of mbuf allocated for model output

    uint32_t inQueueNum;        // queue number of queue in the inQueueIdList
    uint64_t inQueueIdList;     // input data queue id list
    uint32_t outQueueNum;       // queue number of queue in the outQueueIdList
    uint64_t outQueueIdList;    // output data queue id list
    uint64_t mbufPtrlist;       // mbuflist pointers array
};

using AicpuPostpareInfo = AicpuPrepareInfo;

struct ModelPrepareData {
    uint32_t dequeueIndex;
    void *lastInputMbuflistPtr;
};

struct ModelPostpareData {
    uint32_t enqueueIndex;
};

struct BufEnQueueInfo {
    uint32_t queueID;          // 算子的输入，队列id，由模型编译时填入
    uint64_t mBufPtr;          // 一个二级指针，指向Mbuf的指针
};

struct QueueAttrs {
    uint32_t queueId;
    int32_t deviceType; // CPU NPU
    int32_t deviceId;
    uint32_t logicId {0U};
};

struct ReportStatusInfo {
    uint32_t modelUuid;           // model instance uuid
    QueueAttrs statusOutputQueue; // queue for report status
    uint32_t inputNum;            // num of input
};

struct MarkStepInfo {
    uint32_t groupTotalCount;
    uint32_t groupIndex;
    uint32_t dataGwRule;  // gw策略，当前固定取枚举值0，方便后续扩展
    uint64_t stepIdAddr;
    uint64_t reserv0; // 兼容性原因：新CANN+老Driver无法解决CheckMarkStepPara报错，因此第一个预留
    uint8_t headFlag; // 1 not is head flag, 0 is head flag
    uint64_t reserved[MAX_MARK_STEP_RESERVE];
    char_t dumpStep[MAX_DUMP_STEP_STR];
};

struct ProcessOutputInfo {
    uint32_t dataSize;        // 输入，需要outputTensor内存大小
    uint64_t srcPtr;          // 输入，一个二级指针，模型outputTensor地址
    uint64_t inMBuf;          // 输入，buff指针，用于获取header填充输出buff的头部
    uint64_t outMBuf;         // 输出，申请的输出数据buff指针
};

enum class ThreadStatus {
    THREAD_INIT = 0,
    THREAD_RUNNING = 1,
    THREAD_EXIT = 2,
};

enum class AicpuPlat {
    AICPU_ONLINE_PLAT = 0,
    AICPU_OFFLINE_PLAT,
    AICPU_MAX_PLAT,
};

// attention: if change define or oder, pls update AicpuModel::modelOperatePermission
// and AicpuModel::operateNextStatus table together.
enum class AicpuModelOperate {
    MODEL_OPERATE_LOAD = 0,
    MODEL_OPERATE_EXECUTE,
    MODEL_OPERATE_ABORT,
    MODEL_OPERATE_TASK_REPORT,
    MODEL_OPERATE_END_GRAPH,
    MODEL_OPERATE_RUN_TASK,
    MODEL_OPERATE_DESTROY,
    MODEL_OPERATE_STOP,
    MODEL_OPERATE_RESTART,
    MODEL_OPERATE_CLEAR_INPUT,
    MODEL_OPERATE_MAX
};

// attention: if change define or oder, pls update AicpuModel::modelOperatePermission
// and AicpuModel::operateNextStatus table together.
enum class AicpuModelStatus {
    MODEL_STATUS_UNINIT = 0,
    MODEL_STATUS_IDLE,
    MODEL_STATUS_LOADING, // The model is in loading status.
    MODEL_STATUS_RUNNING, // the model is in running status.
    MODEL_STATUS_ERROR,
    MODEL_STATUS_ABORT,
    MODEL_STATUS_STOPPED,
    MODEL_STATUS_MAX
};

enum class BindQueueInitStatus {
    UNINIT,
    INITING,
    INITED,
};

enum class CpType {
    MASTER,
    SLAVE
};

struct CallbackMsg {
    event_info event;
    Mbuf *buff;
};

struct BatchDequeueDesc {
    uint32_t inputNums;
    uint32_t alignInterval;
    uint64_t alignOffsetsAddr; // the address of uint32_t array which size is inputNums
    uint64_t queueIdsAddr; // the address of uint32_t array which size is inputNums
    uint64_t mbufAddrsAddr; // the address of uint64_t array which size is inputNums
};

struct BatchDequeueInfo {
    uint32_t inputNums;
    uint32_t alignInterval;
    uint32_t *alignOffsets; // the pointer of uint32_t array which size is inputNums
    uint32_t *queueIds; // the pointer of uint32_t array which size is inputNums
    uint64_t *mbufAddrs; // the pointer of uint64_t array which size is inputNums
};

constexpr size_t RESERVED_PARAMS_NUM = 128U;
struct PrepareMemTaskParam {
    uint32_t modelId;            // model id
    uint64_t inBuffSize;        // input buffer size
    uint64_t outBuffSize;       // output buffer size
    uint32_t inBuffNum;         // in buff num
    uint32_t outBuffNum;        // out buff num
    uint64_t inBuffPtr;         // input buffer(mbuf) secondary pointer
    uint64_t outBuffPtr;        // output buffer(mbuf) secondary pointer
    uint64_t reserved[RESERVED_PARAMS_NUM];
};

struct GetRemoteReqTaskParam {
    uint32_t modelId;             // model id
    uint64_t inBuffPtr;          // input buffer(mbuf) secondary pointer
    uint32_t inBuffNum;        // input buffer index
    bool syncFlag;                // sync flag (false: async, true: sync)
    uint64_t embeddingDim;
    uint64_t reserved[RESERVED_PARAMS_NUM - 1];
};

struct SetRemoteRespTaskParam {
    uint32_t modelId;             // model id
    uint64_t inBuffPtr;          // input buffer(mbuf) secondary pointer
    uint32_t inBuffNum;        // input buffer index
    uint64_t outBuffPtr;         // output buffer(mbuf) secondary pointer
    uint32_t outBuffNum;       // output buffer index
    bool syncFlag;                // sync flag (false: async, true: sync)
    uint64_t reserved[RESERVED_PARAMS_NUM];
};

struct StreamRepeatTaskParam {
    uint32_t modelId;             // model id
    uint32_t streamId;            // stream id
};

struct BatchSendRecvTaskParam {
    uint32_t modelId;
    uint32_t ioNum;
    int32_t flag;
    uint64_t hcomP2pOpList; // 指向输入输出的opdesc数组
    uint8_t reserved[16];
};

struct RemoteCommTaskParm {
    uint64_t hcomOpDescAddr;
    uint64_t buffAddr[MAX_REMOTE_COMMON_TASK_BUFF_LEN];
    uint32_t buffAddrLen;
};

struct GatherDequeParam {
    uint32_t inputNums;
    int32_t  inputsAlignTimeout; // 数据缓存超时清理时间，(单位ms), 配置-1永不超时
    uint32_t  inputsAlignMaxCacheNum; // 数据匹配最大缓存数量
    uint32_t inputsAlignDropout; // 当数据超过max_buf_num或超时后数据是否丢弃，默认为0, 非0值代表丢弃
    uint64_t queueIdsAddr; // 指向的数据类型uint32 the address of uint64_t array which size is inputNums
    uint64_t mbufAddrsAddr; // 指向的数据类型unitptr the address of uint64_t array which size is inputNums
    uint64_t deviceIdAddr; // 指向的数据类型uint32 ;
    uint64_t deviceTypeAddr; // 指向的数据类型uint32  0 NPU 1 CPU
};

struct LockTableTaskParam {
    int32_t lockType;  // 0:rdlock 1:rwlock
    uint32_t tableId;
};

struct UnlockTableTaskParam {
    uint32_t tableId;
};

// max dim size
constexpr int64_t MAX_DIM_SIZE = 32;

#pragma pack(push, 1)
struct RuntimeTensorDesc {
    uint64_t dataAddr;
    int64_t dataOffsetSize;
    int64_t dtype;
    int64_t shape[MAX_DIM_SIZE + 1]; // shape:Dim_Num|DIM0|DIM1|...|DIM31
    int64_t originalShape[MAX_DIM_SIZE + 1]; // original_shape:Dim_Num|DIM0|DIM1|...|DIM31
    int64_t format;
    int64_t subFormat;
    uint64_t dataSize;
    uint8_t reserved[448]; // padding to 1024 bytes
};

struct ModelConfigTensorDesc {
    int64_t dtype;
    int64_t shape[MAX_DIM_SIZE + 1];  // shape:Dim_Num|DIM0|DIM1|...|DIM31
};

struct PrepareDynamicInputOutputKernelArgs {
    uint32_t inputsNum;                 // inputs number
    uint32_t outputsNum;                // outputs number
    uint64_t inputDynamicFlagsAddr;   // address of uint32_t array witch size is inputs_num and value is dynamic flag
    uint64_t outputTensorSizesAddr;   // address of int64_t array witch size is outputs_num and value is tensor size
    uint64_t inputMbufAddrsAddr;      // address of uint64_t array witch size is inputs_num and value is mbuf addr
    uint64_t outputMbufAddrsAddr;     // address of uint64_t array witch size is outputs_num and value is mbuf addr
    uint64_t inputFusionOffsetsAddr;  // address of uint32_t array witch size is inputs_num and value is fusion offset
    uint64_t reqMsgMbufAddr;          // request message mbuf addr
};

struct PostprocessDynamicOutputKernelArgs {
    uint32_t inputsNum;                 // inputs number
    uint32_t outputsNum;                // outputs number
    uint64_t respMsgMbufAddr;         // response message mbuf addr
    uint64_t inputMbufAddrsAddr;      // address of uint64_t array witch size is inputs_num and value is mbuf addr,
    uint64_t outputMbufAddrsAddr;     // address of uint64_t array witch size is outputs_num and value is mbuf addr
    uint64_t outputDynamicFlagsAddr;  // address of uint32_t array witch size is outputs_num and value is dynamic flag
    uint64_t outputStaticTensorDescAddr;  // address of uint64_t array witch value is static output tensor desc and
                                          // size is static outputs num
};

struct ShapeValidation {
    uint64_t mbufAddrs;
    uint64_t offset;
    char_t rsv[16];
};

struct ShapeValidationInfo {
    uint64_t inputNums;
    uint64_t shapeValidationAddr;
};

struct BufEnQueueBuffInfo {
    uint32_t queueID;  // 算子的输入，队列id，由模型编译时填入
    int32_t deviceId;
    uint64_t mBufPtr;  // 一个二级指针，指向Mbuf的指针
};

struct BatchDequeueBuffDesc {
    uint32_t inputNums;
    uint32_t alignInterval;
    uint64_t alignOffsetsAddr; // the address of uint32_t array which size is inputNums
    uint64_t queueIdsAddr; // the address of uint32_t array which size is inputNums
    uint64_t mbufAddrsAddr; // the address of uint64_t array which size is inputNums
    uint64_t deviceIdAddr;
};

struct BatchDequeueBuffInfo {
    uint32_t inputNums;
    uint32_t alignInterval;
    uint32_t *alignOffsets; // the pointer of uint32_t array which size is inputNums
    uint32_t *queueIds; // the pointer of uint32_t array which size is inputNums
    uint64_t *mbufAddrs; // the pointer of uint64_t array which size is inputNums
    int32_t *deviceIds;
};

#pragma pack(pop)

constexpr uint32_t AICPU_TOPIC_USER_DATA_LEN = 10U;
struct AicpuTopicMailbox {
    // word 0
    uint8_t  mailboxId;
    uint32_t vfid : 6;
    uint16_t rspMode : 1;
    uint16_t satMode : 1;
    uint16_t blkDim;
    // word 1
    uint16_t streamId;
    uint16_t taskId;
    // word 2
    uint16_t blkId;
    uint16_t kernelType : 7;
    uint16_t batchMode : 1;
    uint32_t topicType : 4;
    uint32_t qos : 3;
    uint16_t res0 : 1;
    // word 3
    uint32_t pid;
    // word 4-13
    uint32_t userData[AICPU_TOPIC_USER_DATA_LEN];
    // word 14
    uint32_t subtopicId : 12;
    uint32_t topicId : 6;
    uint32_t gid : 6;
    uint8_t userDataLen : 8;
    // word 15
    uint16_t hacSn : 5;
    uint16_t res1 : 11;
    uint16_t tqId;
};
}
#endif

