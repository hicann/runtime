/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_NPU_DRIVER_HPP
#define CCE_RUNTIME_NPU_DRIVER_HPP

#include "driver.hpp"
#include "runtime/mem.h"
#include "securec.h"
#include "dev_info_manage.h"
#include <unordered_set>
#include "driver/ascend_hal.h"
#include "npu_driver_base.hpp"

namespace cce {
namespace runtime {
// Real driver
class NpuDriver : public Driver {
public:
    NpuDriver();
    ~NpuDriver() override = default;

    // get offline mode or online mode from driver
    uint32_t GetRunMode() override;
    static uint32_t RtGetRunMode();
    uint32_t GetAicpuDeploy() const override;

    // Get total device count accessable by current host.
    rtError_t GetDeviceCount(int32_t * const cnt) override;

    rtError_t GetChipCount(uint32_t * const cnt) override;
    rtError_t GetChipList(uint32_t chipList[], const uint32_t cnt) override;
    rtError_t GetDeviceCountFromChip(const uint32_t chipId, uint32_t * const cnt) override;
    rtError_t GetDeviceFromChip(const uint32_t chipId, uint32_t deviceList[], const uint32_t cnt) override;
    rtError_t GetChipFromDevice(const uint32_t deviceId, uint32_t * const chipId) override;
    bool IsSupportFeature(RtOptionalFeatureType f) const override;
    const DevProperties& GetDevProperties(void) const override;
    rtError_t GetDeviceIDs(uint32_t * const deviceIds, const uint32_t len) override;

    // Alloc page-locked host memory.
    rtError_t HostMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
        const uint16_t moduleId = MODULEID_RUNTIME, const uint32_t vaFlag = 0) override;
    rtError_t AllocFastRingBufferAndDispatch(void ** const dptr, const uint64_t size, const uint32_t deviceId,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    void FreeFastRingBuffer(void * const ptr, const uint64_t size, const uint32_t deviceId) override;

    // Free host memory.
    rtError_t HostMemFree(void * const dptr) override;

    // Alloc host shared memory.
    rtError_t MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
        rtMallocHostSharedMemoryOut * const out, const uint32_t deviceId) override;

    // Free host shared memory.
    rtError_t FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in, const uint32_t deviceId) override;

