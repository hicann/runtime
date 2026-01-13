/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_TIMER_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_TIMER_H

#include <bitset>
#include <map>
#include <mutex>
#include <fstream>
#include "memory/chunk_pool.h"
#include "message/prof_params.h"
#include "singleton/singleton.h"
#include "thread/thread.h"
#include "transport/uploader.h"
#include "utils/utils.h"


namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::utils;
const char * const PROF_PROC_STAT = "/proc/stat";
const char * const PROF_PROC_MEM = "/proc/meminfo";
const char * const PROF_NET_STAT = "/proc/net/dev";
const char * const PROF_PROC_UPTIME = "/proc/uptime";
constexpr uint32_t PROC_STAT_USELESS_DATA_SIZE = 512;
constexpr uint32_t PROC_PID_STAT_DATA_SIZE = 512;
constexpr uint32_t PROC_MEM_USELESS_DATA_SIZE = 1536;
constexpr uint32_t PROC_PID_MEM_DATA_SIZE = 32;
constexpr uint32_t PROC_PID_NUM = 128;

enum TimerHandlerTag {
    PROF_SYS_STAT,
    PROF_SYS_MEM,
    PROF_ALL_PID,
    PROF_HOST_PROC_CPU,
    PROF_HOST_PROC_MEM,
    PROF_HOST_ALL_PID,
    PROF_HOST_ALL_PID_CPU,
    PROF_HOST_ALL_PID_MEM,
    PROF_HOST_SYS_NETWORK,
    PROF_NETDEV_STATS,
    PROF_NONE
};

class TimerHandler {
public:
    explicit TimerHandler(TimerHandlerTag tag);
    virtual ~TimerHandler();
public:
    virtual int32_t Execute() = 0;
    virtual int32_t Init() = 0;
    virtual int32_t Uinit() = 0;
    TimerHandlerTag GetTag();
private:
    TimerHandlerTag tag_;
};

struct TimerAttr {
    TimerAttr(TimerHandlerTag tg, int32_t id, uint32_t size, uint64_t interval) : tag(tg), devId(id),
        bufSize(size), sampleInterval(interval), srcFileName(""), retFileName(""), pid(0) {}
    TimerHandlerTag tag;
    int32_t devId;
    uint32_t bufSize;
    uint64_t sampleInterval;
    std::string srcFileName;
    std::string retFileName;
    uint32_t pid;
};

class ProcTimerHandler : public TimerHandler {
public:
    ProcTimerHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                     SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                     SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                     SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcTimerHandler() override;

public:
    int32_t Execute() override;
    int32_t Init() override;
    int32_t Uinit() override;
protected:
    virtual void ParseProcFile(std::ifstream &ifs, std::string &data) = 0;

protected:
    void PacketData(std::string &dest, std::string &data, uint32_t headSize);
    void StoreData(std::string &data);
    void SendData(CONST_UNSIGNED_CHAR_PTR buf, uint32_t size);
    void FlushBuf();
    bool IsValidData(std::ifstream &ifs, std::string &data) const;
    bool CheckFileSize(const std::string &file) const;

protected:
    analysis::dvvp::common::memory::Chunk buf_;
    std::ifstream if_;

private:
    volatile bool isInited_;
    unsigned long long prevTimeStamp_;
    unsigned long long sampleIntervalNs_;
    uint32_t index_;
    std::string srcFileName_;
    std::string retFileName_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param_;
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader_;
};

class ProcHostCpuHandler : public ProcTimerHandler {
public:
    ProcHostCpuHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                       SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcHostCpuHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
    void ParseProcTidStat(std::string &data);
    void ParseSysTime(std::string &data);

private:
    std::string sysTimeSrc_;
    std::string taskSrc_;
};

class ProcHostMemHandler : public ProcTimerHandler {
public:
    ProcHostMemHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                       SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcHostMemHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
    void ParseProcMemUsage(std::string &data);

private:
    std::string statmSrc_;
};

class ProcHostNetworkHandler : public ProcTimerHandler {
public:
    ProcHostNetworkHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                           SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                           SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                           SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcHostNetworkHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
    void ParseNetStat(std::string &data);
};

class ProcStatFileHandler : public ProcTimerHandler {
public:
    ProcStatFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                        SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                        SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcStatFileHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
};

class ProcPidStatFileHandler : public ProcTimerHandler {
public:
    ProcPidStatFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                           SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                           SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                           SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcPidStatFileHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
    void GetProcessName(std::string &processName);
private:
    uint32_t pid_;
    std::ifstream ifStat_;
};

