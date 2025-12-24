/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_timer.h"
#include <algorithm>
#include <cstdio>
#include <cctype>
#include <string>
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#include <windows.h>
#else
#include <unistd.h>
#endif
#include "config/config.h"
#include "logger/msprof_dlog.h"
#include "utils/utils.h"
#include "adprof_collector_proxy.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;

const char * const PROC_FILE = "/proc";
const char * const PROC_COMM_FILE = "comm";
const char * const PROC_CPU = "cpu";
const char * const PROC_SELF = "self";
const char * const PROC_PID_STAT = "stat";
const char * const PROC_TID_STAT = "stat";
const char * const PROC_PID_MEM = "statm";

const char * const PROC_TASK = "task";

const char * const PROF_PID_MEM_FILE = "Memory.data";
const char * const PROF_PID_STAT_FILE = "CpuUsage.data";

const char * const PROF_DATA_TIMER_STAMP = "TimeStamp:";
const char * const PROF_DATA_INDEX = "\nIndex:";
const char * const PROF_DATA_LEN = "\nDataLen:";
const char * const PROF_DATA_PROCESSNAME = "ProcessName:";

TimerHandler::TimerHandler(TimerHandlerTag tag)
    : tag_(tag)
{
}

TimerHandler::~TimerHandler()
{
}

TimerHandlerTag TimerHandler::GetTag()
{
    return tag_;
}

ProcTimerHandler::ProcTimerHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                   SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                   SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                   SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : TimerHandler(attr->tag),
      buf_(attr->bufSize),
      isInited_(false),
      prevTimeStamp_(0),
      sampleIntervalNs_(attr->sampleInterval),
      index_(0),
      srcFileName_(attr->srcFileName),
      retFileName_("data/" + attr->retFileName), param_(param), jobCtx_(jobCtx), upLoader_(upLoader)
{
}

ProcTimerHandler::~ProcTimerHandler()
{
}

int32_t ProcTimerHandler::Init()
{
    int32_t ret = PROFILING_FAILED;
    do {
        if (isInited_) {
            MSPROF_LOGE("The Handler is inited");
            MSPROF_INNER_ERROR("EK9999", "The Handler is inited");
            break;
        }

        if (!buf_.Init()) {
            MSPROF_LOGE("Buf init failed");
            MSPROF_INNER_ERROR("EK9999", "Buf init failed");
            break;
        }

        prevTimeStamp_ = 0;
        isInited_ = true;
        ret = PROFILING_SUCCESS;
    } while (0);

    return ret;
}

int32_t ProcTimerHandler::Uinit()
{
    if (!isInited_) {
        return PROFILING_SUCCESS;
    }

    FlushBuf();

    upLoader_.reset();
    buf_.Uninit();

    isInited_ = false;
    return PROFILING_SUCCESS;
}

int32_t ProcTimerHandler::Execute()
{
    static const uint32_t PROF_DATE_HEADER_SIZE = 100; // header size:100B
    do {
        if (!isInited_) {
            MSPROF_LOGE("ProcTimerHandler is not inited: %s", retFileName_.c_str());
            MSPROF_INNER_ERROR("EK9999", "ProcTimerHandler is not inited: %s", retFileName_.c_str());
            break;
        }

        unsigned long long curTimeStamp = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        if ((curTimeStamp - prevTimeStamp_) < sampleIntervalNs_ && (prevTimeStamp_ != 0)) {
            continue;
        }
        std::string src;
        std::string dest;
        prevTimeStamp_ = curTimeStamp;
        if (!srcFileName_.empty()) {
            if (!CheckFileSize(srcFileName_)) {
                break;
            }
            std::string canonicalizedPath = Utils::CanonicalizePath(srcFileName_);
            FUNRET_CHECK_EXPR_ACTION_LOGW(canonicalizedPath.empty(), break,
                "The srcFileName_: %s does not exist or permission denied.", srcFileName_.c_str());
            if_.open(canonicalizedPath, std::ifstream::in);
            FUNRET_CHECK_EXPR_ACTION_LOGW(!if_.is_open(), break, "File %s did not open successfully",
                canonicalizedPath.c_str());
            ParseProcFile(if_, src);
            if_.close();

            PacketData(dest, src, PROF_DATE_HEADER_SIZE);
        } else {
            ParseProcFile(if_, src);
            dest = src;
        }

        StoreData(dest);
        index_++;
    } while (0);

    return PROFILING_SUCCESS;
}

