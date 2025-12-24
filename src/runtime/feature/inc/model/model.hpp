/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_MODEL_HPP__
#define __CCE_RUNTIME_MODEL_HPP__

#include <list>
#include <vector>
#include <map>
#include <set>
#include "runtime/rt.h"
#include "base.hpp"
#include "driver.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {
class Stream;
class Context;
class Task;
class LabelAllocator;
class Label;
class Notify;
extern bool g_isAddrFlatDevice;
enum rtDevStringNameT : uint8_t {
    RT_DEV_STRING_ENDGRAPH,
    RT_DEV_STRING_ACTIVE_STREAM,
    RT_DEV_STRING_RESERVED
};

enum ModelType {
    RT_MODEL_NORMAL,      // normal model
    RT_MODEL_CAPTURE_MODEL,  // capture model
    RT_MODEL_MAX
};

constexpr int32_t MODEL_ID_INVALID = -1;
constexpr size_t MALLOC_DEV_NAME_STRING_MAX = 128U;

class Model : public NoCopy {
public:
    explicit Model(ModelType type = RT_MODEL_NORMAL);
    ~Model() noexcept override;
    enum ModelExecuteApiType : uint8_t {
        RT_MODEL_SYNC,
        RT_MODEL_ASYNC,
        RT_MODEL_RESERVED
    };

    rtError_t UpdateSnapShotSqe(void);
    rtError_t Setup(Context * const contextIn);
    rtError_t ReBuild(void);
    rtError_t SinkSqTasksBackup(void);

    virtual rtError_t TearDown();
    rtError_t ClearMemory();

    uint32_t Id_() const
    {
        return static_cast<uint32_t>(id_);
    }

    std::string GetName() const
    {
        return name_;
    }

    uint32_t LastStreamId_() const
    {
        return lastStreamId_;
    }

    uint32_t LastTaskId_() const
    {
        return kernelTaskId_;
    }

    void SetKernelTaskId(uint32_t kernelTaskId, int32_t streamId)
    {
        kernelTaskId_ = kernelTaskId;
        lastStreamId_ = static_cast<uint32_t>(streamId);
    }

    void PushbackArgHandle(const uint16_t streamId, const uint16_t taskId, void *argHandle)
    {
        if (argHandle != nullptr) {
            const uint32_t key = (streamId << 16U) | taskId;
            argLoaderRecord_[key] = argHandle;
        }
    }

    void *GetArgHandle(const uint16_t streamId, const uint16_t taskId) const
    {
        const uint32_t key = (streamId << 16U) | taskId;
        auto iter = argLoaderRecord_.find(key);
        if (iter != argLoaderRecord_.end()) {
            return iter->second;
        }
        return nullptr;
    }

    void ReplaceArgHandle(const uint16_t streamId, const uint16_t taskId, void *argHandle);

    void PushbackDmaAddr(struct DMA_ADDR &dmaAddr)
    {
        dmaAddrRecord_.push_back(dmaAddr);
    }

    bool NeedSubmitTask(void) const
    {
        return needSubmitTask_;
    }

    void SetNeedSubmitTask(bool needSubmitTask)
    {
        needSubmitTask_ = needSubmitTask;
    }

    bool IsDebugRegister(void) const
    {
        return isDebugRegister_;
    }

    void SetDebugRegister(bool isDebugRegister)
    {
        isDebugRegister_ = isDebugRegister;
    }

    Context *Context_() const
    {
        return context_;
    }

    const std::list<Stream *> StreamList_() const
    {
        return streams_;
    }

    void ModelRemoveStream(Stream * const stream)
    {
        streams_.remove(stream);
    }

    void ModelPushFrontStream(Stream * const stream)
    {
        streams_.push_front(stream);
    }

    rtError_t ModelBindTaskSubmit(Stream * const execStream, Stream * const streamIn, const uint32_t flag);
    rtError_t EnterBindStream(Stream * const streamIn, const uint32_t flag);
    rtError_t BindStream(Stream * const streamIn, const uint32_t flag);
    rtError_t ModelUnBindTaskSubmit(Stream * const streamIn, const bool force);
    rtError_t UnbindStream(Stream * const streamIn, const bool force = false);
    rtError_t LoadComplete();
    rtError_t LoadCompleteByStreamPrep(Stream * &stream);
    rtError_t LoadCompleteByStreamPostp(Stream * const stream);
    rtError_t LoadCompleteByStream();
    virtual rtError_t Execute(Stream * const stm, int32_t timeout = -1);
    virtual rtError_t ExecuteSync(int32_t timeout = -1);
    virtual rtError_t ExecuteAsync(Stream * const stm);
    rtError_t AiCpuModelSyncExecute();
    rtError_t GetStreamToAsyncExecute(Stream *stm);
    rtError_t GetStreamToSyncExecute(int32_t timeout = -1);
    rtError_t CheckBindStream(const Stream * const streamIn) const;
    uint32_t ModelGetNodes(void) const;
    rtError_t ModelDebugDotPrint(void) const;
    rtError_t ModelDebugJsonPrint(const char* path, const uint32_t flags) const;
    rtError_t GetModelName(const uint32_t maxLen, char_t * const name) const;
    uint32_t GetStreamIdBySqId(const uint16_t sqId) const;
    rtError_t AddStream(Stream * const streamIn, const uint32_t flag);
    rtError_t DelStream(Stream * const streamIn);
    rtError_t BindSqPerStream(Stream * const streamIn, const uint32_t flag);
    rtError_t UnBindSqPerStream(Stream * const streamIn);

