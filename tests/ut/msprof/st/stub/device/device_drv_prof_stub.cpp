/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_drv_prof_stub.h"
#include <cstring>
#include <set>
#include "device_simulator_manager.h"

int prof_drv_get_channels(unsigned int device_id, channel_list_t *channels)
{
    return SimulatorMgr().ProfDrvGetChannels(device_id, *channels);
}

int prof_drv_start(unsigned int device_id, unsigned int channel_id, struct prof_start_para *start_para)
{
    return SimulatorMgr().ProfDrvStart(device_id, channel_id, *start_para);
}

int prof_stop(unsigned int device_id, unsigned int channel_id)
{
    return SimulatorMgr().ProfDrvStop(device_id, channel_id);
}

int prof_channel_read(unsigned int device_id, unsigned int channel_id, char *out_buf, unsigned int buf_size)
{
    return SimulatorMgr().ProfChannelRead(device_id, channel_id, reinterpret_cast<uint8_t*>(out_buf), buf_size);
}

int prof_channel_poll(struct prof_poll_info *out_buf, int num, int timeout)
{
    return SimulatorMgr().ProfChannelPoll(out_buf, static_cast<int32_t>(num), static_cast<int32_t>(timeout));
}

int halProfSampleRegister(unsigned int dev_id, unsigned int chan_id, struct prof_sample_register_para *ops)
{
    SimulatorMgr().ProfSampleRegister(dev_id, chan_id, &(ops->ops));
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    return static_cast<drvError_t>(SimulatorMgr().GetDevNum(*num_dev));
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    return static_cast<drvError_t>(SimulatorMgr().GetGetDevIDs(devices, len));
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    return static_cast<drvError_t>(SimulatorMgr().GetDeviceInfo(devId, moduleType, infoType, value));
}

constexpr int32_t PROF_MODULE_TYPE_QOS = 9;
struct QosProfileInfo {
    QosProfileInfo() : devId(0), streamNum(0), mode(0) {}
    uint32_t devId;
    uint16_t streamNum;
    uint16_t mode;
    uint8_t mpamId[20];
    char streamName[256];
};

drvError_t halGetDeviceInfoByBuff(uint32_t devId, int32_t moduleType, int32_t infoType, void *value, int32_t *len)
{
    if (moduleType = PROF_MODULE_TYPE_QOS) {
        QosProfileInfo *info = (QosProfileInfo*)value;
        if (info->mode == 0) {
            info->streamNum = 2;
            info->mpamId[0] = 12;
            info->mpamId[1] = 1;
        } else if (info->mode == 1 && info->mpamId[0] == 12) {
            strcpy(info->streamName, "st_mpamid_12");
        } else if (info->mode == 1 && info->mpamId[0] == 1) {
            return (drvError_t)1;
        } else if (info->mode == 2) {
            info->streamNum = 2;
            info->mpamId[0] = 12;
            info->mpamId[1] = 13;
        }
    }
    return (drvError_t)0;
}


drvError_t drvGetPlatformInfo(uint32_t *info)
{
    SimulatorMgr().GetSocSide(info);
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t index, uint32_t *phyId)
{
    *phyId = index;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *index)
{
    *index = phyId;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDByLocalDevID(uint32_t index, uint32_t *phyId)
{
    *phyId = index;
    return DRV_ERROR_NONE;
}

drvError_t halGetAPIVersion(int32_t *ver)
{
    *ver=0x72316;
    return DRV_ERROR_NONE;
}

drvError_t halEschedAttachDevice(uint32_t devId)
{
    return static_cast<drvError_t>(SimulatorMgr().HalEschedAttachDevice(devId));
}

drvError_t halEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, unsigned int *grpId)
{
    return static_cast<drvError_t>(SimulatorMgr().HalEschedCreateGrpEx(devId, grpPara, grpId));
}

drvError_t halEschedDettachDevice(unsigned int devId)
{
    return static_cast<drvError_t>(SimulatorMgr().HalEschedDettachDevice(devId));
}

drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
    unsigned long long eventBitmap)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, int timeout,
    struct event_info *event)
{
    return static_cast<drvError_t>(SimulatorMgr().HalEschedWaitEvent(devId, grpId, threadId, timeout, event));
}

drvError_t halEschedQueryInfo(unsigned int devId, ESCHED_QUERY_TYPE type, struct esched_input_info *inPut,
    struct esched_output_info *outPut)
{
    return static_cast<drvError_t>(SimulatorMgr().HalEschedQueryInfo(devId, type, inPut, outPut));
}

drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubmitEvent(uint32_t devId, struct event_summary *event)
{
    return static_cast<drvError_t>(SimulatorMgr().HalEschedSubmitEvent(devId, event));
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
    return static_cast<drvError_t>(SimulatorMgr().HalProfSampleDataReport(dev_id, chan_id, sub_chan_id, para));
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    (void)pid;
    (void)chip_id;
    (void)vfid;
    *host_pid = getpid();
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

drvError_t drvGetDeviceSplitMode(unsigned int dev_id, unsigned int *mode)
{
    *mode = 0;
    return DRV_ERROR_NONE;
}

drvError_t drvGetLocalDevIDByHostDevID(uint32_t devIndex, uint32_t *hostDeviceId)
{
    *hostDeviceId = devIndex;
    return DRV_ERROR_NONE;
}
#ifndef PROF_LITE
drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    (void)devId;
    (void)status;
    return DRV_ERROR_NONE;
}
#endif

int halProfDataFlush(unsigned int deviceId, unsigned int channelId, unsigned int *bufSize)
{
    (void)deviceId;
    (void)channelId;
    (void)bufSize;
    return 0;
}