/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_cust_so.h"

#include "aicpusd_cust_so_manager.h"
#include "aicpusd_drv_manager.h"
#include "hwts_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string LOADOP_FROM_BUFF = "loadOpFromBuf";
const std::string BATCH_LOADSO_FROM_BUFF = "batchLoadsoFrombuf";
const std::string DELETE_CUSTOP = "deleteCustOp";

constexpr uint32_t MAX_CUSTOM_SO_NUM = 1024U;
constexpr uint32_t CCPU_DEFAULT_GROUP_ID = 30U;
constexpr GroupShareAttr GROUP_WITH_ALL_ATTR = {1U, 1U, 1U, 1U, 0U}; // admin + read + write + alloc
}  // namespace


std::mutex LoadOpFromBuffTsKernel::mutexForStartCustProcess_;
std::set<std::string> LoadOpFromBuffTsKernel::alreadyLoadSoName_;

int32_t CustOperationCommon::SendCtrlCpuMsg(
    int32_t custAicpuPid, const uint32_t eventType, char_t *msg, const uint32_t msgLen) const
{
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = custAicpuPid;
    eventInfoSummary.event_id = EVENT_CCPU_CTRL_MSG;
    eventInfoSummary.subevent_id = eventType;
    eventInfoSummary.msg = msg;
    eventInfoSummary.msg_len = msgLen;
    eventInfoSummary.grp_id = CCPU_DEFAULT_GROUP_ID;
    eventInfoSummary.dst_engine = CCPU_DEVICE;
    DeployContext deployCtx = DeployContext::DEVICE;
    (void)GetAicpuDeployContext(deployCtx);
    if (deployCtx == DeployContext::HOST) {
        eventInfoSummary.dst_engine = static_cast<uint32_t>(CCPU_HOST);
        aicpusd_info("SendCtrlCpuMsg to dst engine: %u", eventInfoSummary.dst_engine);
    }
    const drvError_t ret = halEschedSubmitEvent(AicpuDrvManager::GetInstance().GetDeviceId(),
                                                &eventInfoSummary);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Failed to submit aicpu event. ret is %d.", ret);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    aicpusd_info("SendCtrlCpuMsg success type:%u", eventType);
    return AICPU_SCHEDULE_OK;
}

int32_t CustOperationCommon::GetGroupNameInfo(std::vector<std::string> &groupNameList, std::string &groupNameStr) const
{
    const pid_t curPid = drvDeviceGetBareTgid();
    std::map<std::string, GroupShareAttr> buffGrpInfo = {};
    const int32_t ret = AicpuDrvManager::GetInstance().QueryProcBuffInfo(static_cast<uint32_t>(curPid), buffGrpInfo);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Fail to get group info of acipusd[%d]", curPid);
        return ret;
    }

    for (const auto &groupInfo : buffGrpInfo) {
        if (groupInfo.second.admin == 1U) {
            groupNameList.emplace_back(groupInfo.first);
            groupNameStr = groupNameStr + groupInfo.first + ",";
            aicpusd_info("Get aicpusd buff group[%s] succ.", groupInfo.first.c_str());
        }
    }

    return AICPU_SCHEDULE_OK;
}