    void SetModelExecutorType(uint32_t executorFlag)
    {
        executorFlag_ = executorFlag;
    }

    void SetModelName(std::string &name)
    {
        name_ = name;
    }

    uint32_t GetModelExecutorType() const
    {
        return (uint32_t)executorFlag_;
    }

    void *GetAicpuModelInfo() const
    {
        return aicpuModelInfo_;
    }

    uint32_t GetFirstTaskId() const
    {
        return firstTaskId_;
    }

    const void *GetDevString(rtDevStringNameT name) const
    {
        if (name == RT_DEV_STRING_ENDGRAPH) {
            return endGraphName_;
        } else if (name == RT_DEV_STRING_ACTIVE_STREAM) {
            return activeStreamName_;
        } else {
            return nullptr;
        }
    }

    const void* GetDevModelID() const
    {
        return modeID_;
    }

    rtError_t SaveAicpuStreamTask(const Stream * const streamIn, const rtCommand_t * const command);
    rtError_t PacketAicpuTaskInfo(rtAicpuModelInfo_t * const infoAicpuModel);
    rtError_t PacketAllStreamInfo(rtAicpuModelInfo_t * const aicpuModelInfoIn);
    rtError_t PacketQueueInfo(rtAicpuModelInfo_t * const aicpuModelInfoIn);
    rtError_t PacketAicpuModelInfo();
    bool NeedLoadAicpuModelTask();
    rtError_t SynchronizeExecute(Stream * const stm, int32_t timeout = -1);
    uint32_t ModelExecuteType();
    rtError_t ModelAbort();
    rtError_t MallocDevString(const char_t * const str, void **ptr) const;
    rtError_t MallocDevValue(const void * const data, const uint32_t size, void **ptr) const;
    void PushbackArgActiveStream(void *argHandle)
    {
        argActiveStreamRecord_.push_back(argHandle);
    }
    void IncEndGraphNum(void)
    {
        endGraphNum_++;
    }
    uint32_t EndGraphNum_(void) const
    {
        return endGraphNum_;
    }
    void IncModelExitNum(void)
    {
        modelExitNum_++;
    }
    uint32_t ModelExitNum_(void) const
    {
        return modelExitNum_;
    }

    void SetEndGraphNotify(Notify *notify)
    {
        endGraphNotify_ = notify;
    }
    Notify *GetEndGraphNotify()
    {
        return endGraphNotify_;
    }
    Stream *GetExeStream() const
    {
        return exeStream_;
    }
    void SetExeStream(Stream *exeStream)
    {
        exeStream_ = exeStream;
    }
    int16_t GetSchGroupId() const
    {
        return schGroupId_;
    }
    void SetSchGroupId(int16_t schGrpId)
    {
        schGroupId_ = schGrpId;
    }
    rtError_t LoadCompleteByCallAiCpuIntf();
    rtError_t BindQueue(const uint32_t queueId, const rtModelQueueFlag_t flag);
    void ExecuteComplete(void);
    rtError_t LabelAlloc(Label * const labelIn, uint16_t &labelId);
    rtError_t LabelFree(const uint16_t labelId);
    rtError_t CmoIdAlloc(const uint32_t logicId, uint16_t &cmoId);
    rtError_t GetCmoId(const uint32_t logicId, uint16_t &cmoId);
    void CmoIdFree(void);
    rtError_t AicpuModelSetExtId(const uint32_t modelId, const uint32_t extId);
    uint64_t GetLabelCountdevPtr() const
    {
        return RtPtrToValue(labelCountPtr_);
    }
    void LabelCountInc()
    {
        labelCount_++;
    }

    bool IsModelHeadStream(Stream *const stm) const
    {
        for (Stream * const stmListEntry : headStreams_) {
            if (stmListEntry == stm) {
                return true;
            }
        }
        return false;
    }

    const std::list<Stream *> GetHeadStreamList_() const
    {
        return headStreams_;
    }

    std::mutex& GetFirstExecuteMutex()
    {
        return firstExecuteMutex_;
    }

    bool GetFirstExecute() const
    {
        return firstExecuteFlag_.load();
    }

    void SetFirstExecute(bool firstExecuteFlag)
    {
        firstExecuteFlag_.store(firstExecuteFlag);
    }

    void *GetFuncCallHostMem() const
    {
        return funcCallHostMem_;
    }

