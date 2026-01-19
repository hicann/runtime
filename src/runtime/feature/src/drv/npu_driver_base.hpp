/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_NPU_DRIVER_BASE_HPP
#define CCE_RUNTIME_NPU_DRIVER_BASE_HPP

#include "errcode_manage.hpp"

extern "C" {
int __attribute__((weak)) halMbufSetDataLen(Mbuf *mbufPtr, uint64_t len);
int __attribute__((weak)) halMbufGetDataLen(Mbuf *mbuf, uint64_t *len);
drvError_t __attribute__((weak)) halBufEventReport(const char *grpName);
drvError_t __attribute__((weak)) halMemAdvise(DVdeviceptr ptr, size_t count, unsigned int type, DVdevice device);
drvError_t __attribute__((weak)) halMemcpySumbit(struct DMA_ADDR *dma_addr, int32_t flag);
drvError_t __attribute__((weak)) halMemcpyWait(struct DMA_ADDR *dma_addr);
drvError_t __attribute__((weak)) halResourceInfoQuery(uint32_t devId, uint32_t tsId, drvResourceType_t type,
    struct halResourceInfo *info);
drvError_t __attribute__((weak)) halCheckProcessStatus(DVdevice device, processType_t process_type,
    processStatus_t status, bool *is_matched);
drvError_t __attribute__((weak)) halCheckProcessStatusEx(DVdevice device, processType_t process_type,
    processStatus_t status, struct drv_process_status_output *out);    
int32_t __attribute__((weak)) halMapErrorCode(drvError_t code);
drvError_t __attribute__((weak)) halCqReportRecv(uint32_t devId, struct halReportRecvInfo *info);
drvError_t __attribute__((weak)) halSqCqQuery(uint32_t devId, struct halSqCqQueryInfo *info);
drvError_t __attribute__((weak)) halResourceConfig(uint32_t devId, struct halResourceIdInputInfo *in,
    struct halResourceConfigInfo *para);
int __attribute__((weak)) halMbufCopyRef(Mbuf *mbuf, Mbuf **newMbuf);
int __attribute__((weak)) halMbufAllocEx(uint64_t size, unsigned int align,
    unsigned long flag, int grp_id, Mbuf **mbuf);
drvError_t __attribute__((weak)) halGetPhyDeviceInfo(uint32_t phyId, int32_t moduleType,
    int32_t infoType, int64_t *value);
drvError_t __attribute__((weak)) halGetPairPhyDevicesInfo(uint32_t devId, uint32_t otherDevId,
    int32_t infoType, int64_t *value);
int __attribute__((weak)) halMbufChainAppend(Mbuf *mbufChainHead, Mbuf *mbuf);
int __attribute__((weak)) halMbufChainGetMbufNum(Mbuf *mbufChainHead, unsigned int *num);
int __attribute__((weak)) halMbufChainGetMbuf(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf);
drvError_t __attribute__((weak)) halQueueSet(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *input);
drvError_t __attribute__((weak)) halQueueReset(unsigned int devId, unsigned int qid);
drvError_t __attribute__((weak)) halGetAPIVersion(int *halAPIVersion);
bool __attribute__((weak)) halSupportFeature(uint32_t devId, drvFeature_t type);
drvError_t __attribute__((weak)) halMemDestroyAddrBatch(struct DMA_ADDR *ptr[], uint32_t num);
drvError_t __attribute__((weak)) halGrpCacheAlloc(const char *name, unsigned int devId, GrpCacheAllocPara *para);
int __attribute__((weak)) halBuffGetInfo(enum BuffGetCmdType cmd, void *inBuff, unsigned int inLen,
    void *outBuff, unsigned int *outLen);
drvError_t __attribute__((weak)) halBuffGet(Mbuf *mbuf, void *buf, unsigned long size);
int __attribute__((weak)) halMbufBuild(void *buff, uint64_t len, Mbuf **mbuf);
int __attribute__((weak)) halBuffAlloc(uint64_t size, void **buff);
int __attribute__((weak)) halBuffFree(void *buff);
int __attribute__((weak)) halMbufUnBuild(Mbuf *mbuf, void **buff, uint64_t *len);
void __attribute__((weak)) halBuffPut(Mbuf *mbuf, void *buf);
drvError_t __attribute__((weak)) halSqTaskSend(uint32_t devId, struct halTaskSendInfo *info);
drvError_t __attribute__((weak)) halEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara,
    unsigned int *grpId);