int32_t CustOperationCommon::StartCustProcess(
    const uint32_t loadLibNum, const char_t *const loadLibName[]) const
{
    // 01-Get group name of current process
    std::vector<std::string> groupNameList = {};
    std::string groupNameStr = "";
    const int32_t ret = GetGroupNameInfo(groupNameList, groupNameStr);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    const uint32_t validGroupNum = static_cast<uint32_t>(groupNameList.size());
    // Remove comma at the end of the string
    groupNameStr = ((validGroupNum != 0U) ? groupNameStr.substr(0UL, groupNameStr.length() - 1UL) : groupNameStr);
    // 02-startup cust aicpusd and get cust aicpusd pid
    int32_t custAicpuPid = -1;
    bool firstStart = true;
    int32_t tdtStatus = 0;
    if (&CreateOrFindCustPidEx != nullptr) {
        aicpusd_info("Create or find custom pid by CreateOrFindCustPidEx.");
        CustAicpuPara para = {};
        para.paraVersion = static_cast<uint32_t>(CustAicpuParaVersion::CUST_AICPU_PARA_WITHOUT_SO_INFO);
        para.infoPara.paraWithoutSoInfo.deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        para.infoPara.paraWithoutSoInfo.hostPid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
        para.infoPara.paraWithoutSoInfo.vfId = AicpuDrvManager::GetInstance().GetVfId();
        para.infoPara.paraWithoutSoInfo.groupNameList = groupNameStr.c_str();
        para.infoPara.paraWithoutSoInfo.groupNameNum = validGroupNum;
        para.infoPara.paraWithoutSoInfo.custProcPid = &custAicpuPid;
        para.infoPara.paraWithoutSoInfo.firstStart = &firstStart;
        tdtStatus = CreateOrFindCustPidEx(&para);
    } else {
        aicpusd_info("Create or find custom pid by CreateOrFindCustPid, load so event will be send to tsd.");
        tdtStatus = CreateOrFindCustPid(AicpuDrvManager::GetInstance().GetDeviceId(), loadLibNum,
            loadLibName, static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()),
            AicpuDrvManager::GetInstance().GetVfId(), groupNameStr.c_str(), validGroupNum, &custAicpuPid, &firstStart);
    }
    if ((tdtStatus != 0) || (custAicpuPid < 0)) {
        aicpusd_err("Call tdt interface to create or find custom process pid failed, error[%d] pid[%d].",
                    tdtStatus, custAicpuPid);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    AicpuScheduleInterface::GetInstance().SetAicpuCustSdProcId(custAicpuPid);
    if (!firstStart) {
        aicpusd_run_info("Cust aicpu have already existed");
        return AICPU_SCHEDULE_OK;
    }

    // 03-add group for cust aicpu
    for (const auto &grpName : groupNameList) {
        const auto drvRet = halGrpAddProc(grpName.c_str(), custAicpuPid, GROUP_WITH_ALL_ATTR);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Add group[%s] for cust aicpusd failed, ret[%d]", grpName.c_str(), drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
    }
    aicpusd_run_info("halGrpAddProc success, custAicpuPid[%d], validGroupNum[%u]", custAicpuPid, validGroupNum);

    if (validGroupNum > 0U) {
        if (SendCtrlCpuMsg(
                custAicpuPid, static_cast<uint32_t>(TsdSubEventType::TSD_EVENT_STOP_SUB_PROCESS_WAIT), nullptr, 0U) !=
            AICPU_SCHEDULE_OK) {
            aicpusd_run_info("SendCtrlCpuMsg send to custaicpu no success");
        }
        aicpusd_run_info("SendCtrlCpuMsg Send to custaicpu success");
        (void)StopWaitForCustAicpu();
        aicpusd_run_info("wait custaicpu attach group success");
    }
    if (&CreateOrFindCustPidEx != nullptr) {
        aicpusd_run_info("Begin to notify open custom so event to cust ctrl cpu, custAicpuPid[%d]", custAicpuPid);
        int32_t notifyRet = AicpuNotifyLoadSoEventToCustCtrlCpu(AicpuDrvManager::GetInstance().GetDeviceId(),
            static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()),
            AicpuDrvManager::GetInstance().GetVfId(), custAicpuPid, loadLibNum, loadLibName);
        if (notifyRet != 0) {
            aicpusd_warn("Aicpu notify open custom so event to cust ctrl aicpu failed, error[%d] pid[%d].",
                         notifyRet, custAicpuPid);
        }
    }

    aicpusd_run_info("StartCustProcess end");
    return AICPU_SCHEDULE_OK;
}

