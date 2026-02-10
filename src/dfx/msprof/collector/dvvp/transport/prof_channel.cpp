/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_channel.h"
#include <functional>
#include <new>
#include <string>
#include <set>
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "ascend_hal.h"
#include "securec.h"
#include "uploader_mgr.h"
#include "json_parser.h"

namespace analysis {
namespace dvvp {
namespace transport {
constexpr uint32_t MAX_BUFFER_SIZE = 1024 * 1024 * 4;
constexpr uint32_t UPLOAD_BUFFER_SIZE = 1024 * 1024 * 2;
constexpr int32_t MAX_READ_LEN = 1024 * 1024 * 32;
const uint32_t MAX_SCHEDULING_TIME = 3;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Msprofiler::Parser;

namespace {
const std::set<AI_DRV_CHANNEL> SUPPORT_FLUSH_CHANNEL_SET = {
    PROF_CHANNEL_AI_CORE, PROF_CHANNEL_HWTS_LOG, PROF_CHANNEL_TS_FW, PROF_CHANNEL_L2_CACHE,
    PROF_CHANNEL_STARS_SOC_LOG, PROF_CHANNEL_FFTS_PROFILE_TASK, PROF_CHANNEL_NPU_APP_MEM, PROF_CHANNEL_NPU_MEM,
    PROF_CHANNEL_AISTACK_MEM, PROF_CHANNEL_AICPU, PROF_CHANNEL_CUS_AICPU, PROF_CHANNEL_ADPROF
};
}

ChannelReader::ChannelReader(int32_t deviceId, analysis::dvvp::driver::AI_DRV_CHANNEL channelId,
                             const std::string &relativeFileName,
                             SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx)
    : deviceId_(deviceId),
      channelId_(channelId),
      relativeFileName_(relativeFileName),
      bufSize_(MAX_BUFFER_SIZE),
      dataSize_(0),
      spaceSize_(MAX_BUFFER_SIZE),
      buffer_(MAX_BUFFER_SIZE, '\0'),
      hashId_(0),
      jobCtx_(jobCtx),
      warmupSize_(0),
      totalSize_(0),
      isChannelStopped_(false),
      isInited_(false),
      readSpeedPerfCount_(nullptr),
      overallReadSpeedPerfCount_(nullptr),
      lastEndRawTime_(0),
      drvChannelReadCont_(0),
      schedulingTime_(0),
      totalSchedulingInCnt_(0),
      totalSchedulingOutCnt_(0),
      needWait_(false),
      flushBufSize_(0),
      flushCurSize_(0),
      readExecCnt_(0),
      uploadDataMaxDuration_(0)
{
    if (JsonParser::instance()->GetJsonChannelReportBufferLen(channelId_) != 0) {
        bufSize_ = JsonParser::instance()->GetJsonChannelReportBufferLen(channelId_);
    }
    MSPROF_LOGI("Channel reader %s, buffer size : %d", relativeFileName.c_str(), bufSize_);
}

ChannelReader::~ChannelReader() {}

int32_t ChannelReader::Init()
{
    /* different channel of same device should be seperated to different thread and
     different device of same channel shoud be seperate to different thread */
    hashId_ = channelId_ + deviceId_;
    MSVP_MAKE_SHARED1(readSpeedPerfCount_, PerfCount, SPEED_PERFCOUNT_MODULE_NAME, return PROFILING_FAILED);
    MSVP_MAKE_SHARED1(overallReadSpeedPerfCount_, PerfCount, SPEEDALL_PERFCOUNT_MODULE_NAME, return PROFILING_FAILED);
    lastEndRawTime_ = 0;
    isInited_ = true;
    std::lock_guard<std::mutex> lk(mtx_);
    drvChannelReadCont_ = 0;
    return PROFILING_SUCCESS;
}

int32_t ChannelReader::Uinit()
{
    MSPROF_EVENT("device id %d, channel: %d, total_size_channel: %lld bytes, warmup_size: %lld bytes, "
                 "file:%s, job_id:%s, channelReadCnt:%lld, readExecCnt: %u, dispatchInCnt: %u, "
                 "dispatchOutCnt: %u, uploadDataMaxDuration: %llu.",
                 deviceId_, static_cast<int32_t>(channelId_), totalSize_, warmupSize_, relativeFileName_.c_str(),
                 jobCtx_->job_id.c_str(), drvChannelReadCont_, readExecCnt_, totalSchedulingInCnt_,
                 totalSchedulingOutCnt_, uploadDataMaxDuration_);
    std::string tag =
        "[" + jobCtx_->job_id + " : " + std::to_string(deviceId_) + " : " + std::to_string(channelId_) + "]";
    readSpeedPerfCount_->OutPerfInfo("ChannelReaderSpeed" + tag);
    overallReadSpeedPerfCount_->OutPerfInfo("ChannelReaderSpeedAll" + tag);
    isInited_ = false;
    do {
        MSVP_TRY_BLOCK(FlushBuffToUpload(), break);
    } while (0);

    return PROFILING_SUCCESS;
}

void ChannelReader::SetChannelStopped()
{
    isChannelStopped_ = true;
}

bool ChannelReader::GetSchedulingStatus()
{
    return (schedulingTime_.load() >= MAX_SCHEDULING_TIME);
}

void ChannelReader::RegisterBufferThread(SHARED_PTR_ALIA<ChannelBuffer> channelBuffer)
{
    readerBuffer_ = channelBuffer;
}

void ChannelReader::SetSchedulingStatus(bool isScheduling)
{
    if (isScheduling) {
        schedulingTime_++;
        totalSchedulingInCnt_++;
    } else if (schedulingTime_.load() > 0) {
        schedulingTime_--;
        totalSchedulingOutCnt_++;
    }
}

int32_t ChannelReader::Execute()
{
    int32_t totalLen = 0;
    int32_t currLen = 0;
    std::lock_guard<std::mutex> lk(mtx_);
    readExecCnt_++;
    std::unique_lock<std::mutex> guard(flushMutex_, std::defer_lock);
    do {
        drvChannelReadCont_++;
        if (!isInited_ || isChannelStopped_) {
            break;
        }
        if (dataSize_ >= MAX_BUFFER_SIZE) {
            UploadData();
        }
        spaceSize_ = bufSize_ - dataSize_;
        const uint64_t startRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        guard.lock();
        currLen = DrvChannelRead(deviceId_, channelId_,
                                 reinterpret_cast<UNSIGNED_CHAR_PTR>(const_cast<CHAR_PTR>(buffer_.data())) + dataSize_,
                                 spaceSize_);
        CheckIfSendFlush(currLen);
        guard.unlock();
        const uint64_t endRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        readSpeedPerfCount_->UpdatePerfInfo(startRawTime, endRawTime, currLen);  // update the PerfCount info
        if (lastEndRawTime_ != 0) {
            overallReadSpeedPerfCount_->UpdatePerfInfo(lastEndRawTime_, endRawTime, currLen);
        }
        if (currLen <= 0) {
            if (currLen < 0) {
                MSPROF_LOGE("read device %d, channel:%d, ret=%d", deviceId_, static_cast<int32_t>(channelId_), currLen);
                MSPROF_INNER_ERROR("EK9999", "read device %d, channel:%d, ret=%d", deviceId_,
                                   static_cast<int32_t>(channelId_), currLen);
            }
            if ((dataSize_ >= UPLOAD_BUFFER_SIZE)) {
                UploadData();
                continue;
            }
            break;
        }
        lastEndRawTime_ = endRawTime;
        totalLen += currLen;
        totalSize_ += static_cast<long long>(currLen);
        dataSize_ += currLen;
    } while ((currLen > 0) && (totalLen < MAX_READ_LEN));
    SetSchedulingStatus(false);
    return PROFILING_SUCCESS;
}

size_t ChannelReader::HashId()
{
    return hashId_;
}

void ChannelReader::UploadData()
{
    const uint64_t uploadStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    if (dataSize_ == 0) {
        return;
    }
    // file chunk
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return);
    fileChunkReq->isLastChunk = false;
    fileChunkReq->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
    fileChunkReq->chunkSize = dataSize_;
    fileChunkReq->offset = -1;
    fileChunkReq->fileName = Utils::PackDotInfo(relativeFileName_, NULL_CHUNK);
    fileChunkReq->chunk.swap(buffer_);
    fileChunkReq->extraInfo = Utils::PackDotInfo(jobCtx_->job_id, jobCtx_->dev_id);

