/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COLLECTOR_DVVP_MSPROF_DYNAMIC_PROFILING_DYN_PROF_CLIENT_H
#define COLLECTOR_DVVP_MSPROF_DYNAMIC_PROFILING_DYN_PROF_CLIENT_H

#include <cstdint>
#include <functional>
#include <map>
#include "dyn_prof_def.h"
#include "thread/thread.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {
enum class DynProfCliCmd {
    DYN_PROF_CLI_CMD_START = 0,
    DYN_PROF_CLI_CMD_STOP,
    DYN_PROF_CLI_CMD_QUIT,
    DYN_PROF_CLI_CMD_HELP,
    DYN_PROF_CLI_CMD_UNKNOW
};

class DynProfClient : public analysis::dvvp::common::thread::Thread {
public:
    DynProfClient() = default;
    ~DynProfClient() override = default;

    void SetParams(const std::string &params);
    int32_t Start() override;
    int32_t Stop() override;
    bool IsCliStarted() const;

protected:
    void Run(const struct error_message::Context &errorContext) override;

private:
    void DynProfCliInitProcFunc();
    int32_t DynProfCliCreate();
    int32_t DynProfCliSendParams() const;

    DynProfMsgRsqCode DynProfCliSendCmd(DynProfMsgType req) const;
    void DynProfCliProcStart() const;
    void DynProfCliProcStop() const;
    void DynProfCliProcQuit() const;
    void DynProfCliHelpInfo() const;

    int32_t cliSockFd_ { -1 };
    bool cliStarted_ { false };
    std::string dynProfParams_;
    std::map<DynProfCliCmd, ProcFunc> procFuncMap_;
};

class DynProfCliMgr : public analysis::dvvp::common::singleton::Singleton<DynProfCliMgr> {
    friend analysis::dvvp::common::singleton::Singleton<DynProfCliMgr>;

public:
    ~DynProfCliMgr() override;
    int32_t StartDynProfCli(const std::string &params);
    void StopDynProfCli();
    void SetKeyPid(int32_t pid);
    int32_t GetKeyPid() const;
    std::string GetKeyPidEnv() const;
    void EnableDynProfCli();
    bool IsDynProfCliEnable() const;
    std::string GetDynProfEnv() const;
    void SetAppMode();
    bool IsAppMode() const;
    bool IsCliStarted() const;
    void WaitQuit();

private:
    DynProfCliMgr() = default;
    bool enabled_ { false };
    bool isAppMode_ { false }; // --application
    int32_t keyPid_ { 0 };         // --application: msprofbin pid; --pid: app pid
    SHARED_PTR_ALIA<Collector::Dvvp::DynProf::DynProfClient> dynProfCli_;
};
} // namespace DynProf
} // namespace Dvvp
} // namespace Collector

#endif