/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AOE_STUB_H
#define AOE_STUB_H

#include <set>
#include <limits>
#include <memory>
#include <set>
#include "slog.h"
#include "mmpa_api.h"
#include "data_manager.h"
#include "ge_stub.h"
#include "acl/acl.h"
#include "acl_prof.h"

using RunFunc = bool (*) (int32_t fd);
bool RunInfer(std::set<RunnerOpInfo> &modelInfo, RunFunc func);
bool RunModel(int32_t fd);
bool RunOp(int32_t fd);
void SetModelId(uint32_t &modelId);
void SetStreamId(uint32_t &streamId);
aclError RunInferWithApi(std::string &aclProfPath, uint32_t devId, aclprofAicoreMetrics aicoreMetrics,
    const aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig);
#endif