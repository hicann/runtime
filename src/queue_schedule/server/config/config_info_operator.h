/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CONFIG_INFO_OPERATOR_H
#define CONFIG_INFO_OPERATOR_H

#include <string>
#include "bind_relation.h"
#include "common/bqs_status.h"
#include "queue_schedule/dgw_client.h"

namespace bqs {
class ConfigInfoOperator {
public:
    /**
     * default constructor
     */
    explicit ConfigInfoOperator(const uint32_t deviceId, const std::string groupNames = "");

    /**
     * default destructor
     */
    virtual ~ConfigInfoOperator() = default;

    /**
     * @brief parse config event
     * @param subEventId subEventId
     * @param queueId queue id
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ParseConfigEvent(const uint32_t subEventId, const uint32_t queueId, void *mbuf,
        const uint16_t clientVersion);

    /**
     * process update config
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessUpdateConfig(const uint32_t index);

    /**
     * attach queue process and check src queue read authoriy, dst queue write authority
     * @param src src entity info
     * @param dst dst entity info
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus AttachAndCheckQueue(const EntityInfo& src, const EntityInfo& dst) const;

private:

    // not allow copy constructor and assignment operators
    ConfigInfoOperator(const ConfigInfoOperator &) = delete;

    ConfigInfoOperator &operator=(const ConfigInfoOperator &) = delete;

    ConfigInfoOperator(ConfigInfoOperator &&) = delete;

    ConfigInfoOperator &operator=(ConfigInfoOperator &&) = delete;

    /**
     * process update routes
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessUpdateRoutes(const uint32_t index) const;

    /**
     * preprocess update config info
     * @param mbufData mbuf data addr
     * @param dataLen data len
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus PreprocessUpdateCfgInfo(const uintptr_t mbufData, const uint64_t dataLen);

    /**
     * check and record update config info to updateCfgInfo_
     * @param mbufData mbuf data
     * @param dataLen mbuf data len
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckAndRecordUpdateCfgInfo(const uintptr_t mbufData, const uint64_t dataLen);

    /**
     * check and record update route info to updateCfgInfo_
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckAndRecordRouteInfo() const;

    /**
     * check and record create group info to updateCfgInfo_
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckAndRecordAddGrpInfo() const;

    /**
     * check and record delete group/update profiling info to updateCfgInfo_
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckAndRecordCfgInfo() const;

    BqsStatus CheckAndRecordCommonCfg(const size_t resultOffset) const;

    BqsStatus CheckAndRecordRedeployCfg() const;

    /**
     * check flow queue auth
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckFlowQueueAuth() const;

    /**
     * check queue auth
     * @param queueId queue id
     * @param isSrc is src queue
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckQueueAuth(const uint32_t queueId, const uint32_t resId, const bool isSrc) const;

    /**
     * check queue auth
     * @param info entity info
     * @param isSrc is src queue
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckQueueAuth(const EntityInfo &info, const bool isSrc) const;

    /**
     * check queue auth for group
     * @param groupId group id
     * @param isSrc is src
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CheckQueueAuthForGroup(const uint32_t groupId, const bool isSrc) const;

    /**
     * attach queue
     * @param info entity info
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus AttachQueue(const EntityInfo &info) const;

    /**
     * attach queue in group
     * @param groupId group id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus AttachQueueInGroup(const uint32_t groupId) const;

    /**
     * query config
     * @param mbufData mbuf data addr
     * @param dataLen mbuf data len
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryConfig(const uintptr_t mbufData, const uint64_t dataLen) const;

    /**
     * query config number
     * @param mbufData mbuf data addr
     * @param dataLen mbuf data len
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryConfigNum(const uintptr_t mbufData, const uint64_t dataLen) const;

    /**
     * create hcom handle
     * @param mbufData mbuf data addr
     * @param dataLen mbuf data len
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus CreateHcomHandle(const uintptr_t mbufData, const uint64_t dataLen);

    /**
     * destroy hcom handle
     * @param mbufData mbuf data addr
     * @param dataLen mbuf data len
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus DestroyHcomHandle(const uintptr_t mbufData, const uint64_t dataLen) const;

    /**
     * query group
     * @param mbufData mbuf data addr
     * @param dataLen mbuf data len
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryGroup(const uintptr_t mbufData, const uint64_t dataLen, const bool onlyQryNum) const;

    /**
     * query route by src
     * @param mbufData mbuf data addr
     * @param src src entity info
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryRoutesBySrc(const uintptr_t mbufData, const EntityInfo &src, const bool onlyQryNum) const;

    /**
     * query route by dst
     * @param mbufData mbuf data addr
     * @param dst dst entity info
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryRoutesByDst(const uintptr_t mbufData, const EntityInfo &dst, const bool onlyQryNum) const;

    /**
     * query route by src and dst
     * @param mbufData mbuf data addr
     * @param src src entity info
     * @param dst dst entity info
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryRoutesBySrcAndDst(const uintptr_t mbufData, const EntityInfo &src,
                                     const EntityInfo &dst, const bool onlyQryNum) const;

    /**
     * query all routes
     * @param mbufData mbuf data addr
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus QueryAllRoutes(const uintptr_t mbufData, const bool onlyQryNum) const;

    /**
     * query route
     * @param mbufData mbuf data addr
     * @param dataLen mbuf data len
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus QueryRoutes(const uintptr_t mbufData, const uint64_t dataLen, const bool onlyQryNum) const;

    /**
     * record query result
     * @param routeList routes list
     * @param mbufData mbuf data
     * @param onlyQryNum only query num
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus SaveQueryResult(std::list<std::pair<const EntityInfo *, const EntityInfo *>> &routeList,
                              const uintptr_t mbufData, const bool onlyQryNum) const;

    /**
     * convert to route
     * @param src src entity info
     * @param dst dst entity info
     * @param route route
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ConvertToRoute(const EntityInfo &src, const EntityInfo &dst, Route &route) const;

    /**
     * convert to endpoint
     * @param entity entity info
     * @param endpoint endpoint
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ConvertToEndpoint(const EntityInfo &entity, Endpoint &endpoint) const;

    /**
     * create entity info
     * @param endpoint endpoint
     * @param isQry is query
     * @return entity info pointer
     */
    EntityInfoPtr CreateEntityInfo(const Endpoint &endpoint, const bool isQry) const;