void ProcTimerHandler::PacketData(std::string &dest, std::string &data, uint32_t headSize)
{
    if (data.size() == 0) {
        MSPROF_LOGW("data is empty, fileName:%s", srcFileName_.c_str());
        return;
    }

    dest.reserve(data.size() + headSize);

    dest += PROF_DATA_TIMER_STAMP;
    dest += std::to_string(prevTimeStamp_);

    dest += PROF_DATA_INDEX;
    dest += std::to_string(index_);

    dest += PROF_DATA_LEN;
    dest += std::to_string(data.size());
    dest += "\n";

    dest += data;
    dest += "\n";
}

void ProcTimerHandler::StoreData(std::string &data)
{
    if (data.size() == 0) {
        return;
    }

    if (buf_.GetFreeSize() < data.size() && buf_.GetUsedSize() != 0) {
        // send buf data
        MSPROF_LOGD("StoreData %d", static_cast<int32_t>(buf_.GetUsedSize()));
        SendData(buf_.GetBuffer(), buf_.GetUsedSize());
        buf_.SetUsedSize(0);
    }

    if (buf_.GetFreeSize() < data.size()) {
        // send data
        SendData(reinterpret_cast<CONST_UNSIGNED_CHAR_PTR>(data.c_str()), data.size());
        return;
    }

    const uint32_t spaceSize = buf_.GetFreeSize();
    const uint32_t usedSize = buf_.GetUsedSize();
    auto dataBuf = buf_.GetBuffer();
    if (dataBuf == nullptr) {
        return;
    }
    errno_t err = memcpy_s(static_cast<void *>(const_cast<UNSIGNED_CHAR_PTR>(buf_.GetBuffer() + usedSize)),
                           spaceSize, data.c_str(), data.size());
    if (err != EOK) {
        MSPROF_LOGE("memcpy stat data failed: %d", static_cast<int32_t>(err));
        MSPROF_INNER_ERROR("EK9999", "memcpy stat data failed: %d", static_cast<int32_t>(err));
    } else {
        buf_.SetUsedSize(usedSize + data.size());
    }

    if (buf_.GetFreeSize() <= (buf_.GetBufferSize() * 1) / 4) { // 1 / 4 space size
        // send buf data
        SendData(buf_.GetBuffer(), buf_.GetUsedSize());
        buf_.SetUsedSize(0);
    }
}

void ProcTimerHandler::SendData(CONST_UNSIGNED_CHAR_PTR buf, uint32_t size)
{
    if (buf == nullptr) {
        MSPROF_LOGE("buf to be sent is nullptr");
        MSPROF_INNER_ERROR("EK9999", "buf to be sent is nullptr");
        return;
    }
    TimerHandlerTag tag = GetTag();
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);

    fileChunk->fileName = Utils::PackDotInfo(retFileName_, jobCtx_->tag);
    fileChunk->offset = -1;
    fileChunk->chunk = std::string(reinterpret_cast<CONST_CHAR_PTR>(buf), size);
    fileChunk->chunkSize = size;
    fileChunk->isLastChunk = false;
    fileChunk->extraInfo = Utils::PackDotInfo(jobCtx_->job_id, jobCtx_->dev_id);
    if (tag >= PROF_HOST_PROC_CPU && tag <= PROF_HOST_SYS_NETWORK) {
        fileChunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    } else {
        fileChunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
    }

    if (AdprofCollectorProxy::instance()->AdprofStarted()) {
        AdprofCollectorProxy::instance()->Report(fileChunk);
    } else {
        if (upLoader_ == nullptr) {
            MSPROF_LOGE("[ProcTimerHandler::SendData] upLoader_ is null");
            MSPROF_INNER_ERROR("EK9999", "upLoader_ is null");
            return;
        }
        int32_t ret = upLoader_->UploadData(fileChunk);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[ProcTimerHandler::SendData] Upload Data Failed");
            MSPROF_INNER_ERROR("EK9999", "Upload Data Failed");
        }
    }
}

