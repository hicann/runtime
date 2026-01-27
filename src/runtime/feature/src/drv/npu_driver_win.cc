/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "mmpa/mmpa_api.h"
#include "driver/ascend_inpackage_hal.h"
#include "task.hpp"
#include "driver.hpp"
#include "securec.h"
#include "runtime.hpp"
#include "osal.hpp"
#include "arg_loader.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "npu_driver_record.hpp"

namespace cce {
namespace runtime {

rtError_t NpuDriver::MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
    rtMallocHostSharedMemoryOut * const out, const uint32_t deviceId)
{
    UNUSED(in);
    UNUSED(out);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in, const uint32_t deviceId)
{
    UNUSED(in);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr,
    const uint32_t deviceId)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(type);
    UNUSED(devPtr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostUnregister(void *ptr,  const uint32_t deviceId)
{
    UNUSED(ptr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostAddrRegister(void * const addr, const uint64_t size, const uint32_t deviceId)
{
    UNUSED(addr);
    UNUSED(size);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostAddrUnRegister(void * const addr, const uint32_t deviceId)
{
    UNUSED(addr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags)
{
    UNUSED(devPtr);
    UNUSED(size);
    UNUSED(alignment);
    UNUSED(devAddr);
    UNUSED(flags);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReleaseMemAddress(void* devPtr)
{
    UNUSED(devPtr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    UNUSED(handle);
    UNUSED(size);
    UNUSED(prop);
    UNUSED(flags);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::FreePhysical(rtDrvMemHandle handle)
{
    UNUSED(handle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    UNUSED(devPtr);
    UNUSED(size);
    UNUSED(offset);
    UNUSED(handle);
    UNUSED(flags);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::UnmapMem(void* devPtr)
{
    UNUSED(devPtr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    UNUSED(virPtr);
    UNUSED(size);
    UNUSED(desc);
    UNUSED(count);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags)
{
    UNUSED(virPtr);
    UNUSED(location);
    UNUSED(flags);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAllocationGranularity(const rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity)
{
    UNUSED(prop);
    UNUSED(option);
    UNUSED(granularity);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    UNUSED(handle);
    UNUSED(handleType);
    UNUSED(flags);
    UNUSED(shareableHandle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle)
{
    UNUSED(handle);
    UNUSED(handleType);
    UNUSED(flags);
    UNUSED(shareableHandle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    UNUSED(shareableHandle);
    UNUSED(devId);
    UNUSED(handle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ImportFromShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int32_t devId, rtDrvMemHandle *handle)
{
    UNUSED(shareableHandle);
    UNUSED(handleType);
    UNUSED(devId);
    UNUSED(handle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    UNUSED(shareableHandle);
    UNUSED(pid);
    UNUSED(pidNum);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetServerIdAndshareableHandle(
    rtMemSharedHandleType handleType, const void *sharehandle, uint32_t *serverId, uint64_t *shareableHandle)
{
    UNUSED(handleType);
    UNUSED(sharehandle);
    UNUSED(serverId);
    UNUSED(shareableHandle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufInit(rtMemBuffCfg_t * const cfg)
{
    UNUSED(cfg);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffAlloc(const uint64_t size, void **buff)
{
    UNUSED(size);
    UNUSED(buff);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffFree(void * const buff)
{
    UNUSED(buff);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffConfirm(void * const buff, const uint64_t size)
{
    UNUSED(buff);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    UNUSED(type);
    UNUSED(inBuff);
    UNUSED(inLen);
    UNUSED(outBuff);
    UNUSED(outLen);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BufEventTrigger(const char_t * const name)
{
    UNUSED(name);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size)
{
    UNUSED(mbufPtr);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size,
    const uint64_t flag, const int32_t grpId)
{
    UNUSED(mbufPtr);
    UNUSED(size);
    UNUSED(flag);
    UNUSED(grpId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufFree(rtMbufPtr_t const memBuf)
{
    UNUSED(memBuf);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t *mbufPtr)
{
    UNUSED(buff);
    UNUSED(size);
    UNUSED(mbufPtr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size)
{
    UNUSED(mbufPtr);
    UNUSED(buff);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size)
{
    UNUSED(mbufPtr);
    UNUSED(buff);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufPut(const rtMbufPtr_t mbufPtr, void * const buff)
{
    UNUSED(mbufPtr);
    UNUSED(buff);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len)
{
    UNUSED(mbufPtr);
    UNUSED(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len)
{
    UNUSED(mbufPtr);
    UNUSED(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetBuffSize(const rtMbufPtr_t memBuf, uint64_t * const totalSize)
{
    UNUSED(memBuf);
    UNUSED(totalSize);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetBuffAddr(const rtMbufPtr_t memBuf, void ** const buf)
{
    UNUSED(memBuf);
    UNUSED(buf);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetPrivInfo(const rtMbufPtr_t memBuf,  void ** const priv, uint64_t * const size)
{
    UNUSED(memBuf);
    UNUSED(priv);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr)
{
    UNUSED(mbufPtr);
    UNUSED(newMbufPtr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    UNUSED(memBufChainHead);
    UNUSED(memBuf);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainGetMbuf(rtMbufPtr_t const memBufChainHead, const uint32_t index,
    rtMbufPtr_t * const memBuf)
{
    UNUSED(memBufChainHead);
    UNUSED(index);
    UNUSED(memBuf);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num)
{
    UNUSED(memBufChainHead);
    UNUSED(num);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg)
{
    UNUSED(name);
    UNUSED(cfg);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
    const rtMemGrpCacheAllocPara *const para)
{
    UNUSED(name);
    UNUSED(devId);
    UNUSED(para);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpAddProc(const char_t * const name, const int32_t pid,
                                   const rtMemGrpShareAttr_t * const attr)
{
    UNUSED(name);
    UNUSED(pid);
    UNUSED(attr);
    return RT_ERROR_NONE;
}

static rtError_t MemGrpQueryGroupsOfProcess(const rtMemGrpQueryInput_t * const input,
    rtMemGrpQueryOutput_t * const output)
{
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_NONE;
}

static rtError_t MemGrpQueryGroupId(const rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_NONE;
}

static rtError_t MemGrpGrpQueryGroupAddrInfo(const rtMemGrpQueryInput_t * const input,
    rtMemGrpQueryOutput_t * const output)
{
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpQuery(const rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpAttach(const char_t * const name, const int32_t timeout)
{
    UNUSED(name);
    UNUSED(timeout);
    return RT_ERROR_NONE;
}

 rtError_t NpuDriver::MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr, uint32_t * const qid)
{
    UNUSED(devId);
    UNUSED(queAttr);
    UNUSED(qid);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDestroy(const int32_t devId, const uint32_t qid)
{
    UNUSED(devId);
    UNUSED(qid);
    return RT_ERROR_NONE;
}

static rtError_t CheckMemQueueSupported(bool &isSupported)
{
    UNUSED(isSupported);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueInit(const int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
    const rtMemQueueSetInputPara * const input)
{
    UNUSED(devId);
    UNUSED(cmd);
    UNUSED(input);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const memBuf)
{
    UNUSED(devId);
    UNUSED(qid);
    UNUSED(memBuf);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const memBuf)
{
    UNUSED(devId);
    UNUSED(qid);
    UNUSED(memBuf);
    return RT_ERROR_NONE;
}

static rtError_t GetBuffIovec(struct buff_iovec * const vec, const rtMemQueueBuff_t * const inBuf,
    bool &baseNeedFree)
{
    UNUSED(vec);
    UNUSED(inBuf);
    UNUSED(baseNeedFree);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid,
                                         const rtMemQueueBuff_t * const inBuf, const int32_t timeout)
{
    UNUSED(devId);
    UNUSED(qid);
    UNUSED(inBuf);
    UNUSED(timeout);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid,
                                         const rtMemQueueBuff_t * const outBuf, const int32_t timeout)
{
    UNUSED(devId);
    UNUSED(qid);
    UNUSED(outBuf);
    UNUSED(timeout);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen, const int32_t timeout)
{
    UNUSED(devId);
    UNUSED(qid);
    UNUSED(bufLen);
    UNUSED(timeout);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd,
                                   const void * const inBuff, const uint32_t inLen,
                                   void * const outBuff, const uint32_t * const outLen)
{
    UNUSED(devId);
    UNUSED(cmd);
    UNUSED(inBuff);
    UNUSED(inLen);
    UNUSED(outBuff);
    UNUSED(outLen);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId)
{
    UNUSED(devId);
    UNUSED(name);
    UNUSED(qId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeout)
{
    UNUSED(devId);
    UNUSED(qid);
    UNUSED(timeout);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQEventCrossDevSupported(int32_t * const isSupported)
{
    UNUSED(isSupported);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubmitEvent(const int32_t devId, const rtEschedEventSummary_t * const evt)
{
    UNUSED(devId);
    UNUSED(evt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
                                           rtEschedEventReply_t * const ack)
{
    UNUSED(devId);
    UNUSED(evt);
    UNUSED(ack);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedAttachDevice(const uint32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedDettachDevice(const uint32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    UNUSED(devId);
    UNUSED(grpId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedCreateGrpEx(const uint32_t devId, const uint32_t maxThreadNum,
                                       uint32_t * const grpId)
{
    UNUSED(devId);
    UNUSED(maxThreadNum);
    UNUSED(grpId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubscribeEvent(const int32_t devId, const uint32_t grpId,
                                          const uint32_t threadId, const uint64_t eventBitmap)
{
    UNUSED(devId);
    UNUSED(grpId);
    UNUSED(threadId);
    UNUSED(eventBitmap);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedWaitEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
                                     const int32_t timeout, rtEschedEventSummary_t * const evt)
{
    UNUSED(devId);
    UNUSED(grpId);
    UNUSED(threadId);
    UNUSED(timeout);
    UNUSED(evt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
                                    const uint32_t subeventId, char_t * const msg, const uint32_t len)
{
    UNUSED(devId);
    UNUSED(evtId);
    UNUSED(subeventId);
    UNUSED(msg);
    UNUSED(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
    rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut)
{
    UNUSED(devId);
    UNUSED(type);
    UNUSED(inPut);
    UNUSED(outPut);
    return RT_ERROR_NONE;
}

drvError_t NpuDriver::DrvEschedManage(const uint32_t devId, const int32_t timeout, const uint32_t eschedTid,
                                      const uint32_t grpId, struct halReportRecvInfo *info)
{
    UNUSED(devId);
    UNUSED(timeout);
    UNUSED(eschedTid);
    UNUSED(grpId);
    UNUSED(info);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetFaultEvent(const int32_t deviceId, const rtDmsEventFilter * const filter, rtDmsFaultEvent *dmsEvent,
    uint32_t len, uint32_t *eventCount)
{
    UNUSED(deviceId);
    UNUSED(filter);
    UNUSED(dmsEvent);
    UNUSED(len);
    UNUSED(eventCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAllFaultEvent(const uint32_t deviceId, rtDmsFaultEvent * const dmsEvent,
    uint32_t len, uint32_t *eventCount)
{
    UNUSED(deviceId);
    UNUSED(dmsEvent);
    UNUSED(len);
    UNUSED(eventCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReadFaultEvent(
    const int32_t deviceId, uint32_t timeout, const rtDmsEventFilter * const filter, rtDmsFaultEvent *dmsEvent)
{
    UNUSED(deviceId);
    UNUSED(timeout);
    UNUSED(filter);
    UNUSED(dmsEvent);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetRasSyscnt(const uint32_t deviceId, RtHbmRasInfo *hbmRasInfo)
{
    UNUSED(deviceId);
    UNUSED(hbmRasInfo);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    UNUSED(deviceId);
    UNUSED(memUceInfo);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceInfoByBuff(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    void * const buf, int32_t * const size)
{
    UNUSED(deviceId);
    UNUSED(moduleType);
    UNUSED(infoType);
    UNUSED(buf);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetDeviceInfoByBuff(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    void * const buf, const int32_t size)
{
    UNUSED(deviceId);
    UNUSED(moduleType);
    UNUSED(infoType);
    UNUSED(buf);
    UNUSED(size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceAicpuStat(const uint32_t deviceId)
{
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceStatus(uint32_t devId, drvStatus_t * const status)
{
    UNUSED(devId);
    UNUSED(status);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::TaskKill(const uint32_t deviceId, const uint32_t tsId,
		              const uint32_t sqId, const uint32_t operationType)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(operationType);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::TaskAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
    const uint32_t targetId, uint32_t &result)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(opType);
    UNUSED(targetId);
    UNUSED(result);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryAbortStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
    const uint32_t targetId, uint32_t &status)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(queryType);
    UNUSED(targetId);
    UNUSED(status);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::RecoverAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
    const uint32_t targetId, uint32_t &result)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(opType);
    UNUSED(targetId);
    UNUSED(result);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryRecoverStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
    const uint32_t targetId, uint32_t &status)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(queryType);
    UNUSED(targetId);
    UNUSED(status);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    UNUSED(deviceId);
    UNUSED(memUceInfo);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ResourceReset(const uint32_t deviceId, const uint32_t tsId, drvIdType_t type)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetMaxStreamAndTask(const uint32_t deviceId, const uint32_t tsId, uint32_t * const maxStrCount)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(maxStrCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAvailStreamNum(const uint32_t deviceId, const uint32_t tsId, uint32_t * const streamCount)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(streamCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAvailEventNum(const uint32_t deviceId, const uint32_t tsId, uint32_t * const eventCount)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(eventCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetMaxModelNum(const uint32_t deviceId, const uint32_t tsId, uint32_t *maxModelCount)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(maxModelCount);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryOpExecTimeoutInterval(const uint32_t deviceId, const uint32_t tsId,
    uint64_t &timeoutInterval)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(timeoutInterval);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReAllocResourceId(const uint32_t deviceId, const uint32_t tsId, const uint32_t priority,
                                       const uint32_t resourceId, drvIdType_t idType)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(priority);
    UNUSED(resourceId);
    UNUSED(idType);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t priority, uint32_t streamFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(priority);
    UNUSED(id);
    UNUSED(streamFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t streamFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    UNUSED(streamFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EventIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t eventFlag, const bool createFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(eventFlag);
    UNUSED(id);
    UNUSED(createFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EventIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                                 const uint32_t eventFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(eventFlag);
    UNUSED(id);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CmoIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CmoIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ModelIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ModelIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NotifyIdAlloc(const int32_t deviceId, uint32_t * const id, const uint32_t tsId,
                                   const uint32_t notifyFlag, const bool isCountNotify, const bool isEvent)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    UNUSED(notifyFlag);
    UNUSED(isCountNotify);
    UNUSED(isEvent);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NotifyIdFree(const int32_t deviceId, const uint32_t id, const uint32_t tsId,
                                  const uint32_t notifyFlag, const bool isCountNotify)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(id);
    UNUSED(notifyFlag);
    UNUSED(isCountNotify);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                                  uint32_t * const sqId, uint32_t * const cqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(groupId);
    UNUSED(sqId);
    UNUSED(cqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCqFree(const uint32_t sqId, const uint32_t cqId, const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NormalSqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag,
                                        uint32_t * const sqId, uint32_t * const cqId,
                                        uint32_t * const info, const uint32_t len,
                                        uint32_t * const msg, const uint32_t msgLen)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    UNUSED(drvFlag);
    UNUSED(info);
    UNUSED(len);
    UNUSED(msg);
    UNUSED(msgLen);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NormalSqCqFree(const uint32_t deviceId, const uint32_t tsId,
                                    const uint32_t drvFlag, const uint32_t sqId, const uint32_t cqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    UNUSED(drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqAllocate(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
    const bool isNeedFast, uint32_t &cqId, bool &isFastCq, const bool isCtrlSq)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(streamId);
    UNUSED(isNeedFast);
    UNUSED(cqId);
    UNUSED(isFastCq);
    UNUSED(isCtrlSq);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqAllocateV2(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
    uint32_t &cqId, const bool isDvppGrp, const uint32_t drvFlag)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(streamId);
    UNUSED(isDvppGrp);
    UNUSED(cqId);
    UNUSED(drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
    const uint32_t drvFlag)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(cqId);
    UNUSED(drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CtrlSqCqAllocate(const uint32_t deviceId, const uint32_t tsId,
                                      uint32_t * const sqId, uint32_t * const cqId, const uint32_t logicCqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    UNUSED(logicCqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CtrlSqCqFree(const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t sqId, const uint32_t cqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::VirtualCqAllocate(const uint32_t devId, const uint32_t tsId,
                                       uint32_t &sqId, uint32_t &cqId, uint8_t *&addr, bool &shmSqReadonly)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    UNUSED(addr);
    UNUSED(shmSqReadonly);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::VirtualCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t sqId, const uint32_t cqId)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DebugSqCqAllocate(const uint32_t deviceId, const uint32_t tsId,
                                       uint32_t &sqId, uint32_t &cqId)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(cqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EnableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DisableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CommandOccupy(const uint32_t sqId, rtTsCmdSqBuf_t ** const command,
                                   const uint32_t cmdCount, const uint32_t deviceId,
                                   const uint32_t tsId, uint32_t * const pos)
{
    UNUSED(sqId);
    UNUSED(command);
    UNUSED(cmdCount);
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(pos);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCommandOccupy(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                     rtHostFuncCommand_t ** const command, const uint32_t cnt)
{
    UNUSED(sqId);
    UNUSED(command);
    UNUSED(cnt);
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqTaskSend(const uint32_t sqId, rtStarsSqe_t * const sqe, const uint32_t deviceId,
                                const uint32_t tsId, const uint32_t sqeNum)
{
    UNUSED(sqId);
    UNUSED(sqe);
    UNUSED(sqeNum);
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CommandSend(const uint32_t sqId, const rtTsCmdSqBuf_t * const command, const uint32_t reportCount,
                                 const uint32_t deviceId, const uint32_t tsId, const uint32_t cmdCount)
{
    UNUSED(sqId);
    UNUSED(command);
    UNUSED(reportCount);
    UNUSED(cmdCount);
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqCommandSend(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                   rtHostFuncCommand_t * const command, const uint32_t cnt)
{
    UNUSED(sqId);
    UNUSED(command);
    UNUSED(cnt);
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DebugSqTaskSend(const uint32_t sqId, uint8_t *const sqe, const uint32_t deviceId,
                                     const uint32_t tsId)
{
    UNUSED(sqId);
    UNUSED(sqe);
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqReportV2(const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
    uint32_t &realCnt)
{
    UNUSED(waitInfo);
    UNUSED(report);
    UNUSED(reportCnt);
    UNUSED(realCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LogicCqReport(const LogicCqWaitInfo &waitInfo, rtLogicReport_t *&report, uint32_t &cnt)
{
    UNUSED(waitInfo);
    UNUSED(report);
    UNUSED(cnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DebugCqReport(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
                                   uint8_t *const report, uint32_t &realCnt)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(cqId);
    UNUSED(report);
    UNUSED(realCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CqReportIrqWait(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                                     const int32_t timeout, uint64_t * const getCqidList, const uint32_t cqidListNum)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(groupId);
    UNUSED(timeout);
    UNUSED(getCqidList);
    UNUSED(cqidListNum);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CqReportGet(const uint32_t deviceId, const uint32_t tsId, const uint32_t cqId,
                                 rtHostFuncCqReport_t ** const report, uint32_t * const cnt)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(cqId);
    UNUSED(report);
    UNUSED(cnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CqReportRelease(rtHostFuncCqReport_t * const report, const uint32_t deviceId,
                                     const uint32_t cqId, const uint32_t tsId, const bool noLog)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(cqId);
    UNUSED(report);
    UNUSED(noLog);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReportWait(void ** const report, int32_t * const cnt, const uint32_t deviceId,
                                const uint32_t tsId, const uint32_t cqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(cqId);
    UNUSED(report);
    UNUSED(cnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReportRelease(const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t cqId, const drvSqCqType_t type)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(cqId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqBackup(const uint32_t deviceId, uint32_t *sqIdGroup, const size_t sqIdCnt)
{
    UNUSED(deviceId);
    UNUSED(sqIdGroup);
    UNUSED(sqIdCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqRestore(const uint32_t deviceId, uint32_t *sqIdGroup, const size_t sqIdCnt)
{
    UNUSED(deviceId);
    UNUSED(sqIdGroup);
    UNUSED(sqIdCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QuerySq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
		             const uint32_t queryType, uint32_t &status)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(queryType);
    UNUSED(status);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqHead(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head, bool needLog)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(head);
    UNUSED(needLog);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqTail(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &tail)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(tail);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqEnable(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &enable)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(enable);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetCqeStatus(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &status)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(status);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetCtrlSqHead(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(head);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetSqHead(const uint32_t deviceId, const uint32_t tsId,
                               const uint32_t sqId, const uint32_t head)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(head);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CleanSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamUnBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                         const uint32_t streamId, const uint32_t logicCqId,
                                         const uint32_t drvFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(streamId);
    UNUSED(logicCqId);
    UNUSED(drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                       const uint32_t streamId, const uint32_t logicCqId,
                                       const uint32_t drvFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(streamId);
    UNUSED(logicCqId);
    UNUSED(drvFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamEnableStmSyncEsched(const uint32_t deviceId, const uint32_t tsId,
                                               const uint32_t streamId, const uint32_t grpId,
                                               const uint32_t eventId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(streamId);
    UNUSED(grpId);
    UNUSED(eventId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::UnbindHostPid(rtBindHostpidInfo info)
{
    UNUSED(info);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BindHostPid(rtBindHostpidInfo info)
{
    UNUSED(info);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SqSwitchStreamBatch(const uint32_t deviceId, struct sq_switch_stream_info *switchInfo,
    const uint32_t num)
{
    UNUSED(deviceId);
    UNUSED(switchInfo);
    UNUSED(num);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
    uint32_t *cpType)
{
    UNUSED(pid);
    UNUSED(chipId);
    UNUSED(vfId);
    UNUSED(hostPid);
    UNUSED(cpType);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num)
{
    UNUSED(name);
    UNUSED(sdid);
    UNUSED(pid);
    UNUSED(num);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid)
{
    UNUSED(name);
    UNUSED(sdid);
    UNUSED(pid);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ParseSDID(const uint32_t sdid, uint32_t *srvId, uint32_t *chipId, uint32_t *dieId, uint32_t *pyhId)
{
    UNUSED(sdid);
    UNUSED(srvId);
    UNUSED(chipId);
    UNUSED(dieId);
    UNUSED(pyhId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                               uint64_t * const addr, uint32_t * const len)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(addr);
    UNUSED(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint16_t moduleId, const uint32_t vaFlag)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(vaFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostMemFree(void * const dptr)
{
    UNUSED(dptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ManagedMemAlloc(void ** const dptr, const uint64_t size, const ManagedMemFlag flag,
                                     const uint32_t deviceId, const uint16_t moduleId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(flag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ManagedMemAllocInner(void ** const dptr, const uint64_t size, const ManagedMemFlag flag,
                                          const uint32_t deviceId, const uint16_t moduleId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(flag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ManagedMemFree(const void * const dptr)
{
    UNUSED(dptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocHugePageManaged(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool cpOnlyFlag)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(cpOnlyFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAlloc1GHugePage(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t memPolicy, const uint32_t deviceId, const uint16_t moduleId, const bool isLogError)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    UNUSED(isLogError);
    UNUSED(memPolicy);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocManaged(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool starsTillingFlag, const bool cpOnlyFlag) const
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(starsTillingFlag);
    UNUSED(cpOnlyFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocOnline(void ** const dptr, const uint64_t size, rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool starsTillingFlag, const bool isNewApi, const bool cpOnlyFlag)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(starsTillingFlag);
    UNUSED(cpOnlyFlag);
    UNUSED(isNewApi);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAllocHugePolicyPageOffline(void ** const dptr, const uint64_t size,
    const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId) const
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAllocPolicyOffline(void ** const dptr, const uint64_t size, const uint32_t memPolicy,
    const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId) const
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    UNUSED(memPolicy);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocOffline(void **dptr, const uint64_t size,
    rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId) const
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAlloc(void ** const dptr, const uint64_t size, const rtMemType_t type,const uint32_t deviceId,
    const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag, const bool starsTillingFlag, const bool isNewApi,
    const bool cpOnlyFlag)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(starsTillingFlag);
    UNUSED(cpOnlyFlag);
    UNUSED(isNewApi);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocConPhy(void ** const dptr, const uint64_t size,
                                       const rtMemType_t type, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemConPhyFree(void * const dptr, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevDvppMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint32_t flag, const uint16_t moduleId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(flag);
    UNUSED(moduleId);
    return RT_ERROR_NONE;
}

// malloc device mem for dvpp cmdlist, read-only, huge page first, milan only
rtError_t NpuDriver::DvppCmdListMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevContinuousMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevContinuousMemFree(void * const dptr, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocForPctrace(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemFreeForPctrace(const void * const dst)
{
    UNUSED(dst);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocCached(void ** const dptr, const uint64_t size,
    const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAllocEx(void ** const dptr, const uint64_t size, const rtMemType_t memType)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(memType);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemFreeEx(void * const dptr)
{
    UNUSED(dptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemFree(void * const dptr, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevSCMemFree(void * const dptr, const uint32_t deviceId)
{
    UNUSED(dptr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::AllocFastRingBufferAndDispatch(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint16_t moduleId)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(moduleId);
    return RT_ERROR_NONE;
}

void NpuDriver::FreeFastRingBuffer(void * const ptr, const uint64_t size, const uint32_t deviceId)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAddressTranslate(const int32_t deviceId, const uint64_t vptr, uint64_t * const pptr)
{
    UNUSED(vptr);
    UNUSED(pptr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGetInfo(const uint32_t deviceId, bool isHugeOnly, size_t * const freeSize, size_t * const totalSize)
{
    UNUSED(isHugeOnly);
    UNUSED(freeSize);
    UNUSED(deviceId);
    UNUSED(totalSize);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGetInfoByType(const uint32_t deviceId, const rtMemType_t type, rtMemInfo_t * const info)
{
    UNUSED(type);
    UNUSED(freeSize);
    UNUSED(info);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t deviceId)
{
    UNUSED(addrs);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(memType);
    UNUSED(checkResult);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                     const size_t inputNum, size_t * const outputNum)
{
    UNUSED(deviceId);
    UNUSED(memUsageInfo);
    UNUSED(inputNum);
    UNUSED(outputNum);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGetInfoEx(const uint32_t deviceId, const rtMemInfoType_t memInfoType,
                                  size_t * const freeSize, size_t * const totalSize)
{
    UNUSED(deviceId);
    UNUSED(memInfoType);
    UNUSED(freeSize);
    UNUSED(totalSize);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr)
{
    UNUSED(attributes);
    UNUSED(ptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes)
{
    UNUSED(attributes);
    UNUSED(ptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PtrGetRealLocation(const void * const ptr, rtMemLocationType &location, rtMemLocationType &realLocation)
{
    UNUSED(location);
    UNUSED(realLocation);
    UNUSED(ptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PcieHostRegister(void * const addr, const uint64_t size, const uint32_t deviceId, void *&outAddr)
{
    UNUSED(addr);
    UNUSED(size);
    UNUSED(deviceId);
    UNUSED(outAddr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PcieHostUnRegister(void * const addr, const uint32_t deviceId)
{
    UNUSED(addr);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

drvError_t NpuDriver::MemCopySyncAdapter(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t size, const rtMemcpyKind_t kind, const uint32_t devId)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(size);
    UNUSED(kind);
    UNUSED(devId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopySync(void * const dst, const uint64_t destMax, const void * const src,
                                 const uint64_t size, const rtMemcpyKind_t kind, bool errShow, uint32_t devId)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(size);
    UNUSED(kind);
    UNUSED(devId);
    UNUSED(errShow);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsync(void * const dst, const uint64_t destMax, const void * const src,
                                  const uint64_t size, const rtMemcpyKind_t kind, volatile uint64_t &copyFd)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(size);
    UNUSED(kind);
    UNUSED(copyFd);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsyncWaitFinish(const uint64_t copyFd)
{
    UNUSED(copyFd);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsyncWaitFinishEx(struct DMA_ADDR *dmaHandle)
{
    UNUSED(dmaHandle);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsyncEx(struct DMA_ADDR *dmaHandle)
{
    UNUSED(dmaHandle);
    return RT_ERROR_NONE;
}
rtError_t NpuDriver::MemCopy2D(void * const dst, const uint64_t dstPitch, const void * const src,
                               const uint64_t srcPitch, const uint64_t width, const uint64_t height,
                               const uint32_t kind, const uint32_t type, const uint64_t fixedSize,
                               struct DMA_ADDR * const dmaAddress)
{
    UNUSED(dst);
    UNUSED(dstPitch);
    UNUSED(src);
    UNUSED(srcPitch);
    UNUSED(width);
    UNUSED(height);
    UNUSED(kind);
    UNUSED(type);
    UNUSED(fixedSize);
    UNUSED(dmaAddress);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemcpyBatch(uint64_t dsts[], uint64_t srcs[], size_t sizes[], size_t count)
{
    UNUSED(dsts);
    UNUSED(srcs);
    UNUSED(sizes);
    UNUSED(count);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t deviceId)
{
    UNUSED(devPtr);
    UNUSED(len);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemSetSync(const void * const devPtr, const uint64_t destMax,
                                const uint32_t val, const uint64_t cnt)
{
    UNUSED(devPtr);
    UNUSED(destMax);
    UNUSED(val);
    UNUSED(cnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAdvise(void * const devPtr, const uint64_t cnt, const uint32_t advise, const uint32_t devid)
{
    UNUSED(devPtr);
    UNUSED(advise);
    UNUSED(devid);
    UNUSED(cnt);
    return RT_ERROR_NONE;
}

void NpuDriver::SetAllocNumaTsSupported()
{
    return;
}

rtError_t NpuDriver::Support1GHugePageCtrl()
{
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SupportNumaTsMemCtrl(int64_t &val)
{
    UNUSED(val);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CheckIfSupport1GHugePage()
{
    return RT_ERROR_NONE;
}

bool NpuDriver::CheckIfSupportNumaTs()
{
    return false;
}

rtError_t NpuDriver::GetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    UNUSED(deviceId);
    UNUSED(offset);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetC2cCtrlAddr(const int32_t deviceId, uint64_t * const addr, uint32_t * const len)
{
    UNUSED(deviceId);
    UNUSED(addr);
    UNUSED(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CheckSupportPcieBarCopy(const uint32_t deviceId, uint32_t &val, const bool need4KAsync)
{
    UNUSED(deviceId);
    UNUSED(val);
    UNUSED(need4KAsync);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAddrModuleId(void *memcpyAddr, uint32_t *moduleId)
{
    UNUSED(memcpyAddr);
    UNUSED(moduleId);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
