/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_cust_dump_process.h"

#include <string>
#include <sched.h>
#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
#include "type_def.h"
#include "dump_task.h"
#include "aicpusd_sqe_adapter.h"

namespace AicpuSchedule {
    namespace {
        // aicpusd 与 custaicpusd 是同样的groupid
        constexpr const uint32_t DATA_DUMP_GRUOP_ID = 31U;
        constexpr const uint32_t DATA_DUMP_THREAD_INDEX = 0U;
        constexpr const uint64_t DATA_DUMP_EVENT_MASK = (1ULL << static_cast<uint32_t>(EVENT_CCPU_CTRL_MSG));
        constexpr const int32_t  DATA_DUMP_TIMEOUT_INTERVAL = 3000;
        constexpr const uint32_t SLEEP_USECS = 50000U;
    };

    AicpuSdCustDumpProcess &AicpuSdCustDumpProcess::GetInstance()
    {
        static AicpuSdCustDumpProcess instance;
        return instance;
    }

    AicpuSdCustDumpProcess::~AicpuSdCustDumpProcess()
    {
        UnitCustDataDumpProcess();
    }

    AicpuSdCustDumpProcess::AicpuSdCustDumpProcess()
        : deviceId_(0U), runningFlag_(false), initFlag_(false)
    {
    }