void ProcTimerHandler::FlushBuf()
{
    MSPROF_LOGI("FlushBuf %s, the total index :%lu", retFileName_.c_str(), index_);

    const size_t usedSize = buf_.GetUsedSize();
    MSPROF_LOGI("FlushBuf, isInited_:%d, bufUsedSize:%d", isInited_ ? 1 : 0, usedSize);
    if (isInited_ && usedSize > 0) {
        SendData(buf_.GetBuffer(), usedSize);
        MSPROF_LOGI("FlushBuf running %d", static_cast<int32_t>(usedSize));
        buf_.SetUsedSize(0);
    }
}

bool ProcTimerHandler::CheckFileSize(const std::string &file) const
{
    int64_t len = analysis::dvvp::common::utils::Utils::GetFileSize(file);
    if (len < 0 || len > MSVP_LARGE_FILE_MAX_LEN) {
        MSPROF_LOGW("[ProcTimerHandler] Proc file(%s) size(%lld)", file.c_str(), len);
        return false;
    }
    return true;
}

bool ProcTimerHandler::IsValidData(std::ifstream &ifs, std::string &data) const
{
    bool isValid = false;
    std::string buf;
    while (std::getline(ifs, buf)) {
        data += buf;
        data += "\n";
        isValid = true;
    }
    return isValid;
}

ProcHostCpuHandler::ProcHostCpuHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                       SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader)
{
    // "/proc/{pid}/task"
    taskSrc_ += PROC_FILE;
    taskSrc_ += MSVP_SLASH;
    taskSrc_ += std::to_string(param->host_sys_pid);
    taskSrc_ += MSVP_SLASH;
    taskSrc_ += PROC_TASK;
}

ProcHostCpuHandler::~ProcHostCpuHandler()
{
}

void ProcHostCpuHandler::ParseProcFile(std::ifstream &ifs /* = ios::in */, std::string &data)
{
    UNUSED(ifs);
    data.reserve(PROC_STAT_USELESS_DATA_SIZE);

    // collect process thread cpu usage data
    std::string procData;
    ParseProcTidStat(procData);
    if (procData.empty()) {
        return;
    }

    data += "time ";
    unsigned long long time = Utils::GetClockMonotonicRaw();
    data += std::to_string(time);
    data += "\n";
    ParseSysTime(data);
    data += procData;
}

void ProcHostCpuHandler::ParseSysTime(std::string &data)
{
    std::string line;
    std::ifstream fin;

    if (!CheckFileSize(PROF_PROC_UPTIME)) {
        return;
    }
    fin.open(PROF_PROC_UPTIME, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), return, "File %s did not open successfully.", PROF_PROC_UPTIME);
    if (std::getline(fin, line)) {
        data += line;
        data += "\n";
    }
    fin.close();
}

void ProcHostCpuHandler::ParseProcTidStat(std::string &data)
{
    std::string line;
    std::ifstream fin;

    std::vector<std::string> tidDirs;
    Utils::GetChildDirs(taskSrc_, false, tidDirs, 0);
    if (tidDirs.empty()) {
        return;
    }
    std::vector<std::string>::iterator it;
    for (it = tidDirs.begin(); it != tidDirs.end(); ++it) {
        std::string statFile = *it + MSVP_SLASH + PROC_TID_STAT;
        if (!CheckFileSize(statFile)) {
            continue;
        }
        statFile = Utils::CanonicalizePath(statFile);
        FUNRET_CHECK_EXPR_ACTION_LOGW(statFile.empty(), continue,
            "The statFile: %s does not exist or permission denied.", statFile.c_str());
        fin.open(statFile, std::ifstream::in);
        FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), continue, "File %s did not open successfully.", statFile.c_str());
        while (std::getline(fin, line)) {
            data += line + "\n";
        }
        fin.close();
    }
}

ProcHostMemHandler::ProcHostMemHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                       SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader)
{
    // "/proc/{pid}/statm"
    statmSrc_ += PROC_FILE;
    statmSrc_ += MSVP_SLASH;
    statmSrc_ += std::to_string(param->host_sys_pid);
    statmSrc_ += MSVP_SLASH;
    statmSrc_ += PROC_PID_MEM;
}

