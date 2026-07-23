/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_drv_api.h"
#include "osal.h"
#include "msprof_dlog.h"

namespace analysis {
namespace dvvp {
namespace driver {
namespace {
// 从 dlopen 打开的 libascend_hal.so 句柄解析符号。通用服务器场景（句柄为空）或符号缺失时
// 返回 nullptr，由调用方按 not support / error 降级。
template <class T>
inline T LoadDrvApi(void *handle, const char *name)
{
    if (handle == nullptr) {
        return nullptr;
    }
    return reinterpret_cast<T>(OsalDlsym(handle, name));
}
}  // namespace

MsprofDrvApi::~MsprofDrvApi()
{
    if (ascendHalLibHandle_ != nullptr) {
        (void)OsalDlclose(ascendHalLibHandle_);
        ascendHalLibHandle_ = nullptr;
    }
}

void MsprofDrvApi::LoadApi()
{
    drvGetDevNum_ = LoadDrvApi<DrvGetDevNumFunc>(ascendHalLibHandle_, "drvGetDevNum");
    drvGetDevIDs_ = LoadDrvApi<DrvGetDevIDsFunc>(ascendHalLibHandle_, "drvGetDevIDs");
    drvGetPlatformInfo_ = LoadDrvApi<DrvGetPlatformInfoFunc>(ascendHalLibHandle_, "drvGetPlatformInfo");
    drvDeviceStatus_ = LoadDrvApi<DrvDeviceStatusFunc>(ascendHalLibHandle_, "drvDeviceStatus");
    halGetDeviceInfo_ = LoadDrvApi<HalGetDeviceInfoFunc>(ascendHalLibHandle_, "halGetDeviceInfo");
    profDrvGetChannels_ = LoadDrvApi<ProfDrvGetChannelsFunc>(ascendHalLibHandle_, "prof_drv_get_channels");
    profDrvStart_ = LoadDrvApi<ProfDrvStartFunc>(ascendHalLibHandle_, "prof_drv_start");
    profStop_ = LoadDrvApi<ProfStopFunc>(ascendHalLibHandle_, "prof_stop");
    profChannelRead_ = LoadDrvApi<ProfChannelReadFunc>(ascendHalLibHandle_, "prof_channel_read");
    profChannelPoll_ = LoadDrvApi<ProfChannelPollFunc>(ascendHalLibHandle_, "prof_channel_poll");
    halProfDataFlush_ = LoadDrvApi<HalProfDataFlushFunc>(ascendHalLibHandle_, "halProfDataFlush");
    drvDeviceGetPhyIdByIndex_ =
        LoadDrvApi<DrvDeviceGetPhyIdByIndexFunc>(ascendHalLibHandle_, "drvDeviceGetPhyIdByIndex");
    halEschedQueryInfo_ = LoadDrvApi<HalEschedQueryInfoFunc>(ascendHalLibHandle_, "halEschedQueryInfo");
    halEschedSubmitEvent_ = LoadDrvApi<HalEschedSubmitEventFunc>(ascendHalLibHandle_, "halEschedSubmitEvent");
    halProfSampleRegister_ = LoadDrvApi<HalProfSampleRegisterFunc>(ascendHalLibHandle_, "halProfSampleRegister");
    halProfSampleRegisterEx_ =
        LoadDrvApi<HalProfSampleRegisterExFunc>(ascendHalLibHandle_, "halProfSampleRegisterEx");
    halProfQueryAvailBufLen_ =
        LoadDrvApi<HalProfQueryAvailBufLenFunc>(ascendHalLibHandle_, "halProfQueryAvailBufLen");
    halProfSampleDataReport_ =
        LoadDrvApi<HalProfSampleDataReportFunc>(ascendHalLibHandle_, "halProfSampleDataReport");
    drvHdcClientCreate_ = LoadDrvApi<DrvHdcClientCreateFunc>(ascendHalLibHandle_, "drvHdcClientCreate");
    drvHdcClientDestroy_ = LoadDrvApi<DrvHdcClientDestroyFunc>(ascendHalLibHandle_, "drvHdcClientDestroy");
    drvHdcServerCreate_ = LoadDrvApi<DrvHdcServerCreateFunc>(ascendHalLibHandle_, "drvHdcServerCreate");
    drvHdcServerDestroy_ = LoadDrvApi<DrvHdcServerDestroyFunc>(ascendHalLibHandle_, "drvHdcServerDestroy");
    drvHdcSessionAccept_ = LoadDrvApi<DrvHdcSessionAcceptFunc>(ascendHalLibHandle_, "drvHdcSessionAccept");
    drvHdcSetSessionReference_ =
        LoadDrvApi<DrvHdcSetSessionReferenceFunc>(ascendHalLibHandle_, "drvHdcSetSessionReference");
    drvHdcSessionConnect_ = LoadDrvApi<DrvHdcSessionConnectFunc>(ascendHalLibHandle_, "drvHdcSessionConnect");
    halHdcSessionConnectEx_ =
        LoadDrvApi<HalHdcSessionConnectExFunc>(ascendHalLibHandle_, "halHdcSessionConnectEx");
    drvHdcSessionClose_ = LoadDrvApi<DrvHdcSessionCloseFunc>(ascendHalLibHandle_, "drvHdcSessionClose");
    drvHdcGetCapacity_ = LoadDrvApi<DrvHdcGetCapacityFunc>(ascendHalLibHandle_, "drvHdcGetCapacity");
    drvHdcAllocMsg_ = LoadDrvApi<DrvHdcAllocMsgFunc>(ascendHalLibHandle_, "drvHdcAllocMsg");
    drvHdcFreeMsg_ = LoadDrvApi<DrvHdcFreeMsgFunc>(ascendHalLibHandle_, "drvHdcFreeMsg");
    drvHdcReuseMsg_ = LoadDrvApi<DrvHdcReuseMsgFunc>(ascendHalLibHandle_, "drvHdcReuseMsg");
    drvHdcGetMsgBuffer_ = LoadDrvApi<DrvHdcGetMsgBufferFunc>(ascendHalLibHandle_, "drvHdcGetMsgBuffer");
    drvHdcAddMsgBuffer_ = LoadDrvApi<DrvHdcAddMsgBufferFunc>(ascendHalLibHandle_, "drvHdcAddMsgBuffer");
    halHdcSend_ = LoadDrvApi<HalHdcSendFunc>(ascendHalLibHandle_, "halHdcSend");
    halHdcRecv_ = LoadDrvApi<HalHdcRecvFunc>(ascendHalLibHandle_, "halHdcRecv");
    halHdcGetSessionAttr_ = LoadDrvApi<HalHdcGetSessionAttrFunc>(ascendHalLibHandle_, "halHdcGetSessionAttr");
    halEschedAttachDevice_ = LoadDrvApi<HalEschedAttachDeviceFunc>(ascendHalLibHandle_, "halEschedAttachDevice");
    halEschedDettachDevice_ = LoadDrvApi<HalEschedDettachDeviceFunc>(ascendHalLibHandle_, "halEschedDettachDevice");
    halEschedSubscribeEvent_ =
        LoadDrvApi<HalEschedSubscribeEventFunc>(ascendHalLibHandle_, "halEschedSubscribeEvent");
    halQueryDevpid_ = LoadDrvApi<HalQueryDevpidFunc>(ascendHalLibHandle_, "halQueryDevpid");
    halEschedWaitEvent_ = LoadDrvApi<HalEschedWaitEventFunc>(ascendHalLibHandle_, "halEschedWaitEvent");
}

void MsprofDrvApi::EnsureInit()
{
    std::call_once(initFlag_, [this]() {
        ascendHalLibHandle_ = OsalDlopen(MSPROF_ASCEND_HAL_LIB, RTLD_LAZY | RTLD_NODELETE);
        if (ascendHalLibHandle_ == nullptr) {
            // 通用服务器场景：未安装驱动包时 dlopen 失败，不报错/告警，仅打印 INFO。
            // 仍继续 LoadApi：符号可能已由进程内其它已加载模块提供（全局符号表回退），
            // 若最终仍解析不到，对应包装方法按 not support / error 降级。
            // OsalDlerror() 在无错误记录时可能返回 nullptr（POSIX dlerror 语义），对 %s 做空指针保护。
            const char *dlErrMsg = OsalDlerror();
            MSPROF_EVENT("Unable to open %s, running as general server scenario. dlopen info: %s",
                MSPROF_ASCEND_HAL_LIB, (dlErrMsg != nullptr) ? dlErrMsg : "unknown");
        }
        LoadApi();
    });
}

bool MsprofDrvApi::IsDrvLibLoaded()
{
    EnsureInit();
    return ascendHalLibHandle_ != nullptr;
}

drvError_t MsprofDrvApi::drvGetDevNum(uint32_t *numDev)
{
    EnsureInit();
    if (drvGetDevNum_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvGetDevNum_(numDev);
}

drvError_t MsprofDrvApi::drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    EnsureInit();
    if (drvGetDevIDs_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvGetDevIDs_(devices, len);
}

drvError_t MsprofDrvApi::drvGetPlatformInfo(uint32_t *info)
{
    EnsureInit();
    if (drvGetPlatformInfo_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvGetPlatformInfo_(info);
}

drvError_t MsprofDrvApi::drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    EnsureInit();
    if (drvDeviceStatus_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvDeviceStatus_(devId, status);
}

drvError_t MsprofDrvApi::halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    EnsureInit();
    if (halGetDeviceInfo_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halGetDeviceInfo_(devId, moduleType, infoType, value);
}

int MsprofDrvApi::ProfDrvGetChannels(unsigned int deviceId, channel_list_t *channels)
{
    EnsureInit();
    if (profDrvGetChannels_ == nullptr) {
        return PROF_ERROR;
    }
    return profDrvGetChannels_(deviceId, channels);
}

int MsprofDrvApi::ProfDrvStart(unsigned int deviceId, unsigned int channelId, struct prof_start_para *startPara)
{
    EnsureInit();
    if (profDrvStart_ == nullptr) {
        return PROF_ERROR;
    }
    return profDrvStart_(deviceId, channelId, startPara);
}

int MsprofDrvApi::ProfStop(unsigned int deviceId, unsigned int channelId)
{
    EnsureInit();
    if (profStop_ == nullptr) {
        return PROF_ERROR;
    }
    return profStop_(deviceId, channelId);
}

int MsprofDrvApi::ProfChannelRead(unsigned int deviceId, unsigned int channelId, char *outBuf, unsigned int bufSize)
{
    EnsureInit();
    if (profChannelRead_ == nullptr) {
        return PROF_ERROR;
    }
    return profChannelRead_(deviceId, channelId, outBuf, bufSize);
}

int MsprofDrvApi::ProfChannelPoll(struct prof_poll_info *outBuf, int num, int timeout)
{
    EnsureInit();
    if (profChannelPoll_ == nullptr) {
        return PROF_ERROR;
    }
    return profChannelPoll_(outBuf, num, timeout);
}

int MsprofDrvApi::halProfDataFlush(unsigned int deviceId, unsigned int channelId, unsigned int *dataLen)
{
    EnsureInit();
    if (halProfDataFlush_ == nullptr) {
        // 保持上层 DrvProfFlush 现有 "not support 视为成功" 语义。
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halProfDataFlush_(deviceId, channelId, dataLen);
}

drvError_t MsprofDrvApi::drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    EnsureInit();
    if (drvDeviceGetPhyIdByIndex_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvDeviceGetPhyIdByIndex_(devIndex, phyId);
}

drvError_t MsprofDrvApi::halEschedQueryInfo(unsigned int devId, ESCHED_QUERY_TYPE type,
    struct esched_input_info *inPut, struct esched_output_info *outPut)
{
    EnsureInit();
    if (halEschedQueryInfo_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halEschedQueryInfo_(devId, type, inPut, outPut);
}

drvError_t MsprofDrvApi::halEschedSubmitEvent(unsigned int devId, struct event_summary *event)
{
    EnsureInit();
    if (halEschedSubmitEvent_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halEschedSubmitEvent_(devId, event);
}

int MsprofDrvApi::halProfSampleRegister(unsigned int devId, unsigned int chanId,
    struct prof_sample_register_para *para)
{
    EnsureInit();
    if (halProfSampleRegister_ == nullptr) {
        return PROF_ERROR;
    }
    return halProfSampleRegister_(devId, chanId, para);
}

int MsprofDrvApi::halProfSampleRegisterEx(unsigned int devId, unsigned int chanId,
    struct prof_sample_register_para *para)
{
    EnsureInit();
    if (halProfSampleRegisterEx_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halProfSampleRegisterEx_(devId, chanId, para);
}

int MsprofDrvApi::halProfQueryAvailBufLen(unsigned int devId, unsigned int chanId, unsigned int *buffAvailLen)
{
    EnsureInit();
    if (halProfQueryAvailBufLen_ == nullptr) {
        return PROF_ERROR;
    }
    return halProfQueryAvailBufLen_(devId, chanId, buffAvailLen);
}

int MsprofDrvApi::halProfSampleDataReport(unsigned int devId, unsigned int chanId, unsigned int subChanId,
    struct prof_data_report_para *para)
{
    EnsureInit();
    if (halProfSampleDataReport_ == nullptr) {
        return PROF_ERROR;
    }
    return halProfSampleDataReport_(devId, chanId, subChanId, para);
}

drvError_t MsprofDrvApi::drvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    EnsureInit();
    if (drvHdcClientCreate_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcClientCreate_(client, maxSessionNum, serviceType, flag);
}

drvError_t MsprofDrvApi::drvHdcClientDestroy(HDC_CLIENT client)
{
    EnsureInit();
    if (drvHdcClientDestroy_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcClientDestroy_(client);
}

drvError_t MsprofDrvApi::drvHdcServerCreate(int devId, int serviceType, HDC_SERVER *server)
{
    EnsureInit();
    if (drvHdcServerCreate_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcServerCreate_(devId, serviceType, server);
}

drvError_t MsprofDrvApi::drvHdcServerDestroy(HDC_SERVER server)
{
    EnsureInit();
    if (drvHdcServerDestroy_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcServerDestroy_(server);
}

drvError_t MsprofDrvApi::drvHdcSessionAccept(HDC_SERVER server, HDC_SESSION *session)
{
    EnsureInit();
    if (drvHdcSessionAccept_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcSessionAccept_(server, session);
}

drvError_t MsprofDrvApi::drvHdcSetSessionReference(HDC_SESSION session)
{
    EnsureInit();
    if (drvHdcSetSessionReference_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcSetSessionReference_(session);
}

drvError_t MsprofDrvApi::drvHdcSessionConnect(int peerNode, int peerDevid, HDC_CLIENT client, HDC_SESSION *session)
{
    EnsureInit();
    if (drvHdcSessionConnect_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcSessionConnect_(peerNode, peerDevid, client, session);
}

hdcError_t MsprofDrvApi::halHdcSessionConnectEx(int peerNode, int peerDevid, int peerPid, HDC_CLIENT client,
    HDC_SESSION *session)
{
    EnsureInit();
    if (halHdcSessionConnectEx_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halHdcSessionConnectEx_(peerNode, peerDevid, peerPid, client, session);
}

drvError_t MsprofDrvApi::drvHdcSessionClose(HDC_SESSION session)
{
    EnsureInit();
    if (drvHdcSessionClose_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcSessionClose_(session);
}

drvError_t MsprofDrvApi::drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    EnsureInit();
    if (drvHdcGetCapacity_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcGetCapacity_(capacity);
}

drvError_t MsprofDrvApi::drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    EnsureInit();
    if (drvHdcAllocMsg_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcAllocMsg_(session, ppMsg, count);
}

drvError_t MsprofDrvApi::drvHdcFreeMsg(struct drvHdcMsg *msg)
{
    EnsureInit();
    if (drvHdcFreeMsg_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcFreeMsg_(msg);
}

drvError_t MsprofDrvApi::drvHdcReuseMsg(struct drvHdcMsg *msg)
{
    EnsureInit();
    if (drvHdcReuseMsg_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcReuseMsg_(msg);
}

drvError_t MsprofDrvApi::drvHdcGetMsgBuffer(struct drvHdcMsg *msg, int index, char **pBuf, int *pLen)
{
    EnsureInit();
    if (drvHdcGetMsgBuffer_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcGetMsgBuffer_(msg, index, pBuf, pLen);
}

drvError_t MsprofDrvApi::drvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    EnsureInit();
    if (drvHdcAddMsgBuffer_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drvHdcAddMsgBuffer_(msg, pBuf, len);
}

hdcError_t MsprofDrvApi::halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    EnsureInit();
    if (halHdcSend_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halHdcSend_(session, pMsg, flag, timeout);
}

hdcError_t MsprofDrvApi::halHdcRecv(HDC_SESSION session, struct drvHdcMsg *pMsg, int bufLen, UINT64 flag,
    int *recvBufCount, UINT32 timeout)
{
    EnsureInit();
    if (halHdcRecv_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halHdcRecv_(session, pMsg, bufLen, flag, recvBufCount, timeout);
}

drvError_t MsprofDrvApi::halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    EnsureInit();
    if (halHdcGetSessionAttr_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halHdcGetSessionAttr_(session, attr, value);
}

drvError_t MsprofDrvApi::halEschedAttachDevice(unsigned int devId)
{
    EnsureInit();
    if (halEschedAttachDevice_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halEschedAttachDevice_(devId);
}

drvError_t MsprofDrvApi::halEschedDettachDevice(unsigned int devId)
{
    EnsureInit();
    if (halEschedDettachDevice_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halEschedDettachDevice_(devId);
}

drvError_t MsprofDrvApi::halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
    unsigned long long eventBitmap)
{
    EnsureInit();
    if (halEschedSubscribeEvent_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halEschedSubscribeEvent_(devId, grpId, threadId, eventBitmap);
}

drvError_t MsprofDrvApi::halQueryDevpid(struct halQueryDevpidInfo info, pid_t *devPid)
{
    EnsureInit();
    if (halQueryDevpid_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halQueryDevpid_(info, devPid);
}

drvError_t MsprofDrvApi::halEschedWaitEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
    int timeout, struct event_info *event)
{
    EnsureInit();
    if (halEschedWaitEvent_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return halEschedWaitEvent_(devId, grpId, threadId, timeout, event);
}
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis
