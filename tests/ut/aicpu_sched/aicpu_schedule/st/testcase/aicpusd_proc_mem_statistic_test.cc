/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpusd_proc_mem_statistic.h"
#undef private

using namespace AicpuSchedule;
class AicpuSdProcMemStatisticTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AicpuSdProcMemStatisticTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AicpuSdProcMemStatisticTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpuSdProcMemStatisticTest SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpuSdProcMemStatisticTest TearDown" << std::endl;
    }
};

bool WriteStatFile(const std::string &fileName, const std::string &fileInfo)
{
    std::ofstream ofFile;
    ofFile.open(fileName, std::ios::app);
    if (!ofFile) {
        std::cout << "open "<< fileName << "failed" << std::endl;
        return false;
    }
    ofFile << fileInfo << std::endl;
    ofFile.close();
    return true;
}

TEST_F(AicpuSdProcMemStatisticTest, SvmMemStatDevice) {
    std::string svmFile = "/tmp/svmstat";
    std::string fileInfo = "peak_page_cnt=1234; peak_hpage_cnt=456";
    if (WriteStatFile(svmFile, fileInfo)) {
        AicpuSdProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.deployCtx_ = DeployContext::DEVICE;
        procMem.StatisticProcSvmMemInfo();
        procMem.PrintOutProcMemInfo(123U);
        remove(svmFile.c_str());
        EXPECT_EQ(procMem.svmMem_.statCnt, 1UL);
    }
}

bool WriteStatFileTwo(const std::string &fileName, const std::string &fileInfo, const std::string &fileInfo2)
{
    std::ofstream ofFile;
    ofFile.open(fileName, std::ios::app);
    if (!ofFile) {
        std::cout << "open "<< fileName << "failed" << std::endl;
        return false;
    }
    ofFile << fileInfo << std::endl;
    ofFile << fileInfo2 << std::endl;
    ofFile.close();
    return true;
}

TEST_F(AicpuSdProcMemStatisticTest, xsMemStat) {
    std::string xsmFile = "/tmp/xsmstat";
    std::string fileInfo = "summary: 1234 1234";
    if (WriteStatFile(xsmFile, fileInfo)) {
        AicpuSdProcMemStatistic procMem;
        procMem.xsMem_.statCnt = 0UL;
        procMem.xsMemCfgFile_ = xsmFile;
        procMem.StatisticProcXsMemInfo();
        procMem.PrintOutProcMemInfo(123U);
        remove(xsmFile.c_str());
        EXPECT_EQ(procMem.xsMem_.statCnt, 1UL);
    }
}

TEST_F(AicpuSdProcMemStatisticTest, rssStatFailed1) {
    std::string rssFile = "/tmp/rsstat";
    std::string fileInfo = "summary: 1234";
    if (WriteStatFile(rssFile, fileInfo)) {
        AicpuSdProcMemStatistic procMem;
        procMem.rssMem_.statCnt = 0UL;
        procMem.rssMemCfgFile_ = rssFile;
        procMem.StatisticProcOsMemInfo();
        remove(rssFile.c_str());
    }

    std::string fileInfo1 = "VmRSS:undefine";
    std::string fileInfo2 = "VmHWM:undefine";
    if (WriteStatFileTwo(rssFile, fileInfo1, fileInfo2)) {
        AicpuSdProcMemStatistic procMem;
        procMem.rssMem_.statCnt = 0UL;
        procMem.rssMemCfgFile_ = rssFile;
        procMem.StatisticProcOsMemInfo();
        remove(rssFile.c_str());
    }

    std::string svmFile = "/tmp/svmstat";
    std::string fileInfo3 = "peak_page_cnts=1234; peak_hpage_cnt=456";
    if (WriteStatFile(svmFile, fileInfo3)) {
        AicpuSdProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.deployCtx_ = DeployContext::DEVICE;
        procMem.StatisticProcSvmMemInfo();
        remove(svmFile.c_str());
    }

    std::string fileInfo4 = "peak_page_cnt=1234;";
    if (WriteStatFile(svmFile, fileInfo4)) {
        AicpuSdProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.deployCtx_ = DeployContext::DEVICE;
        procMem.StatisticProcSvmMemInfo();
        remove(svmFile.c_str());
    }

    std::string fileInfo5 = "peak_page_cnt=1234; peak_hpage_cnt=456";
    if (WriteStatFile(svmFile, fileInfo5)) {
        AicpuSdProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.deployCtx_ = DeployContext::HOST;
        procMem.StatisticProcSvmMemInfo();
        procMem.PrintOutProcMemInfo(123U);
        remove(svmFile.c_str());
    }

    std::string xsmFile = "/tmp/xsmstat";
    std::string fileInfo6 = "summarys: 1234 1234";
    if (WriteStatFile(xsmFile, fileInfo6)) {
        AicpuSdProcMemStatistic procMem;
        procMem.xsMem_.statCnt = 0UL;
        procMem.xsMemCfgFile_ = xsmFile;
        procMem.StatisticProcXsMemInfo();
        remove(xsmFile.c_str());
    }

    if (WriteStatFile(xsmFile, fileInfo)) {
        AicpuSdProcMemStatistic procMem;
        procMem.xsMem_.statCnt = 0UL;
        procMem.xsMemCfgFile_ = xsmFile;
        procMem.StatisticProcXsMemInfo();
        remove(xsmFile.c_str());
    }

    AicpuSdProcMemStatistic procMem;
    procMem.rssMem_.statCnt = 0UL;
    procMem.rssMemCfgFile_ = rssFile;
    uint64_t rssValue = 0UL;
    uint64_t hwmValue = 0UL;
    auto ret = procMem.GetOsMemInfoFromFile(rssValue, hwmValue);
    EXPECT_EQ(ret, false);
}