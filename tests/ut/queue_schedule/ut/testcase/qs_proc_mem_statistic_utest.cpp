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
#include "qs_proc_mem_statistic.h"
#include "bqs_util.h"
#undef private

using namespace std;
using namespace bqs;
class QsProcMemStatisticTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "QsProcMemStatisticTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "QsProcMemStatisticTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "QsProcMemStatisticTest SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "QsProcMemStatisticTest TearDown" << std::endl;
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
TEST_F(QsProcMemStatisticTest, SvmMemStatHost) {
    std::string svmFile = "/tmp/svmstat";
    std::string fileInfo = "peak_page_cnt=1234; peak_hpage_cnt=456";
    if (WriteStatFile(svmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.runDevice_ = false;
        procMem.StatisticProcSvmMemInfo();
        procMem.PrintOutProcMemInfo(123U);
        remove(svmFile.c_str());
        EXPECT_NE(procMem.svmMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, SvmMemStatDevice) {
    std::string svmFile = "/tmp/svmstat";
    std::string fileInfo = "peak_page_cnt=1234; peak_hpage_cnt=456";
    if (WriteStatFile(svmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.runDevice_ = true;
        procMem.StatisticProcSvmMemInfo();
        procMem.PrintOutProcMemInfo(123U);
        remove(svmFile.c_str());
        EXPECT_EQ(procMem.svmMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, SvmMemStatFailed1) {
    std::string svmFile = "/tmp/svmstat";
    std::string fileInfo = "peak_page_cnts=1234; peak_hpage_cnt=456";
    if (WriteStatFile(svmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.runDevice_ = true;
        procMem.StatisticProcSvmMemInfo();
        remove(svmFile.c_str());
        EXPECT_NE(procMem.svmMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, SvmMemStatFailed2) {
    std::string svmFile = "/tmp/svmstat";
    std::string fileInfo = "peak_page_cnt=1234;";
    if (WriteStatFile(svmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.svmMem_.statCnt = 0UL;
        procMem.svmMemCfgFile_ = svmFile;
        procMem.runDevice_ = true;
        procMem.StatisticProcSvmMemInfo();
        remove(svmFile.c_str());
        EXPECT_NE(procMem.svmMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, xsMemStat) {
    std::string xsmFile = "/tmp/xsmstat";
    std::string fileInfo = "summary: 1234 1234";
    if (WriteStatFile(xsmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.xsMem_.statCnt = 0UL;
        procMem.xsMemCfgFile_ = xsmFile;
        procMem.StatisticProcXsMemInfo();
        procMem.PrintOutProcMemInfo(123U);
        remove(xsmFile.c_str());
        EXPECT_EQ(procMem.xsMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, xsMemStatFailed1) {
    std::string xsmFile = "/tmp/xsmstat";
    std::string fileInfo = "summarys: 1234 1234";
    if (WriteStatFile(xsmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.xsMem_.statCnt = 0UL;
        procMem.xsMemCfgFile_ = xsmFile;
        procMem.StatisticProcXsMemInfo();
        remove(xsmFile.c_str());
        EXPECT_NE(procMem.xsMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, xsMemStatFailed2) {
    std::string xsmFile = "/tmp/xsmstat";
    std::string fileInfo = "summary: 1234";
    if (WriteStatFile(xsmFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.xsMem_.statCnt = 0UL;
        procMem.xsMemCfgFile_ = xsmFile;
        procMem.StatisticProcXsMemInfo();
        remove(xsmFile.c_str());
        EXPECT_TRUE(procMem.xsMem_.statCnt == 0UL);
        std::string paseStr = "1234";
        uint64_t value = 0UL;
        EXPECT_TRUE(bqs::TransStrToull(paseStr, value) == true);
        EXPECT_EQ(value, 1234UL);
        value = 0UL;
        std::string paseStr1 = "uid=";
        EXPECT_TRUE(bqs::TransStrToull(paseStr1, value) == false);
    }
}

TEST_F(QsProcMemStatisticTest, rssStatFailed1) {
    std::string rssFile = "/tmp/rsstat";
    std::string fileInfo = "summary: 1234";
    QsProcMemStatistic procMem;
    procMem.rssMem_.statCnt = 0UL;
    procMem.rssMemCfgFile_ = rssFile;
    uint64_t rssValue = 0UL;
    uint64_t hwmValue = 0UL;
    auto ret = procMem.GetOsMemInfoFromFile(rssValue, hwmValue);
    EXPECT_EQ(ret, false);
}

TEST_F(QsProcMemStatisticTest, rssStatFailed2) {
    std::string rssFile = "/tmp/rsstat";
    std::string fileInfo = "summary: 1234";
    if (WriteStatFile(rssFile, fileInfo)) {
        QsProcMemStatistic procMem;
        procMem.rssMem_.statCnt = 0UL;
        procMem.rssMemCfgFile_ = rssFile;
        procMem.StatisticProcOsMemInfo();
        remove(rssFile.c_str());
        EXPECT_NE(procMem.rssMem_.statCnt, 1UL);
    }
}

TEST_F(QsProcMemStatisticTest, rssStatFailed3) {
    std::string rssFile = "/tmp/rsstat";
    std::string fileInfo = "VmRSS:undefine";
    std::string fileInfo2 = "VmHWM:undefine";
    if (WriteStatFileTwo(rssFile, fileInfo, fileInfo2)) {
        QsProcMemStatistic procMem;
        procMem.rssMem_.statCnt = 0UL;
        procMem.rssMemCfgFile_ = rssFile;
        procMem.StatisticProcOsMemInfo();
        remove(rssFile.c_str());
        EXPECT_NE(procMem.rssMem_.statCnt, 1UL);
    }
}