class ProcMemFileHandler : public ProcTimerHandler {
public:
    ProcMemFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                       SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcMemFileHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
};

class ProcPidMemFileHandler : public ProcTimerHandler {
public:
    ProcPidMemFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                          SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                          SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                          SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcPidMemFileHandler() override;

private:
    void ParseProcFile(std::ifstream &ifs, std::string &data) override;
    void GetProcessName(std::string &processName);

private:
    uint32_t pid_;
};

class ProcPidFileHandler {
public:
    ProcPidFileHandler() {}
    virtual ~ProcPidFileHandler() {}
    void Execute();

public:
    SHARED_PTR_ALIA<ProcPidMemFileHandler>  memHandler_;
    SHARED_PTR_ALIA<ProcPidStatFileHandler> statHandler_;
};

class ProcAllPidsFileHandler : public TimerHandler {
public:
    ProcAllPidsFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
        SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
        SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader);
    ~ProcAllPidsFileHandler() override;

public:
    int32_t Execute() override;
    int32_t Init() override;
    int32_t Uinit() override;

public:
    static void GetProcessName(uint32_t pid, std::string &processName);

private:
    void ParseProcFile(const std::ifstream &ifs, const std::string &data) const;
    void GetCurPids(std::vector<uint32_t> &curPids) const;
    void GetNewExitPids(std::vector<uint32_t> &curPids, std::vector<uint32_t> &prevPids,
            std::vector<uint32_t> &newPids, std::vector<uint32_t> &exitPids) const;
    void HandleNewPids(std::vector<uint32_t> &newPids);
    void HandleExitPids(std::vector<uint32_t> &exitPids);

private:
    uint32_t devId_;
    unsigned long long prevTimeStamp_;
    unsigned long long sampleIntervalNs_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param_;
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader_;

    std::map<uint32_t, SHARED_PTR_ALIA<ProcPidFileHandler> > pidsMap_;
    std::vector<uint32_t> prevPids_;
};

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define DCMI_OK 0

struct dcmi_network_pkt_stats_info {
    unsigned long long mac_tx_mac_pause_num;
    unsigned long long mac_rx_mac_pause_num;
    unsigned long long mac_tx_pfc_pkt_num;
    unsigned long long mac_tx_pfc_pri0_pkt_num;
    unsigned long long mac_tx_pfc_pri1_pkt_num;
    unsigned long long mac_tx_pfc_pri2_pkt_num;
    unsigned long long mac_tx_pfc_pri3_pkt_num;
    unsigned long long mac_tx_pfc_pri4_pkt_num;
    unsigned long long mac_tx_pfc_pri5_pkt_num;
    unsigned long long mac_tx_pfc_pri6_pkt_num;
    unsigned long long mac_tx_pfc_pri7_pkt_num;
    unsigned long long mac_rx_pfc_pkt_num;
    unsigned long long mac_rx_pfc_pri0_pkt_num;
    unsigned long long mac_rx_pfc_pri1_pkt_num;
    unsigned long long mac_rx_pfc_pri2_pkt_num;
    unsigned long long mac_rx_pfc_pri3_pkt_num;
    unsigned long long mac_rx_pfc_pri4_pkt_num;
    unsigned long long mac_rx_pfc_pri5_pkt_num;
    unsigned long long mac_rx_pfc_pri6_pkt_num;
    unsigned long long mac_rx_pfc_pri7_pkt_num;
    unsigned long long mac_tx_total_pkt_num;
    unsigned long long mac_tx_total_oct_num;
    unsigned long long mac_tx_bad_pkt_num;
    unsigned long long mac_tx_bad_oct_num;
    unsigned long long mac_rx_total_pkt_num;
    unsigned long long mac_rx_total_oct_num;
    unsigned long long mac_rx_bad_pkt_num;
    unsigned long long mac_rx_bad_oct_num;
    unsigned long long mac_rx_fcs_err_pkt_num;
    unsigned long long roce_rx_rc_pkt_num;
    unsigned long long roce_rx_all_pkt_num;
    unsigned long long roce_rx_err_pkt_num;
    unsigned long long roce_tx_rc_pkt_num;
    unsigned long long roce_tx_all_pkt_num;
    unsigned long long roce_tx_err_pkt_num;
    unsigned long long roce_cqe_num;
    unsigned long long roce_rx_cnp_pkt_num;
    unsigned long long roce_tx_cnp_pkt_num;
    unsigned long long roce_err_ack_num;
    unsigned long long roce_err_psn_num;
    unsigned long long roce_verification_err_num;
    unsigned long long roce_err_qp_status_num;
    unsigned long long roce_new_pkt_rty_num;
    unsigned long long roce_ecn_db_num;
    unsigned long long nic_tx_all_pkg_num;
    unsigned long long nic_tx_all_oct_num;
    unsigned long long nic_rx_all_pkg_num;
    unsigned long long nic_rx_all_oct_num;
    long tv_sec;
    long tv_usec;
    unsigned char reserved[64];
};

