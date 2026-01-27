/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "base.hpp"
#include "securec.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "engine.hpp"
#include "runtime.hpp"
#include "package_rebuilder.hpp"
#include "logger.hpp"
#undef private
#undef protected
#include <map>

using namespace testing;
using namespace cce::runtime;

#ifndef UT_REPORT_HASH_KEY
#define UT_REPORT_HASH_KEY(taskId, streamId, taskType)               \
    (((static_cast<uint64_t>(taskId) << 32U) & 0xFFFF00000000U) | \
     ((static_cast<uint64_t>(streamId) << 16U) & 0xFFFF0000U) | \
     (static_cast<uint64_t>(taskType) & 0x0000FFFFU))
#endif

class PackageRebuilderTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

TEST_F(PackageRebuilderTest, PackageReportReceive_false)
{
    rtError_t error;
    rtTaskReport_t report;
    report.taskID = 1U;
    report.SOP = 0U;
    report.EOP = 0U;
    report.streamID = 1U;
    report.packageType = 1U;

    uint8_t package[M_PROF_PACKAGE_LEN] = {0U};
    size_t pktLen  = static_cast<size_t>(M_PROF_PACKAGE_LEN);
    TaskInfo task = {};
    task.pkgStat[report.packageType].packageReportNum = 1U;

    std::unique_ptr<PackageRebuilder> pr = std::make_unique<PackageRebuilder>();
    bool ret = pr->PackageReportReceive(&report, package, pktLen, &task);
    EXPECT_EQ(ret, false);

    report.SOP = 1U;
    report.EOP = 1U;
    task.pkgStat[report.packageType].packageReportNum = 2U;
    ret = pr->PackageReportReceive(&report, package, pktLen, &task);
    EXPECT_EQ(ret, false);

    report.SOP = 1U;
    report.MOP = 1U;
    task.pkgStat[report.packageType].packageReportNum = 2U;
    ret = pr->PackageReportReceive(&report, package, pktLen, &task);
    EXPECT_EQ(ret, false);

    report.SOP = 0U;
    report.MOP = 0U;
    ret = pr->PackageReportReceive(&report, package, pktLen, &task);
    EXPECT_EQ(ret, false);

    report.SOP = 1U;
    report.MOP = 0U;
    task.pkgStat[report.packageType].packageReportNum = 2U;
    const uint64_t reportHashVal =
        static_cast<uint64_t>(UT_REPORT_HASH_KEY(report.taskID, report.streamID, report.packageType));
    const size_t packageBufLen =
        static_cast<uint32_t>(task.pkgStat[report.packageType].packageReportNum + 1U) * sizeof(uint32_t);
    pr->rptPkgTbl_[reportHashVal] = static_cast<rtPackageBuf_t *>(malloc(packageBufLen));
    ret = pr->PackageReportReceive(&report, package, pktLen, &task);
    EXPECT_EQ(ret, false);
}

int memset_s_stub(void *str, size_t buf_l, int c, size_t n)
{
    return -1;
}

TEST_F(PackageRebuilderTest, PackageReportReceive_memcpy_fail)
{
    rtError_t error;
    rtTaskReport_t report;
    report.taskID = 1U;
    report.SOP = 1U;
    report.EOP = 1U;
    report.streamID = 1U;
    report.packageType = 1U;

    uint8_t package[M_PROF_PACKAGE_LEN] = {0U};
    size_t pktLen  = static_cast<size_t>(M_PROF_PACKAGE_LEN);
    TaskInfo task = {};
    task.pkgStat[report.packageType].packageReportNum = 2U;

    MOCKER(memset_s).stubs().will(invoke(memset_s_stub));
    std::unique_ptr<PackageRebuilder> pr = std::make_unique<PackageRebuilder>();
    bool ret = pr->PackageReportReceive(&report, package, pktLen, &task);
    EXPECT_EQ(ret, false);
    pr->rptPkgTbl_[1] = static_cast<rtPackageBuf_t *>(malloc(1U));
    GlobalMockObject::verify();
}