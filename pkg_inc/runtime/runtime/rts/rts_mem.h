/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_MEM_H
#define CCE_RUNTIME_RTS_MEM_H

#include "base.h"
#include "mem.h"
#include "mem_base.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define RT_IPC_MEM_FLAG_DEFAULT                       0x0UL
#define RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL
#define RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS     0x1UL

#define RT_VMM_FLAG_DEFAULT                           0x0UL
#define RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION     0x1UL

/**
 * @ingroup rts_mem
 * @brief synchronized memcpy2D
 * @param [in] params   memcpy2D params info
 * @param [in] config   extended parameter
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemcpy2D(rtMemcpy2DParams_t *params, rtMemcpyConfig_t *config);

/**
 * @ingroup rts_mem
 * @brief asynchronized memcpy2D
 * @param [in] params   memcpy2D params info
 * @param [in] config   extended parameter
 * @param [in] stm      asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemcpy2DAsync(rtMemcpy2DParams_t *params, rtMemcpyConfig_t *config, rtStream_t stm);

/**
 * @ingroup rts_mem
 * @brief get current device memory total and free
 * @param [in] memInfoType
 * @param [out] freeSize
 * @param [out] totalSize
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsMemGetInfo(rtMemInfoType memInfoType, size_t *freeSize, size_t *totalSize);

/**
 * @ingroup rts_mem
 * @brief synchronized memcpy
 * @param [in] dst      destination address pointer
 * @param [in] destMax  length of destination address memory
 * @param [in] src      source address pointer
 * @param [in] cnt      the number of byte to copy
 * @param [in] kind     memcpy type
 * @param [in] config   memcpy config
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind kind,
    rtMemcpyConfig_t *config);

/**
 * @ingroup rts_mem
 * @brief asynchronized memcpy
 * @param [in] dst      destination address pointer
 * @param [in] destMax  length of destination address memory
 * @param [in] src      source address pointer
 * @param [in] cnt      the number of byte to copy
 * @param [in] kind     memcpy type
 * @param [in] config   memory copy config  
 * @param [in] stm      asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemcpyAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind kind,
    rtMemcpyConfig_t *config, rtStream_t stm);

/**
 * @ingroup rts_mem
 * @brief get memcpy desc size
 * @param [in]  kind memcpy type
 * @param [out] descSize desc size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetMemcpyDescSize(rtMemcpyKind kind, size_t *descSize);

/**
 * @ingroup rts_mem
 * @brief set memcpy desc
 * @param [in] desc     memcpy desc address
 * @param [in] kind     memcpy type
 * @param [in] srcAddr  source address pointer
 * @param [in] dstAddr  destination address pointer
 * @param [in] count    the number of byte to copy
 * @param [in] config   memory copy config
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetMemcpyDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, void *srcAddr, void *dstAddr,
    size_t count, rtMemcpyConfig_t *config);

/**
 * @ingroup rts_mem
 * @brief use desc to do memcpy
 * @param [in] desc   memcpy desc address
 * @param [in] kind   memcpy type
 * @param [in] config memory copy config
 * @param [in] stm    stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemcpyAsyncWithDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, rtMemcpyConfig_t *config,
    rtStream_t stream);
/**
 * @ingroup rts_mem
 * @brief launch common cmo task on the stream.
 * @param [in] srcAddrPtr     prefetch addrs
 * @param [in] srcLen         prefetch addrs load
 * @param [in] cmoType        opcode   
 * @param [in] stm            stream
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, rtStream_t stm);

/**
 * @ingroup rts_mem
 * @brief launch common cmo task  on the stream.
 * @param [in] srcAddrPtr     prefetch addrs
 * @param [in] srcLen         prefetch addrs load
 * @param [in] cmoType        opcode  
 * @param [in] logicId        logic barrier Id. >0 valid Id, =0 invalid id
 * @param [in] stm            stream
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsCmoAsyncWithBarrier(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, uint32_t logicId, rtStream_t stm);

/**
 * @ingroup rts_mem
 * @brief launch cmo task on the stream.
 * @param [in] taskCfg     task config info
 * @param [in] stm         stream
 * @param [in] reserve     reserve param
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsLaunchCmoTask(rtCmoTaskCfg_t *taskCfg, rtStream_t stm, const void *reserve);

/**
 * @ingroup rts_mem
 * @brief alloc device memory
 * @param [in|out] devPtr   memory pointer
 * @param [in] size         memory size
 * @param [in] policy       memory policy
 * @param [in] advise       memory advise, such as TS,DVPP
 * @param [in] cfg   memory attributes config, such ModuleId, DeviceId
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMalloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg);

/**
 * @ingroup rts_mem
 * @brief free device memory
 * @param [in|out] devPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsFree(void *devPtr);

/**
 * @ingroup rts_mem
 * @brief This command is used to export an allocation to a shareable handle.
 * @attention Only support ONLINE scene. Not support compute group.
 * @param [in] handle Handle for the memory allocation.
 * @param [in] handleType Currently unused, must be MEM_HANDLE_TYPE_NONE.
 * @param [in] flags  flags for this operation. The valid flags are:
 *         RT_VMM_FLAG_DEFAULT : Default behavior.
 *         RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION : Remove the whitelist verification for PID.
 * @param [out] shareableHandle Export a shareable handle.
 * @return DRV_ERROR_NONE : success
 * @return DV_ERROR_XXX : fail
 */
