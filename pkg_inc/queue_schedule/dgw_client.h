/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_CLIENT_H
#define DGW_CLIENT_H

#include <memory>
#include <string>
#include <vector>
#include <utility>
#include <list>
#include "common/type_def.h"
#include "queue_schedule/qs_client.h"

namespace bqs {
// max ip len
constexpr size_t MAX_IP_LEN = 16UL;
// max tag name len
constexpr size_t MAX_TAG_NAME_LEN = 128UL;

// config command for datagw
enum class ConfigCmd : int32_t {
    DGW_CFG_CMD_BIND_ROUTE = 0,
    DGW_CFG_CMD_UNBIND_ROUTE = 1,
    DGW_CFG_CMD_QRY_ROUTE = 2,
    DGW_CFG_CMD_ADD_GROUP = 3,
    DGW_CFG_CMD_DEL_GROUP = 4,
    DGW_CFG_CMD_QRY_GROUP = 5,
    DGW_CFG_CMD_RESERVED = 6,
    DGW_CFG_CMD_UPDATE_PROFILING = 7,
    DGW_CFG_CMD_SET_HCCL_PROTOCOL = 8,
    DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE = 9,
    DGW_CFG_CMD_STOP_SCHEDULE = 10,
    DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE = 11
};

// endpoint type
enum class EndpointType : int32_t {
    QUEUE = 0,
    MEM_QUEUE = 1,
    GROUP = 2,
    COMM_CHANNEL = 3,
};

// endpoint status
enum class EndpointStatus : int32_t {
    AVAILABLE = 0,
    UNAVAILABLE = 1,
};

// route status
enum class RouteStatus : int32_t {
    ACTIVE = 0,
    INACTIVE = 1,
    ERROR = 2,
};

// group policy
enum class GroupPolicy : int32_t {
    HASH = 0,
    BROADCAST = 1,
    DYNAMIC = 2,
};

// Query mode
enum class QueryMode : int32_t {
    DGW_QUERY_MODE_SRC_ROUTE = 0,
    DGW_QUERY_MODE_DST_ROUTE = 1,
    DGW_QUERY_MODE_SRC_DST_ROUTE = 2,
    DGW_QUERY_MODE_ALL_ROUTE = 3,
    DGW_QUERY_MODE_GROUP = 4,
    DGW_QUERY_MODE_RESERVED = 5,
};

// qs scheduling policy
enum class SchedPolicy : uint64_t {
    POLICY_UNSUB_F2NF = 1UL,
    POLICY_SUB_BUF_EVENT = 2UL,
};

enum class ProfilingMode : uint32_t {
    PROFILING_CLOSE = 0U,
    PROFILING_OPEN = 1U,
};

enum class HcclProtocolType : uint32_t {
    RDMA = 0U,
    TCP = 1U,
};

#pragma pack(push, 1)
// queue attr: can not named QueueAttr, duplicatable name with driver
struct FlowQueueAttr {
    int32_t queueId;  // queue id
};

struct MemQueueAttr {
    int32_t queueId;  // queue id
    uint32_t queueType; // localQ:0 or clientQ:1
    uint32_t rsv[7];
};

// communication channel attr
struct CommChannelAttr {
    uint64_t handle;         // hcom handle
    uint32_t localTagId;     // local tag id
    uint32_t peerTagId;      // peer tag id
    uint32_t localRankId;    // local rank id
    uint32_t peerRankId;     // peer rank id
    uint32_t localTagDepth;  // local tag depth
    uint32_t peerTagDepth;   // peer tag depth
    uint32_t memType;       // memType: 1-dvpp
    uint32_t rsv[7];         // reserved field
};

// group attr
struct GroupAttr {
    int32_t groupId;       // group id
    GroupPolicy policy;    // only need set for dstination group
    uint32_t endpointNum;  // only used for query result
    uint32_t rootModelId;
};

// endpoint: queue, communication channel, group
struct Endpoint {
    EndpointType type;                      // endpoint type
    EndpointStatus status;                  // endpoint status
    uint32_t peerNum;                       // total instances, used by srcGroup
    uint32_t localId;                       // self id, started by 0, used by srcGroup
    uint32_t globalId;                      // endpoint global id
    uint32_t modelId;
    uint16_t resId;                         // resId
    uint32_t rootModelId;
    char_t rsv[10];                         // reserved field
    union {
        FlowQueueAttr queueAttr;            // queue attr
        MemQueueAttr memQueueAttr;          // mem queue attr
        CommChannelAttr channelAttr;        // communication channel attr
        GroupAttr groupAttr;                // group attr
    } attr;
};

// group query
struct GroupQuery {
    uint32_t endpointNum;  // endpoint num, return value
    int32_t groupId;       // group id
};

// route query
struct RouteQuery {
    uint32_t routeNum;  // route num, return value
    Endpoint src;       // src endpoint
    Endpoint dst;       // dst endpoint
};

// route query or group query
struct ConfigQuery {
    QueryMode mode;           // query mode
    union {
        GroupQuery groupQry;  // group query
        RouteQuery routeQry;  // route query
    } qry;
};

// group config
struct GroupConfig {
    int32_t groupId;       // group id, created by datagw server
    uint32_t endpointNum;  // endpoint number
    Endpoint *endpoints;   // multi queue or channel, memory malloc by user
};

// route info
struct Route {
    RouteStatus status;  // route status
    Endpoint src;        // src endpoint
    Endpoint dst;        // dst endpoint
    char_t rsv[32];      // reserved param
};

// routes config
struct RoutesConfig {
    uint32_t routeNum;  // route number
    Route *routes;      // routes, memory malloc by user
};

// profiling config
struct ProfilingConfig {
    ProfilingMode profMode;  // profiling mode
};

struct HcclProtocolConfig {
    HcclProtocolType protocol;
};

struct DynamicSchedQueueAttr {
    uint32_t queueId;
    uint32_t deviceId;
    int32_t deviceType;
    uint32_t globalLogicId;
    bool isClientQ;
};

struct DynamicSchedConfigV2 {
    uint32_t rootModelId;
    DynamicSchedQueueAttr requestQ;
    DynamicSchedQueueAttr responseQ;
    char rsv[26];
};

struct ReDeployConfig {
    uint64_t rootModelIdsAddr;   // ptr which point to rootModelIds(uint32_t)
    uint32_t rootModelNum;  // rootModelId's number
    char rsv[4];
};

// config info, group config or routes config
struct ConfigInfo {
    ConfigCmd cmd;               // query mode, user donot need fill this param
    union {
        GroupConfig groupCfg;     // group config
        RoutesConfig routesCfg;   // routes config
        ProfilingConfig profCfg;  // profiling config
        HcclProtocolConfig hcclProtocolCfg;
        DynamicSchedConfigV2 *dynamicSchedCfgV2;
        ReDeployConfig reDeployCfg;
    } cfg;
};

// identify info in mbuf head
struct IdentifyInfo {
    uint64_t transId = 0UL;  // transaction id
    char_t rsv[52];          // reserved param
    uint32_t routeLabel;
};

#pragma pack(pop)

class __attribute__((visibility("default"))) DgwClient {
public:
    /**
     * Create instance of dgwClient.
     * @param deviceId  The id of self cpu.
     * @return std::shared_ptr<DgwClient>: DgwClient ptr
     */
    static std::shared_ptr<DgwClient> GetInstance(const uint32_t deviceId);