drvError_t __attribute__((weak)) halEschedThreadSwapout(unsigned int devId, unsigned int grpId,
    unsigned int threadId);
drvError_t __attribute__((weak)) drvDeviceStatus(uint32_t devId, drvStatus_t *status);
drvError_t __attribute__((weak)) halEschedQueryInfo(unsigned int devId, ESCHED_QUERY_TYPE type,
    struct esched_input_info *inPut, struct esched_output_info *outPut);
drvError_t __attribute__((weak)) halShmemOpenHandleByDevId(DVdevice dev_id, const char *name, DVdeviceptr *vptr);

drvError_t __attribute__((weak)) halMemAddressReserve(void **ptr, size_t size, size_t alignment, void *addr,
    uint64_t flag);
drvError_t __attribute__((weak)) halMemAddressFree(void *ptr);
drvError_t __attribute__((weak)) halMemCreate(drv_mem_handle_t **handle, size_t size, const struct drv_mem_prop *prop,
    uint64_t flag);
drvError_t __attribute__((weak)) halMemRelease (drv_mem_handle_t *handle);
drvError_t __attribute__((weak)) halMemMap(void *ptr, size_t size, size_t offset, drv_mem_handle_t *handle,
    uint64_t flag);
drvError_t __attribute__((weak))halMemGetAddressReserveRange(void **ptr, size_t *size, drv_mem_addr_reserve_type type,
    uint64_t flag);
drvError_t __attribute__((weak)) halMemUnmap(void *ptr);
drvError_t __attribute__((weak)) halMemSetAccess(void *ptr, size_t size, struct drv_mem_access_desc *desc,
    size_t count);
drvError_t __attribute__((weak)) halMemExportToShareableHandle(drv_mem_handle_t *handle,
    drv_mem_handle_type handle_type, uint64_t flags, uint64_t *shareable_handle);
drvError_t __attribute__((weak)) halMemImportFromShareableHandle(uint64_t shareable_handle,
    uint32_t devid, drv_mem_handle_t **handle);
drvError_t __attribute__((weak)) halMemSetPidToShareableHandle(uint64_t shareable_handle,
    int pid[], uint32_t pid_num);
drvError_t __attribute__((weak)) halMemGetAccess(void *ptr, struct drv_mem_location *location, uint64_t *flags);
drvError_t __attribute__((weak)) halMemTransShareableHandle(drv_mem_handle_type handle_type,
    struct MemShareHandle *share_handle, uint32_t *server_id, uint64_t *shareable_handle);
drvError_t __attribute__((weak)) halMemExportToShareableHandleV2(
    drv_mem_handle_t *handle, drv_mem_handle_type handle_type, uint64_t flags, struct MemShareHandle *share_handle);
drvError_t __attribute__((weak)) halMemImportFromShareableHandleV2(
    drv_mem_handle_type handle_type, struct MemShareHandle *share_handle, uint32_t devid, drv_mem_handle_t **handle);
drvError_t __attribute__((weak)) halMemRetainAllocationHandle(drv_mem_handle_t **handle, void* ptr);
drvError_t __attribute__((weak)) halMemGetAllocationPropertiesFromHandle(struct drv_mem_prop *prop, drv_mem_handle_t *handle);
drvError_t __attribute__((weak)) halGetHostID(uint32_t *host_id);
drvError_t __attribute__((weak)) halMemGetAllocationGranularity(const struct drv_mem_prop *prop,
    drv_mem_granularity_options option, size_t *granularity);
