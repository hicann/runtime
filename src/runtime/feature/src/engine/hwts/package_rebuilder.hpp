/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_PACKAGE_REBUILDER_HPP__
#define __CCE_RUNTIME_PACKAGE_REBUILDER_HPP__

#include <map>
#include <vector>
#include "base.hpp"
#include "osal.hpp"
#include "driver.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#ifndef CFG_DEV_PLATFORM_PC
#include "error_manager.h"
#endif

namespace cce {
namespace runtime {

struct rtPackageBuf_t {
    uint8_t len;
    uint32_t buf[0];
};

class PackageRebuilder : public NoCopy {
public:
    ~PackageRebuilder() override;
    bool PackageReportReceive(const rtTaskReport_t * const report, uint8_t * const package,
                              const size_t pkgLen, const TaskInfo * const reportTask);

private:
    std::map<uint64_t, rtPackageBuf_t *> rptPkgTbl_;
}; // class PackageRebuilder
}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_PACKAGE_REBUILDER_HPP__
