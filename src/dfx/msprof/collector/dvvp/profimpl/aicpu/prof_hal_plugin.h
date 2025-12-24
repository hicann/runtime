/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_HAL_PLUGIN_H
#define PROF_HAL_PLUGIN_H
#include <cstdint>
#include "singleton/singleton.h"
#include "prof_utils.h"
#include "prof_hal_api.h"

namespace ProfAPI {
using VOID_PTR = void *;
using CONST_VOID_PTR = const void *;

using ProfHalInitFunc = int32_t (*) (uint32_t moduleType, const void *moduleConfig, uint32_t length);
using ProfHalGetVersionFunc = int32_t (*) (uint32_t *version);
using ProfHalFinalFunc = int32_t (*) ();
using ProfHalFlushModuleFunc = void (*) (const ProfHalFlushModuleCallback func);
using ProfHalSendDataFunc = int32_t (*) (const ProfHalSendAicpuDataCallback func);
using ProfHalHelperDirFunc = int32_t (*) (const ProfHalHelperDirCallback func);
using ProfHalSendHelperDataFunc = int32_t (*) (const ProfHalSendHelperDataCallback func);

class ProfHalPlugin : public analysis::dvvp::common::singleton::Singleton<ProfHalPlugin> {
public:
    ~ProfHalPlugin() override;
    void ProfHalApiInit();
    int32_t ProfHalInit(uint32_t moduleType, const void *moduleConfig, uint32_t length);
    int32_t ProfHalGetVersion(uint32_t *version) const;
    int32_t ProfHalFinal() const;
    void ProfHalFlushModuleRegister(const ProfHalFlushModuleCallback func) const;
    void ProfHalSendDataRegister(const ProfHalSendAicpuDataCallback func) const;
    void ProfHalHelperDirRegister(const ProfHalHelperDirCallback func) const;
    void ProfHalSendHelperDataRegister(const ProfHalSendHelperDataCallback func) const;

private:
    void LoadHalApi();
    VOID_PTR msProfLibHandle_{nullptr};
    PTHREAD_ONCE_T profHalApiLoadFlag_;

    ProfHalInitFunc profHalInit_;
    ProfHalGetVersionFunc profHalGetVersion_;
    ProfHalFinalFunc profHalFinal_;
    ProfHalFlushModuleFunc profHalFlush_;
    ProfHalSendDataFunc profHalSendData_;
    ProfHalHelperDirFunc profHalHelperDir_;
    ProfHalSendHelperDataFunc profHalSendHelperData_;
};
}
#endif