    if (readerBuffer_ != nullptr && !readerBuffer_->SwapChannelBuffer(buffer_)) {
        buffer_.reserve(MAX_BUFFER_SIZE);
    }
    int32_t ret = UploaderMgr::instance()->UploadData(jobCtx_->job_id, fileChunkReq);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Upload data failed, jobId: %s", jobCtx_->job_id.c_str());
        MSPROF_INNER_ERROR("EK9999", "Upload data failed, jobId: %s", jobCtx_->job_id.c_str());
    } else if (ret == PROFILING_IN_WARMUP) {
        warmupSize_ += static_cast<long long>(dataSize_);
    }
    dataSize_ = 0;
    const uint64_t uploadEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    if (uploadDataMaxDuration_ < (uploadEndTime - uploadStartTime)) {
        uploadDataMaxDuration_ = uploadEndTime - uploadStartTime;
    }
}

void ChannelReader::FlushBuffToUpload()
{
    std::lock_guard<std::mutex> lk(mtx_);
    UploadData();
}

bool ChannelReader::IsSupportFlushDrvBuff()
{
    return SUPPORT_FLUSH_CHANNEL_SET.find(channelId_) != SUPPORT_FLUSH_CHANNEL_SET.end();
}

void ChannelReader::FlushDrvBuff()
{
    if (!IsSupportFlushDrvBuff()) {
        return;
    }
    // 1. query flush size
    std::unique_lock<std::mutex> guard(flushMutex_);
    uint32_t flushSize = 0;
    const int32_t ret = DrvProfFlush(deviceId_, channelId_, flushSize);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DrvProfFlush failed, deviceId:%d, channelId:%d, ret:%d", deviceId_, channelId_, ret);
        MSPROF_INNER_ERROR("EK9999", "DrvProfFlush failed, deviceId:%d, channelId:%d,ret:%d", deviceId_, channelId_,
                           ret);
        guard.unlock();
        return;
    }
    MSPROF_LOGI("Flush deviceId:%d, channelId:%d, flushSize:%d", deviceId_, channelId_, flushSize);
    // 2. wait flush finished
    if (flushSize == 0) {
        MSPROF_LOGI("No drv data need flush.");
        guard.unlock();
        return;
    }
    needWait_ = true;
    flushBufSize_ = flushSize;
    flushFlag_.wait(guard, [this] { return !this->needWait_; });
    // 3. upload flush data
    FlushBuffToUpload();
}

