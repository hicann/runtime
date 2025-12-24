/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_RDMA_TASK_H
#define RUNTIME_RDMA_TASK_H

#include "driver.hpp"
#include "stars.hpp"
#include "rt_ffts_plus.h"

namespace cce {
namespace runtime {
uint32_t GetSendSqeNumForRdmaDbSendTask(TaskInfo* const taskInfo);
rtError_t RdmaSendTaskInit(TaskInfo* taskInfo, const uint32_t sqId, const uint32_t wqeId);
rtError_t RdmaDbSendTaskInit(TaskInfo* taskInfo, const uint32_t dbIndex, const uint64_t dbInfo, const uint32_t taskSeq);
void ToCommandBodyForRdmaSendTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForRdmaDbSendTask(TaskInfo* taskInfo, rtCommand_t * const command);
void ConstructSqeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);
rtError_t RdmaPiValueModifyTaskInit(
    TaskInfo *const taskInfo, const std::vector<uint64_t>& rdmaPiValueDeviceAddrVec);
void GetRdmaTaskInfoFromFftsPlusTask (const rtFftsPlusTaskInfo_t *const fftsPlusTaskInfo,
    const void *deviceDescAlignBuf, std::vector<uint64_t> &rdmaPiValueDeviceAddrVec);
rtError_t SubmitRdmaPiValueModifyTask(
    Stream *const stm, const rtFftsPlusTaskInfo_t *const fftsPlusTaskInfo, const void *deviceDescAlignBuf);
void ConstructSqeRdmaPiValueModifyTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void RdmaPiValueModifyTaskUnInit(TaskInfo *taskInfo);
void PrintErrorInfoForRDMAPiValueModifyTask(TaskInfo *const taskInfo, const uint32_t devId);
void PrintDfxInfoForRdmaPiValueModifyTask(const TaskInfo *taskInfo, const uint32_t devId);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_RDMA_TASK_H