    // Register host memory.
    rtError_t HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr,  const uint32_t deviceId) override;

    // Unegister host memory.
    rtError_t HostUnregister(void *ptr,  const uint32_t deviceId) override;

    // Alloc specified memory.
    rtError_t MemAllocEx(void ** const dptr, const uint64_t size, const rtMemType_t memType) override;

    // Free specified memory.
    rtError_t MemFreeEx(void * const dptr) override;

    // alloc managed mem
    rtError_t ManagedMemAlloc(void ** const dptr, const uint64_t size, const ManagedMemFlag flag,
        const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME) override;

    // free managed mem
    rtError_t ManagedMemFree(const void * const dptr) override;

    rtError_t MemSetSync(const void * const devPtr, const uint64_t destMax,
                         const uint32_t val, const uint64_t cnt) override;

    rtError_t MemAdvise(void * const devPtr, const uint64_t cnt, const uint32_t advise, const uint32_t devid) override;

    rtError_t MemGetInfo(const uint32_t deviceId, bool isHugeOnly, size_t * const freeSize, size_t * const totalSize) override;

    rtError_t MemGetInfoByType(const uint32_t deviceId, const rtMemType_t type, rtMemInfo_t * const info) override;

    rtError_t CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t deviceId) override;

    rtError_t GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                              const size_t inputNum, size_t * const outputNum) override;

    rtError_t MemGetInfoEx(const uint32_t deviceId, const rtMemInfoType_t memInfoType,
                           size_t * const freeSize, size_t * const totalSize) override;

    rtError_t PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr) override;

    rtError_t PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes) override;

    rtError_t PtrGetRealLocation(const void * const ptr, rtMemLocationType &location, rtMemLocationType &realLocation) override;

    rtError_t MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t deviceId) override;

    // Create IPC Memory
    rtError_t CreateIpcMem(const void * const vptr, const uint64_t byteCount,
                           char_t * const name, const uint32_t len) override;

    //set IPC Memory Attribute
    rtError_t SetIpcMemAttr(const char *name, uint32_t type, uint64_t attr) override;

    // Open IPC Memory
    rtError_t OpenIpcMem(const char_t * const name, uint64_t * const vptr, uint32_t devId) override;

    // Close IPC Memory
    rtError_t CloseIpcMem(const uint64_t vptr) override;

    // Destroy IPC Memory
    rtError_t DestroyIpcMem(const char_t * const name) override;

    // Synchronous memcpy.
    rtError_t MemCopySync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t size,
        const rtMemcpyKind_t kind, bool errShow = true, uint32_t devId = INVALID_COPY_MODULEID) override;

    // Asynchronous memcpy.
    rtError_t MemCopyAsync(void * const dst, const uint64_t destMax, const void * const src,
                           const uint64_t size, const rtMemcpyKind_t kind, volatile uint64_t &copyFd) override;

    // Asynchronous memcpy wait finish.
    rtError_t MemCopyAsyncWaitFinish(const uint64_t copyFd) override;

    rtError_t MemCopyAsyncEx(struct DMA_ADDR *dmaHandle) override;
    rtError_t MemCopyAsyncWaitFinishEx(struct DMA_ADDR *dmaHandle) override;

    // memcpy2D.
    rtError_t MemCopy2D(void * const dst, const uint64_t dstPitch, const void * const src,
                        const uint64_t srcPitch, const uint64_t width, const uint64_t height,
                        const uint32_t kind, const uint32_t type, const uint64_t fixedSize,
                        struct DMA_ADDR * const dmaAddress) override;

    // translate from virtual to physic
    rtError_t MemAddressTranslate(const int32_t deviceId, const uint64_t vptr, uint64_t * const pptr) override;

    rtError_t MemConvertAddr(const uint64_t src, const uint64_t dst, const uint64_t len,
                             struct DMA_ADDR * const dmaAddress) override;

    rtError_t MemDestroyAddr(struct DMA_ADDR * const ptr) override;

    rtError_t GetTransWayByAddr(void * const src, void * const dst, uint8_t * const transType) override;

    // Realloc resource ID.
    rtError_t ReAllocResourceId(const uint32_t deviceId, const uint32_t tsId, const uint32_t priority,
                                const uint32_t resourceId, drvIdType_t idType) override;

    // Alloc stream ID.
    rtError_t StreamIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                            const uint32_t priority, uint32_t streamFlag = 0U) override;

    // Free stream ID.
    rtError_t StreamIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                           const uint32_t streamFlag = 0) override;

    // Alloc event ID.
    rtError_t EventIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId,
                           const uint32_t eventFlag = 0, const bool createFlag = false) override;

    // Free event ID.
    rtError_t EventIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId,
                           const uint32_t eventFlag = 0) override;

    // Alloc cmo ID.
    rtError_t CmoIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId) override;

    // Free cmo ID.
    rtError_t CmoIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId) override;

    // Occupy command space for filling data.
    rtError_t CommandOccupy(const uint32_t sqId, rtTsCmdSqBuf_t ** const command,
                            const uint32_t cmdCount, const uint32_t deviceId,
                            const uint32_t tsId, uint32_t * const pos) override;

    // Send command to driver with filled data.
    rtError_t CommandSend(const uint32_t sqId, const rtTsCmdSqBuf_t * const command, const uint32_t reportCount,
                          const uint32_t deviceId, const uint32_t tsId, const uint32_t cmdCount) override;

    rtError_t SqTaskSend(const uint32_t sqId, rtStarsSqe_t * const sqe, const uint32_t deviceId,
                         const uint32_t tsId, const uint32_t sqeNum) override;

    rtError_t DebugSqTaskSend(const uint32_t sqId, uint8_t *const sqe, const uint32_t deviceId,
                              const uint32_t tsId) override;

    // Wait report from driver. Blocked if no report.
    rtError_t ReportWait(void ** const report, int32_t * const cnt, const uint32_t deviceId,
                         const uint32_t tsId, const uint32_t cqId) override;

    // Release report to driver.
    rtError_t ReportRelease(const uint32_t deviceId, const uint32_t tsId,
                            const uint32_t cqId, const drvSqCqType_t type) override;

    rtError_t NormalSqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag,
                                 uint32_t * const sqId, uint32_t * const cqId,
                                 uint32_t * const info, const uint32_t len,
                                 uint32_t * const msg, const uint32_t msgLen) override;
    rtError_t NormalSqCqFree(const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag,
                             const uint32_t sqId, const uint32_t cqId) override;

    rtError_t SqSwitchStreamBatch(const uint32_t deviceId, struct sq_switch_stream_info *switchInfo,
        const uint32_t num) override;
    rtError_t LogicCqAllocate(const uint32_t devId, const uint32_t tsId, const uint32_t streamId, const bool isNeedFast,
        uint32_t &cqId, bool &isFastCq, const bool isCtrlSq) override;

    rtError_t LogicCqAllocateV2(const uint32_t devId, const uint32_t tsId, const uint32_t streamId,
        uint32_t &cqId, const bool isDvppGrp = false, const uint32_t drvFlag = 0U) override;   // for stars

    rtError_t LogicCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
        const uint32_t drvFlag = 0U) override;

    // Wait report from logic Cq
    rtError_t LogicCqReport(const LogicCqWaitInfo &waitInfo, rtLogicReport_t *&report, uint32_t &cnt) override;

    rtError_t LogicCqReportV2(const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
        uint32_t &realCnt) override;

    rtError_t CreateAsyncDmaWqe(uint32_t devId, const AsyncDmaWqeInputInfo &input, AsyncDmaWqeOutputInfo *output,
                                bool isUbMode = true) override;
    rtError_t DestroyAsyncDmaWqe(uint32_t devId, struct AsyncDmaWqeDestroyInfo *destroyPara,
                                bool isUbMode = true) override;

    rtError_t DebugCqReport(const uint32_t devId, const uint32_t tsId, const uint32_t cqId,
                            uint8_t *const report, uint32_t &realCnt) override;

    // Alloc device global memory.
    rtError_t DevMemAlloc(void ** const dptr, const uint64_t size, const rtMemType_t type,
                          const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME,
                          const bool isLogError = true, const bool readOnlyFlag = false,
                          const bool starsTillingFlag = false, const bool isNewApi = false,
                          const bool cpOnlyFlag = false) override;

    // Alloc contiguous memory.
    rtError_t DevMemAllocConPhy(void ** const dptr, const uint64_t size,
                                const rtMemType_t type, const uint32_t deviceId) override;

    // free contiguous memory
    rtError_t DevMemConPhyFree(void * const dptr, const uint32_t deviceId) override;

    // Alloc device Continuous memory.
    rtError_t DevContinuousMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId) override;
    // Alloc device global memory for dvpp.
    rtError_t DevDvppMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
        const uint32_t flag, const uint16_t moduleId = MODULEID_RUNTIME) override;

    rtError_t DvppCmdListMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId) override;

    // free system cache memory
    rtError_t DevSCMemFree(void * const dptr, const uint32_t deviceId) override;

    rtError_t DevMemAllocHugePageManaged(void ** const dptr, const uint64_t size,
        const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME,
        const bool isLogError = true, const bool readOnlyFlag = false, const bool cpOnlyFlag = false) override;

    rtError_t DevMemAlloc1GHugePage(void ** const dptr, const uint64_t size, const rtMemType_t type,
        const uint32_t memPolicy, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME,
        const bool isLogError = true) override;

    // Alloc pctrace memory
    rtError_t DevMemAllocForPctrace(void ** const dptr, const uint64_t size, const uint32_t deviceId) override;

    // Free device global memory.
    rtError_t DevMemFree(void * const dptr, const uint32_t deviceId) override;
    // Free device Continuous memory.
    rtError_t DevContinuousMemFree(void * const dptr, const uint32_t deviceId) override;
    // Free pctrace memory
    rtError_t DevMemFreeForPctrace(const void * const dst) override;
    // Alloc cached memory.
    rtError_t DevMemAllocCached(void ** const dptr, const uint64_t size,
        const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME) override;
    // Flush Cache
    rtError_t DevMemFlushCache(const uint64_t base, const size_t len) override;
    // Invalid Cache
    rtError_t DevMemInvalidCache(const uint64_t base, const size_t len) override;
    // Function for dev open
    rtError_t DeviceOpen(const uint32_t deviceId, const uint32_t tsId, uint32_t * const ssId) override;

    static rtError_t ProcessResBackup();
    static rtError_t ProcessResRestore();
    // Function for host dev close
    rtError_t HostDeviceClose(const uint32_t deviceId) override;

    // Function for dev close
    rtError_t DeviceClose(const uint32_t deviceId, const uint32_t tsId) override;

    // get device info
    rtError_t GetDevInfo(const uint32_t deviceId, const int32_t moduleType,
                         const int32_t infoType, int64_t * const val) override;

    rtError_t GetStarsInfo(const uint32_t deviceId, const uint32_t tsId, uint64_t &addr) override;
    rtError_t GetTsfwVersion(const uint32_t deviceId, const uint32_t tsId, uint32_t &version,
        uint32_t &isSupportHcomcpu) override;

    // get phy device info
    rtError_t GetPhyDevInfo(const uint32_t phyId, const int32_t moduleType,
                            const int32_t infoType, int64_t * const val) override;

    // alloc notify id
    rtError_t NotifyIdAlloc(const int32_t deviceId, uint32_t * const id, const uint32_t tsId,
                            const uint32_t notifyFlag = 0, const bool isCountNotify = false, const bool isEvent = false) override;
    // free notify id
    rtError_t NotifyIdFree(const int32_t deviceId, const uint32_t id, const uint32_t tsId,
                           const uint32_t notifyFlag = 0, const bool isCountNotify = false) override;
    // Create IPC Notify
    rtError_t CreateIpcNotify(char_t * const name, const uint32_t len, const int32_t devId,
                              uint32_t * const notifyId, const uint32_t tsId,
                              const uint32_t notifyFlag = 0) override;

    // Destroy IPC Notify
    rtError_t DestroyIpcNotify(const char_t * const name, const int32_t devId,
                               const uint32_t notifyId, const uint32_t tsId) override;

    // Open IPC Notify
    rtError_t OpenIpcNotify(const IpcNotifyOpenPara &openPara, uint32_t * const phyId,
        uint32_t * const notifyId, uint32_t * const tsId, uint32_t * const isPod) override;

    // Close IPC Notify
    rtError_t CloseIpcNotify(const char_t * const name, const int32_t devId,
                             const uint32_t notifyId, const uint32_t tsId) override;

    // Ipc set notify pid
    rtError_t SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num) override;

    // Ipc set mem pid
    rtError_t SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num) override;

    // get addr notify
    rtError_t NotifyGetAddrOffset(const int32_t deviceId, const uint32_t notifyId,
                                  uint64_t * const devAddrOffset, const uint32_t tsId) override;

    // Alloc model ID.
    rtError_t ModelIdAlloc(int32_t * const id, const uint32_t deviceId, const uint32_t tsId) override;

    // Free model ID.
    rtError_t ModelIdFree(const int32_t id, const uint32_t deviceId, const uint32_t tsId) override;

    // Get fast memory virtual addr
    rtError_t LoadProgram(const int32_t devId, void * const prog, const uint32_t offset,
                          const uint64_t size, void ** const vPtr) override;

    rtError_t GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId) override;

    rtError_t GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex) override;

    static rtError_t DeviceGetPhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId);
    static rtError_t DeviceGetIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex);
    static rtError_t EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag);
    static rtError_t DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc);
    static rtError_t DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t dev, const uint32_t peerDevice);
    static rtError_t GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status);
    static rtError_t SetIpcNotifyDisablePidVerify(const char *const name);
    static rtError_t GetIpcNotifyPeerPhyDevId(const char *const name, uint32_t *const peerPhyDevId);
    static rtError_t GetPhyDevIdByIpcMemName(const char *name, uint32_t *const phyDevId);
    static rtError_t SetMemShareHandleDisablePidVerify(uint64_t shareableHandle);
    static rtError_t GetPhyDevIdByMemShareHandle(uint64_t shareableHandle, uint32_t *const peerPhyDevId);
    rtError_t DeviceGetBareTgid(uint32_t * const pid) const override;
    static Driver *Instance_();

    rtError_t SqCqAllocate(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                           uint32_t * const sqId, uint32_t * const cqId) override;

    rtError_t DebugSqCqAllocate(const uint32_t deviceId, const uint32_t tsId, uint32_t &sqId,
                                uint32_t &cqId) override;

    rtError_t SqCqFree(const uint32_t sqId, const uint32_t cqId, const uint32_t deviceId,
                       const uint32_t tsId) override;

    rtError_t CtrlSqCqAllocate(const uint32_t deviceId, const uint32_t tsId,
                               uint32_t * const sqId, uint32_t * const cqId, const uint32_t logicCqId) override;

    rtError_t CtrlSqCqFree(const uint32_t deviceId, const uint32_t tsId,
                           const uint32_t sqId, const uint32_t cqId) override;

    rtError_t VirtualCqAllocate(const uint32_t devId, const uint32_t tsId,
                                uint32_t &sqId, uint32_t &cqId, uint8_t *&addr, bool &shmSqReadonly) override;

    rtError_t VirtualCqFree(const uint32_t devId, const uint32_t tsId, const uint32_t sqId,
                            const uint32_t cqId) override;

    rtError_t CqReportIrqWait(const uint32_t deviceId, const uint32_t tsId, const uint32_t groupId,
                              const int32_t timeout, uint64_t * const getCqidList,
                              const uint32_t cqidListNum) override;

    rtError_t CqReportGet(const uint32_t deviceId, const uint32_t tsId, const uint32_t cqId,
                          rtHostFuncCqReport_t ** const report, uint32_t * const cnt) override;
    rtError_t CqReportRelease(rtHostFuncCqReport_t * const report, const uint32_t deviceId,
                              const uint32_t cqId, const uint32_t tsId, const bool noLog = false) override;

    rtError_t SqCommandOccupy(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                              rtHostFuncCommand_t ** const command, const uint32_t cnt) override;

    rtError_t SqCommandSend(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                            rtHostFuncCommand_t * const command, const uint32_t cnt) override;

    rtError_t EnableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId) override;

    rtError_t DisableSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId) override;

    rtError_t SetSqHead(const uint32_t deviceId, const uint32_t tsId,
                        const uint32_t sqId, const uint32_t head) override;

    rtError_t SetSqTail(const uint32_t deviceId, const uint32_t tsId,
                        const uint32_t sqId, const uint32_t tail) override;

    rtError_t CleanSq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId) override;

    rtError_t TaskKill(const uint32_t deviceId, const uint32_t tsId,
		       const uint32_t sqId, const uint32_t operationType) override;

    rtError_t QueryOpExecTimeoutInterval(const uint32_t deviceId, const uint32_t tsId,
        uint64_t &timeoutInterval) override;

    rtError_t TaskAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
                              const uint32_t targetId, uint32_t &result) override;

    rtError_t QueryAbortStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
                                     const uint32_t targetId, uint32_t &status) override;

    rtError_t RecoverAbortByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
                                 const uint32_t targetId, uint32_t &result) override;

    rtError_t QueryRecoverStatusByType(const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
                                       const uint32_t targetId, uint32_t &status) override;

    rtError_t QuerySq(const uint32_t deviceId, const uint32_t tsId,
                      const uint32_t sqId, const uint32_t queryType, uint32_t &status) override;

    rtError_t GetSqHead(const uint32_t deviceId, const uint32_t tsId,
                        const uint32_t sqId, uint16_t &head, bool needLog = true) override;

    rtError_t GetCtrlSqHead(const uint32_t deviceId, const uint32_t tsId,
                            const uint32_t sqId, uint16_t &head) override;

    rtError_t GetSqTail(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &tail) override;
    rtError_t GetSqAddrInfo(
        const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint64_t &sqAddr) override;
    rtError_t GetSqEnable(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &enable) override;

    rtError_t StreamBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                const uint32_t streamId, const uint32_t logicCqId,
                                const uint32_t drvFlag = 0U) override;

    rtError_t StreamUnBindLogicCq(const uint32_t deviceId, const uint32_t tsId,
                                  const uint32_t streamId, const uint32_t logicCqId,
                                  const uint32_t drvFlag = 0U) override;

    rtError_t GetChipCapability(const uint32_t deviceId, struct halCapabilityInfo * const info) override;

    rtError_t GetCapabilityGroupInfo(const int32_t deviceId, const int32_t ownerId, const int32_t groupId,
                                     struct capability_group_info * const groupInfo,
                                     const int32_t groupCount) override;

    rtError_t WriteNotifyRecord(const uint32_t deviceId, const uint32_t tsId, const uint32_t notifyId) override;
    rtError_t GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId,
                                 const int32_t infoType, int64_t * const val, const bool deviceFlag = false) override;                            
    bool CheckIfSupportNumaTs() override;
    bool CheckIfSupportDsaUpdate() override;
    rtError_t SupportNumaTsMemCtrl(int64_t &val) override;
    void SetAllocNumaTsSupported() override;
    rtError_t GetL2CacheOffset(uint32_t deviceId, uint64_t *offset) override;
    rtError_t GetC2cCtrlAddr(const int32_t deviceId, uint64_t * const addr, uint32_t * const len) override;
    rtError_t GetSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId,
                                        uint64_t * const addr, uint32_t * const len) override;
    rtError_t UnmapSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId) override;
    rtError_t GetAvailEventNum(const uint32_t deviceId, const uint32_t tsId, uint32_t * const eventCount) override;
    rtError_t CheckSupportPcieBarCopy(const uint32_t deviceId, uint32_t &val, const bool need4KAsync = true) override;

    rtError_t PcieHostRegister(void *const addr, const uint64_t size, const uint32_t deviceId, void *&outAddr) override;

    rtError_t PcieHostUnRegister(void * const addr, const uint32_t deviceId) override;

    rtError_t HostAddrRegister(void * const addr, const uint64_t size, const uint32_t deviceId) override;

    rtError_t HostAddrUnRegister(void * const addr, const uint32_t deviceId) override;

    rtError_t GetCqeStatus(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &status) override;

    // mbuff queue api
    static rtError_t MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr, uint32_t * const qid);
    static rtError_t MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName);
    static rtError_t MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName);
    static rtError_t MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid);
    static rtError_t MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName);
    static rtError_t MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
        const rtMemQueueSetInputPara * const input);
    static rtError_t MemQueueDestroy(const int32_t devId, const uint32_t qid);
    static rtError_t MemQueueInit(const int32_t devId);
    static rtError_t MemQueueReset(const int32_t devId, const uint32_t qid);
    static rtError_t MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const memBuf);
    static rtError_t MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const memBuf);
    static rtError_t MemQueuePeek(const int32_t devId, const uint32_t qid, size_t *const bufLen, const int32_t timeout);
    static rtError_t MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid,
                                         const rtMemQueueBuff_t * const inBuf, const int32_t timeout);
    static rtError_t MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid,
                                         const rtMemQueueBuff_t * const outBuf, const int32_t timeout);
    static rtError_t MemQueueQueryInfo(const int32_t devId, const uint32_t qid, rtMemQueueInfo_t * const queInfo);
    static rtError_t MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd,
                                   const void * const inBuff, const uint32_t inLen,
                                   void * const outBuff, const uint32_t * const outLen);
    static rtError_t MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
                                   const rtMemQueueShareAttr_t * const attr);
    static rtError_t MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeout);
    static rtError_t EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
                                           rtEschedEventReply_t * const ack);
    static rtError_t QueryDevPid(const rtBindHostpidInfo_t * const info, int32_t * const devPid);
    static rtError_t MbufInit(rtMemBuffCfg_t * const cfg);
    static rtError_t BuffAlloc(const uint64_t size, void **buff);
    static rtError_t BuffConfirm(void * const buff, const uint64_t size);
    static rtError_t MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t *mbufPtr);
    static rtError_t MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size);
    static rtError_t MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size, const uint64_t flag,
        const int32_t grpId);
    static rtError_t BuffFree(void * const buff);
    static rtError_t MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size);
    static rtError_t MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size);
    static rtError_t MbufPut(const rtMbufPtr_t mbufPtr, void * const buff);
    static rtError_t MbufFree(rtMbufPtr_t const memBuf);
    static rtError_t MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len);
    static rtError_t MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len);
    static rtError_t MbufGetBuffAddr(const rtMbufPtr_t memBuf, void ** const buf);
    static rtError_t MbufGetBuffSize(const rtMbufPtr_t memBuf, uint64_t * const totalSize);
    static rtError_t MbufGetPrivInfo(const rtMbufPtr_t memBuf, void ** const priv, uint64_t * const size);
    static rtError_t MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr);
    static rtError_t MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf);
    static rtError_t MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num);
    static rtError_t MbufChainGetMbuf(const rtMbufPtr_t memBufChainHead, const uint32_t index,
                                      rtMbufPtr_t * const memBuf);
    static rtError_t MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg);
    static rtError_t MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
        const rtMemGrpCacheAllocPara *const para);
    static rtError_t BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
        void * const outBuff, uint32_t * const outLen);
    static rtError_t MemGrpAddProc(const char_t *const name, const int32_t pid, const rtMemGrpShareAttr_t *const attr);
    static rtError_t MemGrpAttach(const char_t * const name, const int32_t timeout);
    static rtError_t MemGrpQuery(const rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output);
    static rtError_t MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId);
    static rtError_t QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId);
    static rtError_t QueueSubscribe(const int32_t devId, const uint32_t qId,
                                    const uint32_t groupId, const int32_t type);
    static rtError_t BufEventTrigger(const char_t * const name);

    static rtError_t EschedAttachDevice(const uint32_t devId);
    static rtError_t EschedDettachDevice(const uint32_t devId);
    static rtError_t EschedWaitEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
                                     const int32_t timeout, rtEschedEventSummary_t * const evt);
    static rtError_t EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type);
    static rtError_t EschedSubmitEvent(const int32_t devId, const rtEschedEventSummary_t * const evt);
    static rtError_t EschedSubscribeEvent(const int32_t devId, const uint32_t grpId,
                                          const uint32_t threadId, const uint64_t eventBitmap);
    static rtError_t EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
                                    const uint32_t subeventId, char_t * const msg, const uint32_t len);
    static rtError_t GetMaxStreamAndTask(const uint32_t deviceId, const uint32_t tsId, uint32_t *const maxStrCount);
    static rtError_t GetAvailStreamNum(const uint32_t deviceId, const uint32_t tsId, uint32_t *const streamCount);
    static rtError_t GetMaxModelNum(const uint32_t deviceId, const uint32_t tsId, uint32_t *maxModelCount);
    static rtError_t GetDeviceAicpuStat(const uint32_t deviceId);
    static rtError_t GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util);

    static rtError_t StreamEnableStmSyncEsched(const uint32_t deviceId, const uint32_t tsId,
                                               const uint32_t streamId, const uint32_t grpId,
                                               const uint32_t eventId);
    static rtError_t EschedCreateGrpEx(const uint32_t devId, const uint32_t maxThreadNum, uint32_t *const grpId);
    static drvError_t DrvEschedManage(const uint32_t devId, const int32_t timeout, const uint32_t eschedTid,
                                      const uint32_t grpId, struct halReportRecvInfo *info);
    rtError_t GetDeviceStatus(uint32_t devId, drvStatus_t * const status) override;
    static rtError_t HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t *const server);
    static rtError_t HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
        rtHdcSession_t * const session);
    static rtError_t HdcSessionClose(rtHdcSession_t const session);
    static rtError_t HdcServerDestroy(rtHdcServer_t const server);
    static rtError_t EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
                                     rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut);
    static rtError_t ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags);
    static rtError_t ReleaseMemAddress(void* devPtr);
    static rtError_t MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags);
    static rtError_t FreePhysical(rtDrvMemHandle handle);
    static rtError_t MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle);
    static rtError_t MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop);
    static rtError_t MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags);
    static rtError_t UnmapMem(void* devPtr);
    static rtError_t MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count);
    static rtError_t MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags);
    static rtError_t GetServerIdAndshareableHandle(rtMemSharedHandleType handleType,
        const void *sharehandle, uint32_t *serverId, uint64_t *shareableHandle);
    static rtError_t GetServerId(const uint32_t deviceId, int64_t *const serverId);
    static rtError_t ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
        uint64_t flags, uint64_t *shareableHandle);
    static rtError_t ExportToShareableHandleV2(
        rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle);
    static rtError_t ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle);
    static rtError_t ImportFromShareableHandleV2(
        const void *shareableHandle, rtMemSharedHandleType handleType, int32_t devId, rtDrvMemHandle *handle);
    static rtError_t GetHostID(uint32_t *hostId);
    static rtError_t SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum);
    static rtError_t GetAllocationGranularity(const rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option, size_t *granularity);
    static rtError_t BindHostPid(rtBindHostpidInfo info);
    static rtError_t UnbindHostPid(rtBindHostpidInfo info);
    static rtError_t QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
        uint32_t *cpType);
    static rtError_t MemQEventCrossDevSupported(int32_t * const isSupported);
    static rtError_t GetFaultEvent(const int32_t deviceId, const rtDmsEventFilter * const filter, rtDmsFaultEvent *dmsEvent,
        uint32_t len, uint32_t *eventCount);
    static rtError_t GetAllFaultEvent(const uint32_t deviceId, rtDmsFaultEvent * const dmsEvent,
        uint32_t len, uint32_t *eventCount);
    static rtError_t ReadFaultEvent(
        const int32_t deviceId, uint32_t timeout, const rtDmsEventFilter * const filter, rtDmsFaultEvent *dmsEvent);
    static rtError_t GetRasSyscnt(const uint32_t deviceId, RtHbmRasInfo *hbmRasInfo);
    static rtError_t GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo);
    static rtError_t GetSmmuFaultValid(uint32_t deviceId, bool &isValid);
    static rtError_t MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo);
    static bool CheckIsSupportFeature(uint32_t devId, int32_t featureType);
    static rtError_t CheckIfSupport1GHugePage();
    static rtError_t ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid);
    rtError_t ParseSDID(const uint32_t sdid, uint32_t *srvId, uint32_t *chipId, uint32_t *dieId, uint32_t *pyhId) override;
    static rtError_t ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num);
    static rtError_t UpdateAddrVA2PA(uint64_t devAddr, uint64_t len);
    static rtError_t QueryUbInfo(const uint32_t deviceId, rtUbDevQueryCmd cmd, void * const devInfo);
    static rtError_t GetDevResAddress(const uint32_t deviceId, const rtDevResInfo * const resInfo,
                                      uint64_t *resAddr, uint32_t *resLen);
    static rtError_t ReleaseDevResAddress(const uint32_t deviceId, const rtDevResInfo * const resInfo);
    static rtError_t MemcpyBatch(uint64_t dsts[], uint64_t srcs[], size_t sizes[], size_t count);
    static rtError_t GetDeviceInfoByBuff(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
        void * const buf, int32_t * const size);
    static rtError_t SetDeviceInfoByBuff(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
        void * const buf, const int32_t size);
    drvError_t MemCopySyncAdapter(void * const dst, const uint64_t destMax, const void * const src,
        const uint64_t size, const rtMemcpyKind_t kind, const uint32_t devId) override;
    rtError_t ResourceReset(const uint32_t deviceId, const uint32_t tsId, drvIdType_t type) override;
    rtError_t GetAddrModuleId(void *memcpyAddr, uint32_t *moduleId) override;
    static rtError_t Support1GHugePageCtrl();
    rtError_t SqArgsCopyWithUb(uint32_t devId, struct halSqTaskArgsInfo *sqArgs) override;
    rtError_t ResetSqCq(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId,
        const uint32_t streamFlag) override;
    rtError_t ResetLogicCq(const uint32_t deviceId, const uint32_t tsId, const uint32_t logicCqId,
        const uint32_t streamFlag) override;
    rtError_t StopSqSend(const uint32_t deviceId, const uint32_t tsId) override;
    rtError_t ResumeSqSend(const uint32_t deviceId, const uint32_t tsId) override;
    rtError_t StreamTaskFill(uint32_t devId, uint32_t streamId, void *streamMem,
        void *taskInfo, uint32_t taskCnt) override;
    static rtError_t GetPageFaultCount(const uint32_t deviceId, uint32_t * const value);

    // dqs
    rtError_t GetDqsQueInfo(const uint32_t devId, const uint32_t qid, DqsQueueInfo *queInfo) override;
    rtError_t GetDqsMbufPoolInfo(const uint32_t poolId, DqsPoolInfo *dqsPoolInfo) override;

    static rtError_t SqBackup(const uint32_t deviceId, uint32_t *sqIdGroup, const size_t sqIdCnt);
    static rtError_t SqRestore(const uint32_t deviceId, uint32_t *sqIdGroup, const size_t sqIdCnt);
