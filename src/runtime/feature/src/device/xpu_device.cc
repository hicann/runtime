/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "xpu_device.hpp"
#include "stream_sqcq_manage_xpu.hpp"
#include "task_xpu_recycle.hpp"
#include "utils.h"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "stream_xpu.hpp"
#include "arg_loader_xpu.hpp"

namespace cce {
namespace runtime {

constexpr double VERSION = 1.0;
constexpr uint32_t MAX_STREAM_NUM = 64;
constexpr uint32_t MAX_STREAM_DEPTH = 1024;
constexpr uint32_t TIMEOUT_MONITOR_GRANULARITY = 1000;
constexpr uint32_t DEFAULT_TASKEXE_TIMEOUT = 30000;

XpuDevice::XpuDevice(const uint32_t devId)
    : RawDevice(devId), ThreadRunnable(), xpuArgLoader_(nullptr),
      deviceId_(devId), driver_(nullptr), streamIdBitmap_(nullptr), streamSqCqManage_(nullptr) {}

XpuDevice::~XpuDevice() noexcept
{
    if (driver_ != nullptr) {
        (void)driver_->XpuDriverDeviceClose(deviceId_);
        driver_ = nullptr;
    }
    DELETE_O(streamIdBitmap_);
    DELETE_O(xpuArgLoader_);
    DELETE_O(streamSqCqManage_);
}

static rtError_t ParseXpuConfigInfoFromFile(XpuConfigInfo *configInfo, const std::string &fileName)
{
    std::string key("ver=");
    double version = 0.0;
    bool ret = GetConfigIniValueDouble(fileName, key, version);
    COND_RETURN_ERROR(!ret, RT_ERROR_INVALID_VALUE, "Failed to parse field 'ver'");
    configInfo->version = version;

    key = "max_stream_num=";
    int32_t maxStreamNum = 0;
    ret = GetConfigIniValueInt32(fileName, key, maxStreamNum);
    COND_RETURN_ERROR(!ret, RT_ERROR_INVALID_VALUE, "Failed to parse field 'max_stream_num'");
    if (maxStreamNum <= 0 || maxStreamNum > static_cast<int32_t>(MAX_STREAM_NUM)) {
        maxStreamNum = static_cast<int32_t>(MAX_STREAM_NUM);
    }
    configInfo->maxStreamNum = static_cast<uint32_t>(maxStreamNum);

    key = "max_stream_depth=";
    int32_t maxStreamDepth = 0;
    ret = GetConfigIniValueInt32(fileName, key, maxStreamDepth);
    COND_RETURN_ERROR(!ret, RT_ERROR_INVALID_VALUE, "Failed to parse field 'max_stream_depth'");
    if (maxStreamDepth <= 0 || maxStreamDepth > static_cast<int32_t>(MAX_STREAM_DEPTH)) {
        maxStreamDepth = static_cast<int32_t>(MAX_STREAM_DEPTH);
    }
    configInfo->maxStreamDepth = static_cast<uint32_t>(maxStreamDepth);

    key = "timeout_monitor_granularity=";
    int32_t timeoutMonitorGranularity = 0;
    ret = GetConfigIniValueInt32(fileName, key, timeoutMonitorGranularity);
    COND_RETURN_ERROR(!ret, RT_ERROR_INVALID_VALUE, "Failed to parse field 'timeout_monitor_granularity'");
    configInfo->timeoutMonitorGranularity = timeoutMonitorGranularity;

    key = "default_task_exec_timeout=";
    int32_t defaultTaskExeTimeout = 0;
    ret = GetConfigIniValueInt32(fileName, key, defaultTaskExeTimeout);
    COND_RETURN_ERROR(!ret, RT_ERROR_INVALID_VALUE, "Failed to parse field 'default_task_exec_timeout'");
    configInfo->defaultTaskExeTimeout = defaultTaskExeTimeout;
    return RT_ERROR_NONE;
}

rtError_t XpuDevice::ParseXpuConfigInfo()
{
    const char_t *env = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LATEST_INSTALL_PATH, env);
    if ((env == nullptr) || (*env == '\0')) {
        RT_LOG(RT_LOG_ERROR, "Can not read ASCEND_LATEST_INSTALL_PATH!");
        return RT_ERROR_INVALID_VALUE;
    }
    const std::string rtCfgFile("/conf/RuntimeConfig.ini");
    const std::string path(env);
    const std::string fileName = path + rtCfgFile;
    
