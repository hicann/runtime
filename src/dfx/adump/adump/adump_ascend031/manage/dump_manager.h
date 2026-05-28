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
#include "runtime/rt.h"
#include <set>

namespace Adx {
enum class DumpEnableAction : int32_t
{
    ENABLE,
    DISABLE,
    AUTO
};
class DumpManager {
public:
    static DumpManager &Instance();
    int32_t SetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig);
    int32_t SetDumpConfig(const char *dumpConfigData, size_t dumpConfigSize, const char *dumpConfigPath = "null");
    int32_t UnSetDumpConfig();
    bool IsEnableDump(DumpType dumpType);
    int32_t DumpOperator(const std::string &opType, const std::string &opName, const std::vector<TensorInfo> &tensors,
        rtStream_t stream);
    int32_t DumpOperatorV2(const std::string &opType, const std::string &opName,
        const std::vector<TensorInfoV2> &tensors, rtStream_t stream);
    int32_t DumpOperatorWithCfg(const std::string &opType, const std::string &opName,
        const std::vector<TensorInfo> &tensors, aclrtStream stream, const DumpCfg &dumpCfg);
    int32_t RegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc);
    int32_t HandleDumpEvent(uint32_t moduleId, DumpEnableAction action);
    void ConvertOperatorInfo(const OperatorInfo &opInfo, OperatorInfoV2 &operatorInfoV2) const;
    std::vector<TensorInfoV2> ConvertTensorInfoToDumpTensorV2(const std::vector<TensorInfo> &TensorInfos) const;
    uint64_t AdumpGetDumpSwitch();
    DumpSetting GetDumpSetting() const;
    void KFCResourceInit();
    void AddExceptionOp(const OperatorInfo &opInfo);
    void AddExceptionOpV2(const OperatorInfoV2 &opInfo);
    int32_t DelExceptionOp(uint32_t deviceId, uint32_t streamId);

    int32_t RegisterExceptionDumpCallback(ExceptionDumpCallback callback);
    int32_t UnregisterExceptionDumpCallback(ExceptionDumpCallback callback);

private:
    DumpManager();
    DumpManager(const DumpManager &) = delete;
    DumpManager &operator = (const DumpManager &) = delete;
    void ConvertTensorInfo(const TensorInfo &tensorInfo, TensorInfoV2 &tensor) const;
    std::string GetBinName() const;
    bool CheckBinValidation();
    DumpSetting dumpSetting_;
    std::mutex resourceMtx_;
    std::mutex resourceMtx2_;
    std::set<DumpType> openedDump_;
    std::map<uint32_t, AdumpCallback> enableCallbackFunc_;
    std::map<uint32_t, AdumpCallback> disableCallbackFunc_;
    std::string dumpConfigInfo_;
    bool isKFCInit_ = false;
};
} // namespace Adx
#endif // DUMP_MANAGER_H