drvError_t __attribute__((weak)) drvBindHostPid(struct drvBindHostpidInfo info);
drvError_t __attribute__((weak)) drvUnbindHostPid(struct drvBindHostpidInfo info);
drvError_t __attribute__((weak)) drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
    unsigned int *host_pid, unsigned int *cp_type);
drvError_t __attribute__((weak)) halMemcpy(void *dst, size_t dst_size, void *src, size_t count,
    struct memcpy_info *info);
drvError_t __attribute__((weak)) halShrIdOpen(const char *name, struct drvShrIdInfo *info);
drvError_t __attribute__((weak)) halShrIdCreate(struct drvShrIdInfo *info, char *name, uint32_t name_len);
drvError_t __attribute__((weak)) halShrIdClose(const char *name);
drvError_t __attribute__((weak)) halShrIdSetAttribute(const char *name, enum shrIdAttrType type, struct shrIdAttr attr);
drvError_t __attribute__((weak)) halShrIdInfoGet(const char *name, struct shrIdGetInfo *info);
drvError_t __attribute__((weak)) halGetFaultEvent(uint32_t devId, struct halEventFilter *filter,
    struct halFaultEventInfo *eventInfo, uint32_t len, uint32_t *eventCount);
drvError_t __attribute__((weak)) halGetDeviceInfoByBuff(uint32_t devId, int moduleType,
    int infoType, void *buf, int32_t *size);
drvError_t __attribute__((weak)) halSetDeviceInfoByBuff(uint32_t devId, int32_t moduleType,
    int32_t infoType, void *buf, int32_t size);
drvError_t __attribute__((weak)) halShrIdSetPodPid(const char *name, uint32_t sdid, pid_t pid);
drvError_t __attribute__((weak)) halParseSDID(uint32_t sdid, struct halSDIDParseInfo *sdid_parse);
DVresult __attribute__((weak)) halShmemSetPodPid(const char *name, uint32_t sdid, int pid[], int num);
drvError_t __attribute__((weak)) halUpdateAddress(uint64_t device_addr, uint64_t len);

drvError_t __attribute__((weak)) halAsyncDmaCreate(uint32_t devId, struct halAsyncDmaInputPara *in,
    struct halAsyncDmaOutputPara *out);
drvError_t __attribute__((weak)) halAsyncDmaDestory(uint32_t devId, struct halAsyncDmaDestoryPara *para);
drvError_t __attribute__((weak)) halSqTaskArgsAsyncCopy(uint32_t devId, struct halSqTaskArgsInfo *info);
drvError_t __attribute__((weak)) halResAddrMap(unsigned int devId, struct res_addr_info *res_info,
    unsigned long *va, unsigned int *len);
drvError_t __attribute__((weak)) halResAddrUnmap(unsigned int devId, struct res_addr_info *res_info);

drvError_t __attribute__((weak)) halHostUnregisterEx(void *srcPtr, UINT32 devid, UINT32 flag);
drvError_t __attribute__((weak)) halHostRegister(void *srcPtr, UINT64 size, UINT32 flag, UINT32 devid, void **dstPtr);
drvError_t __attribute__((weak)) halHostRegisterCapabilities(UINT32 devid, UINT32 acc_module_type, UINT32 *mem_map_cap);
drvError_t __attribute__((weak)) halShmemSetAttribute(const char *name, uint32_t type, uint64_t attr);
drvError_t __attribute__((weak))
halMemShareHandleSetAttribute(uint64_t shareableHandle, enum ShareHandleAttrType type, struct ShareHandleAttr attr);
drvError_t __attribute__((weak)) halMemShareHandleInfoGet(uint64_t shareableHandle, struct ShareHandleGetInfo *info);
drvError_t __attribute__((weak)) halShmemInfoGet(const char *name, struct ShmemGetInfo *info);
drvError_t __attribute__((weak)) drvHdcServerCreate(int devid, int serviceType, HDC_SERVER *pServer);
drvError_t __attribute__((weak)) drvHdcServerDestroy(HDC_SERVER server);
drvError_t __attribute__((weak)) drvHdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session);
drvError_t __attribute__((weak)) drvHdcSessionClose(HDC_SESSION session);
drvError_t __attribute__((weak)) halReadFaultEvent(
    int32_t devId, int timeout, struct halEventFilter* filter, struct halFaultEventInfo* eventInfo);
