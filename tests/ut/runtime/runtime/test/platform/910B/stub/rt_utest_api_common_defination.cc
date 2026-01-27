/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "../../../rt_utest_api.hpp"

DVresult drvMemGetAttribute_1(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_LOCK_DEV;
    return DRV_ERROR_NONE;
}
DVresult drvMemGetAttribute_2(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_LOCK_HOST;
    return DRV_ERROR_NONE;
}
DVresult drvMemGetAttribute_3(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_LOCK_DEV_DVPP;
    return DRV_ERROR_NONE;
}
DVresult drvMemGetAttribute_4(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_SVM;
    return DRV_ERROR_NONE;
}
DVresult drvMemGetAttribute_5(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_SVM_DEVICE;
    return DRV_ERROR_NONE;
}
DVresult drvMemGetAttribute_6(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_SVM_HOST;
    return DRV_ERROR_NONE;
}

DVresult drvMemGetAttribute_7(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = 0x0080; // DV_MEM_USER_MALLOC
    return DRV_ERROR_NONE;
}

DVresult drvMemGetAttribute_8(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = 0x01000; // else
    return DRV_ERROR_NONE;
}
extern rtError_t rtStreamAddToModel(rtStream_t stm, rtModel_t captureMdl);

drvError_t drvGetPlatformInfo_1(uint32_t *info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_2(uint32_t *info)
{
    *info = RT_RUN_MODE_AICPU_SCHED;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_3(uint32_t *info)
{
    *info = RT_RUN_MODE_OFFLINE;
    return DRV_ERROR_NONE;
}

int stat_stub0 (const char *pathname, struct stat *statbuf)
{
    UNUSED(pathname);
    statbuf->st_size = 100;
    return 0;
}

int munmap_stub0 (void *start,size_t length)
{
    UNUSED(start);
    UNUSED(length);
    return 1;
}

Context *CurrentContextStub(ApiImpl *api_imp)
{
    return nullptr;
}

Context *CurrentContextStubCtx(ApiImpl *api_imp)
{
    static Context ctx(nullptr, false);
    return &ctx;
}

drvError_t halGetAPIVersionStub(int *halAPIVersion)
{
    *halAPIVersion = 0x050E17;
    return DRV_ERROR_NONE;
}
rtError_t ProfilerTraceExTaskInitStub(TaskInfo* taskInfo, const uint64_t id, const uint64_t mdlId, const uint16_t tag)
{
    taskInfo->type = TS_TASK_TYPE_PROFILER_TRACE_EX;
    taskInfo->typeName = "PROFILER_TRACE_EX";
    taskInfo->u.profilerTraceExTask.profilerTraceId = id;
    taskInfo->u.profilerTraceExTask.modelId = mdlId;
    taskInfo->u.profilerTraceExTask.tagId = tag;

    return RT_ERROR_INVALID_VALUE;
}

rtError_t kernel_launch_stub(const void *stubFunc,
                         uint32_t blockDim,
                         void *args,
                         uint32_t argsSize,
                         rtSmDesc_t *smDesc,
                         rtStream_t stream)
{
    return (stubFunc == &ApiTest::function_)
          && (blockDim == 1)
          && (((void **)args)[0] == (void*)100)
          && (((void **)args)[1] == (void*)200)
          && (argsSize == 2*sizeof(void*))
          && (smDesc == NULL)
          && (stream == ApiTest::stream_)
          ? RT_ERROR_NONE
          : ACL_ERROR_RT_PARAM_INVALID;
}
drvError_t halQueueCreate_stub(unsigned int devId, const QueueAttr *queAttr, unsigned int *qid) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedAttachDevice_stub(unsigned int devId) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedDettachDevice_stub(unsigned int devId) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedWaitEvent_stub(unsigned int devId, unsigned int grpId, unsigned int threadId,
    int timeout, struct event_info *event) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedCreateGrp_stub(unsigned int devId, unsigned int grpId, GROUP_TYPE type) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedSubmitEvent_stub(unsigned int devId, struct event_summary *event) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedSubscribeEvent_stub(unsigned int devId, unsigned int grpId, unsigned int threadId,
    unsigned long long eventBitmap) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedAckEvent_stub(unsigned int devId, EVENT_ID eventId, unsigned int subeventId,
    char *msg, unsigned int msgLen) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedQueryInfo_stub(unsigned int devId, ESCHED_QUERY_TYPE type, struct esched_input_info *inPut,
    struct esched_output_info *outPut) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueInit_stub(unsigned int devId) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueDestroy_stub(unsigned int devId, unsigned int qid) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueEnQueue_stub(unsigned int devId, unsigned int qid, void *mbuf) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueDeQueue_stub(unsigned int devId, unsigned int qid, void **mbuf) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueuePeek_stub(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueEnQueueBuff_stub(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueDeQueueBuff_stub(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueQueryInfo_stub(unsigned int devId, unsigned int qid, QueueInfo *queInfo) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueQuery_stub(unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara *inPut,
    QueueQueryOutputPara *outPut) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueGrant_stub(unsigned int devId, int qid, int pid, QueueShareAttr attr) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueAttach_stub(unsigned int devId, unsigned int qid, int timeOut) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halEschedSubmitEventSync_stub(unsigned int devId, struct event_summary *event, int timeout,
    struct event_reply *ack) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueSet_stub(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *input) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueReset_stub(unsigned int devId, unsigned int qid) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueGetQidbyName_stub(unsigned int devId, const char *name, unsigned int *qid) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueSubF2NFEvent_stub(unsigned int devId, unsigned int qid, unsigned int groupid) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
drvError_t halQueueSubscribe_stub(unsigned int devId, unsigned int qid, unsigned int groupId, int type) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}
int halGrpQuery_stub(GroupQueryCmdType cmd,
    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    *outLen = 0;
    if (cmd == GRP_QUERY_GROUP_ADDR_INFO) {
        GroupQueryInput* grpInput = PtrToPtr<void, GroupQueryInput>(inBuff);
        uint32_t devId = grpInput->grpQueryGroupAddrPara.devId;
        return (devId == static_cast<uint32_t>(DEFAULT_HOSTCPU_LOGIC_DEVICE_ID)) ?
            static_cast<int>(DRV_ERROR_NONE) : static_cast<int>(DRV_ERROR_INVALID_VALUE);
    }
    return static_cast<int>(DRV_ERROR_NONE);
}
drvError_t halGrpCacheAlloc_stub(const char *name, unsigned int devId, GrpCacheAllocPara *para) {
    return (devId == DEFAULT_HOSTCPU_LOGIC_DEVICE_ID) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}

drvError_t drvGetDevIDs_stub_00(uint32_t *devices, uint32_t len)
{
    for (size_t i = 0; i < len; i++) {
        devices[i] = i;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs_stub_01(uint32_t *devices, uint32_t len)
{
    for (size_t i = 0; i < 8; i++) {
        devices[i] = i;
    }
    return DRV_ERROR_NONE;
}

void RegStreamStateCallbackFunc(rtStream_t stream, const bool isCreate)
{
    printf("RegStreamStateCallback, stream=[%p]\n", stream);
}

drvError_t halResourceIdFreeStub(uint32_t devId, struct halResourceIdInputInfo *in)
{
    return DRV_ERROR_NONE;
}

drvError_t drvNotifyIdAddrOffsetStub(uint32_t devId, struct drvNotifyInfo *info)
{
    info->devAddrOffset = 0;
    return DRV_ERROR_NONE;
}

rtDeviceState g_rtsDeviceStateCallback[TEST_MAX_DEV_NUM];

void stubRtsDeviceStateCallback(uint32_t devId, rtDeviceState state, void *args)
{
    g_rtsDeviceStateCallback[devId] = state;
    return;
}

void stubRtsStreamStateCallback(rtStream_t stm, rtStreamState state, void *args)
{
    return;
}

void ResetAllDeviceStateV2()
{
    for (uint32_t i = 0; i < TEST_MAX_DEV_NUM; ++i) {
        g_rtsDeviceStateCallback[i] = RT_DEVICE_STATE_SET_PRE;
    }
}

rtError_t rtsSetDeviceTaskAbortCallbackFake(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    const rtError_t error = apiInstance->SetTaskAbortCallBack(regName, RtPtrToPtr<void *>(callback),
        args, TaskAbortCallbackType::TASK_ABORT_TYPE_MAX);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

rtError_t rtsSetTaskFailCallbackFake(const char_t *regName, rtsTaskFailCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    const rtError_t error = apiInstance->RegTaskFailCallbackByModule(regName, RtPtrToPtr<void *>(callback),
        args, TaskFailCallbackType::TASK_FAIL_CALLBACK_TYPE_MAX);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

void stubRtsTaskFailCallback(rtExceptionInfo_t *exceptionInfo, void *args)
{
    return;
}

void taskFailCallback(rtExceptionInfo_t *exceptionInfo)
{
    printf("this is app taskFail callback");
}

drvError_t halResourceIdAllocFailedStub(uint32_t devId, struct halResourceIdInputInfo *in,
    struct halResourceIdOutputInfo *out) {
    return DRV_ERROR_INNER_ERR;
}

drvError_t drvNotifyIdAddrOffsetFailedStub(uint32_t devId, struct drvNotifyInfo *info)
{
    return DRV_ERROR_INNER_ERR;
}

drvError_t halResourceIdAllocStub(uint32_t devId, struct halResourceIdInputInfo *in,
    struct halResourceIdOutputInfo *out) {
    out->resourceId = 1;
    return DRV_ERROR_NONE;
}

uint32_t g_exception_device_id = 1;
void StubTaskFailCallback(rtExceptionInfo *exceptionInfo)
{
    exceptionInfo = exceptionInfo;
    g_exception_device_id = exceptionInfo->deviceid;
    return;
}

int32_t stubRtsDeviceTaskAbortCallback(uint32_t devId, rtDeviceTaskAbortStage stage, uint32_t timeout, void *args)
{
    return 0;
}

rtError_t GetNotifyPhyInfoStub(cce::runtime::ApiImpl *api,
    Notify *const inNotify, rtNotifyPhyInfo* notifyInfo)
{
    notifyInfo->phyId = 1;
    notifyInfo->tsId = 2;
    return RT_ERROR_NONE;
}
rtError_t msprofreportcallback(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    return ACL_RT_SUCCESS;
}

void initData(uint32_t *hostPtr, uint32_t count, uint32_t data) {
    for (int i = 0; i < count; i++) {
        hostPtr[i] = data;
    }
}

void initUpdateDsaSqe(uint32_t *hostAddr, rtStarsDsaSqe_t* dsaSqe)
{
    const uint32_t * const cmd = reinterpret_cast<const uint32_t *>(dsaSqe);
    for(int i = 4U; i <= 13U; i++) {
        hostAddr[i - 4] = cmd[i];
    }
}

rtSocType_t g_StubSocType = SOC_BEGIN;

struct RtUtestStubHardwareInfo {
    int32_t socType;
    int32_t aicoreNum;
    int32_t aicoreFreq;
    int32_t tsNum;
    int64_t hardwareVersion;
};

void drvStubInit(rtSocType_t socType)
{
    g_StubSocType = socType;
}
rtStream_t ApiTest::stream_ = NULL;
rtEvent_t ApiTest::event_ = NULL;
void* ApiTest::binHandle_ = nullptr;
char  ApiTest::function_ = 'a';
uint32_t ApiTest::binary_[32] = {};
Driver* ApiTest::driver_ = NULL;
bool ApiTest::disableFlag_ = true;

bool ApiTest5::flag  = false;