ProcHostMemHandler::~ProcHostMemHandler()
{
}

void ProcHostMemHandler::ParseProcFile(std::ifstream &ifs /* = ios::in */, std::string &data)
{
    UNUSED(ifs);
    data.reserve(PROC_STAT_USELESS_DATA_SIZE);

    // collect process memory usage data
    std::string procData;
    ParseProcMemUsage(procData);
    if (procData.empty()) {
        return;
    }

    unsigned long long time = Utils::GetClockMonotonicRaw();
    data += std::to_string(time);
    data += " ";
    data += procData;
}

void ProcHostMemHandler::ParseProcMemUsage(std::string &data)
{
    std::string line;
    std::ifstream fin;

    if (!CheckFileSize(statmSrc_)) {
        return;
    }
    std::string canonicalizedPath = Utils::CanonicalizePath(statmSrc_);
    FUNRET_CHECK_EXPR_ACTION_LOGW(canonicalizedPath.empty(), return,
        "The statmSrc_: %s does not exist or permission denied.", statmSrc_.c_str());
    fin.open(canonicalizedPath, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), return, "File %s did not open successfully.",
        canonicalizedPath.c_str());
    if (std::getline(fin, line)) {
        data += line + "\n";
    }
    fin.close();
}

ProcHostNetworkHandler::ProcHostNetworkHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                               SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                               SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                               SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader)
{
}

ProcHostNetworkHandler::~ProcHostNetworkHandler()
{
}

void ProcHostNetworkHandler::ParseProcFile(std::ifstream &ifs /* = ios::in */, std::string &data)
{
    UNUSED(ifs);
    data.reserve(PROC_STAT_USELESS_DATA_SIZE);

    data += "time ";
    unsigned long long time = Utils::GetClockMonotonicRaw();
    data += std::to_string(time);
    data += "\n";
    ParseNetStat(data);
}

void ProcHostNetworkHandler::ParseNetStat(std::string &data)
{
    std::string line;
    std::ifstream fin;

    if (!CheckFileSize(PROF_NET_STAT)) {
        return;
    }
    fin.open(PROF_NET_STAT, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), return, "File %s did not open successfully", PROF_NET_STAT);
    while (std::getline(fin, line)) {
        if (line.find(":") != std::string::npos) {
            data += line + "\n";
        }
    }
    fin.close();
}

ProcStatFileHandler::ProcStatFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                         SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                         SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                         SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader)
{
}

ProcStatFileHandler::~ProcStatFileHandler()
{
}

void ProcStatFileHandler::ParseProcFile(std::ifstream &ifs, std::string &data)
{
    data.reserve(PROC_STAT_USELESS_DATA_SIZE);

    std::string buf;

    while (std::getline(ifs, buf)) {
        std::transform (buf.begin(), buf.end(), buf.begin(), static_cast<int32_t (*)(int32_t)>(std::tolower));

        if (buf.find(PROC_CPU) != std::string::npos) {
            data += buf;
            data += "\n";
        } else {
            break;
        }
    }
}

ProcPidStatFileHandler::ProcPidStatFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                               SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                               SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                               SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader), pid_(attr->pid)
{
}

ProcPidStatFileHandler::~ProcPidStatFileHandler()
{
}

void ProcPidStatFileHandler::ParseProcFile(std::ifstream &ifs, std::string &data)
{
    data.reserve(PROC_PID_STAT_DATA_SIZE);
    if (IsValidData(ifs, data)) {
        // pid name
        std::string processName(PROC_SELF);
        ProcAllPidsFileHandler::GetProcessName(pid_, processName);

        data += PROF_DATA_PROCESSNAME;
        data += processName;
        data += "\n";
        std::string buf;
        ifStat_.open(PROF_PROC_STAT, std::ifstream::in);
        FUNRET_CHECK_EXPR_ACTION_LOGW(!ifStat_.is_open(), return, "File %s did not open successfully.", PROF_PROC_STAT);
        while (std::getline(ifStat_, buf)) {
            std::transform (buf.begin(), buf.end(), buf.begin(), static_cast<int32_t (*)(int32_t)>(std::tolower));

            if (buf.find(PROC_CPU) != std::string::npos) {
                data += buf;
                data += "\n";
                break;
            }
        }

        ifStat_.close();
    }
}