drvError_t __attribute__((weak)) halMemcpyBatch(uint64_t dst[], uint64_t src[], size_t size[], size_t count);
drvError_t __attribute__((weak)) halDeviceOpen(uint32_t devid, halDevOpenIn *in, halDevOpenOut *out);
drvError_t __attribute__((weak)) halDeviceClose(uint32_t devid, halDevCloseIn *in);
drvError_t __attribute__((weak)) halQueueGetDqsQueInfo(uint32_t devId, uint32_t qid, DqsQueueInfo *info);
drvError_t __attribute__((weak)) halBuffGetDQSPooInfoById(uint32_t poolId, DqsPoolInfo *poolInfo);

drvError_t __attribute__((weak)) halProcessResBackup(halProcResBackupInfo *info);
drvError_t __attribute__((weak)) halProcessResRestore(halProcResRestoreInfo *info);
drvError_t __attribute__((weak)) halResourceIdInfoGet(struct drvResIdKey *key,  drvResIdProcType type,  uint64_t *value);
drvError_t __attribute__((weak)) halShrIdDestroy(const char *name);
drvError_t __attribute__((weak)) halShrIdSetPid(const char *name, pid_t pid[], uint32_t pid_num);
drvError_t __attribute__((weak)) halShrIdRecord(const char *name);
drvError_t __attribute__((weak)) halResourceDetailQuery(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceDetailInfo *info);
drvError_t __attribute__((weak)) halCdqCreate(uint32_t devId, uint32_t tsId, struct halCdqPara *cdqPara, uint32_t *queId);
drvError_t __attribute__((weak)) halCdqDestroy(unsigned int devId, unsigned int tsId, unsigned int queId);
drvError_t __attribute__((weak)) halCdqAllocBatch(unsigned int devId, unsigned int tsId, unsigned int queId, unsigned int timeout, unsigned int *batchId);
drvError_t __attribute__((weak)) halStreamTaskFill(uint32_t dev_id, uint32_t stream_id, void *stream_mem,
    void *task_info, uint32_t task_cnt);
drvError_t __attribute__((weak)) halSqSwitchStreamBatch(uint32_t dev_id, struct sq_switch_stream_info *info,
    uint32_t num);
drvError_t __attribute__((weak)) drvDeviceOpen(void **devInfo, uint32_t devId);
drvError_t __attribute__((weak)) drvDeviceClose(uint32_t devId);
drvError_t __attribute__((weak)) drvCustomCall(uint32_t devId, uint32_t cmd, void *para);
drvError_t __attribute__((weak)) drvNotifyIdAddrOffset(uint32_t devId, struct drvNotifyInfo *info);
drvError_t __attribute__((weak)) drvCreateIpcNotify(struct drvIpcNotifyInfo *info, char *name, uint32_t len);
drvError_t __attribute__((weak)) drvDestroyIpcNotify(const char *name, struct drvIpcNotifyInfo *info);
drvError_t __attribute__((weak)) drvCloseIpcNotify(const char *name, struct drvIpcNotifyInfo *info);
drvError_t __attribute__((weak)) drvSetIpcNotifyPid(const char *name, pid_t pid[], int num);
int __attribute__((weak)) drvMemDeviceClose(uint32_t devid);
int __attribute__((weak)) drvMemDeviceOpen(uint32_t devid, int devfd);
DVresult __attribute__((weak)) drvLoadProgram(DVdevice device_id, void *program, unsigned int offset,
    size_t byte_count, void **v_ptr);
DVresult __attribute__((weak)) drvMemAllocL2buffAddr(DVdevice device, void **l2buff, UINT64 *pte);
DVresult __attribute__((weak)) drvMemReleaseL2buffAddr(DVdevice device, void *l2buff);
DVresult __attribute__((weak)) drvMbindHbm(DVdeviceptr devPtr, size_t len, uint32_t type, uint32_t dev_id);

