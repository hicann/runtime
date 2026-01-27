/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "devdrv_runtime_api_stub.h"

/*
函数原型	drvGetPlatformInfo(u32 *info)
函数功能	获取当前平台信息
输入说明
输出说明
		0 : 表示当前在Device侧
		1 : 表示当前在Host侧
返回值说明	见drvError_t定义
使用说明
注意事项
*/
drvError_t drvGetPlatformInfo(uint32_t *info) {
    if (info) {
        *info = 1;
    }
    return DRV_ERROR_NONE;
}

/*
函数原型	drvError_t drvGetDevNum(u32 *num_dev)
函数功能	获取当前设备个数
输入说明
输出说明
返回值说明	见drvError_t定义
使用说明
注意事项
*/
drvError_t drvGetDevNum(uint32_t *num_dev) {
    *num_dev = 1;
    return DRV_ERROR_NONE;
}

/*
函数原型	drvError_t drvGetDevIDs(u32 *devices)
函数功能	获取当前所有的设备ID
输入说明
输出说明
返回值说明	见drvError_t定义
使用说明
注意事项
*/
drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len) {
    devices[0] = 0;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    return DRV_ERROR_NONE;
}

/*
函数原型	drvError_t drvDeviceGetPhyIdByIndex(u32 index, u32 *phyId)
函数功能	get phy id by index
输入说明
输出说明
返回值说明	见drvError_t定义
使用说明
注意事项
*/
drvError_t drvDeviceGetPhyIdByIndex(uint32_t index, uint32_t *phyId) {
    *phyId = index;
    return DRV_ERROR_NONE;
}

/*
函数原型	drvError_t drvDeviceGetIndexByPhyId(u32 phyId, u32 *index)
函数功能	get index by phy id
输入说明
输出说明
返回值说明	见drvError_t定义
使用说明
注意事项
*/
drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *index) {
    *index = phyId;
    return DRV_ERROR_NONE;
}

/*
函数原型	drvError_t drvGetDevIDByLocalDevID(u32 index, u32 *phyId)
函数功能	get host phy id by dev index
输入说明
输出说明
返回值说明	见drvError_t定义
使用说明
注意事项
*/
drvError_t drvGetDevIDByLocalDevID(uint32_t index, uint32_t *phyId) {
    *phyId = index;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    (void)devId;
    (void)status;
    return DRV_ERROR_NONE;
}
#ifdef __cplusplus
extern "C" {
#endif

int rtGetDeviceIdByGeModelIdx(uint32_t geModelIdx, uint32_t *deviceId)
{
    return 0;
}

int rtProfSetProSwitch(void* data, uint32_t len)
{
    return 0;
}

int rtSetMsprofReporterCallback(MsprofReporterCallback callBack)
{
    return 0;
}

int rtRegDeviceStateCallback(const char *regName, rtDeviceStateCallback callback)
{
    return 0;
}

int dsmi_get_device_info(unsigned int device_id, unsigned int main_cmd, unsigned int sub_cmd,
    void *buf, unsigned int *size) {
    *(int*)buf = 1;
    return 0;
}

drvError_t halEschedAttachDevice(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, unsigned int *grpId)
{
    *grpId = 32;
    return DRV_ERROR_NONE;
}

drvError_t halEschedDettachDevice(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
    unsigned long long eventBitmap)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, int timeout,
    struct event_info *event)
{
    event->comm.event_id = EVENT_USR_START;
    return DRV_ERROR_NONE;
}

drvError_t halEschedQueryInfo(unsigned int devId, ESCHED_QUERY_TYPE type, struct esched_input_info *inPut,
    struct esched_output_info *outPut)
{
    struct esched_query_gid_output *gidOut = (struct esched_query_gid_output *)outPut->outBuff;
    gidOut->grp_id = 32;
    return DRV_ERROR_NONE;
}

drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubmitEvent(uint32_t devId, struct event_summary *event)
{
    return DRV_ERROR_NONE;
}

int halProfQueryAvailBufLen(unsigned int dev_id, unsigned int chan_id, unsigned int *buff_avail_len)
{
    (void)dev_id;
    (void)chan_id;
    *buff_avail_len = (1023U * 1024U) - 256U;
    return 0;
}

int halProfSampleDataReport(unsigned int dev_id, unsigned int chan_id, unsigned int sub_chan_id,
    struct prof_data_report_para *para)
{
    return 0;
}

int halProfSampleRegister(unsigned int dev_id, unsigned int chan_id, struct prof_sample_register_para *ops)
{
    return 0;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    (void)pid;
    (void)chip_id;
    (void)vfid;
    (void)host_pid;
    (void)cp_type;
    return DRV_ERROR_NONE;
}

drvError_t halDrvEventThreadInit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halDrvEventThreadUninit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

int halProfDataFlush(unsigned int deviceId, unsigned int channelId, unsigned int *bufSize)
{
    (void)deviceId;
    (void)channelId;
    (void)bufSize;
    return 0;
}

#ifdef __cplusplus
}
#endif