ProcMemFileHandler::ProcMemFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                       SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader)
{
}

ProcMemFileHandler::~ProcMemFileHandler()
{
}

void ProcMemFileHandler::ParseProcFile(std::ifstream &ifs, std::string &data)
{
    data.reserve(PROC_MEM_USELESS_DATA_SIZE);

    std::string buf;
    while (std::getline(ifs, buf)) {
        data += buf;
        data += "\n";
    }
}

ProcPidMemFileHandler::ProcPidMemFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                             SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                             SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                             SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : ProcTimerHandler(attr, param, jobCtx, upLoader), pid_(attr->pid)
{
}

ProcPidMemFileHandler::~ProcPidMemFileHandler()
{
}

void ProcPidMemFileHandler::ParseProcFile(std::ifstream &ifs, std::string &data)
{
    data.reserve(PROC_PID_MEM_DATA_SIZE);
    if (IsValidData(ifs, data)) {
        // pid name
        std::string processName(PROC_SELF);
        ProcAllPidsFileHandler::GetProcessName(pid_, processName);

        data += PROF_DATA_PROCESSNAME;
        data += processName;
        data += "\n";
    }
}

void ProcPidFileHandler::Execute()
{
    if (memHandler_) {
        memHandler_->Execute();
    }
    if (statHandler_) {
        statHandler_->Execute();
    }
}

ProcAllPidsFileHandler::ProcAllPidsFileHandler(SHARED_PTR_ALIA<TimerAttr> attr,
                                               SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param,
                                               SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                                               SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader)
    : TimerHandler(attr->tag),
      devId_(attr->devId),
      prevTimeStamp_(0), sampleIntervalNs_(attr->sampleInterval),
      param_(param), jobCtx_(jobCtx), upLoader_(upLoader)
{
}

ProcAllPidsFileHandler::~ProcAllPidsFileHandler()
{
}

int32_t ProcAllPidsFileHandler::Init()
{
    MSPROF_LOGI("ProcAllPidsFileHandler Init");
    GetCurPids(prevPids_);
    HandleNewPids(prevPids_);

    return PROFILING_SUCCESS;
}

int32_t ProcAllPidsFileHandler::Uinit()
{
    for (auto iter = pidsMap_.cbegin(); iter != pidsMap_.cend(); iter++) {
        if (iter->second->memHandler_ != nullptr) {
            iter->second->memHandler_->Uinit();
        }

        if (iter->second->statHandler_ != nullptr) {
            iter->second->statHandler_->Uinit();
        }
    }

    upLoader_.reset();
    pidsMap_.clear();
    prevPids_.clear();

    return PROFILING_SUCCESS;
}

