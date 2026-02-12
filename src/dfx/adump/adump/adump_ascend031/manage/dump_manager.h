/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_MANAGER_H
#define DUMP_MANAGER_H

#include <mutex>
#include "adump_pub.h"
#include "adump_api.h"
#include "dump_setting.h"
#include "exception_dumper.h"
#include <set>

namespace Adx {
// callback 回调开关控制
enum class DumpEnableAction : int32_t
{
    ENABLE,    // 明确启用
    DISABLE,   // 明确禁用
    AUTO       // 根据开关状态决定
};
class DumpManager {
public:
    static DumpManager &Instance();
    int32_t SetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig);
    int32_t SetDumpConfig(const char *dumpConfigData, size_t dumpConfigSize);
    int32_t UnSetDumpConfig();
    bool IsEnableDump(DumpType dumpType);
    int32_t DumpOperator(const std::string &opType, const std::string &opName, const std::vector<TensorInfo> &tensors,
        rtStream_t stream);
    void AddExceptionOp(const OperatorInfo &opInfo);
    int32_t DelExceptionOp(uint32_t deviceId, uint32_t streamId);
    int32_t DumpExceptionInfo(const rtExceptionInfo &exception);
    uint64_t AdumpGetDumpSwitch();
    DumpSetting GetDumpSetting() const;
    void KFCResourceInit();
    void ExceptionModeDowngrade();
    int32_t DumpOperatorV2(const std::string &opType, const std::string &opName,
        const std::vector<TensorInfoV2> &tensors, rtStream_t stream);
    void AddExceptionOpV2(const OperatorInfoV2 &opInfo);
    int32_t RegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc);
    int32_t HandleDumpEvent(uint32_t moduleId, DumpEnableAction action);
    void ConvertOperatorInfo(const OperatorInfo &opInfo, OperatorInfoV2 &operatorInfoV2) const;
    std::vector<TensorInfoV2> ConvertTensorInfoToDumpTensorV2(const std::vector<TensorInfo> &TensorInfos) const; 

#ifdef __ADUMP_LLT
    void Reset();
    bool GetKFCInitStatus();
    void SetKFCInitStatus(bool status);
#endif

private:
    DumpManager();
    DumpManager(const DumpManager &) = delete;
    DumpManager &operator = (const DumpManager &) = delete;
    int32_t ExceptionConfig(DumpType dumpType, const DumpConfig &dumpConfig);
    void ConvertTensorInfo(const TensorInfo &tensorInfo, TensorInfoV2 &tensor) const;
    int32_t CallbackEnvExceptionDumpEvent(AdumpCallback callbackFunc);
    std::string GetBinName() const;
    bool CheckBinValidation();
    bool RegsiterExceptionCallback();
    bool CheckCoredumpSupportedPlatform() const;
    bool registered_ = false;
    bool isKFCInit_ = false;
    ExceptionDumper exceptionDumper_;
    DumpSetting dumpSetting_;
    std::mutex resourceMtx_;
    std::mutex resourceMtx2_;
    std::set<DumpType> openedDump_;
    std::map<uint32_t, AdumpCallback> enableCallbackFunc_;
    std::map<uint32_t, AdumpCallback> disableCallbackFunc_;
    std::string dumpConfigInfo_;
    bool isEnvExceptionDump_ = false;
};
} // namespace Adx
#endif // DUMP_MANAGER_H