DVresult __attribute__((weak)) halStreamBackup(uint32_t dev_id, struct stream_backup_info *in);
DVresult __attribute__((weak)) halStreamRestore(uint32_t dev_id, struct stream_backup_info *in);
drvError_t __attribute__((weak)) halSetMemSharing(struct drvMemSharingPara *para);
drvError_t __attribute__((weak)) halGetDeviceSplitMode(unsigned int dev_id, unsigned int *mode);
drvError_t __attribute__((weak)) halDrvEventThreadInit(unsigned int devId);
drvError_t __attribute__((weak)) halGetMemUsageInfo(uint32_t dev_id, struct mem_module_usage *mem_usage, size_t in_num, size_t *out_num);
};

namespace cce {
namespace runtime {
constexpr uint64_t MEM_CACHED = (0X1ULL << 41U);
constexpr uint64_t HUGE_PAGE_MEM_CRITICAL_VALUE = (1024ULL * 1024ULL);  // 1M
constexpr uint64_t MEM_LENGTH_2M = 2048000U;
constexpr uint32_t CQ_DEPTH_FOR_FLAT_ADDR_VIRTURE_MACH = 256U;
#ifndef PAGE_SIZE
constexpr uint32_t PAGE_SIZE = 4096U;
#endif

constexpr uint32_t RT_CB_ASYNC_CQ_DEPTH = 512U;
constexpr uint32_t RT_CB_SYNC_CQ_DEPTH = 1U;
constexpr int64_t SUPPORT_NUMA_TS_DEFAULT = -1;
constexpr int32_t MAX_DRV_ERR_CODE_AFTER_TRANS = 9999;
constexpr size_t ERROR_MSG_CODE_LEN = 7U;
constexpr uint64_t NORMAL_MEM = 0ULL;
constexpr uint64_t DVPP_MEM = 1ULL;
constexpr uint32_t SQCQ_DISTHREAD_INDEX = 3U;
constexpr uint32_t LOGICCQ_CTRLSQ_TAG_INDEX = 2U;
constexpr uint32_t INFO_TYPE_UTILIZATION = 23U;
constexpr uint16_t RT_MEM_DEV_READONLY_BIT = 30U;
constexpr uint64_t RT_MEM_DEV_READONLY = 1U; // set device memory readonly, but support H2D copy
constexpr int32_t RT_INFO_TYPE_VA = 34U;
constexpr int32_t RT_INFO_TYPE_SYS_COUNT = 13U;

const std::string RT_MEMORY_ALLOC_ERROR = "EL0004";

enum class RtCtrlType {
    RT_CTRL_TYPE_ADDR_MAP = 0,
    RT_CTRL_TYPE_ADDR_UNMAP = 1,
    RT_CTRL_TYPE_SUPPORT_FEATURE = 2,
    RT_CTRL_TYPE_GET_DOUBLE_PGTABLE_OFFSET = 3,   /* Inpara is devid, Outpara is nocache offset */
    RT_CTRL_TYPE_MEM_REPAIR = 4,                  /* Inpara is MemRepairInPara */
    RT_CTRL_TYPE_MAX = 5
};

#define RUNTIME_WHEN_NO_VIRTUAL_MODEL_RETURN if (sysMode_ != RUN_MACHINE_VIRTUAL || addrMode_ == 0) { \
        return RT_ERROR_NONE; \
}

#define DRV_ERROR_PROCESS(drvErrorCode, format, ...)                                                                 \
    do {                                                                                                             \
        if (&halMapErrorCode != nullptr) {                                                                           \
            const int32_t errCodeAfterTrans = halMapErrorCode(drvErrorCode);                                         \
            RT_LOG(RT_LOG_INFO, "halMapErrorCode ret:%d, drvErrorCode:%d", errCodeAfterTrans,                        \
                static_cast<int32_t>(drvErrorCode));                                                                 \
            if ((errCodeAfterTrans >= 0) && (errCodeAfterTrans < MAX_DRV_ERR_CODE_AFTER_TRANS)) {                    \
                std::string errBuf(ERROR_MSG_CODE_LEN, '\0');                                                        \
                const int32_t errRet = sprintf_s(&(errBuf[0]), ERROR_MSG_CODE_LEN, "EL%04d", errCodeAfterTrans);     \
                errBuf.resize(ERROR_MSG_CODE_LEN - 1U);                                                              \
                if (likely(errRet != -1)) {                                                                          \
                    if (errBuf.compare(RT_MEMORY_ALLOC_ERROR) == 0) {                                                \
                        REPORT_INPUT_ERROR(errBuf,                                                                   \
                            std::vector<std::string>({"module_name"}),                                               \
                            std::vector<std::string>({"UNKNOWN"}));                                                  \
                    } else {                                                                                         \
                        REPORT_INPUT_ERROR(errBuf, std::vector<std::string>(), std::vector<std::string>());          \
                    }                                                                                                \
                } else {                                                                                             \
                    RT_LOG(RT_LOG_WARNING, "sprintf_s failed ret:%d, errCodeAfterTrans:%d",                          \
                           errRet, errCodeAfterTrans);                                                               \
                }                                                                                                    \
                RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__);                                                         \
                break;                                                                                               \
            }                                                                                                        \
        }                                                                                                            \
        RT_LOG_CALL_MSG(ERR_MODULE_DRV, format, ##__VA_ARGS__);                                                      \
    } while (false)

#if (!defined(WIN32))
#define DRV_MALLOC_ERROR_PROCESS(drvErrorCode, moduleId, format, ...)                                                \
    do {                                                                                                             \
        if (&halMapErrorCode != nullptr) {                                                                           \
            const int32_t errCodeAfterTrans = halMapErrorCode(drvErrorCode);                                         \
            RT_LOG(RT_LOG_INFO, "halMapErrorCode ret:%d, drvErrorCode:%d, moduleId: %d", errCodeAfterTrans,          \
                static_cast<int32_t>(drvErrorCode), moduleId);                                                       \
            if ((errCodeAfterTrans >= 0) && (errCodeAfterTrans < MAX_DRV_ERR_CODE_AFTER_TRANS)) {                    \
                std::string errBuf(ERROR_MSG_CODE_LEN, '\0');                                                        \
                const int32_t errRet = sprintf_s(&(errBuf[0]), ERROR_MSG_CODE_LEN, "EL%04d", errCodeAfterTrans);     \
                errBuf.resize(ERROR_MSG_CODE_LEN - 1U);                                                              \
                if (likely(errRet != -1)) {                                                                          \
                    if (errBuf.compare(RT_MEMORY_ALLOC_ERROR) == 0) {                                                \
                        REPORT_INPUT_ERROR(errBuf,                                                                   \
                            std::vector<std::string>({"module_name"}),                                               \
                            std::vector<std::string>({RT_GET_MODULE_NAME(moduleId)}));                               \
                    } else {                                                                                         \
                        REPORT_INPUT_ERROR(errBuf, std::vector<std::string>(), std::vector<std::string>());          \
                    }                                                                                                \
                } else {                                                                                             \
                    RT_LOG(RT_LOG_WARNING, "sprintf_s failed ret:%d, errCodeAfterTrans:%d",                          \
                            errRet, errCodeAfterTrans);                                                              \
                }                                                                                                    \
                RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__);                                                         \
                break;                                                                                               \
            }                                                                                                        \
        }                                                                                                            \
        RT_LOG_CALL_MSG(ERR_MODULE_DRV, format, ##__VA_ARGS__);                                                      \
    } while (false)
#else
#define DRV_MALLOC_ERROR_PROCESS(drvErrorCode, moduleId, format, ...)      \
    RT_LOG_CALL_MSG(ERR_MODULE_DRV, format, ##__VA_ARGS__)
#endif

}  // namespace runtime
}  // namespace ccez

#endif  // CCE_RUNTIME_NPU_DRIVER_BASE_HPP