    static std::shared_ptr<DgwClient> GetInstance(const uint32_t deviceId, const pid_t qsPid);

    static std::shared_ptr<DgwClient> GetInstance(const uint32_t deviceId, const pid_t qsPid, const bool proxy);

    /**
     * Initialize dgw server
     * @param dgwPid dgw server process id
     * @param procSign procSign
     * @return 0:success, other:failed.
     */
    int32_t Initialize(const uint32_t dgwPid, const std::string procSign, const bool isProxy = false,
        const int32_t timeout = -1);

    /**
     * Destroy dgw client
     * @param dgwPid dgw server process id
     * @param procSign procSign
     * @return 0:success, other:failed.
     */
    int32_t Finalize();

    /**
     * Create hccl communication handle
     * @param rankTable rank table
     * @param rankId rank id
     * @param reserve reserve params
     * @param handle handle
     * @return  0:success, other:failed.
     */
    int32_t CreateHcomHandle(const std::string &rankTable, const int32_t rankId,
                             const void * const reserve, uint64_t &handle, const int32_t timeout = -1);

    /**
     * Destroy hccl communication handle
     * @param handle handle
     * @return 0:success, other:failed.
     */
    int32_t DestroyHcomHandle(const uint64_t handle, const int32_t timeout = -1);

    /**
     * Construct a new DgwClient object
     * @param deviceId device Id
     */
    explicit DgwClient(const uint32_t deviceId);

