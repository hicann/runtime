/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_msq_operator_manager.h"

#include <dlfcn.h>
#include <map>
#include <string>

#include "aicpusd_status.h"

namespace AicpuSchedule {
namespace {
const std::string MSQ_OPERATOR_SO_NAME = "libaicpu_msq_operator.so";

template <typename FuncType>
bool LoadSymbol(void* handle, const char* name, FuncType& func)
{
    void* symbol = dlsym(handle, name);
    if ((symbol == nullptr)) {
        aicpusd_err("Load symbol failed, so=%s, symbol=%s", MSQ_OPERATOR_SO_NAME.c_str(), name);
        func = nullptr;
        return false;
    }

    func = reinterpret_cast<FuncType>(symbol);
    return true;
}
} // namespace

void* MsqOperatorManager::handle_ = nullptr;
bool MsqOperatorManager::inited_ = false;
std::mutex MsqOperatorManager::mutex_;
MsqOperatorManager::MsqResetFunc MsqOperatorManager::v1ResetT0Status_ = nullptr;
MsqOperatorManager::MsqResetFunc MsqOperatorManager::v1ResetT1Status_ = nullptr;
MsqOperatorManager::MsqReadStatusFunc MsqOperatorManager::v1ReadT0Status_ = nullptr;
MsqOperatorManager::MsqReadStatusFunc MsqOperatorManager::v1ReadT1Status_ = nullptr;
MsqOperatorManager::MsqReadDataFunc MsqOperatorManager::v1ReadT0Data_ = nullptr;
MsqOperatorManager::MsqReadDataFunc MsqOperatorManager::v1ReadT1Data_ = nullptr;
MsqOperatorManager::MsqSendRspFunc MsqOperatorManager::v1SendT0Response_ = nullptr;
MsqOperatorManager::MsqSendRspFunc MsqOperatorManager::v1SendT1Response_ = nullptr;
MsqOperatorManager::MsqResetFunc MsqOperatorManager::v2ResetT0Status_ = nullptr;
MsqOperatorManager::MsqResetFunc MsqOperatorManager::v2ResetT1Status_ = nullptr;
MsqOperatorManager::MsqReadStatusFunc MsqOperatorManager::v2ReadT1Status_ = nullptr;
MsqOperatorManager::MsqReadDataFunc MsqOperatorManager::v2ReadT1Data_ = nullptr;
MsqOperatorManager::MsqSendRspFunc MsqOperatorManager::v2SendT1Response_ = nullptr;
MsqOperatorManager::WaitFunc MsqOperatorManager::waitFunc_ = nullptr;

int32_t MsqOperatorManager::Init()
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (inited_) {
        return AICPU_SCHEDULE_OK;
    }