void ChannelReader::CheckIfSendFlush(const size_t curLen)
{
    if (!IsSupportFlushDrvBuff()) {
        return;
    }
    if (needWait_) {
        if (flushCurSize_ > UINT_MAX - curLen) {  // Check for overflow, if curLen is very large,Sure to send finish
            SendFlushFinished();
        } else {
            flushCurSize_ += curLen;
            if (flushBufSize_ <= flushCurSize_ || curLen == 0) {
                SendFlushFinished();
            }
        }
    }
}

void ChannelReader::SendFlushFinished()
{
    needWait_ = false;
    flushCurSize_ = 0;
    flushBufSize_ = 0;
    flushFlag_.notify_all();
}

ChannelPoll::ChannelPoll()
    : threadPool_(nullptr),
      isStart_(false),
      pollCount_(0),
      pollSleepCount_(0),
      dispatchCount_(0),
      dispatchChannelCount_(0)
{
}

ChannelPoll::~ChannelPoll()
{
    Stop();
}

int32_t ChannelPoll::AddReader(uint32_t devId, uint32_t channelId, SHARED_PTR_ALIA<ChannelReader> reader)
{
    if (reader == nullptr) {
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    MSPROF_LOGI("AddReader, devId:%u, channel:%u", devId, channelId);
    reader->RegisterBufferThread(threadBuffer_);
    readers_[devId][channelId] = reader;

    return PROFILING_SUCCESS;
}

int32_t ChannelPoll::RemoveReader(uint32_t devId, uint32_t channelId)
{
    std::lock_guard<std::mutex> lk(mtx_);
    MSPROF_LOGI("RemoveReader, devId:%u, channel:%u", devId, channelId);
    auto iter = readers_.find(devId);
    if (iter != readers_.end()) {
        MSPROF_LOGI("RemoveReader, fid dev, devId:%u", devId);
        const auto channelIter = iter->second.find(channelId);
        if (channelIter != iter->second.end()) {
            MSPROF_LOGI("RemoveReader, devId:%u, channel:%u", devId, channelId);
            channelIter->second->SetChannelStopped();
            channelIter->second->Uinit();
            iter->second.erase(channelIter);
        }
        if (iter->second.size() == 0) {
            readers_.erase(iter);
        }
    }

    return PROFILING_SUCCESS;
}

SHARED_PTR_ALIA<ChannelReader> ChannelPoll::GetReader(uint32_t devId, uint32_t channelId)
{
    SHARED_PTR_ALIA<ChannelReader> reader = nullptr;

    std::lock_guard<std::mutex> lk(mtx_);
    const auto iter = readers_.find(devId);
    if (iter != readers_.end()) {
        auto channelIter = iter->second.find(channelId);
        if (channelIter != iter->second.end()) {
            reader = channelIter->second;
        }
    }

    return reader;
}

std::vector<SHARED_PTR_ALIA<ChannelReader>> ChannelPoll::GetAllReaders()
{
    std::vector<SHARED_PTR_ALIA<ChannelReader>> res;

    std::lock_guard<std::mutex> lk(mtx_);
    for (auto iter = readers_.cbegin(); iter != readers_.cend(); ++iter) {
        for (auto channelIter = iter->second.cbegin(); channelIter != iter->second.cend(); ++channelIter) {
            res.push_back(channelIter->second);
        }
    }

    return res;
}

void ChannelPoll::DispatchReader(SHARED_PTR_ALIA<ChannelReader> reader)
{
    if (!reader->GetSchedulingStatus()) {
        reader->SetSchedulingStatus(true);
        (void)threadPool_->Dispatch(reader);
    }
}

int32_t ChannelPoll::DispatchChannel(uint32_t devId, uint32_t channelId)
{
    auto reader = GetReader(devId, channelId);
    if (!reader) {
        MSPROF_LOGW("Unable to find devId:%u, channel:%u", devId, channelId);
        return PROFILING_FAILED;
    }
    DispatchReader(reader);

    return PROFILING_SUCCESS;
}

void ChannelPoll::FlushDrvBuff()
{
    auto res = GetAllReaders();
    for (auto iter = res.begin(); iter != res.end(); ++iter) {
        (*iter)->FlushDrvBuff();
    }
}

int32_t ChannelPoll::Start()
{
    const int32_t devNum = DrvGetDevNum();
    uint32_t threadPoolNum = (devNum <= 0) ? 0 : static_cast<uint32_t>(devNum);
    const uint32_t poolRatio = 2; // set ratio of device num and thread pool num
    threadPoolNum *= poolRatio;
    if (threadPoolNum < analysis::dvvp::common::thread::THREAD_NUM_DEFAULT) {
        threadPoolNum = analysis::dvvp::common::thread::THREAD_NUM_DEFAULT;
    } else if (threadPoolNum > DEV_NUM) {
        threadPoolNum = DEV_NUM;
    }
    MSPROF_LOGI("ChannelPoll set thread pool num: %u", threadPoolNum);

    MSVP_MAKE_SHARED2(threadPool_, analysis::dvvp::common::thread::ThreadPool,
                      analysis::dvvp::common::thread::LOAD_BALANCE_METHOD::ID_MOD, threadPoolNum,
                      return PROFILING_FAILED);
    threadPool_->SetThreadPoolNamePrefix(MSVP_CHANNEL_POOL_NAME_PREFIX);
    threadPool_->SetThreadPoolQueueSize(CHANNELPOLL_THREAD_QUEUE_SIZE);
    isStart_ = true;
    (void)threadPool_->Start();
    MSVP_MAKE_SHARED0(threadBuffer_, ChannelBuffer, return PROFILING_FAILED);
    (void)threadBuffer_->Start();
    analysis::dvvp::common::thread::Thread::SetThreadName(MSVP_CHANNEL_THREAD_NAME);
    isStart_ = true;
    (void)analysis::dvvp::common::thread::Thread::Start();
    return PROFILING_SUCCESS;
}

int32_t ChannelPoll::Stop()
{
    if (isStart_) {
        isStart_ = false;
        (void)analysis::dvvp::common::thread::Thread::Stop();
        (void)threadPool_->Stop();
        (void)threadBuffer_->Stop();
        MSPROF_EVENT("ChannelPoll count: %d, Sleep count: %d, Dispatch count: %d, DispatchChannel count: %d",
                     pollCount_, pollSleepCount_, dispatchCount_, dispatchChannelCount_);
        pollCount_ = 0;
        pollSleepCount_ = 0;
        dispatchCount_ = 0;
        dispatchChannelCount_ = 0;
        threadBuffer_.reset();
        threadBuffer_ = nullptr;
    }

    return PROFILING_SUCCESS;
}

void ChannelPoll::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    constexpr uint32_t channelNum = 6;  // at most get 6 channels to read once loop
    const int32_t defaultTimeoutSec = 1;        // at most wait for 1 seconds

    struct prof_poll_info channels[channelNum];
    (void)memset_s(channels, channelNum * sizeof(struct prof_poll_info), 0, channelNum * sizeof(struct prof_poll_info));

    while (isStart_) {
        const int32_t ret = DrvChannelPoll(channels, channelNum, defaultTimeoutSec);
        pollCount_++;
        if (ret == PROF_ERROR) {
            MSPROF_LOGE("Failed to poll channel");
            MSPROF_INNER_ERROR("EK9999", "Failed to poll channel");
            break;
        }
        if (ret == PROF_STOPPED_ALREADY) {
            if (IsQuit()) {
                MSPROF_LOGI("Exit poll channel thread.");
                break;
            } else {
                const unsigned long sleepTimeInUs = 1000;  // 1000us
                analysis::dvvp::common::utils::Utils::UsleepInterupt(sleepTimeInUs);
                pollSleepCount_++;
                continue;
            }
        }

        dispatchCount_++;
        for (int32_t ii = 0; ii < ret; ++ii) {
            MSPROF_LOGD("DispatchChannel devId: %d, channelID: %d, ret: %d", channels[ii].device_id,
                        channels[ii].channel_id, ret);
            if (JsonParser::instance()->GetJsonChannelReporterSwitch(channels[ii].channel_id)) {
                (void)DispatchChannel(channels[ii].device_id, channels[ii].channel_id);
                dispatchChannelCount_++;
            }
        }
    }
}