    void SetFuncCallHostMem(void *mem)
    {
        funcCallHostMem_ = mem;
    }

    uint64_t GetFunCallMemSize() const
    {
        return funCallMemSize_;
    }

    void SetFunCallMemSize(uint64_t funCallMemSize)
    {
        funCallMemSize_ = funCallMemSize;
    }

    void SetFuncCallSvmMem(uint64_t funcCallSvmMem)
    {
        funcCallSvmMem_ = funcCallSvmMem;
    }

    uint64_t GetFuncCallSvmMem() const
    {
        return funcCallSvmMem_;
    }

    void SetBaseFuncCallSvmMem(void *baseFuncCallSvmMem)
    {
        baseFuncCallSvmMem_ = baseFuncCallSvmMem;
    }

    void *GetBaseFuncCallSvmMem() const
    {
        return baseFuncCallSvmMem_;
    }

    void SetFuncCallDfxBaseSvmMem(void *funcCallDfxBaseSvmMem)
    {
        funcCallDfxBaseSvmMem_ = funcCallDfxBaseSvmMem;
    }

    void *GetFuncCallDfxBaseSvmMem() const
    {
        return funcCallDfxBaseSvmMem_;
    }

    void SetDfxPtr(void *dfxPtr)
    {
        dfxPtr_ = dfxPtr;
    }

    void *GetDfxPtr() const
    {
        return dfxPtr_;
    }

    ModelType GetModelType() const
    {
        return modelType_;
    }

    bool IsModelLoadComplete() const
    {
        return isModelComplete_;
    }
    rtError_t MemWaitDevAlloc(void **devMem, const Device * const dev);
    void MemWaitDevListFree(const Device * const dev) {
        const std::lock_guard<std::mutex> lock(memWaitMutex_);
        for (const auto &item : devAddrList_) {
            (void)dev->Driver_()->DevMemFree(item, dev->Id_());
        }
        devAddrList_.clear();
    }

private:
    /*
     * Disable sq when the stream is bound to the model,
     * and enable sq of the HEAD stream when the model is executed
     */
    rtError_t DisableSq(const Stream * const streamIn) const;
    rtError_t SubmitExecuteTask(Stream * const streamIn);
    rtError_t AicpuModelDestroy();
    rtError_t SendTaskToAicpu(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
                              const void * const args, const uint32_t argsSize, const uint32_t flag);
    rtError_t ReSetup(void);
    void ResetForRestore(void);
    rtError_t ReBindStreams(void);
    rtError_t ReAllocStreamId(void);
    rtError_t SinkSqTasksRestore(void);
    rtError_t CheckRestoredSqStatus(void);

private:
    int32_t id_ = MODEL_ID_INVALID;
    std::string name_;
    uint32_t lastStreamId_;
    uint32_t kernelTaskId_;
    uint32_t firstTaskId_;
    Stream *exeStream_;
    bool needSubmitTask_;
    bool isDebugRegister_;
    std::list<Stream *> streams_;

    std::map<uint32_t, void *> argLoaderRecord_;
    std::vector<struct DMA_ADDR> dmaAddrRecord_;
    Context *context_;
    uint32_t executorFlag_;
    std::map<uint32_t, std::vector<rtAicpuTaskInfo_t> > mapAicpuTask_;
    void *aicpuModelInfo_;
    void *streamInfoPtr_;
    void *aicpuTaskInfoPtr_;
    void *queueInfoPtr_;
    void *modeID_;
    void *endGraphName_;
    void *activeStreamName_;
    std::vector<void *> argActiveStreamRecord_;
    uint32_t endGraphNum_;
    uint32_t modelExitNum_;
    std::vector<rtModelQueueInfo_t> queueInfo_;
    Notifier *notifier_;
    LabelAllocator *labelAllocator_;
    Notify *endGraphNotify_ = nullptr;

    ModelExecuteApiType previousModelType_ = RT_MODEL_RESERVED;
    std::map<uint16_t, Label *> labelMap_;
    std::mutex labelMapMutex_;
    bool isModelDelete_;
    int16_t schGroupId_;
    std::mutex cmoIdMapMutex_;
    std::map<uint32_t, uint16_t> logicIdToCMOIdMap_;
    uint64_t labelCount_;
    void *labelCountPtr_;
    std::list<Stream *> headStreams_;
    std::mutex firstExecuteMutex_;
    std::atomic<bool> firstExecuteFlag_;
    void *funcCallHostMem_;
    uint64_t funCallMemSize_;
    uint64_t funcCallSvmMem_; // device侧内存
    void *baseFuncCallSvmMem_;
    void *funcCallDfxBaseSvmMem_;
    void *dfxPtr_;
    ModelType modelType_;
    bool isModelComplete_ = false;
    std::mutex memWaitMutex_;
    void *currentAddr_ = nullptr;
    uint8_t allocTimes_ = 0;
    std::vector<void *> devAddrList_;
};
}
}

#endif  // __CCE_RUNTIME_MODEL_HPP__
