/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COLLECTOR_DVVP_MSPROF_DYNAMIC_PROFILING_DYN_PROF_DEF_H
#define COLLECTOR_DVVP_MSPROF_DYNAMIC_PROFILING_DYN_PROF_DEF_H

#include <functional>
#include <string>

namespace Collector {
namespace Dvvp {
namespace DynProf {
static const std::string DYN_PROF_SOCK_UNIX_DOMAIN = "dyn_prof_sock_";
constexpr uint32_t DYN_PROF_PARAMS_MAX_LEN = 4096;
constexpr long DYN_PROF_PROC_TIME_OUT = 60;

using ProcFunc = std::function<void()>;

enum class DynProfMsgType {
    DYN_PROF_PARAMS_RSQ = 0,
    DYN_PROF_START_REQ,
    DYN_PROF_START_RSQ,
    DYN_PROF_STOP_REQ,
    DYN_PROF_STOP_RSQ,
    DYN_PROF_QUIT_REQ,
    DYN_PROF_QUIT_RSQ,
};

enum class DynProfMsgRsqCode {
    DYN_PROF_RSQ_SUCCESS = 0,
    DYN_PROF_RSQ_FAIL,
    // start
    DYN_PROF_RSQ_ALREADY_START,
    DYN_PROF_RSQ_NOT_SET_DEVICE,
    // stop
    DYN_PROF_RSQ_NOT_START,
};

struct DynProfMsg {
    DynProfMsgType msgType;
    DynProfMsgRsqCode statusCode;
};

struct DynProfParams {
    uint32_t dataLen = 0;
    char data[DYN_PROF_PARAMS_MAX_LEN] = { 0 };
};

struct DynProfDeviceInfo {
    uint32_t chipId = 0;
    uint32_t devId = 0;
    bool isOpenDevice = false;
};
} // namespace DynProf
} // namespace Dvvp
} // namespace Collector

#endif