private:
    rtError_t ManagedMemAllocInner(void **const dptr, const uint64_t size, const ManagedMemFlag flag,
        const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME);
    rtError_t DevMemAllocManaged(void **const dptr, const uint64_t size, const rtMemType_t type,
        const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME, const bool isLogError = true,
        const bool readOnlyFlag = false, const bool starsTillingFlag = false, const bool cpOnlyFlag = false) const;
    rtError_t DevMemAllocOnline(void **const dptr, const uint64_t size, rtMemType_t type, const uint32_t deviceId,
        const uint16_t moduleId = MODULEID_RUNTIME, const bool isLogError = true, const bool readOnlyFlag = false,
        const bool starsTillingFlag = false, const bool isNewApi = false, const bool cpOnlyFlag = false);
    rtError_t DevMemAllocOffline(void **dptr, const uint64_t size, rtMemType_t type, const uint32_t deviceId,
        const uint16_t moduleId = MODULEID_RUNTIME) const;
    rtError_t MemAllocHugePolicyPageOffline(void ** const dptr, const uint64_t size,
        const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME) const;

    rtError_t MemAllocPolicyOffline(void ** const dptr, const uint64_t size, const uint32_t memPolicy,
        const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId = MODULEID_RUNTIME) const;

    rtError_t transMemAttribute(const uint32_t memPolicy, rtMemType_t * const type) const;

    rtError_t CreateIpcNotifyWithFlag(char_t * const name, const uint32_t len, const int32_t devId,
        uint32_t * const notifyId, const uint32_t tsId, const uint32_t notifyFlag) const;

    rtError_t GetSqRegVirtualAddrBySqidForStarsV2(const int32_t deviceId, const uint32_t tsId,
        const uint32_t sqId, uint64_t * const addr) const;
    
    std::unordered_set<RtOptionalFeatureType> featureSet_;
    DevProperties properties_;
    rtChipType_t chipType_ = CHIP_END;
    uint32_t runMode_ = static_cast<uint32_t>(RT_RUN_MODE_RESERVED);
    uint32_t aicpuDeploy_ = static_cast<uint32_t>(AICPU_DEPLOY_RESERVED);
    bool isTscOpen_ = false;
    bool isTsvOpen_ = false;
    int64_t envType_ = 3;  // 0:FPGA 1:EMU 2:ESL 3:ASIC
    drvStatus_t drvStatus_ = DRV_STATUS_INITING;
    Atomic<uint32_t> sqHeadRetryMaxNum_{0U};
    Atomic<uint32_t> sqHeadQueryFailNum_{0U};
    Atomic<uint32_t> sqTailRetryMaxNum_{0U};
    Atomic<uint32_t> sqTailQueryFailNum_{0U};
    int64_t sysMode_ = 0;
    int64_t addrMode_ = 0;
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_NPU_DRIVER_HPP
