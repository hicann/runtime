/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include <string>
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "devprof_drv_aicpu.h"

using analysis::dvvp::common::error::PROFILING_CONTINUE;
using analysis::dvvp::common::error::PROFILING_SUCCESS;

extern "C" drvError_t drvGetDeviceSplitMode(unsigned int dev_id, unsigned int* mode);
extern "C" int halProfSampleRegister(unsigned int devId, unsigned int chanId, struct prof_sample_register_para* para);
extern "C" int halProfSampleRegisterEx(unsigned int devId, unsigned int chanId, struct prof_sample_register_para* para);
extern "C" int halProfQueryAvailBufLen(unsigned int devId, unsigned int chanId, unsigned int* buffAvailLen);
extern "C" int halProfSampleDataReport(
    unsigned int devId, unsigned int chanId, unsigned int subChanId, struct prof_data_report_para* para);
extern "C" drvError_t drvHdcClientCreate(HDC_CLIENT* client, int maxSessionNum, int serviceType, int flag);
extern "C" drvError_t drvHdcClientDestroy(HDC_CLIENT client);
extern "C" drvError_t drvHdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION* session);
extern "C" drvError_t drvHdcSetSessionReference(HDC_SESSION session);
extern "C" drvError_t halHdcSessionConnectEx(
    int peer_node, int peer_devid, int host_pid, HDC_CLIENT client, HDC_SESSION* session);
extern "C" drvError_t drvHdcSessionClose(HDC_SESSION session);
extern "C" drvError_t drvHdcGetCapacity(struct drvHdcCapacity* capacity);
extern "C" drvError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg** ppMsg, int count);
extern "C" drvError_t drvHdcFreeMsg(struct drvHdcMsg* msg);
extern "C" drvError_t drvHdcReuseMsg(struct drvHdcMsg* msg);
extern "C" drvError_t drvHdcGetMsgBuffer(struct drvHdcMsg* msg, int index, char** pBuf, int* pLen);
extern "C" drvError_t drvHdcAddMsgBuffer(struct drvHdcMsg* msg, char* pBuf, int len);
extern "C" drvError_t halHdcSend(
    HDC_SESSION session, struct drvHdcMsg* msg, unsigned long long flag, unsigned int timeout);
extern "C" drvError_t halHdcRecv(
    HDC_SESSION session, struct drvHdcMsg* msg, int bufLen, unsigned long long flag, int* recvBufCount,
    unsigned int timeout);
extern "C" drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int* value);

int32_t g_handle;
const std::map<std::string, void*> g_map = {
    {"halGetAPIVersion", (void*)halGetAPIVersion},
    {"drvGetDeviceSplitMode", (void*)drvGetDeviceSplitMode},
    {"halEschedQueryInfo", (void*)halEschedQueryInfo},
    {"halEschedCreateGrpEx", (void*)halEschedCreateGrpEx},
    {"halProfSampleRegister", (void*)halProfSampleRegister},
    {"halProfSampleRegisterEx", (void*)halProfSampleRegisterEx},
    {"halProfQueryAvailBufLen", (void*)halProfQueryAvailBufLen},
    {"halProfSampleDataReport", (void*)halProfSampleDataReport},
    {"drvHdcClientCreate", (void*)drvHdcClientCreate},
    {"drvHdcClientDestroy", (void*)drvHdcClientDestroy},
    {"drvHdcSessionConnect", (void*)drvHdcSessionConnect},
    {"drvHdcSetSessionReference", (void*)drvHdcSetSessionReference},
    {"halHdcSessionConnectEx", (void*)halHdcSessionConnectEx},
    {"drvHdcSessionClose", (void*)drvHdcSessionClose},
    {"drvHdcGetCapacity", (void*)drvHdcGetCapacity},
    {"drvHdcAllocMsg", (void*)drvHdcAllocMsg},
    {"drvHdcFreeMsg", (void*)drvHdcFreeMsg},
    {"drvHdcReuseMsg", (void*)drvHdcReuseMsg},
    {"drvHdcGetMsgBuffer", (void*)drvHdcGetMsgBuffer},
    {"drvHdcAddMsgBuffer", (void*)drvHdcAddMsgBuffer},
    {"halHdcSend", (void*)halHdcSend},
    {"halHdcRecv", (void*)halHdcRecv},
    {"halHdcGetSessionAttr", (void*)halHdcGetSessionAttr},
};

extern "C" __attribute__((visibility("default"))) void* mmDlsym(void* handle, const char* funcName)
{
    auto it = g_map.find(funcName);
    if (it != g_map.end()) {
        return it->second;
    }
    return nullptr;
}

extern "C" __attribute__((visibility("default"))) int32_t mmDlclose(void* handle) { return 0; }

extern "C" __attribute__((visibility("default"))) void* mmDlopen(const char* fileName, int mode)
{
    if (strcmp(fileName, "libascend_hal.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

extern "C" __attribute__((visibility("default"))) char* mmDlerror(void) { return nullptr; }

extern "C" int32_t AdprofInit(const AicpuStartPara* para)
{
    const int32_t ret = DevprofDrvAicpu::instance()->AdprofInit(para);
    return ret == PROFILING_CONTINUE ? PROFILING_SUCCESS : ret;
}

extern "C" int32_t AdprofFinalize(void)
{
    DevprofDrvAicpu::instance()->DeviceReportStop();
    return PROFILING_SUCCESS;
}
