/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_HPP__
#define __CCE_RUNTIME_TASK_HPP__
#include <condition_variable>
#include "base.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "starsv2_sqe_info.hpp"
#include "error_message_manage.hpp"
#include "task_allocator.hpp"

namespace cce {
namespace runtime {
#define RTS_BUFF_ASSING_NUM (64U) // 64字节对齐
/**
* @ingroup
* @brief the struct define of report msg when task is completed
*/
struct tagTsTaskReportMsg {
    uint16_t SOP : 1; /* start of packet, indicates this is the first 32bit return payload */
    uint16_t MOP : 1; /* middle of packet, indicates the payload is a continuation of previous task return payload */
    uint16_t EOP : 1; /* *<end of packet, indicates this is the last 32bit return payload.
                     SOP & EOP can appear in the same packet, MOP & EOP can also appear on the same packet. */
    uint16_t packageType : 3;
    uint16_t streamID : 10;
    uint16_t taskID;
    uint32_t payLoad;
    uint16_t SQ_id : 9;
    uint16_t reserved : 6;
    uint16_t phase : 1;
    uint16_t SQ_head : 14;
    uint16_t streamIDEx : 1; /* streamID high bit */
    uint16_t faultStreamIDEx : 1; /* fault streamID high bit */
};

static inline uint8_t GetStarsDefinedErrCode(const uint8_t errorType)
{
    return errorType & RT_STARS_EXIST_ERROR;
}

// for aic/aiv op
std::string GetTaskKernelName(const TaskInfo *task);

enum tsReportType_t {
    TS_REPORT_MSG_TYPE_TS_REPORT = 0,
    TS_REPORT_MSG_TYPE_STARS_CQE,
    TS_REPORT_MSG_TYPE_BUTT
};

typedef union tagReportBuf {
    rtTaskReport_t *tsReport;
    rtStarsCqe_t *starsCqe;
} tsReportBuf_t;

struct tagTsReportMsg {
    tsReportType_t msgType;
    tsReportBuf_t msgBuf;
};

// allloc buffer form driver
union tagTsCmdSqBuf {
    rtCommand_t cmd;
    rtStarsSqe_t starsSqe;
};

union tagTsCommandBuf {
    rtCommand_t cmd;          // to ts module
    union {
        rtStarsSqe_t starsSqe[SQE_NUM_PER_STARS_TASK_MAX]; // STARS sqe format, to stars directly
        rtStarsV2Sqe_t starsv2Sqe[SQE_NUM_PER_STARSV2_TASK_MAX]; // STARS sqe format, to stars directly
    } u;
};

enum rtTaskCommandType {
    RT_TASK_COMMAND_TYPE_TS_COMMAND = 0, // ts module command format
    RT_TASK_COMMAND_TYPE_STARS_SQE,  // STARS(System Task and Resource Scheduler) sqe format
    RT_TASK_COMMAND_TYPE_BUTT
};

// task schedule format union
struct tagTaskTsCommand {
    rtTaskCommandType cmdType;
    rtTsCommandBuf_t cmdBuf;
};

typedef struct tagTsHostFuncCqReportMsg {
    volatile uint16_t phase      : 1;
    volatile uint16_t SOP        : 1;
    volatile uint16_t MOP        : 1;
    volatile uint16_t EOP        : 1;
    volatile uint16_t cqId       : 12; /* block flag */
    volatile uint16_t streamId ;
    volatile uint16_t taskId;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t sequenceId;
    volatile uint8_t isBlock;
    volatile uint8_t reserved1;
    volatile uint16_t eventId;
    volatile uint64_t hostFuncCbPtr;
    volatile uint64_t fnDataPtr;
} rtHostFuncCqReport_t;

typedef struct tagTsHostFuncSqSendMsg {
    uint16_t phase : 1;
    uint16_t SOP : 1;
    uint16_t MOP : 1;
    uint16_t EOP : 1;
    uint16_t reserved : 12;
    uint16_t streamId;
    uint16_t taskId;
    uint16_t cqId;
    uint16_t cqTail;
    uint16_t sequenceId;
    uint32_t reserved1[13];
} rtHostFuncSqCommand_t;

typedef struct tagTsHostFuncRecordSendMsg {
    uint32_t pid;
    uint8_t cmdType;
    uint8_t vfId;
    uint8_t tid;
    uint8_t tsId;
    uint16_t streamId;
    uint16_t recordId;
    uint16_t taskId;
    uint16_t reserved;
    uint32_t reserved1[12];
} rtHostFuncRecordCommand_t;

struct tagTsHostFuncSendMsg{
    union {
        rtHostFuncSqCommand_t sq_send_msg;
        rtHostFuncRecordCommand_t record_msg;
    } u;
};

/**
 * @ingroup engine
 * @brief the type defination of logic cq (total 16 bytes).
 */
typedef struct tagTsLogicCqReportMsg {
    volatile uint16_t phase      : 1;
    volatile uint16_t SOP        : 1; /* start of packet, indicates this is the first 32bit return payload */
    volatile uint16_t MOP        : 1; /* middle of packet, indicates the payload is a continuation of previous task
                                         return payload */
    volatile uint16_t EOP        : 1; /* end of packet, indicates this is the last 32bit return payload. SOP & EOP
                                         can appear in the same packet, MOP & EOP can also appear on the same packet. */
    volatile uint16_t logicCqId  : 12;
    volatile uint16_t streamId;
    volatile uint16_t taskId;
    volatile uint8_t logicCqType;
    volatile uint8_t reserved0;
    volatile uint32_t errorCode;
    volatile uint32_t payLoad;    // ((faultTaskId & 0x0000ffff) << 16) | (faultStreamId & 0x0000ffff)
} rtLogicReport_t;

typedef enum tagTsLogicCqType {
    LOGIC_RPT_SUCCESS = 0,
    LOGIC_RPT_TERMINAL = 1,
    LOGIC_RPT_TASK_ERROR = 2,
    LOGIC_RPT_MODEL_ERROR = 3,
    LOGIC_RPT_TSCH_VERSION = 4,
    LOGIC_RPT_OVERFLOW_ERROR = 5,
    LOGIC_RPT_EVENT_DESTROY = 6,
    LOGIC_RPT_BLOCKING_OPERATOR = 7,
    LOGIC_RPT_AICPU_ERR_MSG_REPORT = 8
} tsLogicCqType;

/**
 * @ingroup engine
 * @brief the type defination of virtual sq shm (total 32 bytes).
 */
typedef struct tagTsShmTaskMsg {
    volatile uint32_t taskId;       // execute position
    volatile uint32_t firstErrorCode;   // first error code
    volatile uint32_t taskId1;      // first error task
    volatile uint32_t lastErrorCode;   // last error code
    volatile uint32_t taskId2;      // last error task
    volatile uint32_t payLoad;
    volatile uint32_t payLoad2;
    volatile uint32_t valid;
} rtShmQuery_t;

struct rtStarsLocalMemoryParam_t {
    uint8_t coreType;
    uint8_t reserve;
    uint16_t coreId;
    rtDebugMemoryType_t debugMemType; // 当前枚举取值和ts侧相同
    uint32_t elementSize;
    uint32_t reserved;
    uint64_t srcAddr;
    uint64_t dstAddr;
    uint64_t memLen;
};

enum RtDebugCmdType {
    SET_DEBUG_MODE = 15,
    GET_STALLED_AICINFO_BY_PID = 16,
    READ_REGISTER_BY_CURPROCESS = 17,
    READ_LOCAL_MEMORY_BY_CURPROCESS = 18,
    RELEASE_COREDUMP_MEMORY = 19,
};

struct RtDebugSendInfo {
    RtDebugCmdType reqId;
    uint8_t isReturn;
    uint8_t reserved[3];
    uint32_t msgId; // 暂时没有使用
    uint32_t dataLen;
    uint8_t params[48];
};

struct rtDebugReportInfo_t {
    uint8_t phase;
    uint8_t reserved1[3];
    uint16_t sqIndex;
    uint16_t sqHead;
    uint32_t cmdType;
    uint32_t returnVal;
    uint32_t msgId;
    uint8_t data[44];
};

// Factory class for task alloc and recycle.
class TaskFactory : public NoCopy {
public:
    enum {
        INIT_TASK_CAPACITY = 1024
    };

    TaskFactory(Device * const dev);
    ~TaskFactory() override;

    rtError_t Init();
    static uint32_t GetTaskMaxSize();

    TaskInfo* Alloc(Stream *stream, tsTaskType_t taskType, rtError_t &errCode);

    void SetSerialId(const Stream *const streamPtr, TaskInfo *const taskPtr);

    void ClearSerialVecId(const Stream *const streamPtr);

    void FreeStreamRes(const int32_t streamId);

    int32_t Recycle(TaskInfo *const taskPtr);

    TaskInfo *GetTask(const int32_t streamId, const uint16_t id);

    int32_t TryAgainAlloc(Stream *const streamPtr, rtError_t &errCode);
    void TryTaskReclaim(Stream *const streamPtr) const;
    TaskAllocator *GetAllocator() const
    {
        return allocator_;
    }

private:
    TaskAllocator *allocator_;
    // notify to alloc
    std::condition_variable allocRetry_;
    std::mutex allocRetryMutex_;
    // for exiting to retry
    std::atomic<bool> exitFlag_;
    // for safe destructor
    std::atomic<uint64_t> retryCount_;
    Device *device_;
};

}
}
#endif  // __CCE_RUNTIME_TASK_HPP__
