/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "config/config_info_operator.h"

#include <set>
#include <securec.h>
#include <sstream>

#include "hccl/hccl_ex.h"
#include "hccl/comm_channel_manager.h"
#include "common/type_def.h"
#include "queue_schedule/dgw_client.h"
#include "common/bqs_log.h"
#include "queue_manager.h"
#include "profile_manager.h"
#include "statistic_manager.h"
#include "subscribe_manager.h"
#include "schedule_config.h"
#include "dynamic_sched_mgr.hpp"
#include "queue_schedule_hal_interface_ref.h"

namespace bqs {
namespace {
// allowed max routes number
constexpr size_t MAX_ROUTES_NUM = 8000UL;
// allowed max endpoints number in one group
constexpr uint32_t MAX_ENDPOINTS_NUM_IN_SINGLE_GROUP = 1000U;
// max tag depth: hccl tag depth is 1024, so here is 1024/2
constexpr uint32_t MAX_TAG_DEPTH = 512U;
constexpr uint64_t INITIAL_MEMORY_SIZE = 5UL * 1024UL * 1024UL * 1024UL;  // 5G
constexpr uint16_t RESOURCE_ID_HOST_DEVICE_BIT_NUM = 14;
constexpr uint16_t RESOURCE_ID_ENABLE_BIT_MASK = 0x8000;
constexpr uint16_t ROUCE_ID_DEVICE_ID_DATA_MASK = 0x3FFF;
const std::unordered_set<int32_t> CMD_PROCESSED_BY_ALL_RES = {
    static_cast<int32_t>(ConfigCmd::DGW_CFG_CMD_BIND_ROUTE),
    static_cast<int32_t>(ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE),
    static_cast<int32_t>(ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE),
    static_cast<int32_t>(ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE)};
}

ConfigInfoOperator::ConfigInfoOperator(const uint32_t deviceId, const std::string groupNames)
    : deviceId_(deviceId), groupNames_(groupNames), clientVersion_(0U)
{}

BqsStatus ConfigInfoOperator::ParseConfigEvent(const uint32_t subEventId, const uint32_t queueId, void *mbuf,
    const uint16_t clientVersion)
{
    clientVersion_ = clientVersion;
    // get data buffer from mbuf
    void *mbufData = nullptr;
    auto getBuffRet = halMbufGetBuffAddr(PtrToPtr<void, Mbuf>(mbuf), &mbufData);
    if ((getBuffRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (mbufData == nullptr)) {
        BQS_LOG_ERROR("halMbufGetBuffAddr from queue[%u] in device[%u] failed, error[%d]",
            queueId, deviceId_, getBuffRet);
        return BQS_STATUS_DRIVER_ERROR;
    }
    // get mbuf len
    uint64_t dataLen = 0UL;
    getBuffRet = halMbufGetDataLen(PtrToPtr<void, Mbuf>(mbuf), &dataLen);
    if (getBuffRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("halMbufGetDataLen from queue[%u] in device[%u] failed, error[%d]",
            queueId, deviceId_, getBuffRet);
        return BQS_STATUS_DRIVER_ERROR;
    }

    // statistic info
    auto ret = BQS_STATUS_OK;
    const uintptr_t mbufDataAddr = PtrToValue(mbufData);
    const QueueSubEventType subEventType = static_cast<QueueSubEventType>(subEventId);
    switch (subEventType) {
        case QueueSubEventType::UPDATE_CONFIG: {
            ret = PreprocessUpdateCfgInfo(mbufDataAddr, static_cast<uint64_t>(dataLen));
            break;
        }
        case QueueSubEventType::QUERY_CONFIG_NUM: {
            ret = QueryConfigNum(mbufDataAddr, static_cast<uint64_t>(dataLen));
            break;
        }
        case QueueSubEventType::QUERY_CONFIG: {
            ret = QueryConfig(mbufDataAddr, static_cast<uint64_t>(dataLen));
            break;
        }
        case QueueSubEventType::DGW_CREATE_HCOM_HANDLE: {
            ret = CreateHcomHandle(mbufDataAddr, static_cast<uint64_t>(dataLen));
            break;
        }
        case QueueSubEventType::DGW_DESTORY_HCOM_HANDLE: {
            ret = DestroyHcomHandle(mbufDataAddr, static_cast<uint64_t>(dataLen));
            break;
        }
        default: {
            BQS_LOG_ERROR("Unsupport subEventId[%u] in bind relation procedure", subEventId);
            ret = BQS_STATUS_PARAM_INVALID;
            break;
        }
    }
    return ret;
}

BqsStatus ConfigInfoOperator::ProcessUpdateConfig(const uint32_t index)
{
    BQS_LOG_INFO("Update config[add/del group, bind/unbind route], stage [server:process]");
    // no need to check cfgInfo and updateCfgInfo_ nullptr
    ConfigInfo * const cfgInfo = updateCfgInfo_->cfgInfo;
    if ((CMD_PROCESSED_BY_ALL_RES.count(static_cast<int32_t>(cfgInfo->cmd)) == 0U) && (index != 0U)) {
        BQS_LOG_INFO("Thread[%u] need not process cmd[%d]", index, static_cast<int32_t>(cfgInfo->cmd));
        return BQS_STATUS_OK;
    }

    auto ret = BQS_STATUS_OK;
    switch (cfgInfo->cmd) {
        case ConfigCmd::DGW_CFG_CMD_BIND_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE: {
            ret = ProcessUpdateRoutes(index);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_ADD_GROUP: {
            ret = ProcessAddGroup();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_DEL_GROUP: {
            ret = ProcessDelGroup();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING: {
            ret = ProcessUpdateProfiling();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL: {
            ret = ProcessUpdateHcclProtocol();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE: {
            ret = ProcessInitDynamicSched();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE: {
            ret = ProcessStopSchedule(index);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE: {
            ret = ProcessRestartSchedule(index);
            break;
        }
        default: {
            ret = BQS_STATUS_PARAM_INVALID;
            BQS_LOG_WARN("cmd[%d] is invalid.", static_cast<int32_t>(cfgInfo->cmd));
            break;
        }
    }
    return ret;
}

BqsStatus ConfigInfoOperator::QueryConfig(const uintptr_t mbufData, const uint64_t dataLen) const
{
    ConfigQuery * const cfgQry = PtrToPtr<void, ConfigQuery>(ValueToPtr(mbufData));
    if (cfgQry->mode == QueryMode::DGW_QUERY_MODE_GROUP) {
        return QueryGroup(mbufData, dataLen, false);
    }
    return QueryRoutes(mbufData, dataLen, false);
}

BqsStatus ConfigInfoOperator::QueryConfigNum(const uintptr_t mbufData, const uint64_t dataLen) const
{
    ConfigQuery * const cfgQry = PtrToPtr<void, ConfigQuery>(ValueToPtr(mbufData));
    if (cfgQry->mode == QueryMode::DGW_QUERY_MODE_GROUP) {
        return QueryGroup(mbufData, dataLen, true);
    }
    return QueryRoutes(mbufData, dataLen, true);
}

void ConfigInfoOperator::SplitStringWithDelimeter(const std::string rawStr, const char_t delimeter,
                                                  std::vector<std::string> &results) const
{
    if (rawStr.empty()) {
        BQS_LOG_INFO("str to split is empty");
        return;
    }
    std::stringstream strStream(rawStr);
    std::string strElement;
    while (getline(strStream, strElement, delimeter)) {
        results.emplace_back(strElement);
    }
}

BqsStatus ConfigInfoOperator::QueryGroupAllocInfo()
{
    if (!grpAllocInfos_.empty()) {
        BQS_LOG_INFO("grpAllocInfos_ has been inited");
        return BQS_STATUS_OK;
    }
    std::vector<std::string> groupNames;
    if (groupNames_.empty()) {
        const auto ret = QureySelfMemGroup(groupNames);
        if (ret != BQS_STATUS_OK) {
            return ret;
        }
    } else {
        SplitStringWithDelimeter(groupNames_, ',', groupNames);
    }
    for (const auto &groupName: groupNames) {
        GrpQueryGroupAddrPara queryPara = {};
        const errno_t eRet = memcpy_s(queryPara.grpName, BUFF_GRP_NAME_LEN,
            PtrToPtr<const char, const void>(groupName.c_str()) , strlen(groupName.c_str()) + 1);
        if (eRet != EOK) {
            BQS_LOG_ERROR("Failed to memcpy, ret[%d].", eRet);
            grpAllocInfos_.clear();
            return BQS_STATUS_INNER_ERROR;
        }
        queryPara.devId = deviceId_;

        GrpQueryGroupAddrInfo queryResults[BUFF_GROUP_ADDR_MAX_NUM] = {};
        uint32_t resultSize = 0U;
        const auto drvRet = halGrpQuery(GRP_QUERY_GROUP_ADDR_INFO, &queryPara,
            static_cast<uint32_t>(sizeof(queryPara)), &queryResults[0U], &resultSize);
        if ((drvRet != DRV_ERROR_NONE) || (static_cast<size_t>(resultSize) < sizeof(GrpQueryGroupAddrInfo))) {
            BQS_LOG_ERROR("Failed to halGrpQuery for group[%s], device[%u], ret[%d], resultSize[%u]",
                queryPara.grpName, queryPara.devId, static_cast<int32_t>(drvRet), resultSize);
            grpAllocInfos_.clear();
            return BQS_STATUS_DRIVER_ERROR;
        }

        const uint32_t resultLen = static_cast<uint32_t>(resultSize / sizeof(GrpQueryGroupAddrInfo));
        for (uint32_t index = 0U; index < resultLen; ++index) {
            grpAllocInfos_.emplace_back(queryResults[static_cast<size_t>(index)]);
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::QureySelfMemGroup(std::vector<std::string> &groupNames) const
{
    std::unique_ptr<GroupQueryOutput> groupInfoPtr(new (std::nothrow) GroupQueryOutput());
    if (groupInfoPtr == nullptr) {
        BQS_LOG_ERROR("Fail to allocate GroupQueryOutput");
        return BQS_STATUS_INNER_ERROR;
    }
    GroupQueryOutput &groupInfo = *(groupInfoPtr.get());
    uint32_t groupInfoLen = 0U;
    pid_t curPid = drvDeviceGetBareTgid();
    // query group info for current qs process
    auto drvRet = halGrpQuery(GRP_QUERY_GROUPS_OF_PROCESS, &curPid, static_cast<uint32_t>(sizeof(curPid)),
        PtrToPtr<GroupQueryOutput, void>(&groupInfo), &groupInfoLen);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("halGrpQuery of qs[%d] failed, ret[%d]", curPid, drvRet);
        return BQS_STATUS_DRIVER_ERROR;
    }
    // not in any group, can not do attach process
    if (groupInfoLen == 0U) {
        BQS_LOG_WARN("QS has not been added to any memory group!");
        return BQS_STATUS_OK;
    }
    if ((groupInfoLen % sizeof(groupInfo.grpQueryGroupsOfProcInfo[0])) != 0U) {
        BQS_LOG_ERROR("Group info size[%d] is invalid", groupInfoLen);
        return BQS_STATUS_DRIVER_ERROR;
    }
    const uint32_t groupNum = static_cast<uint32_t>(groupInfoLen / sizeof(groupInfo.grpQueryGroupsOfProcInfo[0]));
    for (uint32_t i = 0U; i < groupNum; ++i) {
        std::string grpName(groupInfo.grpQueryGroupsOfProcInfo[i].groupName);
        if (!IsSvmShareGrp(grpName)) {
            groupNames.emplace_back(grpName);
        }
    }
    return BQS_STATUS_OK;
}

bool ConfigInfoOperator::IsSvmShareGrp(const std::string &grpName) const
{
    return grpName.find("svm_share_grp") != std::string::npos;
}

BqsStatus ConfigInfoOperator::CreateHcomHandle(const uintptr_t mbufData, const uint64_t dataLen)
{
    const auto queryGroupRet = QueryGroupAllocInfo();
    if (queryGroupRet != BQS_STATUS_OK) {
        return queryGroupRet;
    }
    HcomHandleInfo * const info = PtrToPtr<void, HcomHandleInfo>(ValueToPtr(mbufData));
    if (info->rankTableLen == 0UL) {
        BQS_LOG_ERROR("Invalid rank table len[%lu].", info->rankTableLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    uint32_t tempAddHcomTab = 0U;
    bool isOverflow = false;
    BqsCheckAssign32UAdd(static_cast<uint32_t>(sizeof(HcomHandleInfo)), info->rankTableLen, tempAddHcomTab, isOverflow);
    if (isOverflow) {
        BQS_LOG_ERROR("tempAddHcomTab[%u] is invalid.", tempAddHcomTab);
        return BQS_STATUS_PARAM_INVALID;
    }

    uint32_t cfgLen = 0U;
    BqsCheckAssign32UAdd(tempAddHcomTab, static_cast<uint32_t>(sizeof(CfgRetInfo)), cfgLen, isOverflow);
    if (isOverflow) {
        BQS_LOG_ERROR("cfgLen[%u] is invalid.", cfgLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    // check dataLen
    if (dataLen < cfgLen) {
        BQS_LOG_ERROR("dataLen[%lu] is invalid, cfgLen is [%zu].", dataLen, cfgLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    // get rank table
    char_t * const rankTablePtr = PtrToPtr<void, char>(ValueToPtr(mbufData + sizeof(HcomHandleInfo)));
    const std::string rankTable(rankTablePtr, info->rankTableLen);

    auto result = BQS_STATUS_OK;
    // create hcom handle
    CommAttr attr = {};
    attr.deviceId = deviceId_;
    HcclComm hcomHandle = nullptr;
    const HcclResult hcclRet = HcclInitComm(rankTable.c_str(), static_cast<uint32_t>(info->rankId), &attr, &hcomHandle);
    if (hcclRet != HCCL_SUCCESS) {
        result = BQS_STATUS_HCCL_ERROR;
        BQS_LOG_ERROR("Failed to create hcom handle, hccl ret is[%d].", static_cast<int32_t>(hcclRet));
    } else {
        for (const auto &grpAllocInfo: grpAllocInfos_) {
            const uint64_t memorySize = (bqs::RunContext::HOST != bqs::GetRunContext()) ?
                static_cast<uint64_t>(grpAllocInfo.size) : INITIAL_MEMORY_SIZE;
            const auto registerRet = HcclRegisterMemory(hcomHandle,
                ValueToPtr(static_cast<uint64_t>(grpAllocInfo.addr)), memorySize);
            if (registerRet != HCCL_SUCCESS) {
                result = BQS_STATUS_HCCL_ERROR;
                BQS_LOG_ERROR("Failed to register memory, hccl ret is[%d].", static_cast<int32_t>(registerRet));
                HcclFinalizeComm(hcomHandle);
                break;
            }
            BQS_LOG_INFO("Register meomory size[%lu]", memorySize);
        }
        if (result == BQS_STATUS_OK) {
            info->hcomHandle = PtrToValue(hcomHandle);
            BQS_LOG_INFO("Success to create hcom handle[%lu]", info->hcomHandle);
        }
    }

    // write result to mbuf
    CfgRetInfo * const retInfo = PtrToPtr<void, CfgRetInfo>(
        ValueToPtr(mbufData + sizeof(HcomHandleInfo) + info->rankTableLen));
    retInfo->retCode = static_cast<int32_t>(result);

    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::DestroyHcomHandle(const uintptr_t mbufData, const uint64_t dataLen) const
{
    HcomHandleInfo * const info = PtrToPtr<void, HcomHandleInfo>(ValueToPtr(mbufData));
    // check dataLen
    bool overFlow = false;
    uint64_t cfgLen = BqsCheckAssign64UAdd(static_cast<uint64_t>(sizeof(HcomHandleInfo) + sizeof(CfgRetInfo)),
        info->rankTableLen, overFlow);
    if (overFlow || (dataLen < cfgLen)) {
        BQS_LOG_ERROR("dataLen[%lu] is invalid, cfgLen is [%lu].", dataLen, cfgLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    // get hcom handle from mbuf
    const HcclComm hcomHandle = ValueToPtr(info->hcomHandle);
    if (hcomHandle == nullptr) {
        BQS_LOG_ERROR("Hcom handle is nullptr.");
        return BQS_STATUS_PARAM_INVALID;
    }
    BQS_LOG_RUN_INFO("Begin to Destroy hcom handle[%lu].", info->hcomHandle);
    for (const auto &grpAllocInfo: grpAllocInfos_) {
        const auto unRegisterRet = HcclUnregisterMemory(hcomHandle,
            ValueToPtr(static_cast<uint64_t>(grpAllocInfo.addr)));
        if (unRegisterRet != HCCL_SUCCESS) {
            BQS_LOG_ERROR("Failed to unRegister memory, hccl ret is[%d].", static_cast<int32_t>(unRegisterRet));
        }
    }
    BQS_LOG_RUN_INFO("After HcclUnregisterMemory when Destroy hcom handle[%lu].", info->hcomHandle);

    // destroy hcom handle
    auto result = BQS_STATUS_OK;
    const HcclResult hcclRet = HcclFinalizeComm(hcomHandle);
    if (hcclRet != HCCL_SUCCESS) {
        result = BQS_STATUS_HCCL_ERROR;
        BQS_LOG_ERROR("Failed to destroy hcom handle, hccl ret is[%d].", static_cast<int32_t>(hcclRet));
    } else {
        BQS_LOG_INFO("Success to destroy hcom handle[%lu]", info->hcomHandle);
    }
    BQS_LOG_RUN_INFO("After HcclFinalizeComm when Destroy hcom handle[%lu].", info->hcomHandle);

    // write result to mbuf
    CfgRetInfo * const retInfo = PtrToPtr<void, CfgRetInfo>(
        ValueToPtr(mbufData + sizeof(HcomHandleInfo) + info->rankTableLen));
    retInfo->retCode = static_cast<int32_t>(result);

    bqs::StatisticManager::GetInstance().ResetStatistic();
    bqs::ProfileManager::GetInstance(0U).ResetProfiling();
    if (GlobalCfg::GetInstance().GetNumaFlag()) {
        bqs::ProfileManager::GetInstance(1U).ResetProfiling();
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::QueryGroup(const uintptr_t mbufData, const uint64_t dataLen, const bool onlyQryNum) const
{
    if (dataLen < sizeof(ConfigQuery)) {
        BQS_LOG_ERROR("dataLen[%lu] is invalid.", dataLen);
        return BQS_STATUS_PARAM_INVALID;
    }
    // no need check cfgQry nullptr
    ConfigQuery * const cfgQry = PtrToPtr<void, ConfigQuery>(ValueToPtr(mbufData));
    const uint32_t groupId = static_cast<uint32_t>(cfgQry->qry.groupQry.groupId);
    auto &entitiesInGroup = BindRelation::GetInstance().GetEntitiesInGroup(groupId);

    const size_t endpointNum = onlyQryNum ? 0UL : cfgQry->qry.routeQry.routeNum;
    // check total len
    const size_t totalLen = onlyQryNum ? (sizeof(ConfigQuery) + sizeof(CfgRetInfo)) :
        (sizeof(ConfigQuery) + sizeof(ConfigInfo) + (endpointNum * sizeof(Endpoint)) + sizeof(CfgRetInfo));
    if (dataLen != totalLen) {
        BQS_LOG_ERROR("mbuf dataLen[%lu] is not equal with totalLen[%zu].", dataLen, totalLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    if (onlyQryNum) {
        cfgQry->qry.groupQry.endpointNum = static_cast<uint32_t>(entitiesInGroup.size());
        CfgRetInfo * const retInfo = PtrToPtr<void, CfgRetInfo>(ValueToPtr(mbufData + sizeof(ConfigQuery)));
        retInfo->retCode = (cfgQry->qry.groupQry.endpointNum == 0U) ?
            static_cast<int32_t>(BQS_STATUS_GROUP_NOT_EXIST) : static_cast<int32_t>(BQS_STATUS_OK);
        BQS_LOG_INFO("endpointNum is %u in group[%u].", cfgQry->qry.groupQry.endpointNum, groupId);
        return BQS_STATUS_OK;
    }

    // check number
    const uintptr_t results = mbufData + (totalLen - sizeof(CfgRetInfo));
    CfgRetInfo * const retInfo = PtrToPtr<void, CfgRetInfo>(ValueToPtr(results));
    if (endpointNum != entitiesInGroup.size()) {
        retInfo->retCode = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        BQS_LOG_ERROR("endpoint num in group[%u] info is [%u], but searched endpoint num is [%zu].",
            groupId, endpointNum, entitiesInGroup.size());
        return BQS_STATUS_PARAM_INVALID;
    }

    BQS_LOG_INFO("Group [get], stage [server:process], relation [size:%zu]", entitiesInGroup.size());
    // convert and record route
    Endpoint * const endpoints =
        PtrToPtr<void, Endpoint>(ValueToPtr(mbufData + sizeof(ConfigQuery) + sizeof(ConfigInfo)));
    size_t idx = 0UL;
    for (auto &entity : entitiesInGroup) {
        Endpoint * const endpoint = PtrAdd<Endpoint>(endpoints, endpointNum, idx);
        (void)ConvertToEndpoint(*entity, *endpoint);
        idx++;
    }
    retInfo->retCode = static_cast<int32_t>(BQS_STATUS_OK);
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::QueryRoutes(const uintptr_t mbufData, const uint64_t dataLen, const bool onlyQryNum) const
{
    // check data len
    if (dataLen < sizeof(ConfigQuery)) {
        BQS_LOG_ERROR("dataLen[%lu] is invalid.", dataLen);
        return BQS_STATUS_PARAM_INVALID;
    }
    // no need check cfgQry nullptr
    ConfigQuery * const cfgQry = PtrToPtr<void, ConfigQuery>(ValueToPtr(mbufData));

    const size_t routeNum = onlyQryNum ? 0UL : cfgQry->qry.routeQry.routeNum;
    // check total len
    const size_t totalLen = onlyQryNum ? (sizeof(ConfigQuery) + sizeof(CfgRetInfo)) :
        (sizeof(ConfigQuery) + sizeof(ConfigInfo) + (routeNum * sizeof(Route)) + sizeof(CfgRetInfo));
    if (dataLen != totalLen) {
        BQS_LOG_ERROR("mbuf dataLen[%lu] is not equal with totalLen[%zu].", dataLen, totalLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    auto ret = BQS_STATUS_OK;
    switch (cfgQry->mode) {
        case QueryMode::DGW_QUERY_MODE_SRC_ROUTE: {
            const EntityInfoPtr src = CreateEntityInfo(cfgQry->qry.routeQry.src, true);
            ret = (src == nullptr) ? BQS_STATUS_FAILED : QueryRoutesBySrc(mbufData, *src, onlyQryNum);
            break;
        }
        case QueryMode::DGW_QUERY_MODE_DST_ROUTE: {
            const EntityInfoPtr dst = CreateEntityInfo(cfgQry->qry.routeQry.dst, true);
            ret = (dst == nullptr) ? BQS_STATUS_FAILED : QueryRoutesByDst(mbufData, *dst, onlyQryNum);
            break;
        }
        case QueryMode::DGW_QUERY_MODE_ALL_ROUTE: {
            ret = QueryAllRoutes(mbufData, onlyQryNum);
            break;
        }
        case QueryMode::DGW_QUERY_MODE_SRC_DST_ROUTE: {
            const EntityInfoPtr src = CreateEntityInfo(cfgQry->qry.routeQry.src, true);
            const EntityInfoPtr dst = CreateEntityInfo(cfgQry->qry.routeQry.dst, true);
            ret = ((src == nullptr) || (dst == nullptr)) ? BQS_STATUS_FAILED :
                QueryRoutesBySrcAndDst(mbufData, *src, *dst, onlyQryNum);
            break;
        }
        default: {
            ret = BQS_STATUS_PARAM_INVALID;
            BQS_LOG_ERROR("Unsupported query type{0:src, 1:dst, 2:src-and-dst 3:all}:%d",
                static_cast<int32_t>(cfgQry->mode));
            break;
        }
    }
    return ret;
}

BqsStatus ConfigInfoOperator::QueryRoutesBySrc(const uintptr_t mbufData, const EntityInfo &src,
                                               const bool onlyQryNum) const
{
    std::list<std::pair<const EntityInfo *, const EntityInfo *>> routeList;

    QueryRoutesBySrcFromRelation(src, BindRelation::GetInstance().GetSrcToDstRelation(), routeList);
    if (GlobalCfg::GetInstance().GetNumaFlag()) {
        QueryRoutesBySrcFromRelation(src, BindRelation::GetInstance().GetSrcToDstExtraRelation(), routeList);
    }

    return SaveQueryResult(routeList, mbufData, onlyQryNum);
}

void ConfigInfoOperator::QueryRoutesBySrcFromRelation(const EntityInfo &src,
    const MapEnitityInfoToInfoSet &srcToDstRelation,
    std::list<std::pair<const EntityInfo*, const EntityInfo*>> &routeList) const
{
    const auto iter = srcToDstRelation.find(src);
    if (iter == srcToDstRelation.end()) {
        BQS_LOG_WARN("Record does not exist according to src Id:[%u] type:[%d]", src.GetId(), src.GetType());
    } else {
        // generate route list
        const auto &dstSet = iter->second;
        for (auto dstIter = dstSet.begin(); dstIter != dstSet.end(); ++dstIter) {
            routeList.emplace_back(std::make_pair(&src, &(*dstIter)));
        }
    }
}

BqsStatus ConfigInfoOperator::QueryRoutesByDst(const uintptr_t mbufData, const EntityInfo &dst,
                                               const bool onlyQryNum) const
{
    std::list<std::pair<const EntityInfo *, const EntityInfo *>> routeList;

    QueryRoutesByDstFromRelation(dst, BindRelation::GetInstance().GetDstToSrcRelation(), routeList);
    if (GlobalCfg::GetInstance().GetNumaFlag()) {
        QueryRoutesByDstFromRelation(dst, BindRelation::GetInstance().GetDstToSrcExtraRelation(), routeList);
    }

    return SaveQueryResult(routeList, mbufData, onlyQryNum);
}

void ConfigInfoOperator::QueryRoutesByDstFromRelation(const EntityInfo &dst,
    const MapEnitityInfoToInfoSet &dstToSrcRelation,
    std::list<std::pair<const EntityInfo*, const EntityInfo*>> &routeList) const
{
    const auto iter = dstToSrcRelation.find(dst);
    if (iter == dstToSrcRelation.end()) {
        BQS_LOG_WARN("Record does not exist according to dst Id:[%u] type:[%d]", dst.GetId(), dst.GetType());
    } else {
        const auto &srcSet = iter->second;
        // generate route list
        for (auto srcIter = srcSet.begin(); srcIter != srcSet.end(); ++srcIter) {
            routeList.emplace_back(std::make_pair(&(*srcIter), &dst));
        }
    }
}

BqsStatus ConfigInfoOperator::QueryRoutesBySrcAndDst(const uintptr_t mbufData, const EntityInfo &src,
                                                     const EntityInfo &dst, const bool onlyQryNum) const
{
    uint32_t searchedRouteNum = 0U;
    auto &srcToDstRelation = BindRelation::GetInstance().GetSrcToDstRelation();
    const auto iter = srcToDstRelation.find(src);
    if ((iter != srcToDstRelation.end()) && (iter->second.count(dst) != 0UL)) {
        searchedRouteNum = 1U;
    } else {
        if (GlobalCfg::GetInstance().GetNumaFlag()) {
            const auto &srcToDstRelationTmp = BindRelation::GetInstance().GetSrcToDstExtraRelation();
            const auto it = srcToDstRelationTmp.find(src);
            if ((it != srcToDstRelationTmp.end()) && (it->second.count(dst) != 0UL)) {
                searchedRouteNum = 1U;
            }
        }
    }

    // generate route list
    std::list<std::pair<const EntityInfo *, const EntityInfo *>> routeList;
    if (searchedRouteNum != 0U) {
        routeList.emplace_back(std::make_pair(&src, &dst));
    } else {
        BQS_LOG_WARN("Record does not exist according to src Id:[%u] type:[%d]", src.GetId(), src.GetType());
    }
    return SaveQueryResult(routeList, mbufData, onlyQryNum);
}

BqsStatus ConfigInfoOperator::QueryAllRoutes(const uintptr_t mbufData, const bool onlyQryNum) const
{
    // gennerate route list
    std::list<std::pair<const EntityInfo *, const EntityInfo *>> routeList;
    auto &srcToDstRelation = BindRelation::GetInstance().GetSrcToDstRelation();
    for (auto iter = srcToDstRelation.begin(); iter != srcToDstRelation.end(); ++iter) {
        const auto &dstSet = iter->second;
        for (auto &dst : dstSet) {
            routeList.emplace_back(std::make_pair(&(iter->first), &dst));
        }
    }

    if (GlobalCfg::GetInstance().GetNumaFlag()) {
        const auto &srcToDstRelationTmp = BindRelation::GetInstance().GetSrcToDstExtraRelation();
        for (auto iter = srcToDstRelationTmp.begin(); iter != srcToDstRelationTmp.end(); ++iter) {
            const auto &dstSet = iter->second;
            for (auto &dst : dstSet) {
                routeList.emplace_back(std::make_pair(&(iter->first), &dst));
            }
        }
    }

    return SaveQueryResult(routeList, mbufData, onlyQryNum);
}

BqsStatus ConfigInfoOperator::SaveQueryResult(std::list<std::pair<const EntityInfo *, const EntityInfo *>> &routeList,
                                              const uintptr_t mbufData, const bool onlyQryNum) const
{
    // no need check cfgQry nullptr
    ConfigQuery * const cfgQry = PtrToPtr<void, ConfigQuery>(ValueToPtr(mbufData));
    const size_t totalRouteNum = routeList.size();
    if (onlyQryNum) {
        cfgQry->qry.routeQry.routeNum = static_cast<uint32_t>(totalRouteNum);
        CfgRetInfo * const retInfo = PtrToPtr<void, CfgRetInfo>(ValueToPtr(mbufData + sizeof(ConfigQuery)));
        retInfo->retCode = static_cast<int32_t>(BQS_STATUS_OK);
        return BQS_STATUS_OK;
    }

    // check number
    const size_t routeNum = static_cast<size_t>(cfgQry->qry.routeQry.routeNum);
    const uintptr_t results = mbufData + sizeof(ConfigQuery) + sizeof(ConfigInfo) + (routeNum * sizeof(Route));
    CfgRetInfo * const retInfo = PtrToPtr<void, CfgRetInfo>(ValueToPtr(results));
    if (routeNum != totalRouteNum) {
        retInfo->retCode = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        BQS_LOG_ERROR("Route num in query info is [%lu], but searched route num is [%lu].", routeNum, totalRouteNum);
        return BQS_STATUS_PARAM_INVALID;
    }

    // convert and record route
    Route * const routes = PtrToPtr<void, Route>(ValueToPtr(mbufData + sizeof(ConfigQuery) + sizeof(ConfigInfo)));
    size_t idx = 0UL;
    for (auto iter = routeList.begin(); iter != routeList.end(); ++iter) {
        Route * const route = PtrAdd<Route>(routes, routeNum, idx);
        (void)ConvertToRoute(*(iter->first), *(iter->second), *route);
        idx++;
    }
    retInfo->retCode = static_cast<int32_t>(BQS_STATUS_OK);
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::ConvertToRoute(const EntityInfo &src, const EntityInfo &dst, Route &route) const
{
    route.status = RouteStatus::ACTIVE;
    (void)ConvertToEndpoint(src, route.src);
    (void)ConvertToEndpoint(dst, route.dst);
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::ConvertToEndpoint(const EntityInfo &entity, Endpoint &endpoint) const
{
    auto ret = BQS_STATUS_OK;
    endpoint.status = EndpointStatus::AVAILABLE;
    switch (entity.GetType()) {
        case dgw::EntityType::ENTITY_QUEUE: {
            if (endpoint.type == EndpointType::MEM_QUEUE) {
                endpoint.attr.memQueueAttr.queueId = static_cast<int32_t>(entity.GetId());
            } else {
                endpoint.type = EndpointType::QUEUE;
                endpoint.attr.queueAttr.queueId = static_cast<int32_t>(entity.GetId());
            }
            break;
        }
        case dgw::EntityType::ENTITY_GROUP: {
            endpoint.type = EndpointType::GROUP;
            endpoint.attr.groupAttr.groupId = static_cast<int32_t>(entity.GetId());
            // group policy && endpoint num
            break;
        }
        case dgw::EntityType::ENTITY_TAG: {
            endpoint.type = EndpointType::COMM_CHANNEL;
            CommChannelAttr &attr = endpoint.attr.channelAttr;
            const dgw::CommChannel * const channel = entity.GetCommChannel();
            if (channel != nullptr) {
                attr.handle = PtrToValue(channel->GetHandle());
                attr.localTagId = channel->GetLocalTagId();
                attr.peerTagId = channel->GetPeerTagId();
                attr.localRankId = channel->GetLocalRankId();
                attr.peerRankId = channel->GetPeerRankId();
                attr.localTagDepth = channel->GetLocalTagDepth();
                attr.peerTagDepth = channel->GetPeerTagDepth();
            }
            break;
        }
        default: {
            BQS_LOG_ERROR("Unsupport entity type[%d].", static_cast<int32_t>(entity.GetType()));
            ret = BQS_STATUS_PARAM_INVALID;
            break;
        }
    }
    return ret;
}

EntityInfoPtr ConfigInfoOperator::CreateEntityInfo(const Endpoint &endpoint, const bool isQry) const
{
    uint32_t id = 0U;
    uint32_t localDeviceId = deviceId_;
    OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_INVALID;
    args.schedCfgKey = endpoint.rootModelId;
    args.globalId = endpoint.globalId;
    args.uuId = endpoint.modelId;

    dgw::EntityType &eType = args.eType;
    bqs::GroupPolicy &policy = args.policy;
    const dgw::CommChannel* &channelPtr = args.channelPtr;
    auto ret = BQS_STATUS_OK;
    switch (endpoint.type) {
        case EndpointType::QUEUE: {
            eType = dgw::EntityType::ENTITY_QUEUE;
            id = static_cast<uint32_t>(endpoint.attr.queueAttr.queueId);
            break;
        }
        case EndpointType::MEM_QUEUE: {
            eType = dgw::EntityType::ENTITY_QUEUE;
            id = static_cast<uint32_t>(endpoint.attr.memQueueAttr.queueId);
            break;
        }
        case EndpointType::COMM_CHANNEL: {
            eType = dgw::EntityType::ENTITY_TAG;
            const CommChannelAttr &attr = endpoint.attr.channelAttr;
            ret = CheckCommChannelAttr(attr, isQry);
            if (ret == BQS_STATUS_OK) {
                const dgw::CommChannel channel(ValueToPtr(attr.handle), attr.localTagId, attr.peerTagId,
                                               attr.localRankId, attr.peerRankId, attr.localTagDepth,
                                               attr.peerTagDepth);
                id = dgw::CommChannelManager::GetInstance().GetCommChannelId(channel, channelPtr);
            }
            break;
        }
        case EndpointType::GROUP: {
            eType = dgw::EntityType::ENTITY_GROUP;
            id = static_cast<uint32_t>(endpoint.attr.groupAttr.groupId);
            policy = endpoint.attr.groupAttr.policy;
            break;
        }
        default: {
            ret = BQS_STATUS_PARAM_INVALID;
            BQS_LOG_DEBUG("Unsupport endpoint type[%d].", static_cast<int32_t>(endpoint.type));
            break;
        }
    }
    if (ret != BQS_STATUS_OK) {
        return nullptr;
    }

    if (clientVersion_ >= 2U) {
        args.peerInstanceNum = endpoint.peerNum;
        args.localInstanceIndex = endpoint.localId;
    }

    if (GlobalCfg::GetInstance().GetNumaFlag() && ((endpoint.resId & RESOURCE_ID_ENABLE_BIT_MASK) != 0U)) {
        localDeviceId = (endpoint.resId & ROUCE_ID_DEVICE_ID_DATA_MASK);
    }

    uint32_t &queueType = args.queueType;
    if (endpoint.type == EndpointType::MEM_QUEUE) {
        // parse hostQ and device belonged
        bool isHostQueue = (((endpoint.resId >> RESOURCE_ID_HOST_DEVICE_BIT_NUM) & 1) != 0) ? true : false;
        uint32_t onwerDeviceId = ((endpoint.resId & RESOURCE_ID_ENABLE_BIT_MASK) != 0U) ?
                                  (endpoint.resId & ROUCE_ID_DEVICE_ID_DATA_MASK) : deviceId_;
        localDeviceId = onwerDeviceId;
        queueType = endpoint.attr.memQueueAttr.queueType;
        if ((bqs::GetRunContext() != bqs::RunContext::HOST) && (&drvGetLocalDevIDByHostDevID != nullptr)) {
            auto retCode = drvGetLocalDevIDByHostDevID(onwerDeviceId, &localDeviceId);
            if (retCode != static_cast<int32_t>(DRV_ERROR_NONE)) {
                BQS_LOG_INFO("host devid(%u) transform to local devid.", localDeviceId);
                localDeviceId = onwerDeviceId;
            }
        }
        BQS_LOG_INFO("[CreateEntityInfo] qid=%u, endpoint.resId=%u, isHostQueue=%d, "
                     "onwerDeviceId=%u, localDeviceId=%u, queueType=%u",
                     id, endpoint.resId, isHostQueue, onwerDeviceId, localDeviceId, queueType);
    }

    // create entity info ptr
    EntityInfoPtr entityPtr = nullptr;
    try {
        entityPtr = std::make_shared<EntityInfo>(id, localDeviceId, &args);
    } catch (...) {
        BQS_LOG_ERROR("Create entity info ptr failed, id[%u], type[%d].",
            id, static_cast<int32_t>(eType));
    }

    BQS_LOG_INFO("Create entity success: %s", entityPtr->ToString().c_str());
    return entityPtr;
}

BqsStatus ConfigInfoOperator::AttachAndCheckQueue(const EntityInfo& src, const EntityInfo& dst) const
{
    auto srcRet = AttachQueue(src);
    auto dstRet = AttachQueue(dst);
    auto ret = (srcRet != BQS_STATUS_OK) ? srcRet : dstRet;
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Fail to attach src[%s] or dst[%s], srcRet[%d], dstRet[%d].",
            src.ToString().c_str(), dst.ToString().c_str(), static_cast<int32_t>(srcRet), static_cast<int32_t>(dstRet));
        return ret;
    }

    srcRet = CheckQueueAuth(src, true);
    dstRet = CheckQueueAuth(dst, false);
    ret = (srcRet != BQS_STATUS_OK) ? srcRet : dstRet;
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Fail to check src[%s] or dst[%s] queue auth, srcRet[%d], dstRet[%d].",
            src.ToString().c_str(), dst.ToString().c_str(), static_cast<int32_t>(srcRet), static_cast<int32_t>(dstRet));
        return ret;
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::AttachQueue(const EntityInfo &info) const
{
    auto ret = BQS_STATUS_OK;
    switch (info.GetType()) {
        case dgw::EntityType::ENTITY_TAG: {
            break;
        }
        case dgw::EntityType::ENTITY_QUEUE: {
            const auto drvRet = halQueueAttach(info.GetDeviceId(), info.GetId(), 0);
            if (drvRet != DRV_ERROR_NONE) {
                BQS_LOG_ERROR("Fail to attach queue[%s], device[%u], ret[%d]", info.ToString().c_str(),
                              info.GetDeviceId(), static_cast<int32_t>(drvRet));
                ret = BQS_STATUS_DRIVER_ERROR;
            }
            break;
        }
        case dgw::EntityType::ENTITY_GROUP: {
            ret = AttachQueueInGroup(info.GetId());
            break;
        }
        default: {
            BQS_LOG_ERROR("Invalid entity[%s]", info.ToString().c_str());
            ret = BQS_STATUS_PARAM_INVALID;
            break;
        }
    }
    return ret;
}

BqsStatus ConfigInfoOperator::AttachQueueInGroup(const uint32_t groupId) const
{
    auto &entitiesInGroup = BindRelation::GetInstance().GetEntitiesInGroup(groupId);
    if (entitiesInGroup.empty()) {
        BQS_LOG_ERROR("Group[%u] does not exist.", groupId);
        return BQS_STATUS_GROUP_NOT_EXIST;
    }
    for (const auto &info : entitiesInGroup) {
        if (info == nullptr) {
            BQS_LOG_ERROR("EntityInfo in Group[%u] is nullptr.", groupId);
            return BQS_STATUS_INNER_ERROR;
        }
        // endpoints in group is the same type
        if (info->GetType() == dgw::EntityType::ENTITY_QUEUE) {
            const auto drvRet = halQueueAttach(info->GetDeviceId(), info->GetId(), 0);
            if (drvRet != DRV_ERROR_NONE) {
                BQS_LOG_ERROR("Fail to attach queue[%s] in group[%u], ret[%d]",
                    info->ToString().c_str(), groupId, static_cast<int32_t>(drvRet));
                return BQS_STATUS_DRIVER_ERROR;
            }
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::PreprocessUpdateCfgInfo(const uintptr_t mbufData, const uint64_t dataLen)
{
    // check and record update config info
    auto ret = CheckAndRecordUpdateCfgInfo(mbufData, dataLen);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Record update config info failed.");
        return ret;
    }

    // attach queue and check queue auth
    ret = CheckFlowQueueAuth();
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Check flow queue auth failed.");
        return ret;
    }
    return BQS_STATUS_WAIT;
}

BqsStatus ConfigInfoOperator::CheckFlowQueueAuth() const
{
    ConfigInfo * const cfgInfo = updateCfgInfo_->cfgInfo;
    // create group no need attach queue and check queue auth
    if (cfgInfo->cmd == ConfigCmd::DGW_CFG_CMD_BIND_ROUTE) {
        size_t idx = 0UL;
        for (auto &entityPair : updateCfgInfo_->entitiesInRoutes) {
            // do attach queue and check src own read auth, dst own write auth
            const auto ret = AttachAndCheckQueue(*(entityPair.first), *(entityPair.second));
            if (ret != BQS_STATUS_OK) {
                BQS_LOG_ERROR("Src[%s] Dst[%s] do attach queue and check auth failed",
                    entityPair.first->ToString().c_str(), entityPair.second->ToString().c_str());
            }
            updateCfgInfo_->results[idx]->retCode = static_cast<int32_t>(ret);
            idx++;
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckQueueAuth(const EntityInfo &info, const bool isSrc) const
{
    if (info.GetType() == dgw::EntityType::ENTITY_QUEUE) {
        if (info.GetQueueType() == bqs::CLIENT_Q) {
            return BQS_STATUS_OK;
        }
        return CheckQueueAuth(info.GetId(), info.GetDeviceId(), isSrc);
    }
    if (info.GetType() == dgw::EntityType::ENTITY_GROUP) {
        return CheckQueueAuthForGroup(info.GetId(), isSrc);
    }
    // else, ENTITY_TAG
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckQueueAuthForGroup(const uint32_t groupId, const bool isSrc) const
{
    auto &entityVec = BindRelation::GetInstance().GetEntitiesInGroup(groupId);
    for (const auto &entityInfoPtr : entityVec) {
        if (entityInfoPtr == nullptr) {
            BQS_LOG_ERROR("EntityInfo in Group[%u] is nullptr.", groupId);
            return BQS_STATUS_INNER_ERROR;
        }
        if (entityInfoPtr->GetType() == dgw::EntityType::ENTITY_QUEUE) {
            if (entityInfoPtr->GetQueueType() == bqs::CLIENT_Q) {
                return BQS_STATUS_OK;
            }
            const auto ret = CheckQueueAuth(entityInfoPtr->GetId(), entityInfoPtr->GetDeviceId(), isSrc);
            if (ret != BQS_STATUS_OK) {
                return ret;
            }
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckQueueAuth(const uint32_t queueId, const uint32_t resId, const bool isSrc) const
{
    std::unique_ptr<QueueQueryOutput> output(new (std::nothrow) QueueQueryOutput());
    if (output == nullptr) {
        BQS_LOG_ERROR("Malloc memory for output failed.");
        return BQS_STATUS_INNER_ERROR;
    }
    QueueQueryOutputPara outputPara = {output.get(), static_cast<uint32_t>(sizeof(QueueQueryOutput))};
    QueQueryQueueAttr queAttr = {static_cast<int32_t>(queueId)};
    QueueQueryInputPara inputPara = {&queAttr, static_cast<uint32_t>(sizeof(queAttr))};
    const auto drvRet = halQueueQuery(resId, QUEUE_QUERY_QUE_ATTR_OF_CUR_PROC, &inputPara, &outputPara);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Fail to query queue info, queue[%u], resId[%u], ret[%d]",
            queueId, resId, static_cast<int32_t>(drvRet));
        return BQS_STATUS_DRIVER_ERROR;
    }

    const uint32_t authValue = isSrc ? static_cast<uint32_t>(output.get()->queQueryQueueAttrInfo.attr.read) :
        static_cast<uint32_t>(output.get()->queQueryQueueAttrInfo.attr.write);
    if (authValue == 0U) {
        BQS_LOG_ERROR("Queue[%u] res[%u] did not own needed authority, isSrc[%d].",
            queueId, resId, static_cast<int32_t>(isSrc));
        return BQS_STATUS_QUEUE_AHTU_ERROR;
    }
    BQS_LOG_INFO("Queue[%u] res[%u] check authority success, isSrc[%d]",
        queueId, resId, static_cast<int32_t>(isSrc));
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckAndRecordUpdateCfgInfo(const uintptr_t mbufData, const uint64_t dataLen)
{
    // check min dataLen
    if (dataLen < sizeof(ConfigInfo)) {
        BQS_LOG_ERROR("dataLen[%lu] is invalid.", dataLen);
        return BQS_STATUS_PARAM_INVALID;
    }
    // check cfgInfo
    ConfigInfo * const cfgInfo = PtrToPtr<void, ConfigInfo>(ValueToPtr(mbufData));
    if (cfgInfo == nullptr) {
        BQS_LOG_ERROR("cfgInfo is nullptr.");
        return BQS_STATUS_PARAM_INVALID;
    }

    updateCfgInfo_.reset(new (std::nothrow) UpdateCfgInfo());
    if (updateCfgInfo_ == nullptr) {
        BQS_LOG_ERROR("Malloc memory for updateCfgInfo_ failed.");
        return BQS_STATUS_INNER_ERROR;
    }
    // record mbuf data
    updateCfgInfo_->mbufData = mbufData;
    updateCfgInfo_->dataLen = dataLen;
    // record cfgInfo
    updateCfgInfo_->cfgInfo = cfgInfo;

    BQS_LOG_INFO("cmd is %d", static_cast<int32_t>(cfgInfo->cmd));
    auto ret = BQS_STATUS_OK;
    switch (cfgInfo->cmd) {
        case ConfigCmd::DGW_CFG_CMD_BIND_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE: {
            ret = CheckAndRecordRouteInfo();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_ADD_GROUP: {
            ret = CheckAndRecordAddGrpInfo();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING:
        case ConfigCmd::DGW_CFG_CMD_DEL_GROUP:
        case ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL: {
            ret = CheckAndRecordCfgInfo();
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE: {
            ret = CheckAndRecordCommonCfg(sizeof(ConfigInfo) + sizeof(DynamicSchedConfigV2));
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE:
        case ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE: {
            ret = CheckAndRecordRedeployCfg();
            break;
        }
        default: {
            ret = BQS_STATUS_PARAM_INVALID;
            BQS_LOG_WARN("cmd[%d] is invalid.", static_cast<int32_t>(cfgInfo->cmd));
            break;
        }
    }

    // check update config info failed, clear updateCfgInfo_
    if (ret != BQS_STATUS_OK) {
        updateCfgInfo_ = nullptr;
    }
    return ret;
}

BqsStatus ConfigInfoOperator::CheckAndRecordRouteInfo() const
{
    const ConfigInfo * const cfgInfo = updateCfgInfo_->cfgInfo;
    const size_t routeNum = static_cast<size_t>(cfgInfo->cfg.routesCfg.routeNum);
    // check route num
    if ((routeNum == 0UL) || (routeNum > MAX_ROUTES_NUM)) {
        BQS_LOG_ERROR("Route num[%u] is invalid, max allowed value is [%u].",
            routeNum, MAX_ROUTES_NUM);
        return BQS_STATUS_PARAM_INVALID;
    }
    // calculate and check totalLen
    const size_t totalLen = sizeof(ConfigInfo) + (routeNum * sizeof(Route)) + (routeNum * sizeof(CfgRetInfo));
    const uint64_t dataLen = updateCfgInfo_->dataLen;
    if (totalLen != dataLen) {
        BQS_LOG_ERROR("dataLen[%lu] is not equal with totalLen[%zu].", dataLen, totalLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    auto &routeVec = updateCfgInfo_->routes;
    auto &resultVec = updateCfgInfo_->results;
    auto &entityPairVec = updateCfgInfo_->entitiesInRoutes;
    const uintptr_t routesAddr = updateCfgInfo_->mbufData + sizeof(ConfigInfo);
    Route * const routes = PtrToPtr<void, Route>(ValueToPtr(routesAddr));
    CfgRetInfo * const results = PtrToPtr<void, CfgRetInfo>(ValueToPtr(routesAddr + (routeNum * sizeof(Route))));
    for (size_t idx = 0UL; idx < routeNum; idx++) {
        Route * const route = PtrAdd<Route>(routes, routeNum, idx);
        CfgRetInfo * const result = PtrAdd<CfgRetInfo>(results, routeNum, idx);
        // initialize retCode
        result->retCode = static_cast<int32_t>(BQS_STATUS_OK);
        routeVec.emplace_back(route);
        resultVec.emplace_back(result);
        // create src and dst entity info ptr
        const EntityInfoPtr src = CreateEntityInfo(route->src, false);
        const EntityInfoPtr dst = CreateEntityInfo(route->dst, false);
        if ((src == nullptr) || (dst == nullptr)) {
            BQS_LOG_ERROR("Create src or dst entityInfoPtr failed.");
            return BQS_STATUS_INNER_ERROR;
        }
        entityPairVec.emplace_back(std::make_pair(src, dst));
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckAndRecordAddGrpInfo() const
{
    const ConfigInfo * const cfgInfo = updateCfgInfo_->cfgInfo;
    const size_t endpointNum = static_cast<size_t>(cfgInfo->cfg.groupCfg.endpointNum);
    // check endpoint num
    if ((endpointNum == 0UL) || (endpointNum > MAX_ENDPOINTS_NUM_IN_SINGLE_GROUP)) {
        BQS_LOG_ERROR("Group num[%u] is invalid, max allowed value is [%u].",
            endpointNum, MAX_ENDPOINTS_NUM_IN_SINGLE_GROUP);
        return BQS_STATUS_PARAM_INVALID;
    }

    // calculate and check totalLen
    const size_t totalLen = sizeof(ConfigInfo) + (endpointNum * sizeof(Endpoint)) + sizeof(CfgRetInfo);
    const uint64_t dataLen = updateCfgInfo_->dataLen;
    if (totalLen != dataLen) {
        BQS_LOG_ERROR("dataLen[%lu] is not equal with totalLen[%zu].", dataLen, totalLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    auto &endpointVec = updateCfgInfo_->endpointsInGroup;
    auto &resultVec = updateCfgInfo_->results;
    auto &entityVec = updateCfgInfo_->entitiesInGroup;
    const uintptr_t endpointsAddr = updateCfgInfo_->mbufData + sizeof(ConfigInfo);
    Endpoint * const endpoints = PtrToPtr<void, Endpoint>(ValueToPtr(endpointsAddr));
    const uintptr_t results = endpointsAddr + (endpointNum * sizeof(Endpoint));
    // only one result
    CfgRetInfo * const result = PtrToPtr<void, CfgRetInfo>(ValueToPtr(results));
    resultVec.emplace_back(result);

    std::set<std::tuple<const uint32_t, const bool, const uint32_t, const dgw::EntityType>> entitySet;
    for (size_t idx = 0UL; idx < endpointNum; idx++) {
        Endpoint * const endpoint = PtrAdd<Endpoint>(endpoints, endpointNum, idx);
        endpointVec.emplace_back(endpoint);
        // create entity info ptr
        EntityInfoPtr entity = CreateEntityInfo(*endpoint, false);
        if (entity == nullptr) {
            BQS_LOG_ERROR("Create entityInfoPtr failed.");
            return BQS_STATUS_PARAM_INVALID;
        }
        if (entity->GetType() == dgw::EntityType::ENTITY_GROUP) {
            BQS_LOG_ERROR("Not allowd group[%s] exist in group.", entity->ToString().c_str());
            return BQS_STATUS_PARAM_INVALID;
        }
        entityVec.emplace_back(entity);
        uint32_t deviceId = ((endpoint->resId & RESOURCE_ID_ENABLE_BIT_MASK) != 0U) ?
                             (endpoint->resId & ROUCE_ID_DEVICE_ID_DATA_MASK) : deviceId_;
        bool isHostQueue = (((endpoint->resId >> RESOURCE_ID_HOST_DEVICE_BIT_NUM) & 1) != 0U) ? true : false;
        (void)entitySet.emplace(std::make_tuple(deviceId, isHostQueue, entity->GetId(), entity->GetType()));
    }

    // check whether group has the same entity
    if (entitySet.size() != endpointNum) {
        BQS_LOG_ERROR("entitySet size[%lu] is not equal with endpointNum[%lu].", entitySet.size(), endpointNum);
        return BQS_STATUS_PARAM_INVALID;
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckAndRecordCfgInfo() const
{
    return CheckAndRecordCommonCfg(sizeof(ConfigInfo));
}

BqsStatus ConfigInfoOperator::CheckAndRecordCommonCfg(const size_t resultOffset) const
{
    // calculate and check totalLen
    const size_t totalLen = resultOffset + sizeof(CfgRetInfo);
    const uint64_t dataLen = updateCfgInfo_->dataLen;
    if (totalLen != dataLen) {
        BQS_LOG_ERROR("dataLen[%lu] is not equal with totalLen[%zu].", dataLen, totalLen);
        return BQS_STATUS_PARAM_INVALID;
    }

    auto &resultVec = updateCfgInfo_->results;
    // only one result
    const uintptr_t results = updateCfgInfo_->mbufData + resultOffset;
    CfgRetInfo * const result = PtrToPtr<void, CfgRetInfo>(ValueToPtr(results));
    resultVec.emplace_back(result);
    BQS_LOG_INFO("CheckAndRecordCommonCfg for %zu", resultOffset);
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::CheckAndRecordRedeployCfg() const
{
    const ConfigInfo * const cfgInfo = updateCfgInfo_->cfgInfo;
    const size_t rootModelIdsLen = cfgInfo->cfg.reDeployCfg.rootModelNum * sizeof(uint32_t);
    return CheckAndRecordCommonCfg(rootModelIdsLen + sizeof(ConfigInfo));
}

BqsStatus ConfigInfoOperator::ProcessUpdateRoutes(const uint32_t index) const
{
    // no need to check cfgInfo and updateCfgInfo_ nullptr
    ConfigInfo * const cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;
    auto &entityPairVec = updateCfgInfo_->entitiesInRoutes;

    auto returnCode = BQS_STATUS_OK;
    size_t idx = 0UL;
    for (auto &entityPair : entityPairVec) {
        // check preprocess result
        CfgRetInfo * const retInfo = resultVec[idx];
        idx++;
        const auto preRet = static_cast<BqsStatus>(retInfo->retCode);
        if (preRet != BQS_STATUS_OK) {
            returnCode = preRet;
            continue;
        }
        // create entity info
        const auto ret = (cfgInfo->cmd == ConfigCmd::DGW_CFG_CMD_BIND_ROUTE) ?
            BindRelation::GetInstance().Bind(*(entityPair.first), *(entityPair.second), index) :
            BindRelation::GetInstance().UnBind(*(entityPair.first), *(entityPair.second), index);
        if (ret == BQS_STATUS_RETRY) {
            continue;
        }

        retInfo->retCode = static_cast<int32_t>(ret);
        returnCode = (returnCode == BQS_STATUS_OK) ? ret : returnCode;
        BQS_LOG_RUN_INFO("Bind/unbind relation operate, cmd[%d], stage[server:process],"
            "relation[src:%s, dst:%s, result:%d]", static_cast<int32_t>(cfgInfo->cmd),
            entityPair.first->ToString().c_str(), entityPair.second->ToString().c_str(), static_cast<int32_t>(ret));
    }
    BindRelation::GetInstance().Order(index);
    return returnCode;
}

BqsStatus ConfigInfoOperator::ProcessAddGroup() const
{
    // no need to check cfgInfo and updateCfgInfo_ nullptr
    // get endpoint number
    auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;
    auto &entityVec = updateCfgInfo_->entitiesInGroup;

    // create group
    uint32_t groupId = 0U;
    const auto retCode = BindRelation::GetInstance().CreateGroup(entityVec, groupId);
    if (retCode == BQS_STATUS_OK) {
        cfgInfo->cfg.groupCfg.groupId = static_cast<int32_t>(groupId);
    }
    // set result
    resultVec[0UL]->retCode = static_cast<int32_t>(retCode);

    BQS_LOG_RUN_INFO("Add group operate, cmd[%d], stage[server:process], endpointNum[%zu], groupId[%u], result:[%d]",
        static_cast<int32_t>(cfgInfo->cmd), entityVec.size(), groupId, static_cast<int32_t>(retCode));
    return retCode;
}

BqsStatus ConfigInfoOperator::ProcessDelGroup() const
{
    // get endpoint number
    const auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;
    const uint32_t groupId = static_cast<uint32_t>(cfgInfo->cfg.groupCfg.groupId);

    // delete group
    const auto retCode = BindRelation::GetInstance().DeleteGroup(groupId);
    // set result
    resultVec[0UL]->retCode = static_cast<int32_t>(retCode);

    BQS_LOG_RUN_INFO("Delete group operate, cmd[%d], stage[server:process], groupId[%u], result:[%d]",
        static_cast<int32_t>(cfgInfo->cmd), groupId, static_cast<int32_t>(retCode));
    return retCode;
}

BqsStatus ConfigInfoOperator::ProcessUpdateProfiling() const
{
    // get prof mode
    const auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;
    const ProfilingMode mode = cfgInfo->cfg.profCfg.profMode;
    // set prof mode
    auto retCode = ProfileManager::GetInstance(0U).UpdateProfilingMode(mode);
    if ((retCode == BQS_STATUS_OK) && GlobalCfg::GetInstance().GetNumaFlag()) {
        retCode = bqs::ProfileManager::GetInstance(1U).UpdateProfilingMode(mode);
    }
    // set result
    resultVec[0UL]->retCode = static_cast<int32_t>(retCode);
    BQS_LOG_RUN_INFO("Update profiling operate, cmd[%d], stage[server:process], profiling mode[%u], result:[%d]",
        static_cast<int32_t>(cfgInfo->cmd), mode, static_cast<int32_t>(retCode));
    return retCode;
}

BqsStatus ConfigInfoOperator::ProcessUpdateHcclProtocol() const
{
    const auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;
    const HcclProtocolType protocol = cfgInfo->cfg.hcclProtocolCfg.protocol;

    // set protocol
    auto retCode = BQS_STATUS_OK;
    std::string strProtocol = "";
    if (protocol == HcclProtocolType::RDMA) {
        strProtocol = "RDMA";
    } else if (protocol == HcclProtocolType::TCP) {
        strProtocol = "TCP";
    } else {
        BQS_LOG_ERROR("Invalid protocol type[%d]", protocol);
        retCode = BQS_STATUS_PARAM_INVALID;
    }

    if (!strProtocol.empty()) {
        const auto ret = setenv("HCCL_NPU_NET_PROTOCOL", strProtocol.c_str(), 1);
        if (ret != 0) {
            BQS_LOG_ERROR("setenv HCCL_NPU_NET_PROTOCOL failed, ret[%d]", ret);
            retCode = BQS_STATUS_INNER_ERROR;
        }
    }
    // set result
    resultVec[0UL]->retCode = static_cast<int32_t>(retCode);
    BQS_LOG_RUN_INFO("Update hccl_protocol operate, cmd[%d], stage[server:process], protocol[%d], result:[%d]",
        static_cast<int32_t>(cfgInfo->cmd), static_cast<int32_t>(protocol), static_cast<int32_t>(retCode));
    return retCode;
}

BqsStatus ConfigInfoOperator::ProcessInitDynamicSched() const
{
    BQS_LOG_INFO("ProcessInitDynamicSched");
    const auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;

    const uintptr_t dynamicSchedCfgAddr = updateCfgInfo_->mbufData + sizeof(ConfigInfo);
    const DynamicSchedConfigV2 * const dynamicCfg =
        PtrToPtr<void, DynamicSchedConfigV2>(ValueToPtr(dynamicSchedCfgAddr));

    BqsStatus retCode = BQS_STATUS_OK;
    uint32_t localRequestQDeviceId = ParseDeviceId(dynamicCfg->requestQ.deviceId);
    uint32_t localResponseDeviceId = ParseDeviceId(dynamicCfg->responseQ.deviceId);

    auto drvRet = halQueueAttach(localRequestQDeviceId, dynamicCfg->requestQ.queueId, 0);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Fail to attach queue[%u], device[%u], ret[%d]", dynamicCfg->requestQ.queueId,
                      localRequestQDeviceId, static_cast<int32_t>(drvRet));
        resultVec[0UL]->retCode = static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
        return BQS_STATUS_DRIVER_ERROR;
    }
    drvRet = halQueueAttach(localResponseDeviceId, dynamicCfg->responseQ.queueId, 0);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Fail to attach queue[%u], device[%u], ret[%d]", dynamicCfg->responseQ.queueId,
                      localResponseDeviceId, static_cast<int32_t>(drvRet));
        resultVec[0UL]->retCode = static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
        return BQS_STATUS_DRIVER_ERROR;
    }

    dgw::DynamicSchedMgr::RootModelInfo schedCfgInfo = {};
    schedCfgInfo.rootModelId = dynamicCfg->rootModelId;
    schedCfgInfo.requestQue = dynamicCfg->requestQ;
    schedCfgInfo.requestQue.deviceId = localRequestQDeviceId;
    schedCfgInfo.responseQue = dynamicCfg->responseQ;
    schedCfgInfo.responseQue.deviceId = localResponseDeviceId;

    uint32_t resIndex = 0U;
    if (GlobalCfg::GetInstance().GetNumaFlag()) {
        resIndex = GlobalCfg::GetInstance().GetResIndexByDeviceId(localRequestQDeviceId);
    }
    const auto addCfgRet = dgw::DynamicSchedMgr::GetInstance(resIndex).AddRootModelInfo(schedCfgInfo);
    if (addCfgRet != dgw::FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Fail to add dynamic sched config, rootModelId[%u], ret[%d]", schedCfgInfo.rootModelId,
            static_cast<int32_t>(addCfgRet));
        resultVec[0UL]->retCode = static_cast<int32_t>(BQS_STATUS_DYNAMIC_SCHEDULE_ERROR);
        return BQS_STATUS_DYNAMIC_SCHEDULE_ERROR;
    }

    QueueSetInputPara inPutParam;
    QueueSetInput inPut;
    inPut.queSetWorkMode.qid = schedCfgInfo.responseQue.queueId;
    inPut.queSetWorkMode.workMode = QUEUE_MODE_PUSH;
    inPutParam.inBuff = static_cast<void *>(&inPut);
    inPutParam.inLen = static_cast<uint32_t>(sizeof(QueueSetInput));
    drvRet = halQueueSet(0U, QUEUE_SET_WORK_MODE, &inPutParam);
    BQS_LOG_RUN_INFO("Set queue[%u] work mode to push for dynamic schedule.", schedCfgInfo.responseQue.queueId);

    if ((SubscribeQueueEvent(!schedCfgInfo.requestQue.isClientQ, schedCfgInfo.requestQue.queueId,
        schedCfgInfo.requestQue.deviceId, resIndex, false) != BQS_STATUS_OK) ||
        (SubscribeQueueEvent(!schedCfgInfo.responseQue.isClientQ, schedCfgInfo.responseQue.queueId,
        schedCfgInfo.responseQue.deviceId, resIndex, true) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("Fail to subscribe enque event of [qid:%u-deviceId:%u-isclientQ:%d] or "
            "subscribe f2nf of [qid:%u-deviceId:%u-isclientQ:%d]",
            schedCfgInfo.responseQue.queueId, schedCfgInfo.responseQue.deviceId, schedCfgInfo.responseQue.isClientQ,
            schedCfgInfo.requestQue.queueId, schedCfgInfo.requestQue.deviceId, schedCfgInfo.responseQue.isClientQ);
        resultVec[0UL]->retCode = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        return BQS_STATUS_INNER_ERROR;
    }
    dgw::ScheduleConfig::GetInstance().
        RecordConfig(dynamicCfg->rootModelId, schedCfgInfo.requestQue, schedCfgInfo.responseQue);

    // set result
    resultVec[0UL]->retCode = static_cast<int32_t>(retCode);
    BQS_LOG_RUN_INFO("Init dynamicSched[%u] operate, cmd[%d], stage[server:process], rootModelId[%u], result:[%d]",
        localRequestQDeviceId, static_cast<int32_t>(cfgInfo->cmd), dynamicCfg->rootModelId,
        static_cast<int32_t>(retCode));
    return retCode;
}

uint32_t ConfigInfoOperator::ParseDeviceId(const uint32_t rawDeviceId) const
{
    uint32_t localDeviceId = rawDeviceId;
    if ((bqs::GetRunContext() != bqs::RunContext::HOST) && (&drvGetLocalDevIDByHostDevID != nullptr)) {
        auto retCode = drvGetLocalDevIDByHostDevID(rawDeviceId, &localDeviceId);
        if (retCode != static_cast<int32_t>(DRV_ERROR_NONE)) {
            BQS_LOG_INFO("host devid(%u) transform to local devid not success.", rawDeviceId);
            localDeviceId = rawDeviceId;
        }
    }
    return localDeviceId;
}

BqsStatus ConfigInfoOperator::SubscribeQueueEvent(const bool isLocalQ, const uint32_t queueId, const uint32_t deviceId,
    const uint32_t resIndex, const bool isEnqueue) const
{
    const auto subscribeManager = Subscribers::GetInstance().GetSubscribeManager(resIndex, deviceId);
    if (subscribeManager == nullptr) {
        BQS_LOG_ERROR("Failed to find subscribeManager for isLocalQ:%d, device: %u, resIndex: %u",
            static_cast<int32_t>(isLocalQ), deviceId, resIndex);
        return BQS_STATUS_INNER_ERROR;
    }
    return isEnqueue ? subscribeManager->Subscribe(queueId) :
        subscribeManager->SubscribeFullToNotFull(queueId);
}

BqsStatus ConfigInfoOperator::CheckCommChannelAttr(const CommChannelAttr &attr, const bool isQry) const
{
    if (attr.localTagId != attr.peerTagId) {
        BQS_LOG_ERROR("Local tag id[%u] is not equal with peer tag id[%u]. Please check!",
            attr.localTagId, attr.peerTagId);
        return BQS_STATUS_PARAM_INVALID;
    }
    if (attr.localRankId == attr.peerRankId) {
        BQS_LOG_ERROR("local rank id[%u] is equal with peer rank id[%u]. Please check!",
            attr.localRankId, attr.peerRankId);
        return BQS_STATUS_PARAM_INVALID;
    }
    if (isQry) {
        return BQS_STATUS_OK;
    }
    // when qry route, no need check tag depth
    if ((attr.localTagDepth == 0U) || (attr.localTagDepth > MAX_TAG_DEPTH)) {
        BQS_LOG_ERROR("Local tag depth[%u] is invalid, max tag depth is [%u].", attr.localTagDepth, MAX_TAG_DEPTH);
        return BQS_STATUS_PARAM_INVALID;
    }
    if ((attr.peerTagDepth == 0U) || (attr.peerTagDepth > MAX_TAG_DEPTH)) {
        BQS_LOG_ERROR("Peer tag depth[%u] is invalid, max tag depth is [%u].", attr.peerTagDepth, MAX_TAG_DEPTH);
        return BQS_STATUS_PARAM_INVALID;
    }
    return BQS_STATUS_OK;
}

BqsStatus ConfigInfoOperator::ProcessStopSchedule(const uint32_t index) const
{
    BQS_LOG_RUN_INFO("ProcessStopSchedule");
    const auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;

    const uintptr_t rootModelIdsAddr = updateCfgInfo_->mbufData + sizeof(ConfigInfo);
    const uint32_t * const rootModelIds = PtrToPtr<void, uint32_t>(ValueToPtr(rootModelIdsAddr));
    const uint32_t rootModelNum = cfgInfo->cfg.reDeployCfg.rootModelNum;

    if ((rootModelNum != 0U) && (rootModelIds == nullptr)) {
        BQS_LOG_ERROR("Invalid rootModelIds");
        resultVec[0UL]->retCode = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        return BQS_STATUS_PARAM_INVALID;
    }

    std::unordered_set<uint32_t> rootModelSet;
    for (uint32_t i = 0U; i < rootModelNum; i++) {
        dgw::ScheduleConfig::GetInstance().StopSched(rootModelIds[i]);
        rootModelSet.insert(rootModelIds[i]);
    }
    (void)dgw::DynamicSchedMgr::GetInstance(index).ClearCacheRouteResult();

    const auto retCode = BindRelation::GetInstance().MakeSureOutputCompletion(index, rootModelSet);

    resultVec[0UL]->retCode = static_cast<int32_t>(retCode);
    BQS_LOG_RUN_INFO("Finish ProcessStopSchedule, retCode is %d", static_cast<int32_t>(retCode));
    return retCode;
}

BqsStatus ConfigInfoOperator::ProcessRestartSchedule(const uint32_t index) const
{
    BQS_LOG_RUN_INFO("ProcessRestartSchedule");
    const auto cfgInfo = updateCfgInfo_->cfgInfo;
    auto &resultVec = updateCfgInfo_->results;

    const uintptr_t rootModelIdsAddr = updateCfgInfo_->mbufData + sizeof(ConfigInfo);
    const uint32_t * const rootModelIds = PtrToPtr<void, uint32_t>(ValueToPtr(rootModelIdsAddr));
    const uint32_t rootModelNum = cfgInfo->cfg.reDeployCfg.rootModelNum;

    if ((rootModelNum != 0U) && (rootModelIds == nullptr)) {
        BQS_LOG_ERROR("Invalid rootModelIds");
        resultVec[0UL]->retCode = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        return BQS_STATUS_PARAM_INVALID;
    }

    std::unordered_set<uint32_t> rootModelSet;
    for (uint32_t i = 0U; i < rootModelNum; i++) {
        rootModelSet.insert(rootModelIds[i]);
    }
    const auto ret = BindRelation::GetInstance().ClearInputQueue(index, rootModelSet);
    if (ret == BQS_STATUS_OK) {
        std::vector<dgw::DynamicSchedMgr::ResponseInfo> responses;
        for (uint32_t i = 0U; i < rootModelNum; i++) {
            do {
                responses.clear();
                (void)dgw::DynamicSchedMgr::GetInstance(index).GetResponse(rootModelIds[i], responses);
            } while (!responses.empty());
            dgw::ScheduleConfig::GetInstance().RestartSched(rootModelIds[i]);
        }
    }
    resultVec[0UL]->retCode = static_cast<int32_t>(ret);
    BQS_LOG_RUN_INFO("Finish ProcessRestartSchedule");
    return ret;
}
}