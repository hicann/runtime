/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_proc_mem_statistic.h"

#include <string>
#include <fstream>
#include "aicpusd_util.h"

namespace AicpuSchedule {
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
    AicpuSdProcMemStatistic::AicpuSdProcMemStatistic() : deployCtx_(DeployContext::HOST), curPid_(0)
    {
    }
 
    AicpuSdProcMemStatistic::~AicpuSdProcMemStatistic()
    {
    }

    void AicpuSdProcMemStatistic::StatisticProcSvmMemInfo()
    {
        if (deployCtx_ != DeployContext::DEVICE) {
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

    bool AicpuSdProcMemStatistic::GetSvmInfoFromFile(uint64_t &svmValue)
    {
        std::ifstream inFile(svmMemCfgFile_);
        if (!inFile) {
            aicpusd_info("open svmMem file not success, pid=%d, errno=%d, strerror=%s", static_cast<int32_t>(curPid_),
                         errno, strerror(errno));
            return false;
        }
        const ScopeGuard fileGuard([&inFile] () { inFile.close(); });
        std::string summaryStr;
        std::string inputLine;
        while (getline(inFile, inputLine)) {
            const size_t pos = inputLine.find(SVM_STAT_NAME);
            if (pos != std::string::npos) {
                summaryStr = inputLine.substr(pos);
                break;
            }
        }

        if (summaryStr.empty()) {
            aicpusd_warn("summaryStr is empty");
            return false;
        }

        uint64_t peakPgCnt = 0;
        uint64_t peakHPgCnt = 0;
        const int32_t ret = sscanf_s(summaryStr.c_str(), "peak_page_cnt=%llu; peak_hpage_cnt=%llu",
                                     &peakPgCnt, &peakHPgCnt);
        if (ret < SVM_VALUE_CNT) {
            aicpusd_warn("read summaryStr:%s failed, ret:%d, peakHPgCnt:%llu, peakHPgCnt:%llu", summaryStr.c_str(), ret,
                         peakPgCnt, peakHPgCnt);
            return false;
        }

        aicpusd_info("peakPgCnt:%lu, peakHPgCnt:%lu summary:%s.", peakPgCnt, peakHPgCnt, summaryStr.c_str());
        if ((peakPgCnt == 0) && (peakHPgCnt == 0UL)) {
            return false;
        }
        svmValue = peakPgCnt * DEFAULT_PAGE_SIZE + peakHPgCnt + H_PAGE_SIZE;
        return true;
    }

    bool AicpuSdProcMemStatistic::GetXsMemInfoFromFile(uint64_t &xsMemValue)
    {
        std::ifstream inFile(xsMemCfgFile_);
        if (!inFile) {
            aicpusd_info("open xsMem file not success, pid=%d, errno=%d, strerror=%s", static_cast<int32_t>(curPid_),
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
            aicpusd_warn("summaryStr is empty");
            return false;
        }

        uint64_t allocSize = 0;
        uint64_t realSize = 0;
        const int32_t ret = sscanf_s(summaryStr.c_str(), "summary: %llu %llu", &allocSize, &realSize);
        if (ret < XSMEM_VALUE_CNT) {
            aicpusd_warn("read summaryStr:%s failed, ret:%d, allocsize:%llu, real size:%llu", summaryStr.c_str(), ret,
                         allocSize, realSize);
            return false;
        }

        aicpusd_info("allocsize:%lu B, real size:%lu B, %s.", allocSize, realSize, summaryStr.c_str());
        if (realSize == 0) {
            return false;
        }
        xsMemValue = realSize;
        return true;
    }

    void AicpuSdProcMemStatistic::StatisticProcXsMemInfo()
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

    bool AicpuSdProcMemStatistic::GetOsMemInfoFromFile(uint64_t &rssValue, uint64_t &hwmValue)
    {
        std::ifstream ifFile(rssMemCfgFile_);
        if (!ifFile) {
            aicpusd_info("open rss file not success, pid=%d, errno=%d, strerror=%s", static_cast<int32_t>(curPid_),
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
            aicpusd_run_info("cannot get vmrss or vmhwm");
            return false;
        }

        if (!AicpuUtil::TransStrToull(vmRssStr.substr(strlen(VM_RSS_NAME)), rssValue)) {
            aicpusd_warn("get vmRssError:%s failed", vmRssStr.c_str());
            return false;
        }

        if (!AicpuUtil::TransStrToull(vmHwmStr.substr(strlen(VM_HWM_NAME)), hwmValue)) {
            aicpusd_warn("get vmHwmError:%s failed", vmHwmStr.c_str());
            return false;
        }
        aicpusd_info("vmRss:%llu KB, vmHwm:%llu KB.", rssValue, hwmValue);
        return true;
    }

    void AicpuSdProcMemStatistic::StatisticProcOsMemInfo()
    {
        uint64_t rssValue = 0UL;
        uint64_t hwmValue = 0UL;
        if (!GetOsMemInfoFromFile(rssValue, hwmValue)) {
            aicpusd_warn("get os meminfo failed");
            return;
        }
        rssMem_.memHwm = hwmValue;
        rssMem_.memTotal += rssValue;
        rssMem_.statCnt++;
    }

    void AicpuSdProcMemStatistic::StatisticProcMemInfo()
    {
        StatisticProcOsMemInfo();
        StatisticProcXsMemInfo();
        StatisticProcSvmMemInfo();
    }

    bool AicpuSdProcMemStatistic::InitProcMemStatistic()
    {
        auto ret = memset_s(&rssMem_, sizeof(rssMem_), 0x00, sizeof(rssMem_));
        if (ret != EOK) {
            aicpusd_err("memset rssMem failed ret:%d", ret);
            return false;
        }
        
        ret = memset_s(&svmMem_, sizeof(svmMem_), 0x00, sizeof(svmMem_));
        if (ret != EOK) {
            aicpusd_err("memset svmMem_ failed ret:%d", ret);
            return false;
        }

        ret = memset_s(&xsMem_, sizeof(xsMem_), 0x00, sizeof(xsMem_));
        if (ret != EOK) {
            aicpusd_err("memset xsMem_ failed ret:%d", ret);
            return false;
        }
        (void)GetAicpuDeployContext(deployCtx_);
        curPid_ = getpid();
        if (curPid_ < 0) {
            aicpusd_err("get pid error:%d", curPid_);
            return false;
        }
        rssMemCfgFile_ = "/proc/" + std::to_string(curPid_) + "/status";
        xsMemCfgFile_  = "/proc/xsmem/task/" + std::to_string(curPid_) + "/summary";
        svmMemCfgFile_ = "/proc/svm/task/" + std::to_string(curPid_) + "/summary";
        return true;
    }

    void AicpuSdProcMemStatistic::PrintOutProcMemInfo(const uint32_t hostPid)
    {
        uint64_t rssavg = 0UL;
        if (rssMem_.statCnt > 0) {
            rssavg = rssMem_.memTotal / rssMem_.statCnt;
        }
        aicpusd_info("rssavg:%llu KB, rsstotal:%llu KB, rsscnt:%llu", rssavg, rssMem_.memTotal, rssMem_.statCnt);
        uint64_t xsmAvg = 0UL;
        if (xsMem_.statCnt > 0) {
            xsmAvg = xsMem_.memTotal / xsMem_.statCnt;
        }
        aicpusd_info("xsmAvg:%llu B, xsmtotal:%llu B, xsmcnt:%llu", xsmAvg, xsMem_.memTotal, xsMem_.statCnt);
        if (deployCtx_ == DeployContext::DEVICE) {
            uint64_t svmAvg = 0UL;
            if (svmMem_.statCnt > 0) {
                svmAvg = svmMem_.memTotal / svmMem_.statCnt;
            }
            aicpusd_info("svmAvg:%llu B, svmtotal:%llu B, svmcnt:%llu", svmAvg, svmMem_.memTotal, svmMem_.statCnt);
            aicpusd_run_info("proc_metrics:pid=%u, rssavg=%lu B, rsshwm=%llu B, xsmemavg=%llu B, xsmemhwm=%lu B, "
                             "svmmemavg=%llu B, svmmemhwm=%lu B", hostPid, rssavg * BYTE_TO_KBYTE,
                             rssMem_.memHwm * BYTE_TO_KBYTE, xsmAvg, xsMem_.memHwm, svmAvg, svmMem_.memHwm);
        } else {
            aicpusd_run_info("proc_metrics:pid=%u, rssavg=%lu B, rsshwm=%llu B, xsmemavg=%llu B, xsmemhwm=%lu B",
                             hostPid, rssavg * BYTE_TO_KBYTE, rssMem_.memHwm * BYTE_TO_KBYTE, xsmAvg, xsMem_.memHwm);
        }
    }
}
