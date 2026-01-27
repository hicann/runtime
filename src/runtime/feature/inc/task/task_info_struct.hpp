/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_INFO_STRUCT_HPP
#define CCE_RUNTIME_TASK_INFO_STRUCT_HPP

#include "dev.h"
#include "task_info_base.hpp"

#define THREAD_FOR_PRE_LOAD (30U)

namespace cce {
namespace runtime {

class Notify;
class CountNotify;
class Event;
class IpcEvent;
class Program;
class Model;
class Driver;
class ArgLoader;

struct CmoAddrTaskInfo {
    void *src;
    void *cmoAddrInfo;
    uint32_t lenInner;
    uint16_t numOuter;
	uint16_t numInner;
	uint32_t strideOuter;
    uint32_t strideInner;
    uint8_t cmoOpCode;
};

struct ReduceAsyncV2TaskInfo {
    void *src;
    void *destPtr;
    void *overflowAddr;
    std::vector<std::shared_ptr<void>> *guardMemVec;
    uint64_t size;
    uint32_t copyType;
    uint32_t copyKind;
    uint64_t overflowAddrOffset;
    uint8_t copyDataType;
};

struct EventRecordTaskInfo {
    Event *event;
    uint64_t timelineBase;   // valid when flag bit 0 set, otherwise set to MAX.
    uint64_t timestamp;
    uint32_t timelineOffset; // offset of timeline
    int32_t eventid;
    int32_t timeout; // for stream sync timeout
    uint16_t waitCqId;
    bool isNotifyRecord;
    bool waitCqflag;
};

struct EventResetTaskInfo {
    Event *event;
    int32_t eventid;
    bool isNotify;
};

struct RemoteEventWaitTaskInfo {
    Event *event;
    uint64_t srcMailboxPa;
    uint64_t srcDoorbellPa;
    uint64_t dstDoorbellPa;
    int32_t eventId;
    int32_t srcDevId;
    int32_t dstDevId;
    uint8_t channelType;
};

struct EventWaitTaskInfo {
    Event *event;
    int32_t eventId;
    uint32_t timeout; // used only for 51 pg1
    uint8_t eventWaitFlag; // 0: event wait(default), 1: notify wait
};

struct DavidEventRecordTaskInfo {
    Event *event;
    uint64_t timestamp;
    int32_t eventId;
    int32_t timeout; // for stream sync timeout
    uint32_t isCountNotify;
    uint32_t countValue;
};

struct DavidEventResetTaskInfo {
    Event *event;
    int32_t eventId;
    uint32_t isCountNotify;
};

struct DavidEventWaitTaskInfo {
    Event *event;
    int32_t eventId;
    uint32_t timeout;
    uint32_t isCountNotify;
    uint32_t countValue;
};

struct MaintenanceTaskInfo {
    MtType mtType;
    uint32_t mtId;
    uint32_t mtIdType;
    uint16_t waitCqId;
    bool flag; // take effect when goal(MtType) is recycle task
};

struct CreateStreamTaskInfo {
    uint32_t streamAttr;
};

struct CreateL2AddrTaskInfo {
    uint64_t ptePA;
};

struct KernelFusionTaskInfo {
    FusionFlag flag;
};

struct ProfilingEnableTaskInfo {
    uint8_t eventMuxConfig[M_PROF_EVEID_NUM];
    uint64_t pid;
    uint64_t startCycle;
    uint64_t stopCycle;
    uint8_t userDefinedEnable;
    uint8_t isRtsProfEn : 1;
    uint8_t isTaskBasedProfEn : 1;
    uint8_t isProfLogEn : 1;
    uint8_t isHwtsLogEn : 1;
    uint8_t reserved : 4; // reserved 4 bits
};

struct AllocDsaAddrInfoTaskInfo {
    uint16_t sqId;
    uint16_t rev;
};

struct ProfilingDisableTaskInfo {
    uint64_t pid;
    uint8_t isRtsProfEn;
    uint8_t isTaskBasedProfEn;
    uint8_t isProfLogEn;
    uint8_t isHwtsLogEn;
};

struct OnlineProfEnableTaskInfo {
    uint64_t onlineProfAddr;
};

struct OnlineProfDisableTaskInfo {
    uint64_t onlineProfAddr;
};

struct AdcProfTaskInfo {
    uint64_t addr;
    uint32_t length;
};

struct PCTraceTaskInfo {
    uint64_t pctraceAddr;
    uint16_t enableTaskID;
    uint16_t coreDim;
};

struct ModelMaintainceTaskInfo {
    Stream *opStream;
    Model *model;
    uint64_t execTimesSvmOffset;
    MmtType type;
    uint32_t streamType;
    uint32_t firstTaskId;
};

struct ModelExecuteTaskInfo {
    Model *model;
    uint32_t modelId;
    uint32_t firstTaskId;
    uint32_t errorTaskId;
    uint32_t errorStreamId;
};

// DebugUnRegisterForStreamTask
struct DebugUnRegForStreamTaskInfo {
    uint32_t streamId;
};

// AddEndGraphTask
struct ModelEndGraphTaskInfo {
    uint64_t argptr;
    uint64_t endGraphNamePtr;
    uint32_t modelId;
    uint32_t executorFlag;
    uint8_t datadumpFlag;
};

// AddModelExitTask
struct ModelExitTaskInfo {
    uint32_t modelId;
    uint32_t streamId;
};

// ModelToAicpuTask
struct ModelToAicpuTaskInfo {
    uint64_t modelArgPtr;
    uint32_t modelId;
    uint32_t cmdType;
    uint32_t executorFlag;
};

// ActiveAicpuStreamTask
struct ActiveAicpuStreamTaskInfo {
    uint64_t args;
    uint64_t funcName;
    uint32_t kernelType;
    uint32_t argsSize;
};

// CallbackLaunchTask
struct CallbackLaunchTaskInfo {
    void *fnData;
    rtCallback_t callBackFunc; // 定义在kernel.h中
    int32_t eventId;
    bool isBlock;
};

// StreamLabelGotoTask
struct StreamLabelGotoTaskInfo {
    uint16_t labelId;
};

// FftsPlusTask
struct FftsPlusTaskInfo {
    void *descBuf;         // device memory
    void *descAlignBuf;
    void *argHandle;
    std::vector<rtFftsPlusTaskErrInfo_t> *errInfo;
    rtFftsPlusSqe_t fftsSqe; // 在rt_stars_define.h中定义
    uint64_t descBufLen;
    uint64_t loadDumpInfo;
    uint64_t unloadDumpInfo;
    uint32_t loadDumpInfoLen;
    uint32_t unloadDumpInfoLen;
    uint32_t argsHandleInfoNum;
    std::vector<void *> *argsHandleInfoPtr;
    uint8_t kernelFlag;
    rtArgsSizeInfo_t inputArgsSize;
};

// NpuGetFloatStatusTask
struct NpuGetFloatStatusTaskInfo {
    void *outputAddrPtr; // the second rank pointer to output data
    uint64_t outputSize;
    uint32_t checkMode;
    bool debugFlag;
};

// NpuClearFloatStatusTask
struct NpuClearFloatStatusTaskInfo {
    uint32_t checkMode;
    bool debugFlag;
};

// OverflowSwitchSetTask
struct OverflowSwitchSetTaskInfo {
    Stream *targetStm;
    bool switchFlag;
};

// StreamTagSetTask
struct StreamTagSetTaskInfo {
    Stream *targetStm;
    uint32_t geOpTag;
};

// RingBufferMaintainTask
struct RingBufferMaintainTaskInfo {
    void *deviceRingBufferAddr;
    uint32_t bufferLen;
    bool deleteFlag;
};

// WriteValueTask
struct WriteValueTaskInfo {
    uint8_t value[WRITE_VALUE_SIZE_MAX_LEN];
    uint64_t addr;
    WriteValueSize awSize;
    TaskWrCqeFlag cqeFlag;
    uint32_t ptrFlag;
    uint64_t sqeAddr;
};

// CmoTask
struct CmoTaskInfo {
    rtCmoTaskInfo_t cmoSqeInfo; // rt_stars_define.h
    uint16_t cmoid;
};

// BarrierTask
struct BarrierTaskInfo {
    rtBarrierTaskMsg_t barrierMsg;
};

// SetStreamModeTask
struct SetStreamModeTaskInfo {
    uint64_t mode;
};

struct SingleBitNotifyRecordInfo {
    bool isIpc;
    bool isPcie;
    bool lastIsPcie;
    bool isPod;
    uint32_t lastLocalId;
    uint64_t lastBaseAddr;
    bool isNotifyReset;
};

struct NotifyRecordTaskInfo {
    uint64_t timestamp;
    uint32_t notifyId;
    uint32_t deviceId;
    uint32_t phyId;
    union {
        SingleBitNotifyRecordInfo singleBitNtfyInfo;
        rtCntNtyRecordInfo_t countNtfyInfo;
    } uInfo;
    union {
        Notify *notify;
        CountNotify *countNotify;
    } uPtr;
    bool isCountNotify;
};

struct CountNotifyWaitInfo {
    rtCntNotifyWaitMode_t mode;
    uint32_t value;
    bool isClear;
};

struct NotifyWaitTaskInfo {
    union {
        Notify *notify;
        CountNotify *countNotify;
    } u;
    uint64_t timestamp;
    uint32_t notifyId;
    uint32_t timeout;
    bool isCountNotify;
    bool isEndGraphNotify;
    Model* captureModel;
    CountNotifyWaitInfo cntNtfyInfo;
};

struct LabelSetTaskInfo {
    void *devDstAddr;
    uint16_t labelId;
};

struct LabelSwitchTaskInfo {
    uint64_t pptr;
    uint32_t condition;
    uint32_t value;
    uint16_t trueLabelId;
};

struct LabelGotoTaskInfo {
    uint16_t labelId;
};

struct ProfilerTraceTaskInfo {
    uint64_t profilerTraceId;
    uint8_t notify;
};

struct ProfilerTraceExTaskInfo {
    uint64_t profilerTraceId;
    uint64_t modelId;
    uint16_t tagId;
};

struct FusionDumpAddrSetTaskInfo {
    uint64_t addr;
    uint64_t combAddr;
    uint32_t dumpSize;
    uint32_t modelId;
    uint8_t flag;
};

struct DataDumpLoadInfoTaskInfo {
    uint64_t dumpInfo;
    uint32_t length;
    uint16_t kernelType;
};

struct AicpuInfoLoadTaskInfo {
    uint64_t aicpuInfo;
    uint32_t length;
};

struct DebugRegisterTaskInfo {
    uint64_t addr;
    uint32_t modelId;
    uint32_t flag;
};

struct DebugUnRegisterTaskInfo {
    uint32_t modelId;
};

struct TimeoutSetTaskInfo {
    uint32_t opWaitTimeout;
    uint32_t opExecuteTimeout;
    bool opWaitTimeoutEn;
    bool opExecuteTimeoutEn;
};

struct GetDevMsgTaskInfo {
    void *devMem;
    uint64_t offset;
    uint32_t msgBufferLen;
    rtGetDevMsgType_t msgType;
};

struct DebugRegisterForStreamTaskInfo {
    uint64_t addr;
    uint32_t streamId;
    uint32_t flag;
};

struct FlipTaskInfo {
    uint16_t flipNumReport;
};

// Add place holder sq lock/unlock task info.
struct SqLockUnlockTaskInfo {
    uint8_t sqLock;
    uint8_t sqUnlock;
};

struct UpdateAddressTaskInfo {
    uint64_t devAddr;
    uint64_t len;
};

struct MdlUpdateTaskInfo {
    uint16_t desStreamId;
    uint16_t exeStreamId;
    uint32_t destaskId;
    void *prgHandle;
    uint64_t descBufOffset;
    uint64_t fftsPlusSqeOffset;
    uint64_t tilingKeyOffset;
    uint64_t blockDimOffset;
    uint64_t tilingTabOffset;
    void *tilingTabAddr;
    uint32_t tilingTabLen;
    void *fftsPlusTaskDescBuf;
    void *blockDimAddr;
    void *tilingKeyAddr;
};

struct MemWriteValueTaskInfo {
    Event *event;
    uint64_t devAddr;
    uint64_t value;
    uint16_t curIndex;
    uint16_t awSize;
};

}
}
#endif  // CCE_RUNTIME_TASK_INFO_STRUCT_HPP