    /**
     * process add group
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessAddGroup() const;

    /**
     * process delete group
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessDelGroup() const;

    /**
     * process update profiling
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessUpdateProfiling() const;

    /**
     * check comm channel attr
     * @param attr comm channel attr
     * @param isQry is query
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus CheckCommChannelAttr(const CommChannelAttr &attr, const bool isQry) const;

    BqsStatus QueryGroupAllocInfo();

    void SplitStringWithDelimeter(const std::string rawStr, const char_t delimeter,
        std::vector<std::string> &results) const;

    BqsStatus QureySelfMemGroup(std::vector<std::string> &groupNames) const;

    BqsStatus ProcessUpdateHcclProtocol() const;

    BqsStatus ProcessInitDynamicSched() const;

    BqsStatus ProcessStopSchedule(const uint32_t index) const;

    BqsStatus ProcessRestartSchedule(const uint32_t index) const;

    void QueryRoutesBySrcFromRelation(const EntityInfo &src, const MapEnitityInfoToInfoSet &srcToDstRelation,
        std::list<std::pair<const EntityInfo*, const EntityInfo*>> &routeList) const;

    void QueryRoutesByDstFromRelation(const EntityInfo &dst, const MapEnitityInfoToInfoSet &dstToSrcRelation,
        std::list<std::pair<const EntityInfo*, const EntityInfo*>> &routeList) const;

    uint32_t ParseDeviceId(const uint32_t rawDeviceId) const;

    BqsStatus SubscribeQueueEvent(const bool isLocalQ, const uint32_t queueId, const uint32_t deviceId,
        const uint32_t resIndex, const bool isEnqueue) const;

    bool IsSvmShareGrp(const std::string &grpName) const;

    // define struct for store update config info
    struct UpdateCfgInfo {
        // mbuf data addr for config
        uintptr_t mbufData;
        // mbuf data len
        uint64_t dataLen;
        // config info
        ConfigInfo *cfgInfo;
        // routes
        std::vector<Route *> routes;
        // endpoints in group
        std::vector<Endpoint *> endpointsInGroup;
        // results
        std::vector<CfgRetInfo *> results;
        // entities in routes: after transform
        std::vector<std::pair<EntityInfoPtr, EntityInfoPtr>> entitiesInRoutes;
        // entities in group: after tranform
        std::vector<EntityInfoPtr> entitiesInGroup;
    };

    // device id
    uint32_t deviceId_ = 0U;
    // record update config info
    std::unique_ptr<UpdateCfgInfo> updateCfgInfo_ = nullptr;
    std::string groupNames_ = "";
    std::vector<GrpQueryGroupAddrInfo> grpAllocInfos_;
    uint16_t clientVersion_;
};
} // namespace bqs
#endif  // CONFIG_INFO_OPERATOR_H