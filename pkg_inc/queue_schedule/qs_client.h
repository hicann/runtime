/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_QS_CLIENT_H
#define QUEUE_SCHEDULE_QS_CLIENT_H

#include <vector>
#include <mutex>

namespace bqs {
using char_t = char;
enum BqsClientErrorCode : int32_t {
    BQS_OK = 0,
    BQS_PARAM_INVALID = 1,
    BQS_INNER_ERROR = 2,
    BQS_DRIVER_ERROR = 3,
    BQS_EASY_COMM_ERROR = 4,
    BQS_PROTOBUF_ERROR = 5,
    BQS_BINDPID_ERROR = 6,
    BQS_UNBINDPID_ERROR = 7,
    BQS_RETRY = 100,
};

enum QueueSubEventType : uint32_t {
    CREATE_QUEUE = 0U,
    DESTROY_QUEUE = 1U,
    DE_QUEUE = 2U,
    EN_QUEUE = 3U,
    PEEK_QUEUE = 4U,
    GRANT_QUEUE = 5U,
    ATTACH_QUEUE = 6U,
    DRIVER_PROCESS_SPLIT = 1024U,
    AICPU_BIND_QUEUE = 1025U,
    AICPU_BIND_QUEUE_RES = 1026U,
    AICPU_BIND_QUEUE_INIT = 1027U,
    AICPU_BIND_QUEUE_INIT_RES = 1028U,
    AICPU_UNBIND_QUEUE = 1029U,
    AICPU_UNBIND_QUEUE_RES = 1030U,
    AICPU_QUERY_QUEUE = 1031U,
    AICPU_QUERY_QUEUE_RES = 1032U,
    AICPU_QUERY_QUEUE_NUM = 1033U,
    AICPU_QUERY_QUEUE_NUM_RES = 1034U,
    AICPU_QUEUE_RELATION_PROCESS = 1035U, // include bind/unbind/query
    AICPU_RELATED_MESSAGE_SPLIT = 2048U,
    ACL_BIND_QUEUE = 2049U,
    ACL_BIND_QUEUE_INIT = 2050U,
    ACL_UNBIND_QUEUE = 2051U,
    ACL_QUERY_QUEUE = 2052U,
    ACL_QUERY_QUEUE_NUM = 2053U,
    ACL_QUEUE_RELATION_PROCESS = 2054U, // include bind/unbind/query
    DGW_CREATE_HCOM_HANDLE = 2055U,
    DGW_CREATE_HCOM_TAG = 2056U,
    DGW_DESTORY_HCOM_TAG = 2057U,
    DGW_DESTORY_HCOM_HANDLE = 2058U,
    UPDATE_CONFIG = 2059U,        // update config
    QUERY_CONFIG_NUM = 2060U,     // query config num
    QUERY_CONFIG = 2061U,         // query config
    BIND_HOSTPID = 2062U,       // Bind QS
    QUERY_LINKSTATUS = 2063U,       // query link status
    QUERY_LINKSTATUS_V2 = 2064U,       // query link status
};

struct BQSBindQueueItem {
    uint32_t srcQueueId_;  // source queue ID
    uint32_t dstQueueId_;  // destination queue ID
};

struct BQSBindQueueMbufPoolItem {
    uint32_t queueId;  // 生产者队列ID
    uint32_t mbufPoolId; // mbuf pool id
    uint64_t mbufPoolHeadBaseAddr;
    uint32_t mbufPoolHeadBlkSize;
    uint32_t mbufPoolHeadOffset;
    uint64_t mbufPoolDataBaseAddr;
    uint32_t mbufPoolDataBlkSize;
    uint32_t mbufPoolDataOffset;
    uint64_t freeOpAddr;
};

struct BQSUnbindQueueMbufPoolItem {
    uint32_t queueId;  // 生产者队列ID
    uint32_t mbufPoolId; // mbuf pool id
};

struct BindQueueInterChipInfo{
    /* 本片 */
    uint16_t srcChipSubQid;                    // 本片消费者队列qid，用于订阅本片生产者队列入队数据
    uint16_t srcMbufPoolId;                    // pool id
    uint32_t srcMbufDataPoolBlkSize;           // 实际分配对齐后的blksize，非原始的blksize
    uint32_t srcMbufDataPoolBlkRealSize;       // 原始的blksize
    uint32_t srcMbufHeadPoolBlkSize;           // 实际分配对齐后的blksize，非原始的blksize
    uint32_t srcMbufDataPoolOffset;            // mbuf的data block的偏移
    uint32_t srcMbufHeadPoolOffset;            // mbuf的head block的偏移
    uint64_t srcMbufDataPoolBaseAddr;          // data pool池的基地址
    uint64_t srcMbufHeadPoolBaseAddr;          // head pool池的基地址
    /* 对片 */
    uint8_t  dstChipId;                        // 对片chip id
    uint16_t dstChipQid;                       // 对片生产者qid，本片跨片队列时会将对片mbuf入队到此队列，触发对端的调度
    uint16_t dstMbufPoolId;                    // pool id
    uint32_t dstMbufDataPoolBlkSize;           // 实际分配对齐后的blksize，非原始的blksize
    uint32_t dstMbufDataPoolBlkRealSize;       // 原始的blksize
    uint32_t dstMbufHeadPoolBlkSize;           // 实际分配对齐后的blksize，非原始的blksize
    uint32_t dstMbufDataPoolOffset;            // mbuf的data block的偏移
    uint32_t dstMbufHeadPoolOffset;            // mbuf的head block的偏移
    uint64_t dstMbufDataPoolBaseAddr;          // data pool池的基地址
    uint64_t dstMbufHeadPoolBaseAddr;          // head pool池的基地址
};

struct BQSBindQueueResult {
    int32_t bindResult_;
};

enum QsQueryType : int32_t {
    BQS_QUERY_TYPE_SRC,     // according to source queue
    BQS_QUERY_TYPE_DST,     // according to destination queue
    BQS_QUERY_TYPE_SRC_AND_DST,
    BQS_QUERY_TYPE_SRC_OR_DST,
    BQS_QUERY_TYPE_ABNORMAL_FOR_QUEUE_ERROR = 100
};

enum EventGroupId : int32_t {
    ENQUEUE_GROUP_ID = 5,
    F2NF_GROUP_ID,
    BIND_QUEUE_GROUP_ID,
    ENQUEUE_GROUP_ID_EXTRA,
    F2NF_GROUP_ID_EXTRA
};

enum class BindRelationStatus: int32_t {
    RelationUnknown = -1,
    RelationUnBind,
    RelationBind,
    RelationAbnormalForQError
};

#pragma pack(push, 1)
 // bind queue initial
 // msg content
struct QsBindInit {
    uint64_t syncEventHead;
    int32_t pid; // source pid
    uint32_t grpId; // source event group id
    uint16_t majorVersion;
    char_t rsv[22];
};
 // tsd bind queue
 // msg content
struct QsBindHostPid {
    uint64_t syncEventHead;
    int32_t hostPid; // source pid
    char_t rsv[24];
};
// bind unbind queryResult
// buff header
struct QsRouteHead {
    uint32_t length;             // total length
    uint32_t routeNum;           // route num, number of QueueRoute
    uint32_t subEventId;         // subeventid including bind/unbind/query
    uint64_t userData;
};
// buff content
struct QueueRoute {
    uint32_t srcId;
    uint32_t dstId;
    int32_t status;
    int16_t srcType;
    int16_t dstType;
    uint64_t srcHandle;
    uint64_t dstHandle;
    char_t rsv[8];
};

// msg content
struct QueueRouteList {
    uint64_t syncEventHead;
    uint64_t routeListMsgAddr;
    char_t rsv[24];
};

// query queryNum
// msg content
struct QueueRouteQuery {
    uint64_t syncEventHead;
    uint32_t queryType;
    uint32_t srcId;
    uint32_t dstId;
    int16_t srcType;
    int16_t dstType;
    uint64_t routeListMsgAddr;
    char_t rsv[8];
};

// rsp for all subeventID
struct QsProcMsgRsp {
    uint64_t syncEventHead;
    int32_t retCode;
    uint32_t retValue;  // init:qID queryNum:real bind number
    uint16_t majorVersion; // init:return version
    uint16_t minorVersion; // init:return version
    char_t rsv[20];
};

// dst_egin device_aicpu use this struct
struct QsProcMsgRspDstAicpu {
    uint64_t syncEventHead;
    int32_t retCode;
    uint32_t retValue;  // init:qID queryNum:real bind number
    uint16_t majorVersion; // init:return version
    uint16_t minorVersion; // init:return version
    char_t rsv[16];
};

struct CreateHcomInfo {
    char_t  masterIp[32];
    uint32_t masterPort;
    char_t localIp[32];
    uint32_t localPort;
    char_t remoteIp[32];
    uint32_t remotePort;
    uint64_t handle;  // handle ptr
};

struct CfgRetInfo {
    int32_t retCode;  // result
    char_t rsv[8];    // reserve params
};

struct HcomHandleInfo {
    int32_t rankId;            // local rank id
    uint64_t rankTableLen;     // rank table length
    uint64_t rankTableOffset;  // rank table offset in data filed of mbuf
    uint64_t hcomHandle;       // hcom handle
    char_t rsv[64];            // reserve params
};
#pragma pack(pop)
struct BQSQueryPara {
    QsQueryType keyType_;
    BQSBindQueueItem bqsBindQueueItem_;
};

typedef void (*ExeceptionCallback)(int32_t fd, void *data);  //  pipe is broken when data is nullptr

class __attribute__((visibility("default"))) BqsClient {
public:
    /**
     * Create instance of BqsClient.
     * @return BqsClient*: success, nullptr: error
     */
    static BqsClient *GetInstance(const char_t *const serverProcName, const uint32_t procNameLen,
                                  const ExeceptionCallback fn);

