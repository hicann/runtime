/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_DATA_DUMPER_H
#define MSPROF_ENGINE_DATA_DUMPER_H

#include "prof_reporter.h"
#include "thread/thread.h"
#include "receive_data.h"

namespace Msprof {
namespace Engine {
class DataDumper : public ReceiveData, public Reporter, public analysis::dvvp::common::thread::Thread {
public:
    /* *
     * @brief DataDumper: the construct function
     */
    DataDumper() = default;
    ~DataDumper() override {};
};
} // namespace Engine
} // namespace Msprof
#endif