    explicit DgwClient(const uint32_t deviceId, const pid_t qsPid);

    explicit DgwClient(const uint32_t deviceId, const pid_t qsPid, const bool proxy);

    /**
     * Destroy the DgwClient object - default method
     */
    ~DgwClient() = default;

public:
    /**
     * Update route config or group config
     * config routes: any route config failed, return failed
     * config group: group config failed, return failed
     * @param cfgInfo group config or route config
     * @param cfgRets config results
     * @return 0:success, other:failed.
     */
    int32_t UpdateConfig(ConfigInfo &cfgInfo, std::vector<int32_t> &cfgRets, const int32_t timeout = -1);

    /**
     * Query Route number or endpoint number in group
     * @param query config query info
     * @return 0:success, other:failed.
     */
    int32_t QueryConfigNum(ConfigQuery &query, const int32_t timeout = -1);

    /**
     * Query routes or group config
     * @param query config query info
     * @param cfgInfo routes config or group config
     * @return 0:success, other:failed.
     */
    int32_t QueryConfig(const ConfigQuery &query, ConfigInfo &cfgInfo, const int32_t timeout = -1);

    /**
     * wait config effect
     * @param timeout(s)
     * @return 0:success, other:failed.
     */
    int32_t WaitConfigEffect(const uint64_t timeout);

    /**
     * wait config effect
     * @param rsv 0:等待tag建链完成，如果没有tag要建链也直接返回成功
     * @param timeout(s)
     * @return 0:success, other:failed.
     */
    int32_t WaitConfigEffect(const int32_t rsv, const int32_t timeout);

private:
    // config params for reducing parameters of API, only used inner
    struct ConfigParams {
        HcomHandleInfo *info;  // hcom handle info, only invalid for create hcom handle
        ConfigQuery *query;    // config query, only invalid for query
        ConfigInfo *cfgInfo;   // config info
        size_t cfgLen;         // config length
        size_t totalLen;       // total length for mbuf
    };

private:
    /**
     * Send synchronization event
     * @param msg message
     * @param msgLen message length
     * @param subEventId subevent id
     * @param timeout  ms
     * @param qsProcMsgRsp return value
     * @return 0:success, other:failed.
     */
    int32_t SendEventToQsSync(const void *const msg, const size_t msgLen, const QueueSubEventType subEventId,
                              QsProcMsgRsp &qsProcMsgRsp, const int32_t timeout = -1) const;
    /**
     * Check and calculate config info length
     * @param cfgInfo config info
     * @param cfgLen config length
     * @param dataList data list which need copy to mbuf
     * @param spareRoutes spare routes which transform memq to q
     * @param spareEndpoints spare endpoint which transform memq to q
     * @return 0:success, other:failed.
     */
    int32_t CalcConfigInfoLen(const ConfigInfo &cfgInfo, size_t &cfgLen,
                              std::list<std::pair<uintptr_t, size_t>> &dataList,
                              std::unique_ptr<Route[]> &spareRoutes,
                              std::unique_ptr<Endpoint[]> &spareEndpoints) const;

    /**
     * Get operate configuration result
     * @param cfgInfo config info
     * @param mbufData mbuf data addr
     * @param cfgLen config info len
     * @param cfgRets config results only for update config
     * @param cmdRet command result
     * @return 0:success, other:failed.
     */
    int32_t GetOperateConfigRet(ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                                std::vector<int32_t> &cfgRets, int32_t &cmdRet) const;

    /**
     * Get operate configuration result
     * @param subEventId subevent id
     * @param cfgParams config params
     * @param dataList data list which need copy to mbuf
     * @param cfgRets config results only for update config
     * @return 0:success, other:failed.
     */
    int32_t OperateConfigToServer(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
                                  std::list<std::pair<uintptr_t, size_t>> &dataList,
                                  std::vector<int32_t> &cfgRets, const int32_t timeout = -1);

    /**
     * Calculate result length
     * @param cfgInfo config info
     * @param retLen result length
     * @return 0:success, other:failed.
     */
    int32_t CalcResultLen(const ConfigInfo &cfgInfo, size_t &retLen) const;