    int32_t AicpuSdCustDumpProcess::InitCustDumpProcess(
        const uint32_t deviceId, const aicpu::AicpuRunMode runMode)
    {
        if (runMode != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            aicpusd_info("not pcie mode no need this thread");
            return AICPU_SCHEDULE_OK;
        }
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (initFlag_) {
            aicpusd_info("already init before");
            return AICPU_SCHEDULE_OK;
        }
        initFlag_ = true;
        deviceId_ = deviceId;
        runningFlag_ = true;
        const int32_t semRet = sem_init(&workerSme_, 0, 0U);
        if (semRet == -1) {
            aicpusd_err("workerSme_ init failed, %s", strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        try {
            msgThread_ = std::thread(&AicpuSdCustDumpProcess::StartProcessEvent, this);
        } catch (std::exception &e) {
            aicpusd_err("create thread file:%s", e.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        const int32_t semWaitRet = sem_wait(&workerSme_);
        if (semWaitRet == -1) {
            aicpusd_err("workerSme wait failed, %s", strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuSdCustDumpProcess::SetDataDumpThreadAffinity() const
    {
        std::vector<uint32_t> ccpuIds = AicpuDrvManager::GetInstance().GetCcpuList();
        if (ccpuIds.empty()) {
            aicpusd_run_info("ccpu list is empty no need bind core");
            return AICPU_SCHEDULE_OK;
        }
        if (AicpuUtil::IsEnvValEqual(ENV_NAME_PROCMGR_AICPU_CPUSET, "1")) {
            uint32_t tryTimes = 0;
            const pid_t tid = static_cast<pid_t>(GetTid());
            auto ret = ProcMgrBindThread(tid, ccpuIds);
            while ((ret != 0U) && (tryTimes <= 1)) {
                aicpusd_warn("set affinity failed ret[%d], will try again", ret);
                (void)usleep(SLEEP_USECS);
                ret = ProcMgrBindThread(tid, ccpuIds);
                tryTimes++;
            }
            if (ret != 0) {
                aicpusd_err("aicpu bind tid by pm res[%d].", ret);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            } else {
                aicpusd_run_info("aicpu bind by pm success");
                return AICPU_SCHEDULE_OK;
            }
        } else {
            pthread_t threadId = pthread_self();
            cpu_set_t cpuset;
            CPU_ZERO(&cpuset);
            for (const auto cpuId: ccpuIds) {
                CPU_SET(cpuId, &cpuset);
                aicpusd_info("prepare bind threadId=%lu to cpuId=%u",
                    threadId, static_cast<uint32_t>(cpuId));
            }
            const int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
            if (ret != 0) {
                aicpusd_run_warn("Datadump thread bind ctrl cpu not success, will run in aicpu. ret=%d, reason=%s",
                                 ret, strerror(errno));
            } else {
                aicpusd_run_info("aicpu bind by self success");
            }
        }

        return AICPU_SCHEDULE_OK;
    }

    void AicpuSdCustDumpProcess::StartProcessEvent()
    {
        int32_t ret = halEschedCreateGrp(deviceId_, DATA_DUMP_GRUOP_ID, GRP_TYPE_BIND_CP_CPU);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halEschedCreateGrp dev[%u] group[%u] type[%d] failed, result[%d].",
                        deviceId_, DATA_DUMP_GRUOP_ID, GRP_TYPE_BIND_CP_CPU, ret);
            sem_post(&workerSme_);
            return;
        }

        if (SetDataDumpThreadAffinity() != AICPU_SCHEDULE_OK) {
            aicpusd_err("datadump thread bind core failed.");
            sem_post(&workerSme_);
            return;
        }
        ret = halEschedSubscribeEvent(deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX, DATA_DUMP_EVENT_MASK);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halEschedSubscribeEvent failed, deviceId[%u], groupId[%u], threadIndex[%u]",
                deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
            sem_post(&workerSme_);
            return;
        }
        ProcessMessage(0U);
        sem_post(&workerSme_);
        aicpusd_run_info("post work sem finish, dump process init finish. deviceId[%u]", deviceId_);
        LoopProcessEvent();
        aicpusd_run_info("dump thread stopped.");
    }

    void AicpuSdCustDumpProcess::LoopProcessEvent()
    {
        while (runningFlag_) {
            ProcessMessage(DATA_DUMP_TIMEOUT_INTERVAL);
        }
    }

    int32_t AicpuSdCustDumpProcess::ProcessMessage(const int32_t timeout)
    {
        event_info drvEventInfo;
        const int32_t retVal = halEschedWaitEvent(deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX,
                                                  timeout, &drvEventInfo);
        if (retVal == DRV_ERROR_NONE) {
            (void) DatadumpTaskProcess(drvEventInfo);
        } else if ((retVal == DRV_ERROR_SCHED_WAIT_TIMEOUT) || (retVal == DRV_ERROR_NO_EVENT)) {
            // if timeout, will continue wait event.
        } else if ((retVal == DRV_ERROR_SCHED_PROCESS_EXIT) || (retVal == DRV_ERROR_SCHED_PARA_ERR)) {
            if (runningFlag_) {
                runningFlag_ = false;
            }
            aicpusd_warn("Failed to get event, error code=%d, deviceId[%u], groupId[%u], threadIndex[%u]",
                         retVal, deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
        } else if (retVal == DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU) {
            runningFlag_ = false;
            aicpusd_err("Cpu Illegal get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
        } else {
            // record a error code
            aicpusd_err("Failed to get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
        }
        return retVal;
    }

    void AicpuSdCustDumpProcess::UnitCustDataDumpProcess()
    {
        aicpusd_info("UnitCustDataDumpProcess start");
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (!initFlag_) {
            aicpusd_info("already uninit no need uninit");
            return;
        }
        runningFlag_ = false;
        initFlag_ = false;
        aicpusd_info("sem post finish");
        if (msgThread_.joinable()) {
            msgThread_.join();
        }
        aicpusd_info("UnitCustDataDumpProcess finish");
    }

    int32_t AicpuSdCustDumpProcess::DoCustDatadumpTask(const event_info &drvEventInfo) const
    {
        if (static_cast<size_t>(drvEventInfo.priv.msg_len) != sizeof(AICPUDumpCustInfo)) {
            aicpusd_err("The len[%u] is not correct[%zu].", drvEventInfo.priv.msg_len, sizeof(AICPUDumpCustInfo));
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (drvEventInfo.comm.subevent_id != static_cast<uint32_t>(AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA)) {
            aicpusd_err("invalid event id:%u", drvEventInfo.comm.subevent_id);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (!IsValidCustAicpu(drvEventInfo.comm.host_pid)) {
            aicpusd_err("invalid sender pid:%d", drvEventInfo.comm.host_pid);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const AICPUDumpCustInfo * const info = PtrToPtr<const char_t, const AICPUDumpCustInfo>(drvEventInfo.priv.msg);
        // version 1 the stream id of dump key is invalid(65535)
        // but ack stream id need keep stream id form event info.
        const uint32_t ackStreamId = info->streamId;
        uint32_t streamId = info->streamId;
        const uint32_t taskId = info->taskId;
        const uint32_t threadIndex = info->threadIndex;
        const uint32_t devId = deviceId_;
        const int32_t custPid = AicpuScheduleInterface::GetInstance().GetAicpuCustSdProcId();
        if (FeatureCtrl::GetTsMsgVersion() == AicpuSqeAdapter::VERSION_1) {
            streamId = AicpuSqeAdapter::INVALID_VALUE16;
        }
        aicpusd_info("begin cust data dump streamid:%u, taskid:%u, threadindex:%u, custpid:%d, ackStreamId:%d",
                     streamId, taskId, threadIndex, custPid, ackStreamId);
        OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
        (void)opDumpTaskMgr.SetCustDumpTaskFlag(streamId, taskId , true);
        const int32_t dumpRet = opDumpTaskMgr.DumpOpInfo(streamId, taskId, INVALID_VAL, INVALID_VAL);
        if (dumpRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("cust data dump error streamid:%u, taskid:%u, threadindex:%u, custpid:%d",
                        streamId, taskId, threadIndex, custPid);
        }
        event_summary dataDumpEvent = {};
        AICPUDumpCustInfo rspInfo;
        rspInfo.retCode = dumpRet;
        rspInfo.streamId = ackStreamId;
        rspInfo.taskId = taskId;
        rspInfo.threadIndex = threadIndex;
        dataDumpEvent.msg = PtrToPtr<AICPUDumpCustInfo, char_t>(&rspInfo);
        dataDumpEvent.msg_len = static_cast<uint32_t>(sizeof(rspInfo));
        dataDumpEvent.dst_engine = CCPU_DEVICE;
        dataDumpEvent.policy = ONLY;
        dataDumpEvent.pid = custPid;
        dataDumpEvent.grp_id = DATA_DUMP_GRUOP_ID;
        dataDumpEvent.event_id = EVENT_CCPU_CTRL_MSG;
        dataDumpEvent.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA;
        const auto drvRet = halEschedSubmitEvent(devId, &dataDumpEvent);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("ERROR failed to dump event, result[%d], devId[%u]", static_cast<int32_t>(drvRet), devId);
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        aicpusd_info("sendback dump event to streamid[%u], taskid[%u], custpid[%d], devId[%u]",
            streamId, taskId, custPid, devId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuSdCustDumpProcess::DoUdfDatadumpSubmitEventSync(const char_t * const msg,
        const uint32_t len, struct event_proc_result &rsp) const
    {
        uint32_t headLen = sizeof(struct event_sync_msg);
        if (len < headLen) {
            aicpusd_err("len[%u], headLen[%u].", len, headLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        struct event_sync_msg msgHead = {};
        auto ret = memcpy_s(&msgHead, headLen, msg, headLen);
        if (ret != 0) {
            aicpusd_err("Memcpy failed. ret[%d], size[%u].", ret, headLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        struct event_summary backEvent = {};

        backEvent.dst_engine = msgHead.dst_engine;
        backEvent.policy = ONLY;
        backEvent.pid = msgHead.pid;
        backEvent.grp_id = msgHead.gid;
        backEvent.event_id =  static_cast<EVENT_ID>(msgHead.event_id);
        backEvent.subevent_id = msgHead.subevent_id;
        backEvent.msg_len = sizeof(struct event_proc_result);
        backEvent.msg = PtrToPtr<struct event_proc_result, char_t>(&rsp);
        const uint32_t deviceId = deviceId_;
        ret = halEschedSubmitEvent(deviceId, &backEvent);
        aicpusd_info("backEvent dst[%d], pid[%d], grpId[%d],  eventId[%d], subeventId[%d], msgLen[%d], deviceId[%u]",
            backEvent.dst_engine, backEvent.pid, backEvent.grp_id, backEvent.event_id,
            backEvent.subevent_id, backEvent.msg_len, deviceId);
        if (ret != 0) {
            aicpusd_err("halEschedSubmitEvent, ret=%d. dst[%d],pid[%d],"
                " grpId[%d], eventId[%d], subeventId[%d], msgLen[%d], deviceId[%u]",
                ret, backEvent.dst_engine, backEvent.pid, backEvent.grp_id,
                backEvent.event_id, backEvent.subevent_id, backEvent.msg_len, deviceId);
                return ret;
        }
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuSdCustDumpProcess::DoUdfDatadumpTask(const event_info &drvEventInfo) const
    {
        uint32_t headLen = sizeof(struct event_sync_msg);
        aicpusd_info("event id[%u], headLen[%u], msg len[%u] udfInfo len[%u]",
            drvEventInfo.comm.subevent_id, headLen,
            static_cast<size_t>(drvEventInfo.priv.msg_len), sizeof(AICPUDumpUdfInfo));
        if (static_cast<size_t>(drvEventInfo.priv.msg_len) != (sizeof(AICPUDumpUdfInfo) + headLen)) {
            aicpusd_err("The len[%u] is not correct[%u + %u].",
                drvEventInfo.priv.msg_len, sizeof(AICPUDumpUdfInfo), headLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (!IsValidUdf(drvEventInfo.comm.host_pid)) {
            aicpusd_err("invalid sender pid:%d", drvEventInfo.comm.host_pid);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        char msg[EVENT_MAX_MSG_LEN] = {};
        int32_t len = sizeof(char) * EVENT_MAX_MSG_LEN - headLen;
        int32_t rLen = drvEventInfo.priv.msg_len - headLen;
        int32_t ret = memcpy_s(msg, len, (drvEventInfo.priv.msg + headLen), rLen);
        if (ret != 0) {
            aicpusd_err("Memcpy failed. ret[%d] len[%d], rlen[%d]", ret, len, rLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const AICPUDumpUdfInfo * const info = PtrToPtr<const char_t, const AICPUDumpUdfInfo>(msg);
        uint8_t *dumpInfo = PtrToPtr<void, uint8_t>(ValueToPtr(info->udfInfo));
        uint64_t length = info->length;
        uint32_t udfPid = info->udfPid;
        UNUSED(udfPid);
        aicpusd_info("udf data dump begin dumpInfo[%p], length[%llu], info->udfInfo[%llu], udfPid[%d]",
            dumpInfo, length, info->udfInfo, udfPid);
        const int32_t hostPid = static_cast<int32_t>(AicpuSchedule::AicpuDrvManager::GetInstance().GetHostPid());
        const uint32_t deviceId = deviceId_;
        std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
        DATADUMP_MAKE_SHARED(opDumpTaskPtr = std::make_shared<OpDumpTask>(hostPid, deviceId),
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED);
        ret = opDumpTaskPtr->PreProcessUdfOpMappingInfo(dumpInfo, length);

        struct event_proc_result rsp = {};
        rsp.ret = ret;
        ret = DoUdfDatadumpSubmitEventSync(drvEventInfo.priv.msg, drvEventInfo.priv.msg_len, rsp);
        if (ret != 0) {
            aicpusd_err("DoUdfDatadumpSubmitEventSync failed, ret[%d], deviceId[%u]", ret, deviceId);
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        aicpusd_info("udf data dump finish dumpInfo[%p], length[%lld], udfPid[%d], deviceId[%u]",
            dumpInfo, length, udfPid, deviceId);
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuSdCustDumpProcess::DatadumpTaskProcess(const event_info &drvEventInfo) const
    {
        const uint32_t subEventId = drvEventInfo.comm.subevent_id;
        if (subEventId == static_cast<uint32_t>(AICPU_SUB_EVENT_REPORT_UDF_DUMPDATA)) {
            return DoUdfDatadumpTask(drvEventInfo);
        } else if (subEventId == static_cast<uint32_t>(AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA)) {
            return DoCustDatadumpTask(drvEventInfo);
        }
        aicpusd_err("invalid event id:%u", subEventId);
        return AICPU_SCHEDULE_OK;
    }
    void AicpuSdCustDumpProcess::GetCustDumpProcessInitFlag(bool &flag)
    {
        const std::lock_guard<std::mutex> lk(initMutex_);
        flag = initFlag_;
    }

    int32_t AicpuSdCustDumpProcess::CreateUdfDatadumpThread(const char_t *msg, const uint32_t len)
    {
        aicpusd_info("create udf dump thread.");
        uint32_t runMode = 0;
        int32_t ret = 0;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Get current aicpu ctx failed.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        ret = InitCustDumpProcess(deviceId, static_cast<aicpu::AicpuRunMode>(runMode));
        if (ret != 0) {
            aicpusd_err("InitCustDumpProcess failed.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        struct event_proc_result rsp = {};
        rsp.ret = ret;
        ret = DoUdfDatadumpSubmitEventSync(msg, len, rsp);
        if (ret != 0) {
            aicpusd_err("DoUdfDatadumpSubmitEventSync failed, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        aicpusd_info("create udf dump thread finish.");
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuSdCustDumpProcess::IsValidUdf(const int32_t sendPid) const
    {
        if (!FeatureCtrl::IfCheckEventSender()) {
            return true;
        }
        unsigned int hostpid = 0;
        unsigned int cpType = DEVDRV_PROCESS_CPTYPE_MAX;
        auto ret = drvQueryProcessHostPid(sendPid, nullptr, nullptr, &hostpid, &cpType);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("query host pid failed pid:%d, ret:%d", sendPid, ret);
            return false;
        }
        const int32_t curHostPid = AicpuDrvManager::GetInstance().GetHostPid();
        if (hostpid == static_cast<unsigned int>(curHostPid)) {
            return true;
        }
        aicpusd_err("invalid sender pid:%d, query hostpid:%d, curHostPid:%d", sendPid, hostpid, curHostPid);
        return false;
    }

    bool AicpuSdCustDumpProcess::IsValidCustAicpu(const int32_t sendPid) const
    {
        if (!FeatureCtrl::IfCheckEventSender()) {
            return true;
        }
        const int32_t custPid = AicpuScheduleInterface::GetInstance().GetAicpuCustSdProcId();
        if (sendPid == custPid) {
            return true;
        }
        aicpusd_err("invalid sender pid:%d, custpid:%d", sendPid, custPid);
        return false;
    }
}
int32_t CreateDatadumpThread(const struct TsdSubEventInfo * const msg)
{
    char message[EVENT_MAX_MSG_LEN] = {};
    auto ret = memcpy_s(message, EVENT_MAX_MSG_LEN, msg, sizeof(struct TsdSubEventInfo));
    if (ret != 0) {
        aicpusd_err("Memcpy failed. ret[%d], size[%u].", ret, sizeof(struct TsdSubEventInfo));
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().CreateUdfDatadumpThread(message,
        EVENT_MAX_MSG_LEN);
}