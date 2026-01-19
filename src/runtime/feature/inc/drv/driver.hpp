/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_DRIVER_HPP__
#define __CCE_RUNTIME_DRIVER_HPP__

#include <unordered_map>
#include <mutex>
#include <atomic>
#include <string>
#include <cstdlib>

#include "osal.hpp"
#include "feature_type.h"
#include "runtime/rt.h"
#include "base.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "securec.h"
#include "pool.hpp"
#include "hwts.hpp"
#include "stars.hpp"
#include "device_properties.h"

namespace cce {
namespace runtime {
using rtTsCmdSqBuf_t = union tagTsCmdSqBuf;
using rtTsCommandBuf_t = union tagTsCommandBuf;
using rtTsCommand_t = struct tagTaskTsCommand;
using rtTsReport_t = struct tagTsReportMsg;
using rtCommand_t = struct tagTsCommand;
using rtTaskReport_t = struct tagTsTaskReportMsg;
using rtHostFuncCommand_t = struct tagTsHostFuncSendMsg;
using rtHostFuncCqReport_t = struct tagTsHostFuncCqReportMsg;
using rtLogicReport_t = struct tagTsLogicCqReportMsg;
using rtShmQuery_t = struct tagTsShmTaskMsg;

class Cdq;

struct ipcMemInfo_t {
    std::string name;
    bool locked;
    int32_t ref;
};

struct LogicCqWaitInfo {
    uint32_t devId;
    uint32_t tsId;
    uint32_t cqId;
    bool isFastCq;
    int32_t timeout;    // ms, -1: wait forever; 0: no wait return
    uint32_t streamId;  // for v2
    uint32_t taskId;    // for v2
};

struct AsyncDmaWqeInputInfo {
    void *src;
    uint64_t size;
    uint32_t sqId;
    uint32_t tsId;
    uint32_t cpyType;
    union {
        void *destPtr;
        uint32_t sqe_pos;
    };
};

struct AsyncDmaWqeOutputInfo {
    union {
        struct {
            uint16_t dieId;
            uint16_t functionId;
            uint16_t jettyId;
            uint8_t *wqe;
            int32_t wqeLen;
        };
        struct DMA_ADDR dmaAddr;
    };
};

struct AsyncDmaWqeDestroyInfo {
    uint32_t tsId;
    uint32_t sqId;
    union {
        struct {
            uint8_t *wqe;
            int32_t size;
        };
        struct DMA_ADDR *dmaAddr;
    };
};

struct IpcNotifyOpenPara {
    const char_t *name;
    uint32_t flag;
    uint32_t localDevId;
    uint32_t localTsId;
};

// facade interface for driver.
class Driver : public NoCopy {
public:
    enum ManagedMemFlag {
        MANAGED_MEM_RW = 0,
        MANAGED_MEM_EX = 1,
    };

    Driver();
    ~Driver() override;

    // get offline mode or online mode from driver
    virtual uint32_t GetRunMode() = 0;
    virtual uint32_t GetAicpuDeploy() const = 0;

    // Get total device count accessable by current host.
    virtual rtError_t GetDeviceCount(int32_t * const cnt) = 0;

    // Get total chip count accessable by current host.
    virtual rtError_t GetChipCount(uint32_t * const cnt) = 0;
    virtual rtError_t GetChipList(uint32_t chipList[], const uint32_t cnt) = 0;
    virtual bool IsSupportFeature(RtOptionalFeatureType f) const = 0;
    virtual const DevProperties& GetDevProperties(void) const = 0;
    virtual rtError_t GetDeviceCountFromChip(const uint32_t chipId, uint32_t * const cnt) = 0;
    virtual rtError_t GetDeviceFromChip(const uint32_t chipId, uint32_t deviceList[], const uint32_t cnt) = 0;
    virtual rtError_t GetChipFromDevice(const uint32_t deviceId, uint32_t * const chipId) = 0;

    virtual rtError_t GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId) = 0;
    virtual rtError_t GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex) = 0;
    virtual rtError_t ParseSDID(const uint32_t sdid, uint32_t *srvId, uint32_t *chipId, uint32_t *dieId, uint32_t *pyhId) = 0;