ChannelBuffer::ChannelBuffer() : isStart_(false), bufferPrepareCount_(0), bufferPopCount_(0)
{
}

ChannelBuffer::~ChannelBuffer()
{
}

int32_t ChannelBuffer::Start()
{
    analysis::dvvp::common::thread::Thread::SetThreadName(MSVP_CHANNEL_BUFFER);
    (void)analysis::dvvp::common::thread::Thread::Start();
    isStart_ = true;
    return PROFILING_SUCCESS;
}

int32_t ChannelBuffer::Stop()
{
    if (isStart_) {
        isStart_ = false;
        (void)analysis::dvvp::common::thread::Thread::Stop();
        MSPROF_EVENT("ChannelBuffer prepare count: %d, pop count: %d",
                     bufferPrepareCount_, bufferPopCount_);
        bufferPrepareCount_ = 0;
        bufferPopCount_ = 0;
    }

    return PROFILING_SUCCESS;
}

void ChannelBuffer::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    const uint8_t maxChanelBufferSize = 8;
    const unsigned long sleepUs = 1000;
    while (isStart_) {
        std::unique_lock<std::mutex> guard(preQueueMutex_, std::defer_lock);
        guard.lock();
        if (preBufferQueue_.size() > maxChanelBufferSize) {
            guard.unlock();
            analysis::dvvp::common::utils::Utils::UsleepInterupt(sleepUs);
            continue;
        }
        guard.unlock();
        std::string buffer(MAX_BUFFER_SIZE, '\0');
        guard.lock();
        preBufferQueue_.push(std::move(buffer));
        guard.unlock();
        bufferPrepareCount_++;
    }
}

bool ChannelBuffer::SwapChannelBuffer(std::string &buffer)
{
    std::unique_lock<std::mutex> guard(preQueueMutex_);
    if (preBufferQueue_.empty()) {
        return false;
    }
    buffer.swap(preBufferQueue_.front());
    preBufferQueue_.pop();
    bufferPopCount_++;
    return true;
}
}  // namespace device
}  // namespace dvvp
}  // namespace analysis
