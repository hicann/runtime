/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_RES_HPP__
#define __CCE_RUNTIME_TASK_RES_HPP__

#include <mutex>
#include "task_info.hpp"
#include "device.hpp"
#include "arg_loader.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t RTS_LITE_PCIE_BAR_COPY_SIZE_NEW = 1024U;
constexpr uint32_t RTS_PCIE_STREAM_NUM_MAX = 8U;
constexpr uint32_t SHOW_DFX_INFO_TASK_NUM = 6U;

struct TaskRes {
    TaskInfo taskInfo;
    void* copyDev;       // lite pcie_bar, null for other
} ;

class TaskResManage {
public:
    TaskResManage();
    virtual ~TaskResManage();
    virtual TaskInfo* GetTaskInfo(uint32_t taskId) const;
    virtual void ResetTaskRes();
    TaskInfo *GetHeadTaskInfo() const;
    void RecycleResHead();
    uint16_t GetResHead() const;
    virtual bool CreateTaskRes(Stream* stm);
    void ReleaseTaskResource(Stream* stm);
    rtError_t RePcieHostRegister(const Stream *const stm) const;
    void *MallocPcieBarBuffer(const uint32_t size, Device * const dev, bool isLogError=true) const;

    bool AllocTaskResId(uint32_t &taskResId);
    bool RecycleTaskInfoOn(uint32_t taskId);
    bool RecycleTaskInfoO1(uint32_t taskId);
    TaskInfo* AllocTaskInfoByTaskResId(Stream *stm, uint32_t taskResId, uint16_t taskId, tsTaskType_t taskType);
    rtError_t LoadInputOutputArgs(const Stream * const stm, void *&kerArgs,uint32_t taskResId,
        const uint32_t size, const void * const args, const rtArgsEx_t * const argsInfo) const;
    rtError_t LoadInputOutputArgs(const Stream * const stm, void *&kerArgs, uint32_t taskResId,
        const uint32_t size, const void * const args, const rtAicpuArgsEx_t * const argsInfo) const;

    void SetResult(void *const kerArgs, struct ArgLoaderResult * const result) const;
    template<typename T>
    rtError_t Load(const T *argsInfo, uint32_t taskResId,
                   Stream * const stm, struct ArgLoaderResult * const result) const
    {
        void *kerArgs = static_cast<void *>(argsInfo->args);
        const uint32_t size = argsInfo->argsSize;
        void * const args = argsInfo->args;

        if (taskRes_[taskResId].copyDev == nullptr || size > RTS_LITE_PCIE_BAR_COPY_SIZE_NEW) {
            RT_LOG(RT_LOG_INFO, "unsupported, size=%u.", size);
            return RT_ERROR_INVALID_VALUE;
        }
        if (argsInfo->isNoNeedH2DCopy == 0U) {
            rtError_t error = LoadInputOutputArgs(stm, kerArgs, taskResId, size, args, argsInfo);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "load args failed, retCode=%#x.", static_cast<uint32_t>(error));
                return error;
            }
        }
        SetResult(kerArgs, result);

        return RT_ERROR_NONE;
    }
    uint16_t GetTaskPoolNum() const
    {
        return taskPoolNum_;
    }

    void ShowDfxInfo(void) const;

    void CreateTaskResBaseAddr(const uint32_t taskPoolSize)
    {
        if (taskResBaseAddr_ == nullptr) {
            taskResBaseAddr_ = new (std::nothrow) uint8_t[taskPoolSize];
        }
    }

    uint8_t *GetTaskResBaseAddr() const
    {
        return taskResBaseAddr_;
    }

public:
    TaskRes* taskRes_{nullptr};
    uint16_t taskResHead_ = 0U; // recycle
    uint16_t taskResTail_ = 0U; // alloc
	uint16_t taskPoolNum_ {1024U};
    // dfx
    int32_t streamId_ {0xFFFF};
    uint32_t deviceId_ {0xFFFFU};
private:
    uint8_t* taskResBaseAddr_{nullptr};
    uint8_t* pcieBaseAddr_{nullptr};
    std::mutex taskHeadMutex_;
    std::mutex taskTailMutex_;
    
    // pcie bar manager
    uint16_t GetTaskPoolSizeByChipType(const rtChipType_t chipType) const;
    void FreePcieBarBuffer(void *addr, Device *para) const;

    // args copy
    void UpdateAddrField(const void * const kerArgs, void * const argsHostAddr, const uint16_t hostInputInfoNum,
                         const rtHostInputInfo * const hostInputInfoPtr) const;

protected:
};

}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_TASK_RES_HPP__