    const std::string realFileName = RealPath(fileName);
    if (realFileName.empty()) {
        RT_LOG(RT_LOG_ERROR, "The RuntimeConfig.ini file does not exist or cannot be accessed, path=[%s]", realFileName.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    rtError_t ret = ParseXpuConfigInfoFromFile(&configInfo_, fileName);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Failed to parse xpu config info, file name=%s", fileName.c_str());
    RT_LOG(RT_LOG_INFO, "xpu config info: ver=%f, max_stream_num=%u, max_stream_depth=%u, timeout_monitor_granularity=%u, "
            "default_task_exec_timeout=%u", configInfo_.version, configInfo_.maxStreamNum, configInfo_.maxStreamDepth, 
            configInfo_.timeoutMonitorGranularity, configInfo_.defaultTaskExeTimeout);
    return RT_ERROR_NONE;
}

rtError_t XpuDevice::InitStreamIdBitmap()
{
    streamIdBitmap_ = new(std::nothrow) Bitmap(configInfo_.maxStreamNum);
    if (streamIdBitmap_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Init streamid bitmap failed, maxStreamNum=%u", configInfo_.maxStreamNum);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_INFO, "Bitmap(%u):Runtime_alloc_size %zu.", configInfo_.maxStreamNum, sizeof(Bitmap));
    return RT_ERROR_NONE;
}

rtError_t XpuDevice::Init()
{
    rtError_t error = ParseXpuConfigInfo();
    ERROR_RETURN_MSG_INNER(
        error, "Failed to parse xpu config info, device_id=%u, retCode=%#x", deviceId_, static_cast<uint32_t>(error));

    error = InitXpuDriver();
    ERROR_RETURN_MSG_INNER(
        error, "Failed to init XpuDriver, device_id=%u, retCode=%#x", deviceId_, static_cast<uint32_t>(error));

    xpuArgLoader_ = new (std::nothrow) XpuArgLoader(this);
    if (xpuArgLoader_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "xpuArgLoader is null, device_id=%u.", deviceId_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    error = xpuArgLoader_->Init();
    ERROR_RETURN_MSG_INNER(
        error, "Failed to init argLoader, device_id=%u, retCode=%#x", deviceId_, static_cast<uint32_t>(error));

    error = InitStreamIdBitmap();
    ERROR_RETURN_MSG_INNER(
        error, "Failed to new Bitmap, device_id=%u, retCode=%#x", deviceId_, static_cast<uint32_t>(error));

    streamSqCqManage_ = new (std::nothrow) XpuStreamSqCqManage(this);
    if (streamSqCqManage_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "New XpuStreamSqCqManage failed, device_id=%u.", deviceId_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    return RT_ERROR_NONE;
}

rtError_t XpuDevice::Start()
{
    rtError_t error = CreateRecycleThread();
    ERROR_RETURN_MSG_INNER(error, "Start xpu recycle failed, retCode=%#x.", static_cast<uint32_t>(error))
    return RT_ERROR_NONE;
}

rtError_t XpuDevice::Stop()
{
    if (recycleThread_ != nullptr) {
        recycleThreadRunFlag_ = false;
        WakeUpRecycleThread();
        recycleThread_->Join();
        RT_LOG(RT_LOG_INFO, "Xpu joined recycle thread OK.");
        DELETE_O(recycleThread_);
        (void)mmSemDestroy(&recycleThreadSem_);
    }
    return RT_ERROR_NONE;
}

rtError_t XpuDevice::InitXpuDriver()
{
    Runtime *const rt = Runtime::Instance();
    XpuDriver *const devDrv = static_cast<XpuDriver*>(rt->driverFactory_.GetDriver(XPU_DRIVER));
    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);

    TprtCfgInfo_t deviceCfgInfo = {
        configInfo_.maxStreamNum,
        configInfo_.maxStreamDepth,
        configInfo_.timeoutMonitorGranularity,
        configInfo_.defaultTaskExeTimeout
    };
    rtError_t error = devDrv->XpuDriverDeviceOpen(deviceId_, &deviceCfgInfo);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to open device, retCode=%#x, deviceId=%u.", static_cast<uint32_t>(error), deviceId_);
    driver_ = devDrv;
    return error;
}

void XpuDevice::FreeStreamIdBitmap(const int32_t id)
{
    if (id == -1) {
        RT_LOG(RT_LOG_DEBUG, "Stream id is not allocted, no need to free.");
        return;
    }
    
    if (static_cast<uint32_t>(id) < configInfo_.maxStreamNum) {
        streamIdBitmap_->FreeId(id);
    } else {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Free xpu stream id=%d, id is invalid.", id);
    }
}

int32_t XpuDevice::AllocStreamId() const
{
    return streamIdBitmap_->AllocId();
}

void XpuDevice::WakeUpRecycleThread(void)
{
    int val = 0;
    sem_getvalue(&recycleThreadSem_, &val);
    if (val < 2) {
        (void)mmSemPost(&recycleThreadSem_);
    }
}

void XpuDevice::RecycleThreadDo(void) const
{
    std::vector<uint32_t> streamIdList;
    std::shared_ptr<Stream> stream = nullptr;
    (void)GetStreamSqCqManage()->GetAllStreamId(streamIdList);
    if (streamIdList.empty()) {
        return;
    }
    for (const auto &id: streamIdList) {
        rtError_t ret = GetStreamSqCqManage()->GetStreamSharedPtrById(id, stream);
        COND_PROC(((ret != RT_ERROR_NONE) || (stream == nullptr)), continue);
        COND_PROC(((stream->GetPendingNum() == 0U)), continue);
        stream.get()->StreamRecycleLock();
        XpuRecycleTaskProcCqe(stream.get());
        XpuRecycleTaskBySqHead(stream.get());
        stream.get()->StreamRecycleUnlock();
        stream.reset();
    }
}

void XpuDevice::RecycleThreadRun(void)
{
    RT_LOG(RT_LOG_INFO, "RecycleThreadRun thread enter.");
    while (recycleThreadRunFlag_) {
        (void)mmSemWait(&recycleThreadSem_);
        SetIsDoingRecycling(true);
        RecycleThreadDo();
        SetIsDoingRecycling(false);
    }
    RT_LOG(RT_LOG_INFO, "RecycleThreadRun thread leave.");
    return;
}

void XpuDevice::Run(const void * param)
{
    UNUSED(param);
    RecycleThreadRun();
}

rtChipType_t XpuDevice::GetChipType() const
{
    return CHIP_XPU;
}

rtError_t XpuDevice::CreateRecycleThread()
{
    void * const xpuRecycle = RtValueToPtr<void *>(static_cast<uint64_t>(XpuThreadType::XPU_THREAD_RECYCLE));
    recycleThread_ = OsalFactory::CreateThread("DPU_RECYCLE", this, xpuRecycle);
    if (recycleThread_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "create dpu recycle thread failed");
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const rtError_t error = mmSemInit(&recycleThreadSem_, 0U);
    if (error != RT_ERROR_NONE) {
        DELETE_O(recycleThread_);
        RT_LOG(RT_LOG_ERROR, "Create sem failed, retCode=%d", error);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    recycleThreadRunFlag_ = true;

    const int32_t ret = recycleThread_->Start();
    if (ret != EN_OK) {
        recycleThreadRunFlag_ = false;
        DELETE_O(recycleThread_);
        (void)mmSemDestroy(&recycleThreadSem_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    return RT_ERROR_NONE;
}

}
}