void ProcAllPidsFileHandler::GetProcessName(uint32_t pid, std::string &processName)
{
    std::string fileName(PROC_FILE);
    fileName += "/";
    fileName += std::to_string(pid);
    fileName += "/";
    fileName += PROC_COMM_FILE;

    int64_t len = analysis::dvvp::common::utils::Utils::GetFileSize(fileName);
    if (len < 0 || len > MSVP_SMALL_FILE_MAX_LEN) {
        MSPROF_LOGW("The %s file size[%" PRId64 "] is not in the range between 0 to %" PRId64 " or does not exist.",
            fileName.c_str(), len, MSVP_SMALL_FILE_MAX_LEN);
        return;
    }

    std::ifstream ifs(fileName, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION_LOGW(!ifs.is_open(), return, "File %s did not open successfully.", fileName.c_str());

    std::getline(ifs, processName);

    ifs.close();
}

void ProcAllPidsFileHandler::GetCurPids(std::vector<uint32_t> &curPids) const
{
    std::vector<std::string> pidDirs;
    pidDirs.reserve(PROC_PID_NUM);
    Utils::GetChildDirs(PROC_FILE, false, pidDirs, 0);

    const size_t size = pidDirs.size();
    curPids.reserve(size);
    curPids.clear();
    for (size_t i = 0; i < size; i++) {
        uint32_t pid = strtoul(pidDirs[i].c_str() + strlen(PROC_FILE) + strlen("/"), nullptr, 0);
        if (pid != 0) {
            curPids.push_back(pid);
        }
    }

    std::sort(curPids.begin(), curPids.end());
}

void ProcAllPidsFileHandler::GetNewExitPids(std::vector<uint32_t> &curPids,
                                            std::vector<uint32_t> &prevPids,
                                            std::vector<uint32_t> &newPids,
                                            std::vector<uint32_t> &exitPids) const
{
    size_t curPidsSize = curPids.size();
    size_t prevPidsSize = prevPids.size();
    size_t i = 0;
    size_t j = 0;

    newPids.clear();
    exitPids.clear();

    for (i = 0, j = 0; i < prevPidsSize && j < curPidsSize;) {
        if (prevPids[i] == curPids[j]) {
            i++;
            j++;
        } else if (prevPids[i] < curPids[j]) {
            MSPROF_LOGI("exit Pid %d", prevPids[i]);
            exitPids.push_back(prevPids[i++]);
        } else {
            MSPROF_LOGI("New Pid %d", curPids[j]);
            newPids.push_back(curPids[j++]);
        }
    }

    while (i < prevPidsSize) {
        exitPids.push_back(prevPids[i++]);
    }

    while (j < curPidsSize) {
        newPids.push_back(curPids[j++]);
    }
}

void ProcAllPidsFileHandler::HandleNewPids(std::vector<uint32_t> &newPids)
{
    TimerHandlerTag tag = GetTag();
    SHARED_PTR_ALIA<ProcPidFileHandler> pidFileHandler = nullptr;
    SHARED_PTR_ALIA<ProcPidMemFileHandler> pidMemHandler = nullptr;
    SHARED_PTR_ALIA<ProcPidStatFileHandler> pidStatHandler = nullptr;

    size_t size = newPids.size();
    for (size_t i = 0; i < size; i++) {
        MSVP_MAKE_SHARED0(pidFileHandler, ProcPidFileHandler, return);

        std::string str;
        std::string pidSrcMemFileName =  std::string(PROC_FILE) + "/"
                                         + std::to_string(newPids[i]) + "/" + PROC_PID_MEM;
        std::string pidSrcStatFileName = std::string(PROC_FILE) + "/"
                                         + std::to_string(newPids[i]) + "/" + PROC_PID_STAT;

        std::string pidRetMemFileName = PROF_PID_MEM_FILE;
        pidRetMemFileName += str;
        std::string pidStatMemFileName = PROF_PID_STAT_FILE;
        pidStatMemFileName += str;

        const uint32_t procPidMemBufSize = (1 << 12); // 1 << 12, the size of per data is about 100Byte
        const uint32_t procPidStatBufSize = (1 << 12); // 1 << 12, the size of per stat data is about 300Byte
        SHARED_PTR_ALIA<TimerAttr> attrMem = nullptr;
        MSVP_MAKE_SHARED4(attrMem, TimerAttr, GetTag(), static_cast<int32_t>(devId_), procPidMemBufSize,
            sampleIntervalNs_, return);
        attrMem->srcFileName = pidSrcMemFileName;
        attrMem->retFileName = std::to_string(newPids[i]) + "-" + pidRetMemFileName;
        attrMem->pid = newPids[i];
        MSVP_MAKE_SHARED4(pidMemHandler, ProcPidMemFileHandler, attrMem, param_, jobCtx_, upLoader_, return);
        SHARED_PTR_ALIA<TimerAttr> attrStat = nullptr;
        MSVP_MAKE_SHARED4(attrStat, TimerAttr, GetTag(), static_cast<int32_t>(devId_), procPidStatBufSize,
            sampleIntervalNs_, return);
        attrStat->srcFileName = pidSrcStatFileName;
        attrStat->retFileName = std::to_string(newPids[i]) + "-" + pidStatMemFileName;
        attrStat->pid = newPids[i];
        MSVP_MAKE_SHARED4(pidStatHandler, ProcPidStatFileHandler, attrStat, param_, jobCtx_, upLoader_, return);
        if (pidMemHandler->Init() == PROFILING_SUCCESS && pidStatHandler->Init() == PROFILING_SUCCESS) {
            if (tag == PROF_ALL_PID || tag ==  PROF_HOST_ALL_PID || tag == PROF_HOST_ALL_PID_CPU) {
                pidFileHandler->statHandler_ = pidStatHandler;
            }
            if (tag == PROF_ALL_PID || tag ==  PROF_HOST_ALL_PID || tag == PROF_HOST_ALL_PID_MEM) {
                pidFileHandler->memHandler_ = pidMemHandler;
            }
            pidsMap_.insert(std::pair<uint32_t, SHARED_PTR_ALIA<ProcPidFileHandler> >(newPids[i], pidFileHandler));
        }
    }
}

void ProcAllPidsFileHandler::HandleExitPids(std::vector<uint32_t> &exitPids)
{
    const size_t size = exitPids.size();
    for (size_t i = 0; i < size; i++) {
        const auto iter = pidsMap_.find(exitPids[i]);
        if (iter != pidsMap_.end()) {
            if (iter->second->memHandler_) {
                iter->second->memHandler_->Uinit();
            }

            if (iter->second->statHandler_) {
                iter->second->statHandler_->Uinit();
            }

            pidsMap_.erase(iter);
        }
    }
}

int32_t ProcAllPidsFileHandler::Execute()
{
    unsigned long long curTimeStamp = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    if ((curTimeStamp - prevTimeStamp_) >= sampleIntervalNs_ || (prevTimeStamp_ == 0)) {
        prevTimeStamp_ = curTimeStamp;

        std::vector<uint32_t> curPids;
        GetCurPids(curPids);

        static const uint32_t CHANGE_PIDS_NUM = 16;
        std::vector<uint32_t> newPids(curPids.size() > prevPids_.size() ?
            curPids.size() - prevPids_.size() : CHANGE_PIDS_NUM);
        std::vector<uint32_t> exitPids(curPids.size() > prevPids_.size() ?
            curPids.size() - prevPids_.size() : CHANGE_PIDS_NUM);

        GetNewExitPids(curPids, prevPids_, newPids, exitPids);
        HandleExitPids(exitPids);
        HandleNewPids(newPids);

        prevPids_.swap(curPids);
        for (auto iter = pidsMap_.cbegin(); iter != pidsMap_.cend(); iter++) {
            iter->second->Execute();
        }
    }
    return PROFILING_SUCCESS;
}

void ProcAllPidsFileHandler::ParseProcFile(const std::ifstream &ifs /* = ios::in */,
    const std::string &data /* = "" */) const
{
    UNUSED(ifs);
    UNUSED(data);
}

ProfTimer::ProfTimer(SHARED_PTR_ALIA<TimerParam> timerParam)
    : isStarted_(false), timerParam_(timerParam)
{
}

ProfTimer::~ProfTimer()
{
    Stop();
}


int32_t ProfTimer::Handler()
{
    std::lock_guard<std::mutex> lk(mtx_);
    for (auto iter = handlerMap_.cbegin(); iter != handlerMap_.cend(); iter++) {
        iter->second->Execute();
    }
    return static_cast<int32_t>(handlerMap_.size());
}

int32_t ProfTimer::RegisterTimerHandler(TimerHandlerTag tag, SHARED_PTR_ALIA<TimerHandler> handler)
{
    MSPROF_LOGI("ProfTimer RegisterTimerHandler tag %u", tag);

    std::lock_guard<std::mutex> lk(mtx_);
    handlerMap_[tag] = handler;

    return PROFILING_SUCCESS;
}

int32_t ProfTimer::RemoveTimerHandler(TimerHandlerTag tag)
{
    MSPROF_LOGI("ProfTimer RemoveTimerHandler tag %u begin", tag);
    std::lock_guard<std::mutex> lk(mtx_);
    const auto iter = handlerMap_.find(tag);
    if (iter != handlerMap_.end()) {
        iter->second->Uinit();

        handlerMap_.erase(tag);
    }
    MSPROF_LOGI("ProfTimer RemoveTimerHandler tag %u succ", tag);

    return PROFILING_SUCCESS;
}

int32_t ProfTimer::Start()
{
    int32_t ret = PROFILING_FAILED;

    MSPROF_LOGI("Start ProfTimer begin");
    std::lock_guard<std::mutex> lk(mtx_);
    do {
        if (isStarted_) {
            MSPROF_LOGE("ProfTimer is running");
            MSPROF_INNER_ERROR("EK9999", "ProfTimer is running");
            break;
        }

        isStarted_ = true;
        analysis::dvvp::common::thread::Thread::SetThreadName(
            analysis::dvvp::common::config::MSVP_COLLECT_PROF_TIMER_THREAD_NAME);
        (void)analysis::dvvp::common::thread::Thread::Start();

        ret = PROFILING_SUCCESS;
        MSPROF_LOGI("Start ProfTimer succ");
    } while (0);

    MSPROF_LOGI("Start ProfTimer end");
    return ret;
}

int32_t ProfTimer::Stop()
{
    int32_t ret = PROFILING_SUCCESS;
    MSPROF_LOGI("Stop ProfTimer begin");
    do {
        if (!isStarted_) {
            break;
        }
        isStarted_ = false;

        (void)analysis::dvvp::common::thread::Thread::Stop();

        mtx_.lock();
        for (auto iter = handlerMap_.cbegin(); iter != handlerMap_.cend(); iter++) {
            iter->second->Uinit();
        }
        handlerMap_.clear();
        mtx_.unlock();

        MSPROF_LOGI("Stop ProfTimer succ");
    } while (0);

    MSPROF_LOGI("Stop ProfTimer end");

    return ret;
}

void ProfTimer::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    do {
        Handler();
        analysis::dvvp::common::utils::Utils::UsleepInterupt(timerParam_->intervalUsec);
    } while (isStarted_);
}

