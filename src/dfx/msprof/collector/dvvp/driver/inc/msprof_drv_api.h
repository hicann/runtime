/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DRIVER_MSPROF_DRV_API_H
#define ANALYSIS_DVVP_DRIVER_MSPROF_DRV_API_H

#include <mutex>
#include "singleton/singleton.h"
#include "ascend_hal.h"
#include "ascend_inpackage_hal.h"

namespace analysis {
namespace dvvp {
namespace driver {
// msprof 通用服务器场景：驱动库 libascend_hal.so 通过 dlopen 动态加载，缺库/缺符号降级返回，
// 不在链接期形成对 libascend_hal.so 的强依赖。
constexpr char MSPROF_ASCEND_HAL_LIB[] = "libascend_hal.so";

using DrvGetDevNumFunc = drvError_t (*)(uint32_t *);
using DrvGetDevIDsFunc = drvError_t (*)(uint32_t *, uint32_t);
using DrvGetPlatformInfoFunc = drvError_t (*)(uint32_t *);
using DrvDeviceStatusFunc = drvError_t (*)(uint32_t, drvStatus_t *);
using HalGetDeviceInfoFunc = drvError_t (*)(uint32_t, int32_t, int32_t, int64_t *);
using ProfDrvGetChannelsFunc = int (*)(unsigned int, channel_list_t *);
using ProfDrvStartFunc = int (*)(unsigned int, unsigned int, struct prof_start_para *);
using ProfStopFunc = int (*)(unsigned int, unsigned int);
using ProfChannelReadFunc = int (*)(unsigned int, unsigned int, char *, unsigned int);
using ProfChannelPollFunc = int (*)(struct prof_poll_info *, int, int);
using HalProfDataFlushFunc = int (*)(unsigned int, unsigned int, unsigned int *);
using DrvDeviceGetPhyIdByIndexFunc = drvError_t (*)(uint32_t, uint32_t *);
using HalEschedQueryInfoFunc = drvError_t (*)(unsigned int, ESCHED_QUERY_TYPE,
    struct esched_input_info *, struct esched_output_info *);
using HalEschedSubmitEventFunc = drvError_t (*)(unsigned int, struct event_summary *);
using HalProfSampleRegisterFunc = int (*)(unsigned int, unsigned int, struct prof_sample_register_para *);
using HalProfSampleRegisterExFunc = int (*)(unsigned int, unsigned int, struct prof_sample_register_para *);
using HalProfQueryAvailBufLenFunc = int (*)(unsigned int, unsigned int, unsigned int *);
using HalProfSampleDataReportFunc = int (*)(unsigned int, unsigned int, unsigned int, struct prof_data_report_para *);
using DrvHdcClientCreateFunc = drvError_t (*)(HDC_CLIENT *, int, int, int);
using DrvHdcClientDestroyFunc = drvError_t (*)(HDC_CLIENT);
using DrvHdcServerCreateFunc = drvError_t (*)(int, int, HDC_SERVER *);
using DrvHdcServerDestroyFunc = drvError_t (*)(HDC_SERVER);
using DrvHdcSessionAcceptFunc = drvError_t (*)(HDC_SERVER, HDC_SESSION *);
using DrvHdcSetSessionReferenceFunc = drvError_t (*)(HDC_SESSION);
using DrvHdcSessionConnectFunc = drvError_t (*)(int, int, HDC_CLIENT, HDC_SESSION *);
using HalHdcSessionConnectExFunc = hdcError_t (*)(int, int, int, HDC_CLIENT, HDC_SESSION *);
using DrvHdcSessionCloseFunc = drvError_t (*)(HDC_SESSION);
using DrvHdcGetCapacityFunc = drvError_t (*)(struct drvHdcCapacity *);
using DrvHdcAllocMsgFunc = drvError_t (*)(HDC_SESSION, struct drvHdcMsg **, int);
using DrvHdcFreeMsgFunc = drvError_t (*)(struct drvHdcMsg *);
using DrvHdcReuseMsgFunc = drvError_t (*)(struct drvHdcMsg *);
using DrvHdcGetMsgBufferFunc = drvError_t (*)(struct drvHdcMsg *, int, char **, int *);
using DrvHdcAddMsgBufferFunc = drvError_t (*)(struct drvHdcMsg *, char *, int);
using HalHdcSendFunc = hdcError_t (*)(HDC_SESSION, struct drvHdcMsg *, UINT64, UINT32);
using HalHdcRecvFunc = hdcError_t (*)(HDC_SESSION, struct drvHdcMsg *, int, UINT64, int *, UINT32);
using HalHdcGetSessionAttrFunc = drvError_t (*)(HDC_SESSION, int, int *);
using HalEschedAttachDeviceFunc = drvError_t (*)(unsigned int);
using HalEschedDettachDeviceFunc = drvError_t (*)(unsigned int);
using HalEschedSubscribeEventFunc = drvError_t (*)(unsigned int, unsigned int, unsigned int, unsigned long long);
using HalQueryDevpidFunc = drvError_t (*)(struct halQueryDevpidInfo, pid_t *);
using HalEschedWaitEventFunc = drvError_t (*)(unsigned int, unsigned int, unsigned int, int, struct event_info *);

// msprof 专用驱动动态加载适配层。集中 dlopen("libascend_hal.so") 并 dlsym 主采集路径驱动符号，
// 懒加载（首次调用时初始化），线程安全（std::call_once）。缺失符号时按类型降级返回：
//   drvError_t 类接口 -> DRV_ERROR_NOT_SUPPORT
//   prof_* 类接口      -> PROF_ERROR
// 该层不依赖 Platform，避免 Platform<->driver 初始化交叉与循环依赖。
class MsprofDrvApi : public analysis::dvvp::common::singleton::Singleton<MsprofDrvApi> {
public:
    MsprofDrvApi() = default;
    ~MsprofDrvApi() override;