#ifdef __cplusplus
}
#endif

using DcmiInitFunc = int (*)();
using DcmiGetCardListFunc = int (*)(int *cardNum, int *cardList, int listLen);
using DcmiGetDeviceNumInCardFunc_ = int (*)(int cardId, int *deviceNum);
using DcmiGetNetdevPktStatsInfoFunc = int (*)(int cardId, int deviceId, int portId,
    struct dcmi_network_pkt_stats_info *statsInfo);

class NetDevStatsHandler : public TimerHandler {
public:
    NetDevStatsHandler(size_t bufSize, uint64_t sampleIntervalNs, std::string jobId,
        SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx);
    ~NetDevStatsHandler() override = default;

    int32_t Execute() override;
    int32_t Init() override;
    int32_t Uinit() override;
    int32_t RegisterDevTask(uint32_t devId);
    int32_t RemoveDevTask(uint32_t devId);
    size_t GetCurDevTaskCount();

private:
    void StoreData(uint32_t devId, std::string data);
    void SendData(uint32_t devId, CONST_UNSIGNED_CHAR_PTR buf, size_t size);
    bool GetDcmiCardDevId(uint32_t devId, int &dcmiCardId, int &dcmiDevId) const;
    std::unordered_map<uint32_t, std::pair<int, int>> GetCurDcmiCardDevIdMap();

    int32_t LoadDcmiApi();

private:
    volatile bool isInited_;
    unsigned long long prevTimeStamp_;
    unsigned long long  sampleIntervalNs_;
    size_t bufSize_;
    std::string retFileName_;
    std::string jobId_;
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx_;

    std::mutex devTaskMtx_;
    std::unordered_map<uint32_t, std::pair<int, int>> dcmiCardDevIdMap_;
    std::unordered_map<uint32_t, SHARED_PTR_ALIA<analysis::dvvp::common::memory::Chunk>> devTaskBufs_;

    VOID_PTR dcmiLibHandle_ = nullptr;
    DcmiInitFunc dcmiInit_ = nullptr;
    DcmiGetCardListFunc dcmiGetCardList_ = nullptr;
    DcmiGetDeviceNumInCardFunc_ dcmiGetDeviceNumInCard_ = nullptr;
    DcmiGetNetdevPktStatsInfoFunc dcmiGetNetdevPktStatsInfo_ = nullptr;
};

struct TimerParam {
    explicit TimerParam(unsigned long interval)
        : intervalUsec(interval)
    {}
    unsigned long intervalUsec;
};

class ProfTimer : public analysis::dvvp::common::thread::Thread {
public:
    explicit ProfTimer(SHARED_PTR_ALIA<struct TimerParam> timerParam);
    ~ProfTimer() override;

public:
    int32_t RegisterTimerHandler(TimerHandlerTag tag, SHARED_PTR_ALIA<TimerHandler> handler);
    int32_t RemoveTimerHandler(TimerHandlerTag tag);
    SHARED_PTR_ALIA<TimerHandler> GetTimerHandler(TimerHandlerTag tag);

public:
    int32_t Init();
    int32_t Uinit();
    int32_t Start() override;
    int32_t Stop() override;

protected:
    void Run(const struct error_message::Context &errorContext) override;

private:
    int32_t Handler();

private:
    volatile bool isStarted_;
    SHARED_PTR_ALIA<struct TimerParam> timerParam_;
    std::mutex mtx_;
    std::map<enum TimerHandlerTag, SHARED_PTR_ALIA<TimerHandler> > handlerMap_;
};

class TimerManager : public analysis::dvvp::common::singleton::Singleton<TimerManager> {
    friend analysis::dvvp::common::singleton::Singleton<TimerManager>;
public:
    void StartProfTimer();
    void StopProfTimer();
    void RegisterProfTimerHandler(TimerHandlerTag tag, SHARED_PTR_ALIA<TimerHandler> handler);
    void RemoveProfTimerHandler(TimerHandlerTag tag);
    SHARED_PTR_ALIA<TimerHandler> GetProfTimerHandler(TimerHandlerTag tag);

protected:
    TimerManager();
    ~TimerManager() override;

private:
    volatile int32_t profTimerCnt_;
    std::mutex profTimerMtx_;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::ProfTimer> profTimer_;
};
}
}
}
#endif
