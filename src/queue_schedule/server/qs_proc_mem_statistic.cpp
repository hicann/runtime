/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "qs_proc_mem_statistic.h"

#include <string>
#include <fstream>
#include <securec.h>
#include "bqs_util.h"

namespace bqs {
    namespace {
        constexpr const char *VM_RSS_NAME = "VmRSS:";
        constexpr const char *VM_HWM_NAME = "VmHWM:";
        constexpr const char *XSMEME_NAME = "summary:";
        const std::string SVM_STAT_NAME = "peak_page_cnt=";
        constexpr const uint64_t DEFAULT_PAGE_SIZE = 4 * 1024UL;
        constexpr const uint64_t H_PAGE_SIZE = 2 * 1024 * 1024UL;
        constexpr const uint64_t BYTE_TO_KBYTE = 1024UL;
        constexpr const int32_t SVM_VALUE_CNT = 2;
        constexpr const int32_t XSMEM_VALUE_CNT = 2;
    }
    QsProcMemStatistic::QsProcMemStatistic() : runDevice_(false), curPid_(0)
    {
    }

    QsProcMemStatistic::~QsProcMemStatistic()
    {
    }

    bool QsProcMemStatistic::GetSvmInfoFromFile(uint64_t &svmValue)
    {
        std::ifstream svmFile(svmMemCfgFile_);
        if (!svmFile) {
            BQS_LOG_INFO("open svmMem file not success, pid=%d, errno=%d, strerror=%s", static_cast<int32_t>(curPid_),
                         errno, strerror(errno));
            return false;
        }
        const ScopeGuard fileGuard([&svmFile] () { svmFile.close(); });
        std::string svmStrInfo;
        std::string curLine;
        while (getline(svmFile, curLine)) {
            const size_t pos = curLine.find(SVM_STAT_NAME);
            if (pos != std::string::npos) {
                svmStrInfo = curLine.substr(pos);
                break;
            }
        }

        if (svmStrInfo.empty()) {
            BQS_LOG_WARN("svmStrInfo is empty");
            return false;
        }

        uint64_t normalPkgCnt = 0;
        uint64_t hugePkgCnt = 0;
        const int32_t ret = sscanf_s(svmStrInfo.c_str(), "peak_page_cnt=%llu; peak_hpage_cnt=%llu",
                                     &normalPkgCnt, &hugePkgCnt);
        if (ret < SVM_VALUE_CNT) {
            BQS_LOG_WARN("get svmStrInfo:%s failed, ret:%d, peakHPgCnt:%lu, peakHPgCnt:%lu", svmStrInfo.c_str(),
                         ret, normalPkgCnt, hugePkgCnt);
            return false;
        }

        BQS_LOG_INFO("peakPgCnt:%lu, peakHPgCnt:%lu summary:%s.", normalPkgCnt, hugePkgCnt, svmStrInfo.c_str());
        if ((normalPkgCnt == 0UL) && (hugePkgCnt == 0UL)) {
            return false;
        }
        svmValue = normalPkgCnt * DEFAULT_PAGE_SIZE + hugePkgCnt + H_PAGE_SIZE;
        return true;
    }

    void QsProcMemStatistic::StatisticProcSvmMemInfo()
    {
        if (!runDevice_) {
            return;
        }
        uint64_t svmValue = 0UL;
        if (!GetSvmInfoFromFile(svmValue)) {
            return;
        }
        if (svmValue > svmMem_.memHwm) {
            svmMem_.memHwm = svmValue;
        }
        svmMem_.memTotal += svmValue;
        svmMem_.statCnt++;
    }