    drvError_t drvGetDevNum(uint32_t *numDev);
    drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len);
    drvError_t drvGetPlatformInfo(uint32_t *info);
    drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status);
    drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value);
    int ProfDrvGetChannels(unsigned int deviceId, channel_list_t *channels);
    int ProfDrvStart(unsigned int deviceId, unsigned int channelId, struct prof_start_para *startPara);
    int ProfStop(unsigned int deviceId, unsigned int channelId);
    int ProfChannelRead(unsigned int deviceId, unsigned int channelId, char *outBuf, unsigned int bufSize);
    int ProfChannelPoll(struct prof_poll_info *outBuf, int num, int timeout);
    int halProfDataFlush(unsigned int deviceId, unsigned int channelId, unsigned int *dataLen);
    drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId);
    drvError_t halEschedQueryInfo(unsigned int devId, ESCHED_QUERY_TYPE type,
        struct esched_input_info *inPut, struct esched_output_info *outPut);
    drvError_t halEschedSubmitEvent(unsigned int devId, struct event_summary *event);
    int halProfSampleRegister(unsigned int devId, unsigned int chanId, struct prof_sample_register_para *para);
    int halProfSampleRegisterEx(unsigned int devId, unsigned int chanId, struct prof_sample_register_para *para);
    int halProfQueryAvailBufLen(unsigned int devId, unsigned int chanId, unsigned int *buffAvailLen);
    int halProfSampleDataReport(unsigned int devId, unsigned int chanId, unsigned int subChanId,
        struct prof_data_report_para *para);
    drvError_t drvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag);
    drvError_t drvHdcClientDestroy(HDC_CLIENT client);
    drvError_t drvHdcServerCreate(int devId, int serviceType, HDC_SERVER *server);
    drvError_t drvHdcServerDestroy(HDC_SERVER server);
    drvError_t drvHdcSessionAccept(HDC_SERVER server, HDC_SESSION *session);
    drvError_t drvHdcSetSessionReference(HDC_SESSION session);
    drvError_t drvHdcSessionConnect(int peerNode, int peerDevid, HDC_CLIENT client, HDC_SESSION *session);
    hdcError_t halHdcSessionConnectEx(int peerNode, int peerDevid, int peerPid, HDC_CLIENT client,
        HDC_SESSION *session);
    drvError_t drvHdcSessionClose(HDC_SESSION session);
    drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity);
    drvError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count);
    drvError_t drvHdcFreeMsg(struct drvHdcMsg *msg);
    drvError_t drvHdcReuseMsg(struct drvHdcMsg *msg);
    drvError_t drvHdcGetMsgBuffer(struct drvHdcMsg *msg, int index, char **pBuf, int *pLen);
    drvError_t drvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len);
    hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout);
    hdcError_t halHdcRecv(HDC_SESSION session, struct drvHdcMsg *pMsg, int bufLen, UINT64 flag,
        int *recvBufCount, UINT32 timeout);
    drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value);
    drvError_t halEschedAttachDevice(unsigned int devId);
    drvError_t halEschedDettachDevice(unsigned int devId);
    drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
        unsigned long long eventBitmap);
    drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *devPid);
    drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, int timeout,
        struct event_info *event);

    // 驱动库是否已成功加载（libascend_hal.so dlopen 成功）。通用服务器场景（无驱动库）返回 false。
    bool IsDrvLibLoaded();

