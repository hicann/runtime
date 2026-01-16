/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "base.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "program.hpp"
#include "notify.hpp"
#include "device.hpp"
#include "task.hpp"
#include "host_task.hpp"
#include "osal.hpp"
#include "profiler.hpp"
#include "npu_driver.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "profiling_agent.hpp"
#include "error_message_manage.hpp"
#include "device_msg_handler.hpp"
#include "thread_local_container.hpp"
#include "dvpp_grp.hpp"
#include "driver/ascend_hal.h"
#include "task_submit.hpp"
#include "platform/platform_info.h"
#include "stream_factory.hpp"
#include "device/device_error_proc.hpp"
#include "stream_state_callback_manager.hpp"
#include "heterogenous.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "stars_engine.hpp"
#include "binary_loader.hpp"
#include "args_handle_allocator.hpp"
#include "para_convertor.hpp"
#include "soc_info.h"
#include "ipc_event.hpp"
namespace {
using DevInfo = struct {
    DEV_MODULE_TYPE moduleType;
    DEV_INFO_TYPE infoType;
};
}

namespace cce {
namespace runtime {

rtError_t ApiImpl::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify, const uint32_t flag)
{
    UNUSED(deviceId);
    UNUSED(retCntNotify);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    UNUSED(inCntNotify);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                   const rtCntNtyRecordInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                            const rtCntNtyWaitInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId)
{
    UNUSED(inCntNotify);
    UNUSED(notifyId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
                                       rtNotifyType_t const regType)
{
    UNUSED(inCntNotify);
    UNUSED(cntNotifyAddress);
    UNUSED(regType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    UNUSED(info);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    UNUSED(cmd);
    UNUSED(devInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    UNUSED(resInfo);
    UNUSED(addrInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;    
}

rtError_t ApiImpl::ReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    UNUSED(resInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT; 
}

rtError_t ApiImpl::WriteValuePtr(void * const writeValueInfo, Stream * const stm,
    void * const pointedAddr)
{
    UNUSED(writeValueInfo);
    UNUSED(stm);
    UNUSED(pointedAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    UNUSED(wqeInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo)
{
    UNUSED(fusionInfo);
    UNUSED(stm);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamTaskAbort(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamRecover(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamTaskClean(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::DeviceResourceClean(int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    ContextManage::DeviceGetStreamlist(devId, type, stmList);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::DeviceGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    ContextManage::DeviceGetModelList(devId, mdlList);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase)
{
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    if (prog->GetBinAlignBaseAddr(curCtx->Device_()->Id_()) == nullptr) {
        RT_LOG(RT_LOG_ERROR, "device addr is NULL, make sure that the kernel launch process has been invoked.");
        return RT_ERROR_PROGRAM_DATA;
    } else {
        *deviceBase = const_cast<void *>(prog->GetBinAlignBaseAddr(curCtx->Device_()->Id_()));
        return RT_ERROR_NONE;
    }
}

rtError_t ApiImpl::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
    const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "FFTS plus launch.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return curCtx->FftsPlusTaskLaunch(fftsPlusTaskInfo, curStm, flag);
}

rtError_t ApiImpl::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "RDMA send failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->RDMASend(sqIndex, wqeIndex, curStm);
}

rtError_t ApiImpl::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "RDMA db send failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->RdmaDbSend(dbIndex, dbInfo, curStm);
}

// dqs
rtError_t ApiImpl::LaunchDqsTask(Stream * const stm, const rtDqsTaskCfg_t * const taskCfg)
{
    UNUSED(stm);
    UNUSED(taskCfg);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemGetInfoByDeviceId(uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize)
{
    uint32_t realDeviceId;
    Runtime * const rt = Runtime::Instance();
    rtError_t error = rt->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    ERROR_RETURN(error, "ChgUserDevIdToDeviceId error:userDeviceId:%u is err:%#x", deviceId, static_cast<uint32_t>(error));
    
    int32_t cnt = 1;
    const auto npuDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);
    error = npuDrv->GetDeviceCount(&cnt);
    ERROR_RETURN(error, "Get device info failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_ERROR(realDeviceId >= static_cast<uint32_t>(cnt),
        RT_ERROR_INVALID_VALUE,
        "Invalid drv devId, current drv devId=%u , valid device range is [0, %d)",
        realDeviceId, cnt);

    return npuDrv->MemGetInfo(realDeviceId, isHugeOnly, freeSize, totalSize);
}

rtError_t ApiImpl::GetDeviceInfoByAttrMisc(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    rtError_t error = RT_ERROR_NONE;
    size_t freeSize = 0UL;
    size_t totalSize = 0UL;

    RT_LOG(RT_LOG_INFO, "get device info by attr misc, deviceId=%u attr=%d", deviceId, attr);

    /* 当attr无法转化为(moduleType, infoType)时，在此增加case */
    switch(attr) {
        case RT_DEV_ATTR_CUBE_CORE_NUM:
            error = GetDeviceInfoFromPlatformInfo(deviceId, "SoCInfo", "cube_core_cnt", val);
            break;
        case RT_DEV_ATTR_WARP_SIZE:
            [[fallthrough]];
        case RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE:
            [[fallthrough]];
        case RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE:
            error = GetDeviceSimtInfo(deviceId, attr, val);
            break;
        case RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE:
            error = MemGetInfoByDeviceId(deviceId, false, &freeSize, &totalSize);
            *val = static_cast<int64_t>(totalSize);
            break;
        case RT_DEV_ATTR_L2_CACHE_SIZE:
            error = GetDeviceInfoFromPlatformInfo(deviceId, "SoCInfo", "l2_size", val);
            break;
        case RT_DEV_ATTR_IS_VIRTUAL:
            unsigned int split_mode;
            drvError_t drvError;
            COND_RETURN_WARN(&halGetDeviceSplitMode == nullptr, RT_ERROR_DRV_NOT_SUPPORT, 
                "[drv api] halGetDeviceSplitMode does not exist.");
            drvError = halGetDeviceSplitMode(deviceId, &split_mode);
            if (drvError == DRV_ERROR_NONE) {
                if (split_mode == RT_VMNG_NORMAL_NONE_SPLIT_MODE) {
                    *val = static_cast<int64_t>(RT_NO_SPLIT_MODE);
                } else if (split_mode == RT_VMNG_VIRTUAL_SPLIT_MODE || split_mode == RT_VMNG_CONTAINER_SPLIT_MODE) {
                    *val = static_cast<int64_t>(RT_SPLIT_MODE);
                } else {
                    RT_LOG(RT_LOG_INFO, "Invalid split mode, Invalid=%d.", split_mode);
                }
            } else {
                DRV_ERROR_PROCESS(drvError, "[drv api]halGetDeviceSplitMode failed. drvRetCode=%d, device_id=%d.",
                static_cast<int32_t>(drvError), deviceId);
            }
            error = RT_GET_DRV_ERRCODE(drvError);
            break;
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Invalid attr=%d.", attr);
            error = RT_ERROR_INVALID_VALUE;
            break;
    }

    return error;
}

rtError_t ApiImpl::GetDeviceInfoByAttr(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    static const std::map<rtDevAttr, DevInfo> devInfoMap = {
        {RT_DEV_ATTR_AICPU_CORE_NUM, {MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM}},
        {RT_DEV_ATTR_AICORE_CORE_NUM, {MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM}},
        {RT_DEV_ATTR_VECTOR_CORE_NUM, {MODULE_TYPE_VECTOR_CORE, INFO_TYPE_CORE_NUM}},
        {RT_DEV_ATTR_PHY_CHIP_ID, {MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_CHIP_ID}},
        {RT_DEV_ATTR_SUPER_POD_DEVICE_ID, {MODULE_TYPE_SYSTEM, INFO_TYPE_SDID}},
        {RT_DEV_ATTR_SUPER_POD_SERVER_ID, {MODULE_TYPE_SYSTEM, INFO_TYPE_SERVER_ID}},
        {RT_DEV_ATTR_SUPER_POD_ID, {MODULE_TYPE_SYSTEM, INFO_TYPE_SUPER_POD_ID}},
        {RT_DEV_ATTR_CUST_OP_PRIVILEGE, {MODULE_TYPE_SYSTEM, INFO_TYPE_CUST_OP_ENHANCE}},
        {RT_DEV_ATTR_MAINBOARD_ID, {MODULE_TYPE_SYSTEM, INFO_TYPE_MAINBOARD_ID}},
        {RT_DEV_ATTR_SMP_ID, {MODULE_TYPE_SYSTEM, INFO_TYPE_MASTERID}},
    };
 
    int32_t moduleType = -1;
    int32_t infoType = -1;
    const auto it = devInfoMap.find(attr);
    if (it != devInfoMap.end()) {
        const DevInfo& devInfo = it->second;
        moduleType = devInfo.moduleType;
        infoType = devInfo.infoType;
        return GetDeviceInfo(deviceId, moduleType, infoType, val);
    }

    return GetDeviceInfoByAttrMisc(deviceId, attr, val);
}

rtError_t ApiImpl::GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
    const std::string &key, int64_t * const value)
{
    Runtime *const rt = Runtime::Instance();
    const rtSocType_t socType = rt->GetSocType();
    const std::string socVersion = GetSocVersionStrByType(socType);
    uint32_t platformRet = fe::PlatformInfoManager::GeInstance().InitRuntimePlatformInfos(socVersion);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR,
            "InitRuntime PlatformInfos failed, devId=%u, socType=%d, socVersion=%s, platformRet=%u",
            deviceId, socType, socVersion.c_str(), platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    fe::PlatFormInfos platformInfos;
    platformRet = fe::PlatformInfoManager::GeInstance().GetRuntimePlatformInfosByDevice(deviceId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR, "get runtime platformInfos by device failed, deviceId=%d", deviceId);
        return RT_ERROR_INVALID_VALUE;
    }

    std::string strVal;
    if (!platformInfos.GetPlatformResWithLock(label, key, strVal)) {
        RT_LOG(RT_LOG_ERROR, "get platform res failed, label=%s, key=%s socVersion=%s", 
            label.c_str(), key.c_str(), socVersion.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    try {
        *value = std::stoll(strVal);
    } catch (...) {
        RT_LOG(RT_LOG_ERROR, "strVal[%s] can not be converted to digital value, label=%s key=%s socVersion=%s",
            strVal.c_str(), label.c_str(), key.c_str(), socVersion.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ResetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventWorkModeSet(uint8_t mode)
{
    const std::unique_lock<std::mutex> lk(GlobalContainer::eventWorkMutex);
    const uint64_t eventModeInitRefCount = GlobalContainer::GetEventModeRefCount();
    if (eventModeInitRefCount > 0U) {
        RT_LOG(RT_LOG_ERROR, "repeatedly set work mode, eventModeInitRefCount: %lu", eventModeInitRefCount);
        return RT_ERROR_INVALID_VALUE;
    }

    GlobalContainer::SetEventWorkMode(mode);
    GlobalContainer::SetEventModeRefCount(1U);
    RT_LOG(RT_LOG_EVENT, "current work mode set success, mode (%u), 0 means software mode, 1 means hardware mode", mode);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventWorkModeGet(uint8_t *mode)
{
    *mode = GlobalContainer::GetEventWorkMode();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle)
{
    return evt->IpcGetEventHandle(handle);
}

rtError_t ApiImpl::IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    *event = new (std::nothrow) IpcEvent(dev, RT_EVENT_IPC, curCtx);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *event == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");
    RT_LOG(RT_LOG_INFO, "new event success");
    const rtError_t error = (*event)->IpcOpenEventHandle(handle);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(*event);,
        "IpcOpenEventHandle failed, retCode=%#x", error);
    return RT_ERROR_NONE;
}
}
}