    bool QsProcMemStatistic::GetXsMemInfoFromFile(uint64_t &xsMemValue)
    {
        std::ifstream inFile(xsMemCfgFile_);
        if (!inFile) {
            BQS_LOG_INFO("open xsMem file not success, pid=%d, errno=%d, strerror=%s", static_cast<int32_t>(curPid_),
                         errno, strerror(errno));
            return false;
        }
        const ScopeGuard fileGuard([&inFile] () { inFile.close(); });
        std::string summaryStr;
        std::string inputLine;
        while (getline(inFile, inputLine)) {
            if (inputLine.compare(0, strlen(XSMEME_NAME), XSMEME_NAME) == 0) {
                summaryStr = std::move(inputLine);
                break;
            }
        }

        if (summaryStr.empty()) {
            BQS_LOG_WARN("summaryStr is empty");
            return false;
        }

        uint64_t allocSize = 0;
        uint64_t realSize = 0;
        const int32_t ret = sscanf_s(summaryStr.c_str(), "summary: %llu %llu", &allocSize, &realSize);
        if (ret < XSMEM_VALUE_CNT) {
            BQS_LOG_WARN("read summaryStr:%s failed, ret:%d, allocsize:%lu, real size:%lu", summaryStr.c_str(), ret,
                         allocSize, realSize);
            return false;
        }

        BQS_LOG_INFO("allocsize:%lu B, real size:%lu B, %s.", allocSize, realSize, summaryStr.c_str());
        if (realSize == 0) {
            return false;
        }
        xsMemValue = realSize;
        return true;
    }

    void QsProcMemStatistic::StatisticProcXsMemInfo()
    {
        uint64_t xsMemValue = 0UL;
        if (!GetXsMemInfoFromFile(xsMemValue)) {
            return;
        }
        if (xsMemValue > xsMem_.memHwm) {
            xsMem_.memHwm = xsMemValue;
        }
        xsMem_.memTotal += xsMemValue;
        xsMem_.statCnt++;
    }

    bool QsProcMemStatistic::GetOsMemInfoFromFile(uint64_t &rssValue, uint64_t &hwmValue)
    {
        std::ifstream ifFile(rssMemCfgFile_);
        if (!ifFile) {
            BQS_LOG_INFO("open rss file not success, pid=%d, errno=%d, strerror=%s", static_cast<int32_t>(curPid_),
                         errno, strerror(errno));
            return false;
        }
        const ScopeGuard fileGuard([&ifFile] () { ifFile.close(); });
        std::string vmRssStr;
        std::string vmHwmStr;
        std::string inputLine;
        while (getline(ifFile, inputLine)) {
            if (inputLine.compare(0, strlen(VM_RSS_NAME), VM_RSS_NAME) == 0) {
                vmRssStr = std::move(inputLine);
            } else if (inputLine.compare(0, strlen(VM_HWM_NAME), VM_HWM_NAME) == 0) {
                vmHwmStr = std::move(inputLine);
            } else {
                continue;
            }
            if ((!vmRssStr.empty()) && (!vmHwmStr.empty())) {
                break;
            }
        }

        if ((vmRssStr.empty()) || (vmHwmStr.empty())) {
            BQS_LOG_RUN_INFO("cannot get vmrss or vmhwm");
            return false;
        }

        if (!bqs::TransStrToull(vmRssStr.substr(strlen(VM_RSS_NAME)), rssValue)) {
            BQS_LOG_INFO("get vmRssError:%s nok", vmRssStr.c_str());
            return false;
        }

        if (!bqs::TransStrToull(vmHwmStr.substr(strlen(VM_HWM_NAME)), hwmValue)) {
            BQS_LOG_INFO("get vmHwmError:%s nok", vmRssStr.c_str());
            return false;
        }
        BQS_LOG_INFO("vmRss:%lu KB, vmHwm:%lu KB.", rssValue, hwmValue);
        return true;
    }

    void QsProcMemStatistic::StatisticProcOsMemInfo()
    {
        uint64_t rssValue = 0UL;
        uint64_t hwmValue = 0UL;
        if (!GetOsMemInfoFromFile(rssValue, hwmValue)) {
            BQS_LOG_INFO("get os meminfo nok");
            return;
        }
        rssMem_.memHwm = hwmValue;
        rssMem_.memTotal += rssValue;
        rssMem_.statCnt++;
    }

