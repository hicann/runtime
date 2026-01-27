/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HCCL_API_H
#define HCCL_API_H

#include <atomic>
#include <map>
#include <mutex>
#include <set>
#include <string>
#include <vector>

#include "aicpusd_common.h"
#include "driver/ascend_hal.h"

namespace AicpuSchedule {
constexpr int32_t RET_SUCCESS = 0;
constexpr int32_t RET_FAILED = -1;
constexpr uint32_t STATUS_SUCCESS = 0U;
constexpr uint32_t STATUS_FAILED = 2U;

using HcclRequest = void*;
using ServiceHandle = void*;
using HcclComm = void*;
using HcomRequest = void*;

using CalcParams = struct tagCalcParams {
    int32_t uniqueCost0;    // worker/client侧的去重开销, 单位:ms
    int32_t gatherCost0;    // worker/client侧的恢复开销, 单位:ms
    int32_t uniqueCost1;    // ps/server侧的去重开销, 单位:ms
    int32_t gatherCost1;    // ps/server侧的恢复开销, 单位:ms
};
typedef enum {
    HCCL_SUCCESS = 0,               /**< success */
    HCCL_E_PARA = 1,                /**< parameter error */
    HCCL_E_PTR = 2,                 /**< empty pointer */
    HCCL_E_MEMORY = 3,              /**< memory error */
    HCCL_E_INTERNAL = 4,            /**< internal error */
    HCCL_E_NOT_SUPPORT = 5,         /**< not support feature */
    HCCL_E_NOT_FOUND = 6,           /**< not found specific resource */
    HCCL_E_UNAVAIL = 7,             /**< resource unavailable */
    HCCL_E_SYSCALL = 8,             /**< call system interface error */
    HCCL_E_TIMEOUT = 9,             /**< timeout */
    HCCL_E_OPEN_FILE_FAILURE = 10,  /**< open file fail */
    HCCL_E_TCP_CONNECT = 11,        /**< tcp connect fail */
    HCCL_E_ROCE_CONNECT = 12,       /**< roce connect fail */
    HCCL_E_TCP_TRANSFER = 13,       /**< tcp transfer fail */
    HCCL_E_ROCE_TRANSFER = 14,      /**< roce transfer fail */
    HCCL_E_RUNTIME = 15,            /**< call runtime api fail */
    HCCL_E_DRV = 16,                /**< call driver api fail */
    HCCL_E_PROFILING = 17,          /**< call profiling api fail */
    HCCL_E_CCE = 18,                /**< call cce api fail */
    HCCL_E_NETWORK = 19,            /**< call network api fail */
    HCCL_E_AGAIN = 20,              /**< try again */
    HCCL_E_REMOTE = 21,             /**< error cqe */
    HCCL_E_RESERVED                 /**< reserved */
} HcclResult;
typedef enum {
    HCCL_DATA_TYPE_INT8 = 0,    /**< int8 */
    HCCL_DATA_TYPE_INT16 = 1,   /**< int16 */
    HCCL_DATA_TYPE_INT32 = 2,   /**< int32 */
    HCCL_DATA_TYPE_FP16 = 3,    /**< fp16 */
    HCCL_DATA_TYPE_FP32 = 4,    /**< fp32 */
    HCCL_DATA_TYPE_INT64 = 5,   /**< int64 */
    HCCL_DATA_TYPE_UINT64 = 6,  /**< uint64 */
    HCCL_DATA_TYPE_UINT8 = 7,   /**< uint8 */
    HCCL_DATA_TYPE_UINT16 = 8,  /**< uint16 */
    HCCL_DATA_TYPE_UINT32 = 9,  /**< uint32 */
    HCCL_DATA_TYPE_FP64 = 10,   /**< fp64 */
    HCCL_DATA_TYPE_BFP16 = 11,  /**< bfp16 */
    HCCL_DATA_TYPE_RESERVED     /**< reserved */
} HcclDataType;
using ReqStatus = struct tagReqStatus {
    int32_t tableId;        // 查找的table_id
    int32_t tag;            // 与算子IR中的tag相同
    int32_t actualSize;     // 如果是接收接口的status, 还返回实际接收到的size
    int32_t rsvd0;
    int64_t globalStep;
};
using UpdateReqStatus = struct tagUpdateReqStatus {
    int32_t tableId;            // 查找的table_id
    int32_t tag;                // 与算子IR中的tag相同
    int32_t actualKeyCount;     // 如果是接收接口的status, 还返回实际接收到的keyCount
    int32_t actualValueCount;   // 如果是接收接口的status, 还返回实际接收到的keyCount
    int64_t globalStep;
};
using LookupReqStatus = struct tagLookupReqStatus {
    int32_t tableId;        // 查找的table_id
    int32_t tag;            // 与算子IR中的tag相同
    int32_t actualCount;    // 如果是接收接口的status, 还返回实际接收到的keyCount
    int32_t rsvd0;
    int32_t workerId;
};

enum HcomOperationType {
    HCOM_OP_TYPE_SEND,
    HCOM_OP_TYPE_RECV,
    HCOM_OP_TYPE_BROADCAST,
    HCOM_OP_TYPE_GATHER,
    // 后续扩展集合通信
    HCOM_OP_TYPE_NUM
};
enum HcomSchedType {
    HCOM_SCHED_TYPE_OS,              // CPU执行，OS调度
    HCOM_SCHED_TYPE_NPU_TS_OFFLOAD,  // TS下沉调度，对应model执行
    HCOM_SCHED_TYPE_NPU_TS,          // TS非下沉调度，对应单算子执行
    HCOM_SCHED_TYPE_NUM
};
#define AICPU_HCOM_GROUP_NAME_MAX_LEN 127

using HcomP2pOpInfo = struct {
    char group[AICPU_HCOM_GROUP_NAME_MAX_LEN];
    uint32_t tag;           // 点到点通信的tag
    uint32_t peerRank;      // 点到点通信的对端rank
    void* addr;             // send/recv的发送或接收buffer
    uint64_t count;         // 数据数量
    HcclDataType dataType;  // 对应HcclDataType
    int32_t rsv0;
    int32_t rsv1;
    int32_t rsv2;
};
typedef enum {
    HCCL_REDUCE_SUM = 0,    /**< sum */
    HCCL_REDUCE_PROD = 1,   /**< prod */
    HCCL_REDUCE_MAX = 2,    /**< max */
    HCCL_REDUCE_MIN = 3,    /**< min */
    HCCL_REDUCE_RESERVED    /**< reserved */
} HcclReduceOp;
typedef struct {
    char group[AICPU_HCOM_GROUP_NAME_MAX_LEN];
    void* inputAddr;
    void* outputAddr;
    uint64_t count;
    HcclDataType dataType;
    uint32_t root;
    HcclReduceOp reduceOp;
    uint64_t strideCount;
} HcomCollOpInfo;
typedef struct {
    HcomOperationType opType;       // op类型用于结合拓扑和rank_table一起决定需要创建哪些通信连接
    HcomSchedType schedType;        // 由于prepare接口需要NPU与CPU共用，创建的QP是不同的，引出需要调度器类型
    int32_t cxtId;                  // 集合通信的执行上下文标识，由调用者自定义，（暂时保留不使用）
                                    // 相同cxtId被认为是相同的执行上下文，比如stream/thread
                                    // 相同上下文的集合通信只能串行执行
    uint64_t flag;                  // bit0：接收数据量和地址是否动态, 1==动态, 此时info里的addr, count无效（预留不使用）
    union {
        HcomP2pOpInfo p2p;
        HcomCollOpInfo coll;
    } info;
} HcomOpDesc;
typedef struct {
    uint32_t status;                // 0: ok; 1: on-going; 2: error
    uint32_t rsv0;
    uint32_t rsv1;
    uint32_t rsv2;
} HcomStatus;
constexpr uint32_t HCCL_COMM_CONFIG_INFO_BYTES = 24U;
constexpr uint32_t COMM_NAME_MAX_LENGTH = 128U;
constexpr uint32_t UDI_MAX_LENGTH = 128U;
typedef struct HcclCommConfigDef {
    char reserved[HCCL_COMM_CONFIG_INFO_BYTES];
    uint32_t hcclBufferSize;
    uint32_t hcclDeterministic;
    char hcclCommName[COMM_NAME_MAX_LENGTH];
    char hcclUdi[UDI_MAX_LENGTH];
} HcclCommConfig;
typedef struct {
    int32_t srcRank;    // 接收/探测到的msg/信封的发送端rank_id，MPI标准定义，调用者可以访问
    int32_t tag;        // 接收/探测到的msg/信封的tag，MPI标准定义，调用者可以访问
    int32_t error;      // 接收/探测的错误码0：no error，others：传输过程出错，MPI标准定义，调用者可以访问
    int32_t cancelled;  // 指定实现，不建议调用者访问
    int32_t count;      // 接收/探测到的payload大小，指定实现，不建议调用者访问
} HcclStatus;
// PS侧控制面接口:类似Helper1.0的通信域创建接口。内部根据rank_table和clusterConfig中描述的PS/worker信息直接建链,
// 只建立一组通信连接，使用者需要防重入
HcclResult StubHcclInitCsComm(const char_t *rankTableM, int32_t rankId, const char_t *roleTable,
                              const CalcParams *calcParams, HcclComm *comm);

HcclResult StubHcclFinalizeComm(HcclComm comm);

HcclResult StubHcclGetLookupRequest(void* keys, int32_t count, HcclDataType type, int32_t tag,
                                    ServiceHandle *handle, HcclComm comm, ReqStatus *status);

HcclResult StubHcclIsetLookupResponse(void *values, int32_t count, HcclDataType type, ServiceHandle handle,
                                      HcclComm comm, HcclRequest *request);
HcclResult StubHcclWaitSome(int32_t count, HcclRequest requestArray[], int32_t *compCount, int32_t compIndices[],
                            HcclStatus compStatus[]);
HcclResult StubHcclAbortSelf(HcclComm comm, int32_t tag);

HcclResult StubHddsServiceCancel(ServiceHandle handle);

HcclResult StubHddsCollRecvUpdateRequest(void *keys, int32_t keyCount, HcclDataType keyType, void *values,
    int32_t valueCount, HcclDataType valueType, int32_t tag, ServiceHandle *handle, HcclComm comm,
    UpdateReqStatus *status);

HcclResult StubHddsIsendUpdateResponse(ServiceHandle handle, HcclComm comm, HcclRequest *request);

HcclResult StubHddsCollRecvLookupRequest(void *keys, int32_t count, HcclDataType type, int32_t tag,
    ServiceHandle *handle, HcclComm comm, LookupReqStatus *status);

HcclResult StubHddsIsendLookupResponse(void *values, int32_t count, HcclDataType type, ServiceHandle handle,
    HcclComm comm, HcclRequest *request);

HcclResult StubHcomPrepareStart(const HcomOpDesc *op, HcomRequest *request);

HcclResult StubHcomPrepareQuery(HcomRequest request, HcomStatus *status);

HcclResult StubHcomSendByOS(void *buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    const char_t *group, uint64_t flag);

HcclResult StubHcomReceiveByOS(void *buf, uint64_t count, HcclDataType dataType, uint32_t peerRank, uint32_t tag,
    const char_t *group, uint64_t flag);

HcclResult StubHcomInitByRankTable(const char_t *rankTable, uint32_t rankId);

HcclResult StubHcomDestroy();

HcclResult StubHcomCreateGroup(const char_t *group, uint32_t rankNum, uint32_t *rankIds);

HcclResult StubHcomDestroyGroup(const char_t *group);

HcclResult StubHcomGatherByOS(void *inputBuf, uint64_t inputCount, HcclDataType inputType, void *outputBuf,
                              uint64_t outputCount, HcclDataType outputType, uint32_t root, const char *group,
                              uint64_t flag);

HcclResult StubHcomBroadcastByOS(void* buf, uint64_t count, HcclDataType dataType, uint32_t root, const char *group,
                                 uint64_t flag);


HcclResult StubHcclDestroyResouce(HcclComm comm, int32_t tag);

HcclResult StubHcclRegisterGlobalMemory(void *addr, uint64_t size);

HcclResult StubHcclUnregisterGlobalMemory(void *addr);

HcclResult StubHcclPsAssociateWorkers(HcclComm comm, int32_t tag, uint32_t workerRanks[], uint64_t workerNum);

HcclResult StubHcclCpuCommInit(const char_t *rankTable, uint32_t rank, HcclCommConfig* config);

// 自定义
int32_t SingleHcclWait(HcclRequest request);

class HcclSoManager {
public:
    static HcclSoManager *GetInstance();

    virtual ~HcclSoManager();

    /**
     * load hccl so
     */
    void LoadSo();
    void LoadHccdSo();
    void LoadHcclSo();

    /**
     * unload hccl so
     */
    void UnloadSo();
    void UnLoadHccdSo();
    void UnLoadHcclSo();

    /**
     * get function
     * @param name hccl function name
     * @return void *
     */
    void *GetFunc(const std::string &name) const;

private:
    HcclSoManager() = default;

    std::map<std::string, void *> funcMap_;
    void *hccdSoHandle_ = nullptr;
    void *hcclSoHandle_ = nullptr;
};

class MBufferPool {
public:
    int32_t Init(const uint32_t blockNum, const uint32_t blockSize, const bool registerMem);
    void UnInit();
    int32_t Allocate(Mbuf **mbufPtr);
    int32_t Free(Mbuf *mbuf);
    int32_t FreeAll();

private:
    mempool_t *mp_ = nullptr;
    std::set<Mbuf*> mbufsAllocated_;
    std::mutex mutexForMbufSet_;
    bool isRegister_ = false;
    void *poolAddr_ = nullptr;
    uint64_t poolSize_ = 0U;
};

} // namespace aicpu
#endif // HCCL_API_H