    /**
     * Add bind relation, support batch bind.
     * @return Number of bind relation successm, record already exists indicate successfully add
     */
    uint32_t BindQueue(
        const std::vector<BQSBindQueueItem> &bindQueueVec, std::vector<BQSBindQueueResult> &bindResultVec) const;

    /**
     * Delete bind relation, support batch unbind according to src queueId or dst queueId or src-dst queueId
     * @return Number of unbind relation success, record not exists indicate successfully delete
     */
    uint32_t UnbindQueue(
        const std::vector<BQSQueryPara> &bqsQueryParaVec, std::vector<BQSBindQueueResult> &bindResultVec) const;

    /**
     * Get bind relation, support get bind according to src queueId or dst queueId
     * @return Number of get bind relation success
     */
    uint32_t GetBindQueue(const BQSQueryPara &queryPara, std::vector<BQSBindQueueItem> &bindQueueVec) const;

    /**
     * Get paged bind relation
     * @return Number of get bind relation success
     */
    uint32_t GetPagedBindQueue(const uint32_t offset, const uint32_t limit, std::vector<BQSBindQueueItem> &bindQueueVec,
        uint32_t &total) const;

    /**
     * Get all bind relation
     * @return Number of get bind relation success
     */
    uint32_t GetAllBindQueue(std::vector<BQSBindQueueItem> &bindQueueVec) const;