    void QsProcMemStatistic::StatisticProcMemInfo()
    {
        StatisticProcOsMemInfo();
        StatisticProcXsMemInfo();
        StatisticProcSvmMemInfo();
    }

    bool QsProcMemStatistic::InitProcMemStatistic()
    {
        runDevice_ = (bqs::GetRunContext() == bqs::RunContext::DEVICE);
        auto ret = memset_s(&rssMem_, sizeof(rssMem_), 0x00, sizeof(rssMem_));
        if (ret != EOK) {
            BQS_LOG_ERROR("memset rssMem failed ret:%d", ret);
            return false;
        }
        
        ret = memset_s(&svmMem_, sizeof(svmMem_), 0x00, sizeof(svmMem_));
        if (ret != EOK) {
            BQS_LOG_ERROR("memset svmMem_ failed ret:%d", ret);
            return false;
        }

        ret = memset_s(&xsMem_, sizeof(xsMem_), 0x00, sizeof(xsMem_));
        if (ret != EOK) {
            BQS_LOG_ERROR("memset xsMem_ failed ret:%d", ret);
            return false;
        }
        curPid_ = getpid();
        if (curPid_ < 0) {
            BQS_LOG_ERROR("get pid error:%d", curPid_);
            return false;
        }
        rssMemCfgFile_ = "/proc/" + std::to_string(curPid_) + "/status";
        xsMemCfgFile_  = "/proc/xsmem/task/" + std::to_string(curPid_) + "/summary";
        svmMemCfgFile_ = "/proc/svm/task/" + std::to_string(curPid_) + "/summary";
        return true;
    }

    void QsProcMemStatistic::PrintOutProcMemInfo(const uint32_t hostPid)
    {
        uint64_t rssavg = 0UL;
        if (rssMem_.statCnt > 0) {
            rssavg = rssMem_.memTotal / rssMem_.statCnt;
        }
        BQS_LOG_INFO("rssavg:%lu KB, rsstotal:%lu KB, rsscnt:%lu", rssavg, rssMem_.memTotal, rssMem_.statCnt);
        uint64_t xsmAvg = 0UL;
        if (xsMem_.statCnt > 0) {
            xsmAvg = xsMem_.memTotal / xsMem_.statCnt;
        }
        BQS_LOG_INFO("xsmAvg:%lu B, xsmtotal:%lu B, xsmcnt:%lu", xsmAvg, xsMem_.memTotal, xsMem_.statCnt);
        if (runDevice_) {
            uint64_t svmAvg = 0UL;
            if (svmMem_.statCnt > 0) {
                svmAvg = svmMem_.memTotal / svmMem_.statCnt;
            }
            BQS_LOG_INFO("svmAvg:%lu B, svmtotal:%lu B, svmcnt:%lu", svmAvg, svmMem_.memTotal, svmMem_.statCnt);
            BQS_LOG_RUN_INFO("proc_metrics:pid=%u, rssavg=%lu B, rsshwm=%lu B, xsmemavg=%lu B, xsmemhwm=%lu B, "
                             "svmmemavg=%lu B, svmmemhwm=%lu B", hostPid, rssavg * BYTE_TO_KBYTE,
                             rssMem_.memHwm * BYTE_TO_KBYTE, xsmAvg, xsMem_.memHwm, svmAvg, svmMem_.memHwm);
        } else {
            BQS_LOG_RUN_INFO("proc_metrics:pid=%u, rssavg=%lu B, rsshwm=%lu B, xsmemavg=%lu B, xsmemhwm=%lu B",
                             hostPid, rssavg * BYTE_TO_KBYTE, rssMem_.memHwm * BYTE_TO_KBYTE, xsmAvg, xsMem_.memHwm);
        }
    }
}