RTS_API rtError_t rtsMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle);

/**
* @ingroup rts_mem
* @brief This command is used to configure the process whitelist which can use shareable handle.
* @attention Only support ONLINE scene. Not support compute group.
* @param [in] shareableHandle A shareable handle.
* @param [in] pid Host pid whitelist array.
* @param [in] pid_num Number of pid arrays.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtsMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum);

/**
* @ingroup rts_mem
* @brief This command is used to import an allocation from a shareable handle.
* @attention Only support ONLINE scene. Not support compute group.
* @param [in] shareableHandle Import a shareable handle.
* @param [in] devId Device id.
* @param [out] handle Value of handle returned, all operations on this allocation are to be performed using this handle.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtsMemImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle);

/**
* @ingroup rts_mem
* @brief This command is used to calculate either the minimal or recommended granularity.
* @attention Only support ONLINE scene.
* @param [in] prop Properties of the allocation.
* @param [in] option Determines which granularity to return.
* @param [out] granularity Returned granularity.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtsMemGetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity);

/**
 * @ingroup rts_mem
 * @brief set memory with uint32_t value
 * @param [in] devPtr
 * @param [in] destMax length of destination address memory
 * @param [in] val
 * @param [in] cnt byte num
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemset(void *devPtr, uint64_t destMax, uint32_t val, uint64_t cnt);

/**
 * @ingroup rts_mem
 * @brief set memory with uint32_t value async
 * @param [in] devPtr
 * @param [in] destMax length of destination address memory
 * @param [in] val
 * @param [in] cnt byte num
 * @param [in] stm
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMemsetAsync(void *ptr, uint64_t destMax, uint32_t val, uint64_t cnt, rtStream_t stm);

/**
 * @ingroup rts_mem
 * @brief This command is used to reserve a virtual address range
 * @attention Only support ONLINE scene
 * @param [in] virPtr Resulting pointer to start of virtual address range allocated.
 * @param [in] size Size of the reserved virtual address range requested.
 * @param [in] policy mem policy.
 * @param [in] expectAddr Expected virtual address space start address Currently, Currently unused, must be zero.
 * @param [in] cfg Memory appication configuration, Currently unused, must be nullptr.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsMemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr, rtMallocConfig_t *cfg);

/**
 * @ingroup rts_mem
 * @brief This command is used to free a virtual address range reserved by halMemAddressReserve.
 * @attention Only support ONLINE scene.
 * @param [in] virPtr Pointer to the address of the virtual memory to be released.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsMemFreeAddress(void** virPtr);

/**
 * @ingroup rts_mem
 * @brief This command is used to alloc physical memory.
 * @attention Only support ONLINE scene.
 * @param [out] handle Value of handle returned,all operations on this allocation are to be performed using this handle.
 * @param [in] size Size of the allocation requested.
 * @param [in] policy mem policy.
 * @param [in] cfg Memory appication configuration.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsMemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg);

/**
 * @ingroup rts_mem
 * @brief This command is used to free physical memory.
 * @attention Only support ONLINE scene.
 * @param [in] handle Value of handle which was returned previously by halMemCreate.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsMemFreePhysical(rtMemHandle* handle);

/**
 * @ingroup rts_mem
 * @brief This command is used to map an allocation handle to a reserved virtual address range.
 * @attention Only support ONLINE scene.
 * @param [in] virPtr Address where memory will be mapped.
 * @param [in] size Size of the memory mapping.
 * @param [in] offset Currently unused, must be zero.
 * @param [in] handle Value of handle which was returned previously by halMemCreate.
 * @param [in] flag Currently unused, must be zero.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsMemMap(void* virPtr, size_t size, size_t offset, rtMemHandle handle, uint64_t flags);

/**
 * @ingroup rts_mem
 * @brief This command is used to unmap the backing memory of a given address range.
 * @attention Only support ONLINE scene.
 * @param [in] devPtr Starting address for the virtual address range to unmap.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsMemUnmap(void* virPtr);

/**
 * @ingroup rts_mem
 * @brief alloc host memory
 * @param [in|out] hostPtr   memory pointer
 * @param [in] size   memory size
 * @param [in] cfg alloc memory config, only support module id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsMallocHost(void **hostPtr, uint64_t size, const rtMallocConfig_t *cfg);

/**
 * @ingroup rts_mem
 * @brief free host memory
 * @param [in] hostPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsFreeHost(void *hostPtr);

/**
 * @ingroup rts_mem
 * @brief get memory attribute:Host or Device
 * @param [in] ptr
 * @param [out] attributes
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsPointerGetAttributes(const void *ptr, rtPtrAttributes_t *attributes);

/**
 * @ingroup rts_mem
 * @brief flush device mempory
 * @param [in] base   virtal base addr
 * @param [in] len    memory size
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsMemFlushCache(void *base, size_t len);

/**
 * @ingroup rts_mem
 * @brief invalid device mempory
 * @param [in] base   virtal base addr
 * @param [in] len    memory size
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsMemInvalidCache(void *base, size_t len);

/**
 * @ingroup rts_mem
 * @brief alloc host shared memory
 * @param ptr    memory pointer
 * @param size   memory size
 * @param type   memory register type
 * @param devPtr memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsHostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr);

/**
 * @ingroup rts_mem
 * @brief register an existing host memory range
 * @param ptr    memory pointer to memory to page-lock
 * @param size   size in bytes of the address range to page-lock in bytes
 * @param flag   flag for allocation input
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag);

/**
 * @ingroup rts_mem
 * @brief free host shared memory
 * @param ptr    memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsHostUnregister(void *ptr);

/**
 * @ingroup rts_mem
 * @brief return device pointer of mapped host memory registered by rtHostRegisterV2
 * @param pDevice   return device pointer for mapped memory
 * @param pHost     requested host pointer mapping
 * @param flag      flag for extensions (must be 0 for now)
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag);

/*
 * @brief get cmo desc size
 * @param [out] size cmo desc size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetCmoDescSize(size_t *size);

/**
 * @ingroup rts_mem
 * @brief set cmo desc
 * @param [in] cmoDes   cmo desc address
 * @param [in] srcAddr  source address ptr
 * @param [in] srcLen   src mem Length
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen);

/**
 * @ingroup rts_mem
 * @brief launch com addr task by com Desc
 * @param [in] cmoDesc   cmo desc ptr
 * @param [in] stm    stream
 * @param [in] cmoOpCode    cmo op code
 * @param [in] reserve  reserve param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stm, rtCmoOpCode cmoOpCode, const void *reserve);

/**
 * @ingroup rts_model
 * @brief launch reduce async task
 * @param [in] reduceInfo  reduce task info
 * @param [in] stm  associated stream
 * @param [in] reserve  reserve param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve);

/**
 * @ingroup dvrt_dev
 * @brief enable direction:devIdDes---->phyIdSrc.
 * @param [in] devIdDes   the logical device id
 * @param [in] phyIdSrc   the physical device id
 * @param [in] flag       reserved
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag);

/**
 * @ingroup dvrt_dev
 * @brief disable direction:devIdDes---->phyIdSrc.
 * @param [in] devIdDes   the logical device id
 * @param [in] phyIdSrc   the physical device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc);

/**
 * @ingroup dvrt_dev
 * @brief get cability of P2P omemry copy betwen device and peeredevic.
 * @param [in] devId   the logical device id
 * @param [in] peerDevice   the physical device id
 * @param [out] *canAccessPeer   1:enable 0:disable
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceCanAccessPeer(uint32_t devId, uint32_t peerDevice, int32_t *canAccessPeer);

/**
 * @ingroup dvrt_dev
 * @brief get status
 * @param [in] devIdDes   the logical device id
 * @param [in] phyIdSrc   the physical device id
 * @param [in|out] status   status value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status);

 /**
 * @ingroup rts_mem
 * @brief make memory shared interprocess and get key
 * @param [in] ptr    device memory address pointer
 * @param [in] size   identification byteCount
 * @param [out] key   identification key
 * @param [in] len    key length
 * @param [in] flags   flags for this operation. The valid flags are:
 *         RT_IPC_MEM_FLAG_DEFAULT : Default behavior.
 *         RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION : Remove the whitelist verification for PID.     
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsIpcMemGetExportKey(const void *ptr, size_t size, char_t *key, uint32_t len, uint64_t flags);

/**
 * @ingroup rts_mem
 * @brief destroy a interprocess shared memory
 * @param [in] key   identification key
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsIpcMemClose(const char_t *key);

/**
 * @ingroup rts_mem
 * @brief open a interprocess shared memory
 * @param [in|out] ptr  device memory address pointer
 * @param [in] key  identification key
 * @param [in] flags flags for this operation. The valid flags are:
 *         RT_IPC_MEM_FLAG_DEFAULT : Default behavior.
 *         RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS : Enables direct access to memory allocations on a peer device.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsIpcMemImportByKey(void **ptr, const char_t *key, uint64_t flags);

/**
 * @ingroup rts_mem
 * @brief Ipc set mem pid
 * @param [in] key  key to be queried
 * @param [in] pid  process id
 * @param [in] num  length of pid[]
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsIpcMemSetImportPid(const char_t *key, int32_t pid[], int num);

/**
 * @ingroup rts_mem
 * @brief Check mem type
 * @param [in] addrs  Memory address array
 * @param [in] size  Memory address array size
 * @param [in] memType  Memory type
 * @param [out] checkResult  result of check
 * @param [in] reserve  reserve to be used
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsCheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve);

/**
 * @ingroup dvrt_mem
 * @brief read mem info while holding the core
 * @param [in] param
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDebugReadAICore(rtDebugMemoryParam *const param);

/**
 * @ingroup rts_mem
 * @brief Asynchronous memcpy
 * @param [in] dst   destination address pointer
 * @param [in] dstMax length of destination address memory
 * @param [in] dstDataOffset  dst data addr offset
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] srcDataOffset src data addr offset
 * @param [in] kind   memcpy type
 * @param [in] stm   asynchronous task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyAsyncWithOffset(void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
    uint64_t cnt, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stm);
 
/**
 * @ingroup rts_mem
 * @brief Setting SSIDs of Shared Memory in Batches.
 * @param [in] key  identification key 
 * @param [in] serverPids  whitelisted server pids
 * @param [in] num  number of serverPids array
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtIpcMemImportPidInterServer(const char *key, const rtServerPid *serverPids, size_t num);

/**
 * @ingroup rts_mem
 * @brief alloc device memory
 * @param [in|out] devPtr   memory pointer
 * @param [in] size         memory size
 * @param [in] policy       memory policy
 * @param [in] advise       memory advise, such as TS,DVPP
 * @param [in] cfg   memory attributes config, such ModuleId, DeviceId
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemAlloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg);

/**
 * @ingroup rts_mem
 * @brief Query the device memory information occupied by each component
 * @param [in] deviceId             the deviceId to be queried
 * @param [in|out] memUsageInfo     the memUsageInfo used to store memory usage information
 * @param [in] inputNum             the number of components that are expected to be queried
 * @param [in|out] outputNum        the actual number of components queried
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtGetMemUsageInfo(uint32_t deviceId, rtMemUsageInfo_t *memUsageInfo, size_t inputNum, size_t *outputNum);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_MEM_H