    handle_ = dlopen(MSQ_OPERATOR_SO_NAME.c_str(), RTLD_NOW);
    if (handle_ == nullptr) {
        aicpusd_err("Open so failed, so=%s, err=%s", MSQ_OPERATOR_SO_NAME.c_str(), dlerror());
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    if (!LoadAllSymbols()) {
        (void)dlclose(handle_);
        handle_ = nullptr;
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    inited_ = true;
    aicpusd_info("Init msq operator manager success, so=%s", MSQ_OPERATOR_SO_NAME.c_str());
    return AICPU_SCHEDULE_OK;
}

void MsqOperatorManager::Finalize()
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (handle_ != nullptr) {
        (void)dlclose(handle_);
        handle_ = nullptr;
    }

    inited_ = false;
    v1ResetT0Status_ = nullptr;
    v1ResetT1Status_ = nullptr;
    v1ReadT0Status_ = nullptr;
    v1ReadT1Status_ = nullptr;
    v1ReadT0Data_ = nullptr;
    v1ReadT1Data_ = nullptr;
    v1SendT0Response_ = nullptr;
    v1SendT1Response_ = nullptr;
    v2ResetT0Status_ = nullptr;
    v2ResetT1Status_ = nullptr;
    v2ReadT1Status_ = nullptr;
    v2ReadT1Data_ = nullptr;
    v2SendT1Response_ = nullptr;
    waitFunc_ = nullptr;
}

bool MsqOperatorManager::LoadAllSymbols()
{
    const std::map<std::string, RawFuncPtr*> symbolTable = {
        {"MsqV1ResetT0Status", reinterpret_cast<RawFuncPtr*>(&v1ResetT0Status_)},
        {"MsqV1ResetT1Status", reinterpret_cast<RawFuncPtr*>(&v1ResetT1Status_)},
        {"MsqV1ReadT0Status", reinterpret_cast<RawFuncPtr*>(&v1ReadT0Status_)},
        {"MsqV1ReadT1Status", reinterpret_cast<RawFuncPtr*>(&v1ReadT1Status_)},
        {"MsqV1ReadT0Data", reinterpret_cast<RawFuncPtr*>(&v1ReadT0Data_)},
        {"MsqV1ReadT1Data", reinterpret_cast<RawFuncPtr*>(&v1ReadT1Data_)},
        {"MsqV1SendT0Response", reinterpret_cast<RawFuncPtr*>(&v1SendT0Response_)},
        {"MsqV1SendT1Response", reinterpret_cast<RawFuncPtr*>(&v1SendT1Response_)},
        {"MsqV2ResetT0Status", reinterpret_cast<RawFuncPtr*>(&v2ResetT0Status_)},
        {"MsqV2ResetT1Status", reinterpret_cast<RawFuncPtr*>(&v2ResetT1Status_)},
        {"MsqV2ReadT1Status", reinterpret_cast<RawFuncPtr*>(&v2ReadT1Status_)},
        {"MsqV2ReadT1Data", reinterpret_cast<RawFuncPtr*>(&v2ReadT1Data_)},
        {"MsqV2SendT1Response", reinterpret_cast<RawFuncPtr*>(&v2SendT1Response_)},
        {"Wait", reinterpret_cast<RawFuncPtr*>(&waitFunc_)},
    };

    for (const auto& symbol : symbolTable) {
        if (!LoadSymbol(handle_, symbol.first.c_str(), *symbol.second)) {
            return false;
        }
    }

    return true;
}

void MsqOperatorManager::CallV1ResetT0Status() { v1ResetT0Status_(); }

void MsqOperatorManager::CallV1ResetT1Status() { v1ResetT1Status_(); }

MsqStatus MsqOperatorManager::CallV1ReadT0Status() { return v1ReadT0Status_(); }

MsqStatus MsqOperatorManager::CallV1ReadT1Status() { return v1ReadT1Status_(); }

void MsqOperatorManager::CallV1ReadT0Data(uint32_t msgSize, MsqDatas* datas) { v1ReadT0Data_(msgSize, datas); }

void MsqOperatorManager::CallV1ReadT1Data(uint32_t msgSize, MsqDatas* datas) { v1ReadT1Data_(msgSize, datas); }

void MsqOperatorManager::CallV1SendT0Response() { v1SendT0Response_(); }

void MsqOperatorManager::CallV1SendT1Response() { v1SendT1Response_(); }

void MsqOperatorManager::CallV2ResetT0Status() { v2ResetT0Status_(); }

void MsqOperatorManager::CallV2ResetT1Status() { v2ResetT1Status_(); }

MsqStatus MsqOperatorManager::CallV2ReadT1Status() { return v2ReadT1Status_(); }

void MsqOperatorManager::CallV2ReadT1Data(uint32_t msgSize, MsqDatas* datas) { v2ReadT1Data_(msgSize, datas); }

void MsqOperatorManager::CallV2SendT1Response() { v2SendT1Response_(); }

void MsqOperatorManager::CallWait()
{
    waitFunc_();
    return;
}
} // namespace AicpuSchedule