    /**
     * Get query config num result
     * @param query config query
     * @param mbufData mbuf data
     * @param cmdRet cmd result
     * @return 0:success, other:failed.
     */
    int32_t GetQryConfigNumRet(ConfigQuery &query, const uintptr_t mbufData, int32_t &cmdRet) const;

    /**
     * Query and check config num
     * @param query config query
     * @param cfgInfo config info
     * @return 0:success, other:failed.
     */
    int32_t CheckConfigNum(const ConfigQuery &query, ConfigInfo &cfgInfo);

    /**
     * Get operate group result
     * @param cfgInfo config info
     * @param mbufData mbuf data addr
     * @param cfgLen config info len
     * @param cfgRets config results only for update config
     * @param cmdRet command result
     * @return 0:success, other:failed.
     */
    int32_t GetUpdateGroupRet(ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                              std::vector<int32_t> &cfgRets, int32_t &cmdRet) const;

    /**
     * Get operate route result
     * @param cfgInfo config info
     * @param mbufData mbuf data addr
     * @param cfgLen config info len
     * @param cfgRets config results only for update config
     * @param cmdRet command result
     * @return 0:success, other:failed.
     */
    int32_t GetUpdateRouteRet(const ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                              std::vector<int32_t> &cfgRets, int32_t &cmdRet) const;

    /**
     * Get query route result
     * @param cfgInfo config info
     * @param mbufData mbuf data addr
     * @param cfgLen config info len
     * @param cfgRets config results only for update config
     * @param cmdRet command result
     * @return 0:success, other:failed.
     */
    int32_t GetQryRouteRet(const ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                           std::vector<int32_t> &cfgRets, int32_t &cmdRet) const;

    /**
     * Get query group result
     * @param cfgInfo config info
     * @param mbufData mbuf data addr
     * @param cfgLen config info len
     * @param cfgRets config results only for update config
     * @param cmdRet command result
     * @return 0:success, other:failed.
     */
    int32_t GetQryGroupRet(const ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                           std::vector<int32_t> &cfgRets, int32_t &cmdRet) const;

    /**
     * Get operate hcom handle result
     * @param subEventId sub event id
     * @param info hcom handle info
     * @param mbufData mbuf data
     * @param cfgLen config info len
     * @param cmdRet command result
     * @return 0:success, other:failed.
     */
    int32_t GetOperateHcomHandleRet(const QueueSubEventType subEventId, HcomHandleInfo &info,
                                    const uintptr_t mbufData, const size_t cfgLen, int32_t &cmdRet) const;

    int32_t ProcessEndpointDeviceId(Endpoint &endpoint) const;

private:
    int32_t OperateToServerOnSameSide(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
                                      std::list<std::pair<uintptr_t, size_t>> &dataList,
                                      std::vector<int32_t> &cfgRets, const int32_t timeout);
    int32_t OperateToServerOnOtherSide(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
                                       std::list<std::pair<uintptr_t, size_t>> &dataList,
                                       std::vector<int32_t> &cfgRets, const int32_t timeout);
    void ExtractRetCode(const QueueSubEventType subEventId, const ConfigParams &cfgParams, const uintptr_t respPtr,
                        std::vector<int32_t> &cfgRets, int32_t &cmdRet) const;
    int32_t InformServer(const QueueSubEventType subEventId, int32_t &cmdRet, const int32_t timeout);

    static int32_t GetPlatformInfo(const uint32_t deviceId);

    static bool IsNumeric(const std::string& str);

    static bool IsSupportSetVisibleDevices();

    static void SplitString(const std::string &str, std::vector<std::string> &result);

    static bool GetVisibleDevices();

    static int32_t ChangeUserDeviceIdToLogicDeviceId(const uint32_t userDevId, uint32_t &logicDevId);

    static int32_t ChangeDynamicScheduleDeviceId(const ConfigInfo &cfgInfo);

    uint32_t deviceId_;
    // dgw server pid
    pid_t qsPid_;
    // proc sign
    std::string procSign_;
    // dgw client pid
    pid_t curPid_;
    // dgw client group id
    uint32_t curGroupId_;
    // dgw client and qs server pipline queue id
    uint32_t piplineQueueId_;
    // dgw initialized flag
    bool initFlag_;
    std::mutex eventMutex_;
    std::mutex mutexForWaitConfig;
    bool isProxy_;
    bool isServerOldVersion_;
};
} // namespace bqs
#endif