/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdarg.h>

#include "securec.h"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "hwts.hpp"
#include "stars.hpp"
#include "base.hpp"
#include "pool.hpp"
#include "runtime.hpp"
#include "gtest/gtest.h"
#include "cmodel_driver.h"
#include "toolchain/prof_api.h"
#include "task.hpp"
#include "rt_utest_encap.h"
#include "rt_utest_stub.h"
#include "task_info.hpp"
#include "stars_base.hpp"
#include "config_define.hpp"


#define MAX_DEVICE_NUM  2
#define MAX_EVENT_NUM 1024
#define MAX_SQCQ_NUM 1024
#define STUB_TS_GRP_NUM 5
using namespace cce::runtime;

static Bitmap g_eventIdBitmap(MAX_EVENT_NUM);
static Bitmap g_streamIdBitmap(992);
static Bitmap g_taskIdBitmap(32760);
static Bitmap g_sqcqIdBitmap(MAX_SQCQ_NUM);

DVresult drvMemSmmuQuery(DVdevice device, UINT32 *SSID)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetAPIVersion(int *halAPIVersion)
{
    *halAPIVersion = __HAL_API_VERSION;
    return DRV_ERROR_NONE;
}

drvError_t drvMemAllocL2buffAddr (DVdevice device, void **l2buff, UINT64 *pte)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemReleaseL2buffAddr (DVdevice device, void *l2buff)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceOpen(void **device, uint32_t deviceId)
{
    //*device = deviceId;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceClose(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDevicePowerUp(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDevicePowerDown(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceReboot(uint32_t devId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(uint32_t *count)
{
    *count = MAX_DEVICE_NUM;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode(unsigned int dev_id, unsigned int *split_mode)
{
     return DRV_ERROR_NONE;
}


int32_t faultEventFlag = 0;
drvError_t halGetFaultEvent(uint32_t devId, struct halEventFilter* filter,
    struct halFaultEventInfo* eventInfo, uint32_t len, uint32_t *eventCount)
{
    if (faultEventFlag == 1) {
        return DRV_ERROR_NONE;
    }
    if (faultEventFlag == 2) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    if (faultEventFlag == 3) {
        return DRV_ERROR_RESOURCE_OCCUPIED;
    }
    if (faultEventFlag == 4) { // halGetFaultEventHbmUce
        *eventCount = 1;
        eventInfo[0].event_id = 0x80e01801U;
        return DRV_ERROR_NONE;
    }
    if (faultEventFlag == 5) { // halGetFaultEventHbmUceAndBlkList
        *eventCount = 2;
        eventInfo[0].event_id = 0x80e01801U;
        eventInfo[1].event_id = 0x81B58002U; //blkList
        return DRV_ERROR_NONE;
    }
    if (faultEventFlag == 6) { // UbBusError, in g_ubMemTimeoutEventIdBlkList
        *eventCount = 1;
        eventInfo[0].event_id = 0x81B78009U;
        return DRV_ERROR_NONE;
    }
    if (faultEventFlag == 7) { //halGetFaultEventMemPoisonRasAndBlkList
        *eventCount = 2;
        eventInfo[0].event_id = 0x81AF8009U;
        // subModuleId
        eventInfo[0].additional_info[23] = 0x03;
        // errorRegisterIndex
        eventInfo[0].additional_info[24] = 0x02;
        // rasCode
        eventInfo[0].additional_info[28] = 0x10;
        eventInfo[0].additional_info[29] = 0x00;
        eventInfo[0].additional_info[30] = 0x00;
        eventInfo[0].additional_info[31] = 0x00;
        
        eventInfo[1].event_id = 0x81B58006U; //blkList
        return DRV_ERROR_NONE;
    }
    if (faultEventFlag == 8) { // link error ras and event whitelist
        *eventCount = 1;
        eventInfo[0].event_id = 0x81AF8009U;
        // subModuleId
        eventInfo[0].additional_info[23] = 0x03;
        // errorRegisterIndex
        eventInfo[0].additional_info[24] = 0x03;
        // rasCode, the 20th bit is 1
        eventInfo[0].additional_info[28] = 0x00;
        eventInfo[0].additional_info[29] = 0x10;
        eventInfo[0].additional_info[30] = 0x00;
        eventInfo[0].additional_info[31] = 0x00;
        return DRV_ERROR_NONE;
    }
    *eventCount = 1;
    eventInfo[0].event_id = 0x80CD8008; // halGetFaultEventL2Buffer，在HBM UCE黑名单中
    return DRV_ERROR_NONE;
}

int32_t l2_buffer_error_resume_cnt = 0;
drvError_t halGetDeviceInfoByBuff(uint32_t devId, int32_t moduleType, int32_t infoType, void *buf, int32_t *size)
{
    if (infoType == 13U) {
        return DRV_ERROR_NONE;
    }
    if (infoType == 44U) { // INFO_TYPE_L2BUFF_RESUME_CNT
        uint32_t *resume_cnt = static_cast<uint32_t*>(buf);
        *resume_cnt = l2_buffer_error_resume_cnt;
        return DRV_ERROR_NONE;
    }
    rtMemUceInfo *memUceInfo = (rtMemUceInfo *)buf;
    const int addrCount = 2;
    memUceInfo->devid = 0;
    memUceInfo->count = 2;
    for (int i = 0; i < addrCount; i++) {
        memUceInfo->repairAddr[i].ptr = 0x10U + i;
        memUceInfo->repairAddr[i].len = 8;
    }

    return DRV_ERROR_NONE;
}

drvError_t halSetDeviceInfoByBuff(uint32_t devId, int32_t moduleType,
    int32_t infoType, void *buf, int32_t size)
{
    return DRV_ERROR_NONE;
}

int64_t g_device_driver_version_stub = 1;
void halSetDeviceInfoEncap(int32_t moduleType, int32_t infoType, int64_t value) {
    if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
        g_device_driver_version_stub = value;
    }
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_910_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
            printf("\r\n halGetDeviceInfo:: moduleType = %d, infoType = %d, g_device_driver_version_stub = %d",
                moduleType, infoType, g_device_driver_version_stub);
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

drvError_t halTsdrvCtl(uint32_t devId, int type, void *param, size_t paramSize, void *out, size_t *outSize)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetPhyDeviceInfo(uint32_t phyId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == PHY_INFO_TYPE_MASTER_ID) {
            *value = 1;
        } else {
        *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

volatile int32_t mallocbuff[100*1024*1024] = {0};
volatile int32_t hugemallocbuff[1024*1024] = {0};
volatile int32_t sendCount[MAX_DEVICE_NUM] = {0};
volatile int32_t recvCount[MAX_DEVICE_NUM] = {0};
rtTaskReport_t g_report[MAX_DEVICE_NUM][2][MAX_REPORT_COUNT]; //pingpong
int32_t g_reportCount[MAX_DEVICE_NUM][2] = {0};
rtCommand_t g_command[MAX_DEVICE_NUM];
uint64_t g_timeStamp[MAX_DEVICE_NUM] = {0};
volatile int32_t sqSendCount[MAX_DEVICE_NUM] = {0};
volatile int32_t cqRecvCount[MAX_DEVICE_NUM] = {0};
volatile int32_t cqSendCount[MAX_DEVICE_NUM] = {0};
rtHostFuncCqReport_t g_CqReportMsg[MAX_DEVICE_NUM];
rtHostFuncSqCommand_t g_SqSendMsg[MAX_DEVICE_NUM];

rtLogicReport_t logicReport;
rtLogicCqReport_t logicCqReport;
rtShmQuery_t vCqShmInfo[1024] = {0};
std::map<uint32_t, uint32_t> logicCqStreamId;
std::mutex logicMutex;

drvError_t halSqMemGet(uint32_t devId, struct halSqMemGetInput *sqMemGetInput, struct halSqMemGetOutput *sqMemGetOutput )
{
    memset_s(&g_command[devId], sizeof(rtTaskReport_t), 0, sizeof(rtTaskReport_t));
    sqMemGetOutput->cmdPtr = (void *)&g_command[devId];
    sqMemGetOutput->cmdCount = 1;
    return DRV_ERROR_NONE;
}

drvError_t halSqMsgSend(uint32_t devId, struct halSqMsgInfo* info)
{
    if (devId >= MAX_DEVICE_NUM) {
        return DRV_ERROR_NONE;
    }
    while (sendCount[devId] != recvCount[devId]);
    //std::cout<<"halSqMsgSend"<<""<<sendCount[devId]<<";"<<""<<recvCount[devId]<<std::endl;

    rtCommand_t *cmd = &g_command[devId];
    int32_t pingpong = sendCount[devId] % 2;
    rtTaskReport_t *report;
    rtHostFuncCqReport_t *cbReport;
    uint64_t ts;
    switch (cmd->type)
    {
    case TS_TASK_TYPE_EVENT_RECORD:
        ts = g_timeStamp[devId]++;
        report = &g_report[devId][pingpong][0];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = ts & 0xffffffffu;
        report->SOP = 1;
        report->MOP = 0;
        report->EOP = 0;
        report = &g_report[devId][pingpong][1];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = ts >> 32;
        report->SOP = 0;
        report->MOP = 0;
        report->EOP = 1;
        break;
    case TS_TASK_TYPE_HOSTFUNC_CALLBACK:
        cbReport = &g_CqReportMsg[devId];
        cbReport->phase = 1;
        cbReport->SOP = 1;
        cbReport->MOP = 0;
        cbReport->EOP = 1;
        cbReport->isBlock = cmd->u.hostFuncCBTask.isBlock;
        cbReport->streamId =   cmd->streamID;
        cbReport->taskId = cmd->taskID;
        cbReport->sqId = 1;
        cbReport->sqHead = 1;
        cbReport->sequenceId = 1;   /* for match */
        cbReport->hostFuncCbPtr = cmd->u.hostFuncCBTask.hostFuncCBPtr;
        cbReport->fnDataPtr = cmd->u.hostFuncCBTask.fnDataPtr;

        report = &g_report[devId][pingpong][0];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = 0;
        report->SOP = 1;
        report->MOP = 0;
        report->EOP = 1;

        cqSendCount[devId]++;
        break;
    case TS_TASK_TYPE_MAINTENANCE:
        if (cmd->u.maintenanceTask.goal == MT_STREAM_DESTROY) {
            usleep(1000); // wait for send flip task, then recv cqe and delete stream.
        }
        // fall through
    default:
        report = &g_report[devId][pingpong][0];
        report->streamID = cmd->streamID;
        report->taskID = cmd->taskID;
        report->payLoad = 0;
        report->SOP = 1;
        report->MOP = 0;
        report->EOP = 1;
        //delete cmd;
        break;
    }
    if (info->reportCount > 2)
    {
        info->reportCount = 2;
    }
    g_reportCount[devId][pingpong] = info->reportCount;
    sendCount[devId]++;

    if (Runtime::Instance()->GetDisableThread()) {
        recvCount[devId]++;
        if (Runtime::Instance()->GetChipType() == CHIP_910_B_93) {
            rtStarsSqe_t *starsSqe = reinterpret_cast<rtStarsSqe_t *>(cmd);
            if (starsSqe->phSqe.rt_streamID < 1024) {
                vCqShmInfo[starsSqe->phSqe.rt_streamID].taskId = starsSqe->phSqe.task_id;
                vCqShmInfo[starsSqe->phSqe.rt_streamID].valid = 0x5A5A5A5A;
            } else {
                printf("halSqMsgSend: illegal stream_id=%u, chip_type is cloud_v2", starsSqe->phSqe.rt_streamID);
            }
        } else {
            if (cmd->streamID < 1024) {
                vCqShmInfo[cmd->streamID].taskId = cmd->taskID;
                vCqShmInfo[cmd->streamID].valid = 0x5A5A5A5A;
            } else {
                printf("halSqMsgSend: illegal stream_id=%u, chip_type=%u", cmd->streamID,
                    Runtime::Instance()->GetChipType());
            }
        }
    }

    return DRV_ERROR_NONE;
}

drvError_t halCqReportIrqWait(uint32_t devId, struct halReportInfoInput *in, struct halReportInfoOutput *out)
{
    return DRV_ERROR_NONE;
}

void StubClearHalSqSendAndRecvCnt(uint32_t devId)
{
    sendCount[devId] = 0;
    recvCount[devId] = 0;
}
drvError_t halCqReportGet(uint32_t devId, struct halReportGetInput *in, struct halReportGetOutput *out)
{
    if (in->type == DRV_LOGIC_TYPE) {
        std::lock_guard<std::mutex> lock(logicMutex);
        uint32_t streamId = logicCqStreamId[in->cqId];
        if (streamId == MAX_UINT32_NUM) {
            logicReport.logicCqType = LOGIC_RPT_TERMINAL;
        } else {
            if (Runtime::Instance()->GetChipType() == CHIP_DAVID) {
                logicCqReport.streamId = streamId;
                logicCqReport.taskId = vCqShmInfo[streamId].taskId;
                logicCqReport.errorCode = 0;
            } else {
                logicReport.phase = 1;
                logicReport.SOP = 1;
                logicReport.MOP = 1;
                logicReport.EOP = 1;
                logicReport.logicCqId = 0;
                logicReport.streamId = streamId;
                logicReport.taskId = vCqShmInfo[streamId].taskId;
                logicReport.logicCqType = LOGIC_RPT_SUCCESS;
                logicReport.reserved0 = 0;
                logicReport.errorCode = 0;
                logicReport.payLoad = 0;
            }
        }
        if (Runtime::Instance()->GetChipType() == CHIP_DAVID) {
            out->reportPtr = &logicCqReport;
        } else {
            out->reportPtr = &logicReport;
        }

        out->reportPtr = &logicReport;
        out->count = 1;
        return DRV_ERROR_NONE;
    }

    while ((sendCount[devId] == recvCount[devId]));
	//RT_LOG(RT_LOG_INFO, "zyx drvReportGet reportPtr %u,%u,%u,%u", sendCount[devId],recvCount[devId],cqSendCount[devId],sqSendCount[devId]);
	//std::cout<<"halCqReportGet"<<""<<sendCount[devId]<<";"<<""<<recvCount[devId]<<std::endl;

    int32_t pingpong = recvCount[devId] % 2;
    out->reportPtr = &g_report[devId][pingpong];
    //RT_LOG(RT_LOG_INFO, "zyx drvReportGet reportPtr %p", &g_report[devId][pingpong]);
    out->count = g_reportCount[devId][pingpong];
    //RT_LOG(RT_LOG_INFO, "zyx drvReportGet count %p", g_reportCount[devId][pingpong]);
    recvCount[devId]++;
    return DRV_ERROR_NONE;
}

drvError_t halSqCqAllocate(uint32_t devId, struct halSqCqInputInfo *in, struct halSqCqOutputInfo *out)
{

    int32_t sqCqId = g_sqcqIdBitmap.AllocId();
    if ((in->flag & TSDRV_FLAG_SPECIFIED_SQ_ID) == TSDRV_FLAG_SPECIFIED_SQ_ID) {
        out->sqId = in->sqId;
    } else {
        out->sqId = sqCqId;
    }
    if ((in->flag & TSDRV_FLAG_SPECIFIED_CQ_ID) == TSDRV_FLAG_SPECIFIED_CQ_ID) {
        out->cqId = in->cqId;
    } else {
        out->cqId = sqCqId;
    }
    if (in->type == DRV_SHM_TYPE) {
        if (Runtime::Instance()->GetDisableThread()) {
            if (Runtime::Instance()->GetChipType() != CHIP_ADC &&
                Runtime::Instance()->GetChipType() != CHIP_AS31XM1 &&
                Runtime::Instance()->GetChipType() != CHIP_610LITE &&
                Runtime::Instance()->GetChipType() != CHIP_CLOUD &&
                Runtime::Instance()->GetChipType() != CHIP_DC) {
                return DRV_ERROR_INVALID_VALUE;
            }
        } else {
            if (Runtime::Instance()->GetChipType() != CHIP_ADC &&
                Runtime::Instance()->GetChipType() != CHIP_AS31XM1 &&
                Runtime::Instance()->GetChipType() != CHIP_610LITE) {
                return DRV_ERROR_INVALID_VALUE;
            }
        }
        if (Runtime::Instance()->GetChipType() == CHIP_DAVID) {
            memset(&logicCqReport, 0, sizeof(rtLogicCqReport_t));
        } else {
            memset(&logicReport, 0, sizeof(rtLogicReport_t));
        }
        memset((void *)vCqShmInfo, 0, sizeof(vCqShmInfo));
        out->queueVAddr = reinterpret_cast<uintptr_t>(vCqShmInfo);
    } else if (in->type == DRV_LOGIC_TYPE) {
        std::lock_guard<std::mutex> lock(logicMutex);
        uint32_t streamId = in->info[0];
        logicCqStreamId[sqCqId] = in->info[0];
    }
    return DRV_ERROR_NONE;
}

drvError_t halSqCqFree(uint32_t devId, struct halSqCqFreeInfo *in)
{
    g_sqcqIdBitmap.FreeId(in->sqId);
    if (in->type == DRV_SHM_TYPE) {
        if (Runtime::Instance()->GetChipType() == CHIP_DAVID) {
            memset(&logicCqReport, 0, sizeof(rtLogicCqReport_t));
        } else {
            memset(&logicReport, 0, sizeof(rtLogicReport_t));
        }
    } else if (in->type == DRV_LOGIC_TYPE) {
        std::lock_guard<std::mutex> lock(logicMutex);
        uint32_t streamId = logicCqStreamId[in->cqId];
        logicCqStreamId.erase(in->sqId);
    }
    return DRV_ERROR_NONE;
}

drvError_t halReportRelease(uint32_t devId, struct halReportReleaseInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemAlloc(void **dptr, uint64_t size, drvMemType_t type, int32_t nodeId)
{
    *dptr = (void *)&mallocbuff[0];
    return DRV_ERROR_NONE;
}

drvError_t drvMemFree (void * dptr, int32_t deviceId)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemAlloc(void **pp, UINT64 size, UINT64 flag)
{
    *pp = (void *)&mallocbuff[0];
    return DRV_ERROR_NONE;
}

drvError_t halSetMemSharing(struct drvMemSharingPara *para)
{
     return DRV_ERROR_NONE;
}

drvError_t halMemAdvise(DVdeviceptr ptr, size_t count, unsigned int advise, DVdevice device)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemFree(void *pp)
{
    return DRV_ERROR_NONE;
}

int halMbufSetDataLen(Mbuf *mbuf, uint64_t len)
{
    return DRV_ERROR_NONE;
}

int halMbufGetDataLen(Mbuf *mbuf, uint64_t *len)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemGetInfo(DVdevice device, unsigned int type, struct MemInfo *info)
{
    return DRV_ERROR_NONE;
}

DVresult halMemGetInfoEx(DVdevice device, unsigned int type, struct MemInfo *info)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemAllocForDvppManaged(DVdeviceptr *pp, size_t bytesize, DVdevice device, DVmem_advise advise)
{
    *pp = (DVdeviceptr)(void *)&mallocbuff[0];
    return DRV_ERROR_NONE;
}

drvError_t halSqTaskSend(uint32_t devId, struct halTaskSendInfo *info)
{
    if (Runtime::Instance()->GetChipType() == CHIP_DAVID) {
        rtStarsSqe_t *starsSqe = reinterpret_cast<rtStarsSqe_t *>(info->sqe_addr);
        vCqShmInfo[starsSqe->phSqe.rt_streamID & (~RT_SYNC_TASK_FLAG)].taskId = starsSqe->phSqe.task_id;
        vCqShmInfo[starsSqe->phSqe.rt_streamID & (~RT_SYNC_TASK_FLAG)].valid = 0x5A5A5A5A;
    }
    return DRV_ERROR_NONE;
}

DVresult drvMemFreeDvppManaged(DVdeviceptr p)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemAllocHost(void** pp, size_t bytesize )
{
    *pp = (void *)&mallocbuff[0];
    return DRV_ERROR_NONE;
}

drvError_t drvMemFreeHost(void *p)
{
    return DRV_ERROR_NONE;
}

drvError_t drvModelMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t size, drvMemcpyKind_t kind, int32_t deviceId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDriverStubInit(void)
{
    return DRV_ERROR_NONE;
}

extern "C" void StartTaskScheduler()
{
}

drvError_t drvMemAllocManaged(DVdeviceptr * pp, size_t bytesize)
{
    *pp = (uint64_t)&mallocbuff[0];
	 return DRV_ERROR_NONE;
}

drvError_t drvMemFreeManaged(DVdeviceptr  p)
{
	return DRV_ERROR_NONE;
}

drvError_t drvMemAddressTranslate(DVdeviceptr vptr, UINT64 *pptr)
{
    return DRV_ERROR_NONE;
}

 drvError_t drvMemcpy(DVdeviceptr dst, size_t DestMax, DVdeviceptr src, size_t ByteCount)
 {
    return DRV_ERROR_NONE;
 }

drvError_t drvGetRserverdMem(void **dst)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemCpyAsync(DVdeviceptr dst, size_t DestMax, DVdeviceptr src, size_t ByteCount, uint64_t *CopyStatus)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemCpyAsyncWaitFinish(uint64_t CopyStatus)
{
    return DRV_ERROR_NONE;
}

drvError_t drvMemConvertAddrEx(DVdeviceptr pSrc, DVdeviceptr pDst, UINT32 len, UINT32 tsOrDrv, struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemCpyAsyncEx(struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemCpyAsyncExWaitFinish(struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    if(info) {
        *info = 0;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvReportRelease(uint32_t devId, struct drvReportReleaseInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvReportPollWait(uint32_t devId, struct drvReportInfo* info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvReportIrqWait(uint32_t devId, struct drvReportInfo* info)
{
    return DRV_ERROR_NONE;
}

void drvDfxShowReport(uint32_t devId)
{
    return;
}

drvError_t drvAllocOperatorMem(void **dst, int32_t size)
{
    return DRV_ERROR_NONE;
}
drvError_t drvFreeOperatorMem(void **dst, int32_t size)
{
    return DRV_ERROR_NONE;
}


DVresult  drvMemConvertAddr(DVdeviceptr pSrc,DVdeviceptr pDst,UINT32 len,struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;

}

DVresult  drvMemDestroyAddr(struct DMA_ADDR *ptr)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemAllocHugePageManaged(DVdeviceptr *pp, size_t bytesize)
{
    *pp = (uint64_t)&hugemallocbuff[0];
    return DRV_ERROR_NONE;
}
DVresult drvMemFreeHugePageManaged(DVdeviceptr p)
{
    return DRV_ERROR_NONE;
}
drvError_t drvMemAdvise(DVdeviceptr devPtr, size_t count, DVmem_advise advise, DVdevice device)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemLock (DVdeviceptr devPtr, unsigned int lockType, DVdevice device)
{
    return DRV_ERROR_NONE;
}
DVresult drvMemUnLock (DVdeviceptr devPtr)
{
    return DRV_ERROR_NONE;
}

void drvFlushCache(uint64_t base, uint32_t len)
{

}

DVresult drvMemPrefetchToDevice ( DVdeviceptr devPtr, size_t len, DVdevice device )
{
    return DRV_ERROR_NONE;
}

DVresult drvMemsetD8 ( DVdeviceptr dst, size_t destMax, UINT8 value, size_t N )
{
    return DRV_ERROR_NONE;
}

drvError_t drvModelGetMemInfo(uint32_t device, size_t *free, size_t *total)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemGetAttribute(DVdeviceptr vptr, struct DVattribute* addtr)
{
    addtr->devId = 0;
    addtr->memType = 0x0010; // DV_MEM_LOCK_DEV;
    return DRV_ERROR_NONE;
}

DVresult halShmemCreateHandle(DVdeviceptr vptr, uint64_t byteCount, char *name, uint32_t len)
{
    return DRV_ERROR_NONE;
}

DVresult halShmemDestroyHandle(const char *name)
{
    return DRV_ERROR_NONE;
}

DVresult halShmemOpenHandle(const char *name, DVdeviceptr *vptr)
{
    return DRV_ERROR_NONE;
}

DVresult halShmemCloseHandle(DVdeviceptr vptr)
{
    return DRV_ERROR_NONE;
}

drvError_t halShmemSetPidHandle(const char *name, pid_t pid[], int num)
{
    return DRV_ERROR_NONE;
}

drvError_t drvSetIpcNotifyPid(const char *name, pid_t pid[], int num)
{
    return DRV_ERROR_NONE;
}

drvError_t halShrIdSetPid(const char *name, pid_t pid[], uint32_t pid_num)
{
    return DRV_ERROR_NONE;
}

void* create_collect_client(const char* address, const char* engine_name)
{
    void * client_handle = nullptr;
    return client_handle;
}

int collect_write(void* handle, const char* job_ctx, struct data_chunk* data)
{
    return 0;
}

void release_collect_client(void* handle)
{
    return;
}

int drvMemDeviceOpen(unsigned int devid, int devfd)
{
    return DRV_ERROR_NONE;
}

int drvMemDeviceClose(unsigned int devid)
{
    return DRV_ERROR_NONE;
}


drvError_t halShrIdOpen(const char *name, struct drvShrIdInfo *info)
{
    info->id_type = SHR_ID_NOTIFY_TYPE;
    return DRV_ERROR_NONE;
}
drvError_t halShrIdClose(const char *name)
{
    return DRV_ERROR_NONE;
}

drvError_t drvCreateIpcNotify(struct drvIpcNotifyInfo *info, char *name, uint32_t len)
{
    return DRV_ERROR_NONE;
}

drvError_t halShmemSetAttribute(const char *name, uint32_t type, uint64_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halShrIdCreate(struct drvShrIdInfo *info, char *name, uint32_t len)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDestroyIpcNotify(const char *name, struct drvIpcNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}
drvError_t halShrIdDestroy(const char *name)
{
    return DRV_ERROR_NONE;
}

drvError_t drvOpenIpcNotify(const char *name, struct drvIpcNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}
drvError_t drvCloseIpcNotify(const char *name, struct drvIpcNotifyInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvNotifyIdAddrOffset(uint32_t deviceid_, struct drvNotifyInfo *drvInfo)
{
    return DRV_ERROR_NONE;
}

drvError_t halResourceDetailQuery(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceDetailInfo *info)
{
    return DRV_ERROR_NONE;
}

int32_t drv_trans_type = 0;
drvError_t drvDeviceGetTransWay(void *src, void *dst, uint8_t *trans_type)
{
    if (drv_trans_type == 0) {
        *trans_type = 0;
    } else {
        *trans_type = drv_trans_type;
    }
    return DRV_ERROR_NONE;
}

DVresult drvLoadProgram (DVdevice deviceId, void *program, unsigned int offset, size_t ByteCount, void **vPtr)
{
    return DRV_ERROR_NONE;
}


drvError_t drvCustomCall(uint32_t devid, uint32_t cmd, void *para)
{
    (void)devid;

    if(cmd == CMD_TYPE_CM_ALLOC)
    {
        devdrv_alloc_cm_para_t *cmPara =(devdrv_alloc_cm_para_t *)para;
        *(cmPara->ptr) =(void*) &hugemallocbuff[0];
    }

    return DRV_ERROR_NONE;
}

drvError_t halHostRegister(void *hostPtr, UINT64 size, UINT32 flag, UINT32 devid, void **devPtr)
{
    return DRV_ERROR_NONE;
}

drvError_t halHostUnregister(void *hostPtr, UINT32 devid)
{
    return DRV_ERROR_NONE;
}

drvError_t halHostUnregisterEx(void *srcPtr, UINT32 devid, UINT32 flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halHostRegisterCapabilities(UINT32 devid, UINT32 acc_module_type, UINT32 *mem_map_cap)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    return DRV_ERROR_NONE;
}
drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    return DRV_ERROR_NONE;
}

drvError_t halDeviceEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halDeviceDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return DRV_ERROR_NONE;
}
drvError_t halDeviceCanAccessPeer(int32_t *canAccessPeer, uint32_t device, uint32_t peerDevice)
{
    return DRV_ERROR_NONE;
}
drvError_t drvGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status)
{
    return DRV_ERROR_NONE;
}

DVresult halMemAllocDevice(DVdeviceptr *pp, size_t bytesize, DVmem_advise advise, DVdevice device)
{
    return DRV_ERROR_NONE;
}

DVresult drvMbindHbm(DVdeviceptr devPtr, size_t len, unsigned int type, uint32_t dev_id)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemAllocPhy32PageManaged(DVdevice device, DVdeviceptr *pp, size_t bytesize)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemFreePhy32PageManaged(DVdeviceptr addr)
{
    return DRV_ERROR_NONE;
}

DVresult halMemFreeDevice(DVdeviceptr p)
{
    return DRV_ERROR_NONE;
}

pid_t drvDeviceGetBareTgid(void)
{
    return 0;
}

drvError_t halGetChipCapability(uint32_t deviceId, struct halCapabilityInfo *info)
{
    info->sdma_reduce_support = 1;
    info->ts_group_number = STUB_TS_GRP_NUM;
    return DRV_ERROR_NONE;
}

drvError_t halGetCapabilityGroupInfo(int deviceId, int ownerId, int groupId, struct capability_group_info *groupInfo, int groupCount)
{
    UNUSED(deviceId);
    UNUSED(ownerId);
    if ((groupId == -1 && groupCount != STUB_TS_GRP_NUM) ||
        (groupId > -1 && groupCount != 1) ||
        (groupId < -1)) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if (groupId == -1) {
        for (int32_t i = 0; i < groupCount; i++) {
            groupInfo[i].group_id = i;
            groupInfo[i].state = i%2;
            groupInfo[i].extend_attribute = 0;
            groupInfo[i].aicore_number = i;
            groupInfo[i].aivector_number = i;
            groupInfo[i].sdma_number = i;
            groupInfo[i].aicpu_number = i;
            groupInfo[i].active_sq_number = i;
        }
        groupInfo[1].extend_attribute = 1;
    } else {
            groupInfo->group_id = groupId;
            groupInfo->state = 1;
            groupInfo->extend_attribute = 1;
            groupInfo->aicore_number = 1;
            groupInfo->aivector_number = 1;
            groupInfo->sdma_number = 1;
            groupInfo->aicpu_number = 1;
            groupInfo->active_sq_number = 1;
    }
    return DRV_ERROR_NONE;
}

drvError_t halGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *value)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetPairPhyDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *value)
{
    return DRV_ERROR_NONE;
}

int32_t halResourceIdFlag = 0;
drvError_t halResourceIdAlloc(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceIdOutputInfo *out)
{
    if (halResourceIdFlag == 1 && in->res[1U] == TSDRV_RES_SPECIFIED_ID) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    if (in->res[1U] == TSDRV_RES_SPECIFIED_ID) {
        out->resourceId = in->resourceId;
        return DRV_ERROR_NONE;
    }
    switch (in->type) {
        case DRV_STREAM_ID:
            out->resourceId = g_streamIdBitmap.AllocId();
            break;
        case DRV_EVENT_ID:
            out->resourceId = g_eventIdBitmap.AllocId();
            break;
        case DRV_MODEL_ID:
            in->resourceId = 1;
            out->resourceId = rand();
            break;
        case DRV_NOTIFY_ID:
            in->resourceId = 1;
            break;
        case DRV_CNT_NOTIFY_ID:
            in->resourceId = 1;
            break;
        default:
            return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halResourceIdFree(uint32_t devId, struct halResourceIdInputInfo *in)
{
    switch (in->type) {
        case DRV_STREAM_ID:
            g_streamIdBitmap.FreeId(in->resourceId);
            break;
        case DRV_EVENT_ID:
            g_eventIdBitmap.FreeId(in->resourceId);
            break;
        case DRV_MODEL_ID:
            break;
        case DRV_NOTIFY_ID:
            break;
        case DRV_CNT_NOTIFY_ID:
            break;
        default:
            return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}
DVresult cmodelDrvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t size, drvMemcpyKind_t kind)
{
    return DRV_ERROR_NONE;
}
drvError_t cmodelDrvFreeHost(void *pp)
{
    return DRV_ERROR_NONE;
}
drvError_t halCdqCreate (unsigned int devId, unsigned int tsId, struct halCdqPara *cdqPara, unsigned int *queId)
{
    return DRV_ERROR_NONE;
}
drvError_t halCdqDestroy(unsigned int devId, unsigned int tsId, unsigned int queId)
{
    return DRV_ERROR_NONE;
}
drvError_t halCdqAllocBatch(unsigned int devId, unsigned int tsId, unsigned int queId, unsigned int timeout, unsigned int *batchId)
{
    return DRV_ERROR_NONE;
}
drvError_t halSqCqConfig(uint32_t devId, struct halSqCqConfigInfo *info)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueCreate(unsigned int devId, const QueueAttr *queAttr, unsigned int *qid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueExport(unsigned int devId, unsigned int qid, struct shareQueInfo *queInfo)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnexport(unsigned int devId, unsigned int qid, struct shareQueInfo *queInfo)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueImport(unsigned int devId, struct shareQueInfo *queInfo, unsigned int* qid)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueUnimport(unsigned int devId, unsigned int qid, struct shareQueInfo *queInfo)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueDestroy(unsigned int devId, unsigned int qid)
{
	return DRV_ERROR_NONE;
}
drvError_t halQueueInit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbuf)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueuePeek(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueEnQueueBuff(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueDeQueueBuff(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueQueryInfo(unsigned int devId, unsigned int qid, QueueInfo *queInfo)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueQuery(unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueGrant(unsigned int devId, int qid, int pid, QueueShareAttr attr)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueAttach(unsigned int devId, unsigned int qid, int timeOut)
{
    return DRV_ERROR_NONE;
}
drvError_t halEschedSubmitEventSync(unsigned int devId, struct event_summary *event, int timeout, struct event_reply *ack)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}
drvError_t drvQueryDevpid(struct drvBindHostpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}
drvError_t halBuffGet(Mbuf *mbuf, void *buff, unsigned long size)
{
    return DRV_ERROR_NONE;
}
int halBuffInit(BuffCfg *cfg)
{
    return 0;
}
int halMbufAlloc(uint64_t size, Mbuf **mbuf)
{
    return 0;
}
int halMbufAllocEx(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    return 0;
}
int halMbufFree(Mbuf *mbuf)
{
    return 0;
}
int halMbufBuild(void *buff, uint64_t len, Mbuf **mbuf)
{
    return 0;
}
int halBuffAlloc(uint64_t size, void **buff)
{
    return 0;
}
int halBuffFree(void *buff)
{
    return 0;
}
void halBuffPut(Mbuf *mbuf, void *buff)
{
    (void)(mbuf);
    (void)(buff);
}
int halMbufUnBuild(Mbuf *mbuf, void **buff, uint64_t *len)
{
    return 0;
}
int halMbufGetBuffAddr(Mbuf *mbuf, void **buf)
{
    return 0;
}
int halMbufGetBuffSize(Mbuf *mbuf, uint64_t *totalSize)
{
    return 0;
}
int halMbufGetPrivInfo(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    return 0;
}
int halMbufCopyRef(Mbuf *mbuf, Mbuf **newMbuf)
{
    return 0;
}
int halMbufChainAppend(Mbuf *mbufChainHead, Mbuf *mbuf)
{
    return 0;
}
int halMbufChainGetMbufNum(Mbuf *mbufChainHead, unsigned int *num)
{
    return 0;
}
int halMbufChainGetMbuf(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf)
{
    return 0;
}
int halGrpCreate(const char *name, GroupCfg *cfg)
{
    return 0;
}
drvError_t halQueueSet(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *input)
{
    return DRV_ERROR_NONE;
}
int  halBuffGetInfo(enum BuffGetCmdType cmd, void *inBuff, unsigned int inLen,
    void *outBuff, unsigned int *outLen)
{
    return DRV_ERROR_NONE;
}
drvError_t halGrpCacheAlloc(const char *name, unsigned int devId, GrpCacheAllocPara *para)
{
    return DRV_ERROR_NONE;
}
int halGrpAddProc(const char *name, int pid, GroupShareAttr attr)
{
    return 0;
}
int halGrpAttach(const char *name, int timeout)
{
    return 0;
}
int halGrpQuery(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    return 0;
}

drvError_t halQueueGetQidbyName(unsigned int devId, const char *name, unsigned int *qid) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedAttachDevice(unsigned int devId) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedDettachDevice(unsigned int devId) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, int timeout, struct event_info *event) {
    event->comm.event_id = EVENT_RANDOM_KERNEL;
    return DRV_ERROR_NONE;
}

drvError_t halEschedCreateGrp(unsigned int devId, unsigned int grpId, GROUP_TYPE type) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubmitEvent(unsigned int devId, struct event_summary *event) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, unsigned long long eventBitmap) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedAckEvent(unsigned int devId, EVENT_ID eventId, unsigned int subeventId, char *msg, unsigned int msgLen) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedThreadSwapout(unsigned int devId, unsigned int grpId, unsigned int threadId) {
    return DRV_ERROR_NONE;
}

drvError_t halEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, unsigned int *grpId) {
    return DRV_ERROR_NONE;
}

drvError_t halResourceInfoQuery(uint32_t devId, uint32_t tsId, drvResourceType_t type, struct halResourceInfo * info) {
    return DRV_ERROR_NONE;
}

drvError_t halResAddrMap(unsigned int devId, struct res_addr_info *res_info, unsigned long *va, unsigned int *len) {
    return DRV_ERROR_NONE;
}

int32_t checkProcessStatusFlag = 0;
drvError_t halCheckProcessStatus(DVdevice device, processType_t processType, processStatus_t status, bool *isMatched) {
    if (checkProcessStatusFlag == 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    if (checkProcessStatusFlag == 2) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halCheckProcessStatusEx(DVdevice device, processType_t processType, processStatus_t status, struct drv_process_status_output *out) {
    out->result = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetChipCount(int *chip_count)
{
    *chip_count = 1;
    return DRV_ERROR_NONE;
}
drvError_t halGetChipList(int chip_list[], int count)
{
    chip_list[0] = 0;
    return DRV_ERROR_NONE;
}
drvError_t halGetDeviceCountFromChip(int chip_id, int *device_count)
{
    *device_count = 1;
    return DRV_ERROR_NONE;
}
drvError_t halGetDeviceFromChip(int chip_id, int device_list[], int count)
{
    for (int i = 0; i < count; i++) {
        device_list[i] = i;
    }
    return DRV_ERROR_NONE;
}
drvError_t halGetChipFromDevice(int device_id, int *chip_id)
{
    *chip_id = 0;
    return DRV_ERROR_NONE;
}
drvError_t halMemcpy2D(struct MEMCPY2D *pCopy)
{
    return DRV_ERROR_NONE;
}
drvError_t halMemCtl(int type, void *param_value, size_t param_value_size,
                     void *out_value, size_t *out_size_ret)
{
    return DRV_ERROR_NONE;
}

drvError_t halBufEventReport(const char *name)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubF2NFEvent(unsigned int devid, unsigned int qid, unsigned int groupid)
{
    return DRV_ERROR_NONE;
}
drvError_t halQueueSubscribe(unsigned int devId, unsigned int qid, unsigned int groupId, int type)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemcpySumbit(struct DMA_ADDR *dmaAddr, int32_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemcpyWait(struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;
}

drvError_t halCqReportRecv(uint32_t devId, struct halReportRecvInfo *info)
{
    struct halReportGetInput repGetInputInfo;
    struct halReportGetOutput repGetOutputInfo;
    repGetInputInfo.type = DRV_LOGIC_TYPE;
    repGetInputInfo.tsId = info->tsId;
    repGetInputInfo.cqId = info->cqId;
    repGetOutputInfo.count = 0U;
    repGetOutputInfo.reportPtr = nullptr;
    halCqReportGet(devId, &repGetInputInfo, &repGetOutputInfo);
    rtLogicReport_t *report = (rtLogicReport_t *)info->cqe_addr;
    *report = *((rtLogicReport_t *)repGetOutputInfo.reportPtr);
    info->report_cqe_num = 1;
    return DRV_ERROR_NONE;
}

int32_t halSqCqRes = 0;
drvError_t halSqCqQuery(uint32_t devId, struct halSqCqQueryInfo *info)
{
    if (info->prop != DRV_SQCQ_PROP_SQ_CQE_STATUS) {
        info->value[0] = 1;
    } else {
        info->value[0] = 0;
    }
    if(halSqCqRes == 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    if(halSqCqRes == 2) {
        return DRV_ERROR_UNINIT;
    }
    return DRV_ERROR_NONE;
}

drvError_t halResourceConfig(uint32_t devId, struct halResourceIdInputInfo *in,
    struct halResourceConfigInfo *para)
{
    return DRV_ERROR_NONE;
}

drvError_t  halQueueReset(unsigned int devId, unsigned int qid)
{
    return DRV_ERROR_NONE;
};

drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    if (status != nullptr) {
        *status = DRV_STATUS_INITING;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvHdcServerCreate(int devid, int serviceType, HDC_SERVER *pServer)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcServerDestroy(HDC_SERVER server)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcSessionClose(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedQueryInfo(unsigned int devId, ESCHED_QUERY_TYPE type, struct esched_input_info *inPut,
    struct esched_output_info *outPut)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemAddressReserve(void **pp, size_t size, size_t alignment, void *addr, uint64_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemAddressFree(void *pp)
{
    return DRV_ERROR_NONE;
}

drvError_t  halMemCreate(drv_mem_handle_t **handle, size_t size, const struct drv_mem_prop *prop, uint64_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemRelease (drv_mem_handle_t *handle)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemMap(void *ptr, size_t size, size_t offset, drv_mem_handle_t *handle, uint64_t flag)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemUnmap(void *ptr)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemSetAccess(void *ptr, size_t size, struct drv_mem_access_desc *desc, size_t count)
{
    if (count == 0) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halMemExportToShareableHandle(drv_mem_handle_t *handle, drv_mem_handle_type handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemImportFromShareableHandle(uint64_t shareableHandle, uint32_t devid, drv_mem_handle_t **handle)
{
    return DRV_ERROR_NONE;
}
drvError_t halShrIdSetPodPid(const char *name, uint32_t sdid, pid_t pid)
{
    return DRV_ERROR_NONE;
}

DVresult halShmemSetPodPid(const char *name, uint32_t sdid, int pid[], int num)
{
    return DRV_ERROR_NONE;
}

DVresult halUpdateAddress(uint64_t device_addr, uint64_t len)
{
    if (len == 0) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halParseSDID(uint32_t sdid, struct halSDIDParseInfo *sdid_parse)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pid_num)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemGetAllocationGranularity(const struct drv_mem_prop *prop, drv_mem_granularity_options option, size_t *granularity)
{
    return DRV_ERROR_NONE;
}

rtError_t StarsVersionTaskInit(TaskInfo * const taskInfo)
{
    taskInfo->typeName = const_cast<char_t*>("STARS_VERSION");
    return RT_ERROR_NONE;
}

drvError_t drvBindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvUnbindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
    unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetSocVersion(uint32_t devId, char *soc_version, uint32_t len)
{
    error_t err = strcpy_s(soc_version, len, "Ascend910_9599");
    if (err != EOK) {
    return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

bool halSupportFeature(uint32_t devId, drvFeature_t type)
{
    return true;
}

drvError_t halGetDevNumEx(uint32_t hw_type, uint32_t *devNum)
{
    if (hw_type == 0) {
        *devNum = 0U;
    }
    if (hw_type == 1) {
        *devNum = 2U;
    }
    return DRV_ERROR_NONE;
}

int32_t reportRasProcFlag = 0;
drvError_t halReadFaultEvent(
    int32_t devId, int timeout, struct halEventFilter* filter, struct halFaultEventInfo* eventInfo)
{
    if (reportRasProcFlag == 1) {
        eventInfo->event_id = 0x80E18400U;
        eventInfo->deviceid = 0;
    }
    if (reportRasProcFlag == 2) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    if (reportRasProcFlag == 3) {
        return DRV_ERROR_RESOURCE_OCCUPIED;
    }
    if (devId == 0) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    eventInfo->assertion = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetChipInfo(unsigned int devId, halChipInfo *chipInfo)
{
    if (devId == 329) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if (devId == 5525) {
        (void)strcpy(reinterpret_cast<char*>(chipInfo->name), "310Pvir02");
        return DRV_ERROR_NONE;
    }
    if (devId == 10) {
        (void)strcpy(reinterpret_cast<char*>(chipInfo->name), "310P5");
    } else if (devId == 12) {
        (void)strcpy(reinterpret_cast<char*>(chipInfo->name), "310P7");
    } else {
        (void)strcpy(reinterpret_cast<char*>(chipInfo->name), "310P3");
    }
    return DRV_ERROR_NONE;
}

drvError_t halSqTaskArgsAsyncCopy(uint32_t devId, struct halSqTaskArgsInfo *info)
{
    if (devId == 10086) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halAsyncDmaCreate(uint32_t devId, struct halAsyncDmaInputPara *in, struct halAsyncDmaOutputPara *out)
{
    return DRV_ERROR_NONE;
}

drvError_t halAsyncDmaDestory(uint32_t devId, halAsyncDmaDestoryPara *para)
{
    return DRV_ERROR_NONE;
}

drvError_t halResAddrUnmap(unsigned int devId, struct res_addr_info *res_info)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemcpyBatch(uint64_t dst[], uint64_t src[], size_t size[], size_t count)
{
    for (size_t i = 0; i < count; i++) {
        (void)memcpy(reinterpret_cast<void *>(dst[i]), reinterpret_cast<void *>(src[i]), size[i]);
    }
    return DRV_ERROR_NONE;
}

drvError_t halQueueGetDqsQueInfo(unsigned int devId, unsigned int qid, DqsQueueInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t halShrIdSetAttribute(const char *name, enum shrIdAttrType type, struct shrIdAttr attr)
{
    return DRV_ERROR_NONE;
}

drvError_t halBuffGetDQSPoolInfoById(unsigned int poolId, DqsPoolInfo *poolInfo)
{
    return DRV_ERROR_NONE;
}

drvError_t halShrIdInfoGet(const char *name, struct shrIdGetInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemShareHandleSetAttribute(
    uint64_t shareableHandle, enum ShareHandleAttrType type, struct ShareHandleAttr attr)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemShareHandleInfoGet(uint64_t shareableHandle, struct ShareHandleGetInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t halShmemInfoGet(const char *name, struct ShmemGetInfo *info)
{
    return DRV_ERROR_NONE;
}

int32_t deviceCloseFlag = 0;
drvError_t halDeviceClose(uint32_t devid, halDevCloseIn *in)
{
    if (deviceCloseFlag == 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

drvError_t halDeviceOpen(uint32_t devid, halDevOpenIn *in, halDevOpenOut *out)
{
    return DRV_ERROR_NONE;
}

int32_t processResBackupFlag = 0;
drvError_t halProcessResBackup(halProcResBackupInfo *info)
{
    if (processResBackupFlag == 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

int32_t processResRestoreFlag = 0;
drvError_t halProcessResRestore(halProcResRestoreInfo *info)
{
    if (processResRestoreFlag == 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

drvError_t halStreamBackup(uint32_t dev_id, struct stream_backup_info *in)
{
    return DRV_ERROR_NONE;
}
drvError_t halStreamRestore(uint32_t dev_id, struct stream_backup_info *in)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetTsegInfoByVa(uint32_t devid, uint64_t va, uint64_t size, uint32_t flag,
    struct halTsegInfo *tsegInfo)
{
    return DRV_ERROR_NONE;
}


DLLEXPORT drvError_t halPutTsegInfo(uint32_t devid, struct halTsegInfo *tsegInfo)
{
    return DRV_ERROR_NONE;
}