TimerManager::TimerManager()
    : profTimerCnt_(0)
{
}

TimerManager::~TimerManager()
{
    profTimer_.reset();
    profTimerCnt_ = 0;
}

void TimerManager::StartProfTimer()
{
    std::lock_guard<std::mutex> lk(profTimerMtx_);
    if (profTimerCnt_ == 0) {
        static const unsigned long long PROF_TIMER_INTERVAL_US = 1000; // 1000 us
        SHARED_PTR_ALIA<TimerParam> timerParam = nullptr;
        MSVP_MAKE_SHARED1(timerParam, TimerParam, PROF_TIMER_INTERVAL_US, return);
        MSVP_MAKE_SHARED1(profTimer_, ProfTimer, timerParam, return);
        if (profTimer_->Start() != PROFILING_SUCCESS) {
            MSPROF_LOGE("StartProfTimer failed");
            MSPROF_INNER_ERROR("EK9999", "StartProfTimer failed");
            return;
        }
        MSPROF_LOGI("StartProfTimer end");
    }
    profTimerCnt_++;
}

void TimerManager::StopProfTimer()
{
    std::lock_guard<std::mutex> lk(profTimerMtx_);
    profTimerCnt_--;
    if (profTimer_ != nullptr && profTimerCnt_ == 0) {
        MSPROF_LOGI("StopProfTimer begin");
        int32_t ret = profTimer_->Stop();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("StopProfTimer failed");
            MSPROF_INNER_ERROR("EK9999", "StopProfTimer failed");
        }
        MSPROF_LOGI("StopProfTimer end");
    }
}

void TimerManager::RegisterProfTimerHandler(TimerHandlerTag tag,
    SHARED_PTR_ALIA<TimerHandler> handler)
{
    std::lock_guard<std::mutex> lk(profTimerMtx_);
    if (profTimer_ != nullptr && handler != nullptr) {
        (void)profTimer_->RegisterTimerHandler(tag, handler);
    }
}

void TimerManager::RemoveProfTimerHandler(TimerHandlerTag tag)
{
    std::lock_guard<std::mutex> lk(profTimerMtx_);
    if (profTimer_ != nullptr) {
        (void)profTimer_->RemoveTimerHandler(tag);
    }
}
}
}
}
