/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_EVENT_C_HPP__
#define __CCE_RUNTIME_EVENT_C_HPP__
#include "task_info.hpp"

namespace cce {
namespace runtime {

class DavidEvent;
struct CrossEventSharedInfo;

rtError_t GetOrCreateCrossEventSharedInfo(
    const Device* source, uint32_t notifyId, bool isCountNotify, CrossEventSharedInfo& info, char* name, uint32_t len);
rtError_t DestroyCrossEventSharedInfo(const Device* source, CrossEventSharedInfo& info);

rtError_t EvtRecord(Event* const evt, Stream* const stm);
rtError_t CheckEventBeforeWait(DavidEvent* const evt, const Stream* const stm, bool& needWait);
rtError_t CrossEvtWait(DavidEvent* const evt, Stream* const stm);
rtError_t EvtWait(Event* const evt, Stream* const stm, const uint32_t timeout);
rtError_t EvtReset(Event* const evt, Stream* const stm);
rtError_t ProcStreamRecordTask(Stream* const stm, int32_t timeout);
rtError_t EvtRecordSoftwareMode(Event* const evt, Stream* const stm);
rtError_t EvtWaitSoftwareMode(Event* const evt, Stream* const stm);
rtError_t EvtResetSoftwareMode(Event* const evt, Stream* const stm);

} // namespace runtime
} // namespace cce

#endif