int32_t CustOperationCommon::AicpuNotifyLoadSoEventToCustCtrlCpu(const uint32_t deviceId, const uint32_t hostPid,
                                                                 const uint32_t vfId, const int32_t custAicpuPid,
                                                                 const uint32_t loadLibNum,
                                                                 const char_t * const loadLibName[]) const
{
    if ((loadLibNum > 0U) && (loadLibName == nullptr)) {
        aicpusd_err("Load lib name is nullptr, loadLibNum=%u, hostPid=%u", loadLibNum, hostPid);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    for (uint32_t i = 0U; i < loadLibNum; i++) {
        TsdSubEventInfo info = { };
        info.deviceId = deviceId;
        info.srcPid = static_cast<uint32_t>(getpid());
        info.dstPid = custAicpuPid;
        info.hostPid = hostPid;
        info.vfId = vfId;
        info.procType = 1U;
        info.eventType = static_cast<uint32_t>(AICPU_SUB_EVENT_OPEN_CUSTOM_SO);
        const errno_t errRet = strcpy_s(info.priMsg, MAX_EVENT_PRI_MSG_LENGTH, loadLibName[i]);
        if (errRet != EOK) {
            aicpusd_err("Copy %s failed, error[%d]", loadLibName[i], errRet);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        event_summary event = { };
        event.dst_engine = CCPU_DEVICE;
        event.policy = ONLY;
        event.pid = custAicpuPid;
        event.grp_id = 30U;
        event.event_id = EVENT_CCPU_CTRL_MSG;
        event.subevent_id = AICPU_SUB_EVENT_OPEN_CUSTOM_SO;
        event.msg = PtrToPtr<TsdSubEventInfo, char_t>(&info);
        event.msg_len = static_cast<uint32_t>(sizeof(TsdSubEventInfo));
        aicpusd_info("msg[%s], msglen[%u]", event.msg, event.msg_len);
        const drvError_t ret = halEschedSubmitEvent(deviceId, &event);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_run_warn("Aicpu send open custom so event to custom ctrl cpu not success, deviceId[%u], "
                             "errcode[%d], please check so name length", deviceId, ret);
        } else {
            aicpusd_info("Aicpu send open custom so event to custom ctrl cpu success.");
        }
        aicpusd_run_info("Notify custom soName info on deviceId[%u] hostpid[%u] vfId[%u] index[%u] soName[%s] success.",
                         deviceId, hostPid, vfId, i, loadLibName[i]);
    }
    aicpusd_run_info("End AicpuNotifyLoadSoEventToCustCtrlCpu on deviceId[%u] hostPid[%u] vfId[%u] soNum[%u].",
                     deviceId, hostPid, vfId, loadLibNum);
    return AICPU_SCHEDULE_OK;
}

int32_t LoadOpFromBuffTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_run_info("Begin to process ts kernel loadOpFromBuf");
    if (!AicpuCustSoManager::GetInstance().IsSupportCustAicpu()) {
        aicpusd_err("Not support cust aicpu scheduler in message queue mode.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    const auto paramKernelName =
        PtrToPtr<void, char_t>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.kernelName));
    if (paramKernelName == nullptr) {
        aicpusd_err("Process LoadOpFromBuf failed as the name of kernel is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    std::string realSoName;
    const auto loadOpFromBufArgs =
        PtrToPtr<void, LoadOpFromBufArgs>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    const int32_t ret = AicpuCustSoManager::GetInstance().CheckAndCreateSoFile(loadOpFromBufArgs, realSoName);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    // if have cust pid, create or find cust pid
    uint32_t runMode;
    const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
    if (status != aicpu::AICPU_ERROR_NONE) {
        aicpusd_err("Get current aicpu ctx failed.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    if (runMode != aicpu::AicpuRunMode::THREAD_MODE) {
        const std::lock_guard<std::mutex> lk(mutexForStartCustProcess_);
        constexpr uint32_t soNum = 1U;
        const char_t *soNames[soNum] = {realSoName.data()};
        auto it = alreadyLoadSoName_.insert(realSoName);
        if (it.second == true) {
            const int32_t startRet = StartCustProcess(soNum, &soNames[0UL]);
            if (startRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Get aicpu group, start up and add group to cust aicpu failed.");
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
        } else {
            aicpusd_run_info("[%s] is already load.", realSoName.c_str());
        }
    }

    aicpusd_run_info("End to process ts LoadOpFromBuf event.");
    return AICPU_SCHEDULE_OK;
}

int32_t BatchLoadSoFromBuffTsKernel::TryToStartCustProcess(
    const std::unique_ptr<const char_t *[]> &soNames, const uint32_t soNum) const
{
    // if have cust pid, create or find cust pid
    uint32_t runMode = 0U;
    const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
    if (status != aicpu::AICPU_ERROR_NONE) {
        aicpusd_err("Get current aicpu ctx failed.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    if (runMode != aicpu::AicpuRunMode::THREAD_MODE) {
        const int32_t ret = StartCustProcess(soNum, soNames.get());
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Get aicpu group, start up and add group to cust aicpu failed.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
    }

    return AICPU_SCHEDULE_OK;
}

int32_t BatchLoadSoFromBuffTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel BatchLoadOpFromBuf event.");
    if (!AicpuCustSoManager::GetInstance().IsSupportCustAicpu()) {
        aicpusd_err("Not support cust aicpu scheduler in message queue mode.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    const auto paramKernelName = 
        PtrToPtr<void, char_t>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.kernelName));
    if (paramKernelName == nullptr) {
        aicpusd_err("Process BatchLoadOpFromBuf failed as the name of kernel is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto batchLoadOpFromBufArgs =
        PtrToPtr<void, BatchLoadOpFromBufArgs>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (batchLoadOpFromBufArgs == nullptr) {
        aicpusd_err("param base for batch load op from buffer is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint64_t custSoInfo = static_cast<uint64_t>(batchLoadOpFromBufArgs->opInfoArgs);
    const uint32_t soNum = static_cast<uint32_t>(batchLoadOpFromBufArgs->soNum);
    // check so num
    if ((soNum == 0U) || (soNum > MAX_CUSTOM_SO_NUM)) {
        aicpusd_err("BatchLoadOpFromBuf kernel input param soNum is invalid. soNum value is %u.", soNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("BatchLoadOpFromBuf soNum is %u.", soNum);
    const std::unique_ptr<const char_t *[]> soNames(new (std::nothrow) const char_t *[soNum]);
    if (soNames == nullptr) {
        aicpusd_err("BatchLoadOpFromBuf kernel malloc for so names array failed, so number[%u]", soNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    std::vector<std::string> soNameVec;
    for (uint32_t i = 0U; i < soNum; i++) {
        std::string realSoName;
        LoadOpFromBufArgs * const custSo =
            PtrToPtr<void, LoadOpFromBufArgs>(ValueToPtr(custSoInfo)) + i;
        const int32_t ret = AicpuCustSoManager::GetInstance().CheckAndCreateSoFile(custSo, realSoName);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        soNameVec.emplace_back(realSoName);
        const size_t index = static_cast<size_t>(i);
        soNames[index] = soNameVec[index].data();
    }

    if (TryToStartCustProcess(soNames, soNum) != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    aicpusd_info("End to process ts BatchLoadOpFromBuf event.");
    return AICPU_SCHEDULE_OK;
}

int32_t DeleteCustOpTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel deleteCustOp event.");
    if (!AicpuCustSoManager::GetInstance().IsSupportCustAicpu()) {
        aicpusd_err("Not support cust aicpu scheduler in message queue mode.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    const auto batchLoadOpFromBufArgs =
        PtrToPtr<void, BatchLoadOpFromBufArgs>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (batchLoadOpFromBufArgs == nullptr) {
        aicpusd_err("param base for delete cust op is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint64_t custSoInfo = static_cast<uint64_t>(batchLoadOpFromBufArgs->opInfoArgs);
    const uint32_t soNum = static_cast<uint32_t>(batchLoadOpFromBufArgs->soNum);
    // check so num
    if ((soNum == 0U) || (soNum > MAX_CUSTOM_SO_NUM)) {
        aicpusd_err("DeleteCustOp kernel input param soNum is invalid. soNum value is %u.", soNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    for (uint32_t i = 0U; i < soNum; i++) {
        LoadOpFromBufArgs * const custSo =
            PtrToPtr<void, LoadOpFromBufArgs>(ValueToPtr(custSoInfo)) + i;
        const int32_t ret = AicpuCustSoManager::GetInstance().CheckAndDeleteSoFile(custSo);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
    }

    // After delete so, check whether dir is empty
    (void)AicpuCustSoManager::GetInstance().CheckAndDeleteCustSoDir();
    aicpusd_info("End to process ts deleteCustOp event.");
    return AICPU_SCHEDULE_OK;
}

REGISTER_HWTS_KERNEL(LOADOP_FROM_BUFF, LoadOpFromBuffTsKernel);
REGISTER_HWTS_KERNEL(BATCH_LOADSO_FROM_BUFF, BatchLoadSoFromBuffTsKernel);
REGISTER_HWTS_KERNEL(DELETE_CUSTOP, DeleteCustOpTsKernel);
}  // namespace AicpuSchedule