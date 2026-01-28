/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef EXCEPTION_DUMPER_H
#define EXCEPTION_DUMPER_H
#include <string>
#include <mutex>
#include <deque>
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_operator.h"
#include "dump_setting.h"
#include "adump_api.h"
#include "path.h"

namespace Adx {
class ExceptionDumper {
public:
    ExceptionDumper() = default;
    ~ExceptionDumper();
    int32_t ExceptionDumperInit(DumpType dumpType, const DumpConfig &dumpConfig);
    inline bool GetExceptionStatus() const;
    inline bool GetArgsExceptionStatus() const;
    inline bool GetCoredumpStatus() const;
    void SetDumpPath(const std::string &dumpPath);
    std::string CreateExtraDumpPath();
    const char* GetExtraDumpCPath() const;
    void AddDumpOperator(const OperatorInfo &opInfo);
    void AddDumpOperatorV2(const OperatorInfoV2 &opInfo);
    int32_t DelDumpOperator(uint32_t deviceId, uint32_t streamId);
    int32_t DumpException(const rtExceptionInfo &exception);
    void ExceptionModeDowngrade();

#ifdef __ADUMP_LLT
    void Reset();
#endif

private:
    std::string CreateDumpPath(Path &dumpPath) const;
    std::string CreateDeviceDumpPath(uint32_t deviceId) const;
    bool FindExceptionOperator(const rtExceptionInfo &exception, DumpOperator &excOp);
    int32_t DumpArgsException(const rtExceptionInfo &exception, const std::string &dumpPath) const;
    int32_t DumpArgsExceptionInner(const rtExceptionInfo &exception, const std::string &dumpPath) const;
    int32_t DumpArgsExceptionFastRecovery(const rtExceptionInfo &exception) const;
    int32_t DumpNormalException(const rtExceptionInfo &exception, const std::string &dumpPath);
    int32_t DumpDetailException(const rtExceptionInfo &exception, const std::string &dumpPath);
    int32_t LoadTensorPluginLib();
    bool InitArgsExceptionMemory() const;
    void Exit() const;
    bool coredumpStatus_{ false };
    bool coredumpEnableComplete_{ true };
    bool exceptionStatus_{ false };
    bool argsExceptionStatus_{ false };
    bool destructionFlag_{false};
    std::string dumpPath_;
    std::string extraDumpPath_;
    DumpSetting setting_;
    std::mutex mutex_;
    std::deque<DumpOperator> agingOperators_;
    std::map<uint32_t, std::map<uint32_t, std::deque<DumpOperator>>> residentOperators_;
};

inline bool ExceptionDumper::GetExceptionStatus() const
{
    return exceptionStatus_;
}

inline bool ExceptionDumper::GetArgsExceptionStatus() const
{
    return argsExceptionStatus_;
}

inline bool ExceptionDumper::GetCoredumpStatus() const
{
    return coredumpStatus_;
}
} // namespace Adx
#endif // EXCEPTION_DUMPER_H