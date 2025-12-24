/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_RPC_DATA_HANDLE_H
#define MSPROF_ENGINE_RPC_DATA_HANDLE_H

#include "utils/utils.h"
#include "hdc/hdc_sender.h"

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;

class IDataHandle {
public:
    IDataHandle() {}
    virtual ~IDataHandle() {}

public:
    virtual int32_t Init() = 0;
    virtual int32_t UnInit() = 0;
    virtual int32_t Flush() = 0;
    virtual int32_t SendData(CONST_VOID_PTR data, uint32_t dataLen, const std::string fileName = "",
        const std::string jobCtx = "") = 0;
};

class HdcDataHandle : public IDataHandle {
public:
    HdcDataHandle(const std::string &moduleNameWithId, int32_t hostPid, int32_t devId);
    ~HdcDataHandle() override;

public:
    int32_t Init() override;
    int32_t UnInit() override;
    int32_t Flush() override;
    int32_t SendData(CONST_VOID_PTR data, uint32_t dataLen, const std::string fileName = "",
        const std::string jobCtx = "") override;

private:
    std::string moduleNameWithId_; // like: DATA_PREPROCESS-80858-3
    int32_t hostPid_;
    int32_t devId_;
    SHARED_PTR_ALIA<HdcSender> hdcSender_;
};

class RpcDataHandle {
public:
    RpcDataHandle(const std::string &moduleNameWithId, const std::string &module, int32_t hostPid, int32_t devId);
    virtual ~RpcDataHandle();

public:
    int32_t Init() const;
    int32_t UnInit() const;
    int32_t Flush() const;
    int32_t SendData(CONST_VOID_PTR data, uint32_t dataLen, const std::string fileName, const std::string jobCtx);
    bool IsReady() const;
    int32_t TryToConnect();

private:
    std::string moduleNameWithId_; // like: DATA_PREPROCESS-80858-3
    std::string module_; // the module name, like: DATA_PREPROCESS
    int32_t hostPid_;
    int32_t devId_;
    SHARED_PTR_ALIA<IDataHandle> dataHandle_;
};
}}
#endif