private:
    void EnsureInit();
    void LoadApi();

    std::once_flag initFlag_;
    void *ascendHalLibHandle_{nullptr};
    DrvGetDevNumFunc drvGetDevNum_{nullptr};
    DrvGetDevIDsFunc drvGetDevIDs_{nullptr};
    DrvGetPlatformInfoFunc drvGetPlatformInfo_{nullptr};
    DrvDeviceStatusFunc drvDeviceStatus_{nullptr};
    HalGetDeviceInfoFunc halGetDeviceInfo_{nullptr};
    ProfDrvGetChannelsFunc profDrvGetChannels_{nullptr};
    ProfDrvStartFunc profDrvStart_{nullptr};
    ProfStopFunc profStop_{nullptr};
    ProfChannelReadFunc profChannelRead_{nullptr};
    ProfChannelPollFunc profChannelPoll_{nullptr};
    HalProfDataFlushFunc halProfDataFlush_{nullptr};
    DrvDeviceGetPhyIdByIndexFunc drvDeviceGetPhyIdByIndex_{nullptr};
    HalEschedQueryInfoFunc halEschedQueryInfo_{nullptr};
    HalEschedSubmitEventFunc halEschedSubmitEvent_{nullptr};
    HalProfSampleRegisterFunc halProfSampleRegister_{nullptr};
    HalProfSampleRegisterExFunc halProfSampleRegisterEx_{nullptr};
    HalProfQueryAvailBufLenFunc halProfQueryAvailBufLen_{nullptr};
    HalProfSampleDataReportFunc halProfSampleDataReport_{nullptr};
    DrvHdcClientCreateFunc drvHdcClientCreate_{nullptr};
    DrvHdcClientDestroyFunc drvHdcClientDestroy_{nullptr};
    DrvHdcServerCreateFunc drvHdcServerCreate_{nullptr};
    DrvHdcServerDestroyFunc drvHdcServerDestroy_{nullptr};
    DrvHdcSessionAcceptFunc drvHdcSessionAccept_{nullptr};
    DrvHdcSetSessionReferenceFunc drvHdcSetSessionReference_{nullptr};
    DrvHdcSessionConnectFunc drvHdcSessionConnect_{nullptr};
    HalHdcSessionConnectExFunc halHdcSessionConnectEx_{nullptr};
    DrvHdcSessionCloseFunc drvHdcSessionClose_{nullptr};
    DrvHdcGetCapacityFunc drvHdcGetCapacity_{nullptr};
    DrvHdcAllocMsgFunc drvHdcAllocMsg_{nullptr};
    DrvHdcFreeMsgFunc drvHdcFreeMsg_{nullptr};
    DrvHdcReuseMsgFunc drvHdcReuseMsg_{nullptr};
    DrvHdcGetMsgBufferFunc drvHdcGetMsgBuffer_{nullptr};
    DrvHdcAddMsgBufferFunc drvHdcAddMsgBuffer_{nullptr};
    HalHdcSendFunc halHdcSend_{nullptr};
    HalHdcRecvFunc halHdcRecv_{nullptr};
    HalHdcGetSessionAttrFunc halHdcGetSessionAttr_{nullptr};
    HalEschedAttachDeviceFunc halEschedAttachDevice_{nullptr};
    HalEschedDettachDeviceFunc halEschedDettachDevice_{nullptr};
    HalEschedSubscribeEventFunc halEschedSubscribeEvent_{nullptr};
    HalQueryDevpidFunc halQueryDevpid_{nullptr};
    HalEschedWaitEventFunc halEschedWaitEvent_{nullptr};
};
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis

#endif