    virtual rtError_t GetDeviceIDs(uint32_t * const deviceIds, const uint32_t len) = 0;

    // Alloc page-locked host memory.
    virtual rtError_t HostMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
        const uint16_t moduleId = MODULEID_RUNTIME, const uint32_t vaFlag = 0) = 0;
    virtual rtError_t AllocFastRingBufferAndDispatch(void ** const dptr, const uint64_t size, const uint32_t deviceId,
        const uint16_t moduleId = MODULEID_RUNTIME)  = 0;
    virtual void FreeFastRingBuffer(void * const ptr, const uint64_t size, const uint32_t deviceId) = 0;

    // Free host memory.
    virtual rtError_t HostMemFree(void * const dptr) = 0;

    // Alloc host shared memory.
    virtual rtError_t MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
        rtMallocHostSharedMemoryOut * const out, const uint32_t deviceId) = 0;

    // Free host shared memory.
    virtual rtError_t FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in, const uint32_t deviceId) = 0;

    // Register host memory.
    virtual rtError_t HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr,  const uint32_t deviceId) = 0;

    // Unegister host memory.
    virtual rtError_t HostUnregister(void *ptr,  const uint32_t deviceId) = 0;

    // Query host memory mapping capabilities.
    virtual rtError_t HostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability *capabilities) = 0;

    // Alloc specified memory.
    virtual rtError_t MemAllocEx(void ** const dptr, const uint64_t size, const rtMemType_t memType) = 0;

    // Free specified memory.
    virtual rtError_t MemFreeEx(void * const dptr) = 0;

    // alloc managed mem
    virtual rtError_t ManagedMemAlloc(void ** const dptr, const uint64_t size, const ManagedMemFlag flag,
        const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME) = 0;

    // free managed mem
    virtual rtError_t ManagedMemFree(const void * const dptr) = 0;

    virtual rtError_t MemAdvise(void *devPtr, uint64_t cnt, uint32_t advise, uint32_t devid) = 0;
    virtual rtError_t MemSetSync(const void * const devPtr, const uint64_t destMax,
                                 const uint32_t val, const uint64_t cnt) = 0;

    virtual rtError_t MemGetInfo(const uint32_t deviceId, bool isHugeOnly, size_t * const freeSize, size_t * const totalSize) = 0;

    virtual rtError_t MemGetInfoByType(const uint32_t deviceId, const rtMemType_t type, rtMemInfo_t * const info) = 0;

    virtual rtError_t CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t deviceId) = 0;

    virtual rtError_t GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                      const size_t inputNum, size_t * const outputNum) = 0;

    virtual rtError_t MemGetInfoEx(const uint32_t deviceId, const rtMemInfoType_t memInfoType,
                                   size_t * const freeSize, size_t * const totalSize) = 0;

    virtual rtError_t PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr) = 0;

    virtual rtError_t PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes) = 0;

    virtual rtError_t PtrGetRealLocation(const void * const ptr, rtMemLocationType &location, rtMemLocationType &realLocation) = 0;

    virtual rtError_t MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t deviceId) = 0;

    // Create IPC Memory
    virtual rtError_t CreateIpcMem(const void * const vptr, const uint64_t byteCount,
                                   char_t * const name, const uint32_t len) = 0;
                                   
    //set IPC Memory Attribute
    virtual rtError_t SetIpcMemAttr(const char *name, uint32_t type, uint64_t attr) = 0;

    // Open IPC Memory
    virtual rtError_t OpenIpcMem(const char_t * const name, uint64_t * const vptr, uint32_t devId) = 0;

    // Close IPC Memory
    virtual rtError_t CloseIpcMem(const uint64_t vptr) = 0;

    // Destroy IPC Memory
    virtual rtError_t DestroyIpcMem(const char_t * const name) = 0;

    // Ipc set notify pid
    virtual rtError_t SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num) = 0;

    // Ipc set mem pid
    virtual rtError_t SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num) = 0;
    // Synchronous memcpy.
    virtual rtError_t MemCopySync(void *dst, uint64_t destMax, const void *src, uint64_t size,
        rtMemcpyKind_t kind, bool errShow = true, uint32_t devId = INVALID_COPY_MODULEID) = 0;
    // Asynchronous memcpy.
    virtual rtError_t MemCopyAsync(void * const dst, const uint64_t destMax, const void * const src,
                                   const uint64_t size, const rtMemcpyKind_t kind, volatile uint64_t &copyFd) = 0;

    // Asynchronous memcpy wait finish.
    virtual rtError_t MemCopyAsyncWaitFinish(const uint64_t copyFd) = 0;

    virtual rtError_t MemCopyAsyncEx(struct DMA_ADDR *dmaHandle) = 0;
    virtual rtError_t MemCopyAsyncWaitFinishEx(struct DMA_ADDR *dmaHandle) = 0;

    // memcpy2D
    virtual rtError_t MemCopy2D(void * const dst, const uint64_t dstPitch, const void * const src,
                                const uint64_t srcPitch, const uint64_t width, const uint64_t height,
                                const uint32_t kind, const uint32_t type, const uint64_t fixedSize,
                                struct DMA_ADDR * const dmaAddress) = 0;

    // translate from virtual to physic
    virtual rtError_t MemAddressTranslate(const int32_t deviceId, const uint64_t vptr, uint64_t * const pptr) = 0;

    virtual rtError_t MemConvertAddr(const uint64_t src, const uint64_t dst, const uint64_t len,
                                     struct DMA_ADDR * const dmaAddress) = 0;

    virtual rtError_t MemDestroyAddr(struct DMA_ADDR * const ptr) = 0;

    virtual rtError_t GetTransWayByAddr(void * const src, void * const dst, uint8_t * const transType) = 0;

    // Realloc resource ID.
    virtual rtError_t ReAllocResourceId(const uint32_t deviceId, const uint32_t tsId, const uint32_t priority,
                                        const uint32_t resourceId, drvIdType_t idType) = 0;

    // Alloc stream ID.
    virtual rtError_t StreamIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                                    const uint32_t priority, uint32_t streamFlag = 0U) = 0;

    // Free stream ID.
    virtual rtError_t StreamIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t streamFlag = 0) = 0;

    // Alloc event ID.
    virtual rtError_t EventIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t eventFlag = 0, const bool createFlag = false) = 0;

    // Free event ID.
    virtual rtError_t EventIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t eventFlag = 0) = 0;

    // Alloc cmo ID.
    virtual rtError_t CmoIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId) = 0;

    // Free cmo ID.
    virtual rtError_t CmoIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId)  = 0;

    // Occupy command space for filling data.
    virtual rtError_t CommandOccupy(const uint32_t sqId, rtTsCmdSqBuf_t ** const command,
                                    const uint32_t cmdCount, const uint32_t deviceId,
                                    const uint32_t tsId, uint32_t * const pos) = 0;

    // Send command to driver with filled data.
    virtual rtError_t CommandSend(const uint32_t sqId, const rtTsCmdSqBuf_t * const command,
                                  const uint32_t reportCount, const uint32_t deviceId,
                                  const uint32_t tsId, const uint32_t cmdCount) = 0;

    // Send task to driver with filled data.
    virtual rtError_t SqTaskSend(const uint32_t sqId, rtStarsSqe_t * const sqe, const uint32_t deviceId,
                                 const uint32_t tsId, const uint32_t sqeNum) = 0;

    virtual rtError_t DebugSqTaskSend(const uint32_t sqId, uint8_t *const sqe, const uint32_t deviceId,
                                      const uint32_t tsId) = 0;

    // Wait report from driver. Blocked if no report.
    virtual rtError_t ReportWait(void ** const report, int32_t * const cnt, const uint32_t deviceId,
                                 const uint32_t tsId, const uint32_t cqId) = 0;

    // Release report to driver.
    virtual rtError_t ReportRelease(const uint32_t deviceId, const uint32_t tsId,
                                    const uint32_t cqId, const drvSqCqType_t type) = 0;

    virtual rtError_t NormalSqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag,
                                         uint32_t * const sqId, uint32_t * const cqId,
                                         uint32_t * const info, const uint32_t len,
                                         uint32_t * const msg, const uint32_t msgLen) = 0;
    virtual rtError_t NormalSqCqFree(const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag,
                                     const uint32_t sqId, const uint32_t cqId) = 0;

    virtual rtError_t SqSwitchStreamBatch(const uint32_t deviceId, struct sq_switch_stream_info *switchInfo,
        const uint32_t num) = 0;
    virtual rtError_t LogicCqAllocate(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
                                      const bool isNeedFast, uint32_t &cqId, bool &isFastCq, const bool isCtrlSq) = 0;

    virtual rtError_t LogicCqAllocateV2(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
        uint32_t &cqId, const bool isDvppGrp = false, const uint32_t drvFlag = 0U) =0;   // for stars

    virtual rtError_t LogicCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
        const uint32_t drvFlag = 0U) = 0;

    // Wait report from logic Cq.
    virtual rtError_t LogicCqReport(const LogicCqWaitInfo &waitInfo, rtLogicReport_t *&report, uint32_t &cnt) = 0;

    virtual rtError_t LogicCqReportV2(const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
        uint32_t &realCnt) = 0;
    virtual rtError_t CreateAsyncDmaWqe(uint32_t devId, const AsyncDmaWqeInputInfo &input, AsyncDmaWqeOutputInfo *output,
                                        bool isUbMode = true) = 0;
    virtual rtError_t DestroyAsyncDmaWqe(uint32_t devId, struct AsyncDmaWqeDestroyInfo *para, bool isUbMode = true) = 0;
    virtual rtError_t WriteNotifyRecord(const uint32_t deviceId, const uint32_t tsId, const uint32_t notifyId) = 0;
    virtual rtError_t DebugCqReport(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
                                    uint8_t *const report, uint32_t &realCnt) = 0;
    // Alloc device global memory.
    virtual rtError_t DevMemAlloc(void ** const dptr, const uint64_t size, const rtMemType_t type,
                                  const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME,
                                  const bool isLogError = true, const bool readOnlyFlag = false,
                                  const bool starsTillingFlag = false, const bool isNewApi = false,
                                  const bool cpOnlyFlag = false) = 0;

    // Alloc contiguous memory
    virtual rtError_t DevMemAllocConPhy(void ** const dptr, const uint64_t size,
                                        const rtMemType_t type, const uint32_t deviceId) = 0;

    // Free contiguous memory
    virtual rtError_t DevMemConPhyFree(void * const dptr, const uint32_t deviceId) = 0;

    // Alloc device global memory for dvpp.
    virtual rtError_t DevDvppMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
        const uint32_t flag, const uint16_t moduleId = MODULEID_RUNTIME) = 0;

    virtual rtError_t DvppCmdListMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId) = 0;

    // Alloc device Continuous memory.
    virtual rtError_t DevContinuousMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId) = 0;

    // free system cache memory
    virtual rtError_t DevSCMemFree(void *dptr, uint32_t deviceId) = 0;

    virtual rtError_t DevMemAllocHugePageManaged(void ** const dptr, const uint64_t size,
        const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME,
        const bool isLogError = true, const bool readOnlyFlag = false, const bool cpOnlyFlag = false) = 0;

    virtual rtError_t DevMemAlloc1GHugePage(void ** const dptr, const uint64_t size, const rtMemType_t type,
        const uint32_t memPolicy, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME,
        const bool isLogError = true) = 0;
    // Alloc pctrace memory
    virtual rtError_t DevMemAllocForPctrace(void ** const dptr, const uint64_t size, const uint32_t deviceId) = 0;

    // Free device global memory.
    virtual rtError_t DevMemFree(void * const dptr, const uint32_t deviceId) = 0;
    // Free device Continuous memory.
    virtual rtError_t DevContinuousMemFree(void * const dptr, const uint32_t deviceId) = 0;
    // Free pctrace memory
    virtual rtError_t DevMemFreeForPctrace(const void * const dst) = 0;
    // Alloc cached memory.
    virtual rtError_t DevMemAllocCached(void ** const dptr, const uint64_t size,
        const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    // Flush Cache
    virtual rtError_t DevMemFlushCache(const uint64_t base, const size_t len) = 0;
    // Invalid Cache
    virtual rtError_t DevMemInvalidCache(const uint64_t base, const size_t len) = 0;
    // Function for dev open
    virtual rtError_t DeviceOpen(const uint32_t deviceId, const uint32_t tsId, uint32_t * const ssId) = 0;

    // Function for host dev close
    virtual rtError_t HostDeviceClose(const uint32_t deviceId) = 0;
    // Function for dev close
    virtual rtError_t DeviceClose(const uint32_t deviceId, const uint32_t tsId) = 0;

    // get device info
    virtual rtError_t GetDevInfo(const uint32_t deviceId, const int32_t moduleType,
                                 const int32_t infoType, int64_t * const val) = 0;

    virtual rtError_t GetStarsInfo(const uint32_t deviceId, const uint32_t tsId, uint64_t &addr) = 0;
    virtual rtError_t GetTsfwVersion(const uint32_t deviceId, const uint32_t tsId, uint32_t &version,
        uint32_t &isSupportHcomcpu) = 0;

    // get phy device info
    virtual rtError_t GetPhyDevInfo(const uint32_t phyId, const int32_t moduleType,
                                    const int32_t infoType, int64_t * const val) = 0;

    // get notify id
    virtual rtError_t NotifyIdAlloc(const int32_t deviceId, uint32_t * const id, const uint32_t tsId,
                                    const uint32_t notifyFlag = 0, const bool isCountNotify = false, const bool isEvent = false) = 0;
    // free notify id
    virtual rtError_t NotifyIdFree(const int32_t deviceId, const uint32_t id, const uint32_t tsId,
                                   const uint32_t notifyFlag = 0, const bool isCountNotify = false) = 0;
    // Create IPC Notify
    virtual rtError_t CreateIpcNotify(char_t * const name, const uint32_t len, const int32_t devId,
                                      uint32_t * const notifyId, const uint32_t tsId,
                                      const uint32_t notifyFlag = 0) = 0;

    // Destroy IPC Notify
    virtual rtError_t DestroyIpcNotify(const char_t * const name, const int32_t devId,
                                       const uint32_t notifyId, const uint32_t tsId) = 0;

    // Open IPC Notify
    virtual rtError_t OpenIpcNotify(const IpcNotifyOpenPara &openPara, uint32_t * const phyId,
        uint32_t * const notifyId, uint32_t * const tsId, uint32_t * const isPod) = 0;

    // Close IPC Notify
    virtual rtError_t CloseIpcNotify(const char_t * const name, const int32_t devId,
                                     const uint32_t notifyId, const uint32_t tsId) = 0;

    virtual rtError_t NotifyGetAddrOffset(const int32_t deviceId, const uint32_t notifyId,
                                          uint64_t * const devAddrOffset, const uint32_t tsId) = 0;

    // Alloc model ID.
    virtual rtError_t ModelIdAlloc(int32_t *id, const uint32_t deviceId, const uint32_t tsId) = 0;

    // Free model ID.
    virtual rtError_t ModelIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId) = 0;

    // Get fast memory virtual addr
    virtual rtError_t LoadProgram(const int32_t devId, void * const prog, const uint32_t offset,
                                  const uint64_t size, void ** const vPtr) = 0;

    virtual rtError_t DeviceGetBareTgid(uint32_t * const pid) const = 0;

    virtual rtError_t SqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                                   uint32_t * const sqId, uint32_t * const cqId) = 0;

    virtual rtError_t DebugSqCqAllocate(const uint32_t deviceId, const uint32_t tsId, uint32_t &sqId,
                                        uint32_t &cqId) = 0;

    virtual rtError_t SqCqFree(const uint32_t sqId, const uint32_t cqId, const uint32_t deviceId,
                               const uint32_t tsId) = 0;

    virtual rtError_t CtrlSqCqAllocate(const uint32_t deviceId, const uint32_t tsId,
                                       uint32_t * const sqId, uint32_t * const cqId, const uint32_t logicCqId) = 0;

    virtual rtError_t CtrlSqCqFree(const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t sqId, const uint32_t cqId) = 0;

    virtual rtError_t VirtualCqAllocate(const uint32_t devId, const uint32_t tsId,
                                        uint32_t &sqId, uint32_t &cqId, uint8_t *&addr, bool &shmSqReadonly) = 0;

    virtual rtError_t VirtualCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t sqId,
                                    const uint32_t cqId) = 0;

    virtual rtError_t CqReportIrqWait(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                                      const int32_t timeout, uint64_t * const getCqidList,
                                      const uint32_t cqidListNum) = 0;

    virtual rtError_t CqReportGet(const uint32_t deviceId, const uint32_t tsId, const uint32_t cqId,
                                  rtHostFuncCqReport_t ** const report, uint32_t * const cnt) = 0;

    virtual rtError_t CqReportRelease(rtHostFuncCqReport_t * const report, const uint32_t deviceId,
                                      const uint32_t cqId, const uint32_t tsId, const bool noLog = false) = 0;

    virtual rtError_t SqCommandOccupy(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                      rtHostFuncCommand_t ** const command, const uint32_t cnt) = 0;

    virtual rtError_t SqCommandSend(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                    rtHostFuncCommand_t * const command, const uint32_t cnt) = 0;

    virtual rtError_t EnableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId) = 0;

    virtual rtError_t DisableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId) = 0;

    virtual rtError_t SetSqHead(const uint32_t deviceId, const uint32_t tsId,
                                const uint32_t sqId, const uint32_t head) = 0;

    virtual rtError_t SetSqTail(const uint32_t deviceId, const uint32_t tsId,
                                const uint32_t sqId, const uint32_t tail) = 0;

    virtual rtError_t GetSqHead(const uint32_t deviceId, const uint32_t tsId,
                                const uint32_t sqId, uint16_t &head, bool needLog = true) = 0;

    virtual rtError_t CleanSq(const uint32_t deviceId, const uint32_t tsId,
                              const uint32_t sqId) = 0;

    virtual rtError_t TaskKill(const uint32_t deviceId, const uint32_t tsId,
                               const uint32_t sqId, const uint32_t operationType) = 0;

    virtual rtError_t QueryOpExecTimeoutInterval(const uint32_t deviceId, const uint32_t tsId,
        uint64_t &timeoutInterval) = 0;

    virtual rtError_t TaskAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
                                      const uint32_t targetId, uint32_t &result) = 0;

    virtual rtError_t QueryAbortStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
                                             const uint32_t targetId, uint32_t &status) = 0;

    virtual rtError_t RecoverAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
                                         const uint32_t targetId, uint32_t &result) = 0;

    virtual rtError_t QueryRecoverStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
                                               const uint32_t targetId, uint32_t &status) = 0;

    virtual rtError_t QuerySq(const uint32_t deviceId, const uint32_t tsId,
                              const uint32_t sqId, const uint32_t queryType, uint32_t &status) = 0;

    virtual rtError_t GetCtrlSqHead(const uint32_t deviceId, const uint32_t tsId,
                                    const uint32_t sqId, uint16_t &head) = 0;

    virtual rtError_t GetSqTail(const uint32_t deviceId, const uint32_t tsId,
                                const uint32_t sqId, uint16_t &tail) = 0;

    virtual rtError_t GetSqAddrInfo(const uint32_t deviceId, const uint32_t tsId,
                                    const uint32_t sqId, uint64_t &sqAddr) = 0;
    virtual rtError_t GetSqEnable(const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t sqId, bool &enable) = 0;

    virtual rtError_t StreamBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                        const uint32_t streamId, uint32_t logicCqId,
                                        const uint32_t drvFlag = 0U) = 0;

    virtual rtError_t StreamUnBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                          const uint32_t streamId, uint32_t logicCqId,
                                          const uint32_t drvFlag = 0U) = 0;

    virtual rtError_t GetChipCapability(const uint32_t deviceId, struct halCapabilityInfo * const info) = 0;

    virtual rtError_t GetCapabilityGroupInfo(const int32_t deviceId, const int32_t ownerId, const int32_t groupId,
                                             struct capability_group_info * const groupInfo,
                                             const int32_t groupCount) = 0;

    virtual rtError_t GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId,
                                         const int32_t infoType, int64_t * const val, const bool deviceFlag = false) = 0;
    virtual bool CheckIfSupportNumaTs() = 0;
    virtual bool CheckIfSupportDsaUpdate() = 0;
    virtual int32_t SupportNumaTsMemCtrl(int64_t &val) = 0;
    virtual void SetAllocNumaTsSupported() = 0;

    virtual rtError_t GetL2CacheOffset(uint32_t deviceId, uint64_t *offset) = 0;
    virtual rtError_t GetC2cCtrlAddr(const int32_t deviceId, uint64_t * const addr, uint32_t * const len) = 0;
    virtual rtError_t GetSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                                uint64_t * const addr, uint32_t * const len) = 0;
    virtual rtError_t UnmapSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId) = 0;
    virtual rtError_t CheckSupportPcieBarCopy(const uint32_t deviceId, uint32_t &val,
        const bool need4KAsync = true) = 0;
    virtual rtError_t GetAvailEventNum(const uint32_t deviceId, const uint32_t tsId, uint32_t * const eventCount) = 0;
    virtual rtError_t PcieHostRegister(void *addr, uint64_t size, const uint32_t deviceId, void *&outAddr) = 0;

    virtual rtError_t PcieHostUnRegister(void *addr, const uint32_t deviceId) = 0;

    virtual rtError_t HostAddrRegister(void * const addr, const uint64_t size, const uint32_t deviceId) = 0;

    virtual rtError_t HostAddrUnRegister(void * const addr, const uint32_t deviceId) = 0;

    virtual rtError_t GetCqeStatus(const uint32_t deviceId, const uint32_t tsId,
                                   const uint32_t sqId, bool &status) = 0;
    virtual rtError_t GetDeviceStatus(uint32_t devId, drvStatus_t * const status) = 0;

    virtual drvError_t MemCopySyncAdapter(void * const dst, const uint64_t destMax, const void * const src,
        const uint64_t size, const rtMemcpyKind_t kind, const uint32_t devId) = 0;
    virtual rtError_t ResourceReset(const uint32_t deviceId, const uint32_t tsId, drvIdType_t type) = 0;
    virtual rtError_t GetAddrModuleId(void *memcpyAddr, uint32_t *moduleId) = 0;
    virtual rtError_t SqArgsCopyWithUb(uint32_t devId, struct halSqTaskArgsInfo *sqArgs) = 0;
    virtual rtError_t ResetSqCq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, 
        const uint32_t streamFlag) = 0;
    virtual rtError_t ResetLogicCq(const uint32_t deviceId, const uint32_t tsId, const uint32_t logicCqId,
        const uint32_t streamFlag) = 0;
    virtual rtError_t StopSqSend(const uint32_t deviceId, const uint32_t tsId) = 0;
    virtual rtError_t ResumeSqSend(const uint32_t deviceId, const uint32_t tsId) = 0;
    virtual rtError_t StreamTaskFill(uint32_t devId, uint32_t streamId, void *streamMem,
        void *taskInfo, uint32_t taskCnt) = 0;
    // dqs
    virtual rtError_t GetDqsQueInfo(const uint32_t devId, const uint32_t qid, DqsQueueInfo *queInfo) = 0;
    virtual rtError_t GetDqsMbufPoolInfo(const uint32_t poolId, DqsPoolInfo *dqsPoolInfo) = 0;
    uint32_t vfId_{MAX_UINT32_NUM};
protected:
    // CallBack
    rtKernelReportCallback callBack_;
};

// Device Independent Driver
class FacadeDriver : public NoCopy {
public:
    FacadeDriver() = default;
    ~FacadeDriver() override = default;

    rtError_t GetDeviceCount(int32_t * const deviceCount) const;
    rtError_t GetDeviceIDs(uint32_t * const devices, const uint32_t len) const;
};

typedef Driver *(*DriverGetInsFunc_t)();
enum driverType_t {
    NPU_DRIVER,
    STUB_DRIVER,
    CPU_DRIVER,
    MAX_DRIVER_NUM,
};
class DriverFactory {
public:
    DriverFactory();
    ~DriverFactory();
    Driver *GetDriver(const driverType_t type);
    static bool RegDriver(const driverType_t type, const DriverGetInsFunc_t func);

private:
    std::atomic<Driver *> drivers_[MAX_DRIVER_NUM];
    std::mutex m;
};

rtError_t GetConnectUbFlagFromDrv(bool &connectUbFlag);
rtError_t InitDrvEventThread(const uint32_t deviceId);
}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_DRIVER_HPP__