    uint32_t BindQueueMbufPool(const std::vector<BQSBindQueueMbufPoolItem> &bindQueueVec,
                               std::vector<BQSBindQueueResult> &bindResultVec) const;

    uint32_t UnbindQueueMbufPool(const std::vector<BQSUnbindQueueMbufPoolItem> &bindQueueVec,
                                 std::vector<BQSBindQueueResult> &bindResultVec) const;

    uint32_t BindQueueInterChip(BindQueueInterChipInfo &interChipInfo) const;

    uint32_t UnbindQueueInterChip(uint16_t srcQueueId) const;

    /**
     * Destroy pip of client to server
     * @return 0:success other:failed
     */
    int32_t Destroy() const;

private:
    BqsClient();
    ~BqsClient();

    BqsClient(const BqsClient &) = delete;
    BqsClient(BqsClient &&) = delete;
    BqsClient &operator=(const BqsClient &) = delete;
    BqsClient &operator=(BqsClient &&) = delete;

    uint32_t DoBindQueue(const std::vector<BQSBindQueueItem> &bindQueueVec,
        std::vector<BQSBindQueueResult> &bindResultVec) const;
    uint32_t DoUnbindQueue(const std::vector<BQSQueryPara> &bqsQueryParaVec,
        std::vector<BQSBindQueueResult> &bindResultVec) const;

private:
    static std::mutex mutex_;  // protect initFlag_ and clientFd_
    static int32_t clientFd_;      // pipe fd of client and server
    static bool initFlag_;     // true means initialized
};
}       // namespace bqs
#endif  // QUEUE_SCHEDULE_QS_CLIENT_H
