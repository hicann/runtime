/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dgw_client.h"
#include <algorithm>
#include <map>
#include <mutex>
#include <string>
#include <sys/types.h>
#include <unistd.h>
#include <securec.h>
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "common/bqs_status.h"
#include "bqs_log.h"
#include "bqs_util.h"
#include "common/type_def.h"
#include "queue_schedule_feature_ctrl.h"
#define AICPU_PLAT_GET_CHIP(type)           (((type) >> 8U) & 0xffU)

namespace {
std::mutex g_dgwClientMut;
std::map<std::tuple<uint32_t, pid_t, bool>, std::shared_ptr<bqs::DgwClient>> g_dgwClientInstanceMap;
// allowed max routes number
constexpr uint32_t MAX_ROUTES_NUM = 8000U;
// allowed max endpoints number in one group
constexpr uint32_t MAX_ENDPOINTS_NUM_IN_SINGLE_GROUP = 1000U;
// default qsPid when create client
constexpr pid_t DEFAULT_QS_PID = -1;
constexpr uint16_t MAJOR_VERSION = 3U;
constexpr uint32_t QUERY_LINK_STATUS_INTERVAL = 100000U;  // 100ms
constexpr uint32_t QUERY_LINK_STATUS_UNIT = 1000000U;  // 1s
constexpr uint16_t RESOURCE_ID_HOST_DEVICE_BIT_NUM = 14;
constexpr uint16_t ROUCE_ID_DEVICE_ID_DATA_MASK = 0x3FFF;
constexpr uint16_t ROUCE_ID_FRONT_PART_DATA_MASK = 0xC000;

std::vector<uint32_t> g_userDeviceInfo;
bool g_hadGetVisibleDevices = false;
int64_t g_chipType = 18;
bool g_hadGetChipType = false;
} // namespace

namespace bqs {

DgwClient::DgwClient(const uint32_t deviceId) : deviceId_(deviceId), qsPid_(DEFAULT_QS_PID), procSign_(), curPid_(-1),
                                                curGroupId_(0U), piplineQueueId_(0U), initFlag_(false), isProxy_(false),
                                                isServerOldVersion_(false)
{
}

DgwClient::DgwClient(const uint32_t deviceId, const pid_t qsPid) : deviceId_(deviceId), qsPid_(qsPid), procSign_(),
    curPid_(-1), curGroupId_(0U), piplineQueueId_(0U), initFlag_(false), isProxy_(false)
{
}

DgwClient::DgwClient(const uint32_t deviceId, const pid_t qsPid, const bool proxy) : deviceId_(deviceId),
    qsPid_(qsPid), procSign_(), curPid_(-1), curGroupId_(0U), piplineQueueId_(0U), initFlag_(false), isProxy_(proxy)
{
}

std::shared_ptr<DgwClient> DgwClient::GetInstance(const uint32_t deviceId)
{
    return GetInstance(deviceId, DEFAULT_QS_PID, false);
}

std::shared_ptr<DgwClient> DgwClient::GetInstance(const uint32_t deviceId, const pid_t qsPid)
{
    return GetInstance(deviceId, qsPid, false);
}

std::shared_ptr<DgwClient> DgwClient::GetInstance(const uint32_t deviceId, const pid_t qsPid, const bool proxy)
{
    BQS_LOG_INFO("[DgwClient] begin to get instance, deviceId=%u, proxy=%d", deviceId, proxy);
    uint32_t logicDeviceId = deviceId;
    if (proxy) {
        if (!g_hadGetChipType && (GetPlatformInfo(deviceId) != static_cast<int32_t>(BQS_STATUS_OK))) {
            return nullptr;
        }
        if (QSFeatureCtrl::IsSupportSetVisibleDevices(g_chipType) && 
            (ChangeUserDeviceIdToLogicDeviceId(deviceId, logicDeviceId) != static_cast<int32_t>(BQS_STATUS_OK))) {
            return nullptr;
        }
        BQS_LOG_INFO("[DgwClient] after change deviceId, logicDeviceId=%u", logicDeviceId);
    }

    std::lock_guard<std::mutex> lk(g_dgwClientMut);
    const auto iter = g_dgwClientInstanceMap.find({logicDeviceId, qsPid, proxy});
    if (iter != g_dgwClientInstanceMap.end()) {
        return iter->second;
    } else {
        std::shared_ptr<DgwClient> clientImplPtr = nullptr;
        try {
            clientImplPtr = std::make_shared<DgwClient>(logicDeviceId, qsPid, proxy);
        } catch (std::bad_alloc &error) {
            BQS_LOG_ERROR("[DgwClient] fail to create client(%u-%d-%d) for %s", logicDeviceId, qsPid, proxy, error.what());
        }
        if (clientImplPtr != nullptr) {
            (void)g_dgwClientInstanceMap.insert({{logicDeviceId, qsPid, proxy}, clientImplPtr});
        }
        return clientImplPtr;
    }
}

int32_t DgwClient::Initialize(const uint32_t dgwPid, const std::string procSign, const bool isProxy,
                              const int32_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Initialize Begin, change qsPid from %d to %d, isproxy: %d",
        qsPid_, static_cast<pid_t>(dgwPid), isProxy);
    qsPid_ = static_cast<pid_t>(dgwPid);
    procSign_ = procSign;
    curPid_ = getpid();
    isProxy_ = isProxy;
    isServerOldVersion_ = false;

    auto drvRet = halEschedAttachDevice(deviceId_);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_PROCESS_REPEAT_ADD)) {
        BQS_LOG_ERROR("Failed to attach device[%u], result[%d].", deviceId_, static_cast<int32_t>(drvRet));
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }

    // send init event to qs
    QsBindInit qsBindInit = {};
    qsBindInit.pid = curPid_;
    qsBindInit.grpId = curGroupId_;
    qsBindInit.majorVersion = MAJOR_VERSION;

    QsProcMsgRsp qsProcMsgRsp = {};
    int32_t ret = SendEventToQsSync(&qsBindInit, sizeof(QsBindInit), ACL_BIND_QUEUE_INIT, qsProcMsgRsp, timeout);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        return ret;
    }
    if (qsProcMsgRsp.retCode != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_WARN("[DgwClient] Initialize event_reply retCode is[%u]", qsProcMsgRsp.retCode);
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }

    if (qsProcMsgRsp.majorVersion != qsBindInit.majorVersion &&
        qsProcMsgRsp.majorVersion < MAJOR_VERSION) {
        BQS_LOG_INFO("[DgwClient] server majorVersion is[%u] client majorVersion is[%u], set isServerOldVersion",
            qsProcMsgRsp.majorVersion, qsBindInit.majorVersion);
        isServerOldVersion_ = true;
    }

    piplineQueueId_ = qsProcMsgRsp.retValue;
    BQS_LOG_DEBUG("[DgwClient] Success to get queue id[%u].", piplineQueueId_);

    // host FlowGW LOCAL_Q need set this before use these queues
    if (!isProxy_) {
        QueueSetInputPara inPutParam;
        (void)halQueueSet(deviceId_, QUEUE_ENABLE_LOCAL_QUEUE, &inPutParam);
    }

    // Before attach queue, process should call halQueueInit.
    drvRet = halQueueInit(deviceId_);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
        BQS_LOG_ERROR("[DgwClient] halQueueInit error, ret=%d", static_cast<int32_t>(drvRet));
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }

    drvRet = halQueueAttach(deviceId_, piplineQueueId_, -1);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("[DgwClient] Attach queue failed, queue id[%u], drvRet [%d].", piplineQueueId_,
                      static_cast<int32_t>(drvRet));
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }

    BuffCfg buffCfg = {};
    ret = halBuffInit(&buffCfg);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) && (ret != static_cast<int32_t>(DRV_ERROR_REPEATED_INIT))) {
        BQS_LOG_ERROR("[DgwClient] Failed to halBuffInit, ret=[%d].", ret);
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }

    initFlag_ = true;
    BQS_LOG_INFO("[DgwClient] Success to Initialize deviceId=[%u], pid=[%u].", deviceId_, curPid_);
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::Finalize()
{
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::CreateHcomHandle(const std::string &rankTable, const int32_t rankId,
                                    const void * const reserve, uint64_t &handle, const int32_t timeout)
{
    (void)reserve;
    BQS_LOG_INFO("[DgwClient] Begin to create hcom handle.");
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] Please check whether datagw client has been initialized.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }
    if (rankTable.empty()) {
        BQS_LOG_ERROR("[DgwClient] Rank table is empty!");
        return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
    }

    // calculate mbuf len: 1. HcomHandleInfo 2. rank table 3. CfgRetInfo
    const size_t cfgLen = sizeof(HcomHandleInfo) + rankTable.length();
    // check two uint32 integer adding whether overflow and execute adding when not overflow.
    uint32_t mbufLen = 0U;
    bool isOverflow = false;
    BqsCheckAssign32UAdd(cfgLen, sizeof(CfgRetInfo), mbufLen, isOverflow);
    if (isOverflow) {
        BQS_LOG_ERROR("mbufLen[%u] is invalid.", mbufLen);
        return BQS_STATUS_PARAM_INVALID;
    }
    // create hcom handle info
    HcomHandleInfo info;
    info.rankId = rankId;
    info.rankTableLen = rankTable.length();
    info.rankTableOffset = sizeof(HcomHandleInfo);

    std::list<std::pair<uintptr_t, size_t>> dataList;
    dataList.emplace_back(std::make_pair(PtrToValue(&info), sizeof(HcomHandleInfo)));
    dataList.emplace_back(std::make_pair(PtrToValue(rankTable.c_str()), rankTable.length()));

    // operate config to server
    std::vector<int32_t> emptyVec;
    const ConfigParams cfgParams = {
        .info = &info,
        .query = nullptr,
        .cfgInfo = nullptr,
        .cfgLen = cfgLen,
        .totalLen = static_cast<size_t>(mbufLen),
    };
    const auto ret = OperateConfigToServer(QueueSubEventType::DGW_CREATE_HCOM_HANDLE, cfgParams, dataList, emptyVec,
        timeout);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] Failed to create hcom handle.");
        return ret;
    }
    // get hcom handle
    handle = info.hcomHandle;
    BQS_LOG_INFO("[DgwClient] Success to create hcom handle[%lu].", handle);
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::DestroyHcomHandle(const uint64_t handle, const int32_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Begin to Destroy hcom handle[%lu].", handle);
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] Please check whether datagw client has been initialized.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }

    // calculate mbuf len: 1. HcomHandleInfo; 2. CfgRetInfo
    const size_t cfgLen = sizeof(HcomHandleInfo);
    const size_t mbufLen = cfgLen + sizeof(CfgRetInfo);
    // hcom handle info
    HcomHandleInfo info;
    info.rankTableLen = 0UL;
    info.rankTableOffset = 0UL;
    info.hcomHandle = handle;

    std::list<std::pair<uintptr_t, size_t>> dataList;
    dataList.emplace_back(std::make_pair(PtrToValue(&info), sizeof(HcomHandleInfo)));

    // operate config to server
    std::vector<int32_t> emptyVec;
    const ConfigParams cfgParams = {
        .info = &info,
        .query = nullptr,
        .cfgInfo = nullptr,
        .cfgLen = cfgLen,
        .totalLen = mbufLen,
    };
    const auto ret = OperateConfigToServer(QueueSubEventType::DGW_DESTORY_HCOM_HANDLE, cfgParams, dataList, emptyVec,
        timeout);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] Failed to destroy hcom handle[%lu].", handle);
        return ret;
    }
    BQS_LOG_INFO("[DgwClient] Success to destroy hcom handle[%lu].", handle);
    return static_cast<int32_t>(BQS_STATUS_OK);
}

bool IsQueueOperationCmd(ConfigInfo &cfgInfo)
{
    return ((cfgInfo.cmd == ConfigCmd::DGW_CFG_CMD_BIND_ROUTE) ||
            (cfgInfo.cmd == ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE) ||
            (cfgInfo.cmd == ConfigCmd::DGW_CFG_CMD_QRY_ROUTE));
}

bool IsGroupOperationCmd(ConfigInfo &cfgInfo)
{
    return ((cfgInfo.cmd == ConfigCmd::DGW_CFG_CMD_ADD_GROUP) ||
            (cfgInfo.cmd == ConfigCmd::DGW_CFG_CMD_QRY_GROUP));
}

int32_t DgwClient::UpdateConfig(ConfigInfo &cfgInfo, std::vector<int32_t> &cfgRets, const int32_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Begin to update config.");
    // check dgw client initialized
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] please check whether datagw client has initialized successfully.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }

    if (isServerOldVersion_ && IsGroupOperationCmd(cfgInfo)) {
        Endpoint *endpoints = cfgInfo.cfg.groupCfg.endpoints;
        if (endpoints != nullptr) {
            bqs::EndpointType type = endpoints->type;
            if (type == bqs::EndpointType::MEM_QUEUE &&
                endpoints->attr.memQueueAttr.queueType == bqs::CLIENT_Q) {
                BQS_LOG_ERROR("[DgwClient] isServerOldVersion CLIENT_Q function interception");
                return static_cast<int32_t>(BQS_STATUS_ENDPOINT_MEM_TYPE_NOT_SUPPORT);
            }
        }
    }

    // mbuf memory layout: 1.config info / 2.Routes or Endpoints / 3.config results
    // calculate config length: 1.config info + 2.Routes or Endpoints
    size_t cfgLen = 0UL;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // here is to consider compatibility between client and server different versions
    std::unique_ptr<Route[]> spareRoutes = nullptr;
    std::unique_ptr<Endpoint[]> spareEndpoints = nullptr;
    if (IsQueueOperationCmd(cfgInfo)) {
        const uint32_t routeNum = cfgInfo.cfg.routesCfg.routeNum;
        spareRoutes.reset(new (std::nothrow) Route[routeNum]);
        if (spareRoutes == nullptr) {
            BQS_LOG_ERROR("[DgwClient] malloc failed on spareRoutes.");
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
    } else if (IsGroupOperationCmd(cfgInfo)) {
        const uint32_t endpointNum = cfgInfo.cfg.groupCfg.endpointNum;
        spareEndpoints.reset(new (std::nothrow) Endpoint[endpointNum]);
        if (spareEndpoints == nullptr) {
            BQS_LOG_ERROR("[DgwClient] malloc failed on spareEndpoints.");
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
    }
    auto ret = CalcConfigInfoLen(cfgInfo, cfgLen, dataList, spareRoutes, spareEndpoints);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] check and calculate length of config info failed.");
        return ret;
    }
    // calculate result length: 3.config results
    size_t retLen = 0UL;
    ret = CalcResultLen(cfgInfo, retLen);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] calculate length of result failed.");
        return ret;
    }

    ConfigQuery unusedParam;
    const ConfigParams cfgParams = {
        .info = nullptr,
        .query = &unusedParam,
        .cfgInfo = &cfgInfo,
        .cfgLen = cfgLen,
        .totalLen = cfgLen + retLen,
    };
    ret = OperateConfigToServer(QueueSubEventType::UPDATE_CONFIG, cfgParams, dataList, cfgRets, timeout);
    BQS_LOG_INFO("[DgwClient] Finish to update config, cmd is %d, ret is [%d].",
                 static_cast<int32_t>(cfgInfo.cmd), ret);
    return ret;
}

int32_t DgwClient::QueryConfig(const ConfigQuery &query, ConfigInfo &cfgInfo, const int32_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Begin to query config.");
    // check dgw client initialized
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] please check whether datagw client has initialized successfully.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }
    // check route num/group num
    auto ret = CheckConfigNum(query, cfgInfo);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] calculate and check config num failed. Please check config num!");
        return ret;
    }

    // mbuf memory layout: 1. config query / 2.config info / 3.Routes or Endpoints / 4.config result
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // calculate query length: 1. config query
    const size_t qryLen = sizeof(ConfigQuery);
    dataList.emplace_back(std::make_pair(PtrToValue(&query), sizeof(ConfigQuery)));
    // here is to consider compatibility between client and server different versions
    std::unique_ptr<Route[]> spareRoutes = nullptr;
    std::unique_ptr<Endpoint[]> spareEndpoints = nullptr;
    if (IsQueueOperationCmd(cfgInfo)) {
        const uint32_t routeNum = cfgInfo.cfg.routesCfg.routeNum;
        spareRoutes.reset(new (std::nothrow) Route[routeNum]);
        if (spareRoutes == nullptr) {
            BQS_LOG_ERROR("[DgwClient] malloc failed on spareRoutes.");
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
    } else if (IsGroupOperationCmd(cfgInfo)) {
        const uint32_t endpointNum = cfgInfo.cfg.groupCfg.endpointNum;
        spareEndpoints.reset(new (std::nothrow) Endpoint[endpointNum]);
        if (spareEndpoints == nullptr) {
            BQS_LOG_ERROR("[DgwClient] malloc failed on spareEndpoints.");
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
    }
    
    // calculate config length: 2.config info + 3.Routes or Endpoints
    size_t cfgLen = 0UL;
    ret = CalcConfigInfoLen(cfgInfo, cfgLen, dataList, spareRoutes, spareEndpoints);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] check and calculate length of config info failed.");
        return ret;
    }
    // calculate result length: 3.config results
    size_t retLen = 0UL;
    ret = CalcResultLen(cfgInfo, retLen);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        BQS_LOG_ERROR("[DgwClient] calculate length of result failed.");
        return ret;
    }

    // opereate config to server
    std::vector<int32_t> emptyVec;
    const ConfigParams cfgParams = {
        .info = nullptr,
        .query = const_cast<ConfigQuery *>(&query),
        .cfgInfo = &cfgInfo,
        .cfgLen = cfgLen,
        .totalLen = qryLen + cfgLen + retLen,
    };
    ret = OperateConfigToServer(QueueSubEventType::QUERY_CONFIG, cfgParams, dataList, emptyVec, timeout);
    BQS_LOG_INFO("[DgwClient] Finish to update config, ret is [%d].", ret);
    return ret;
}

int32_t DgwClient::QueryConfigNum(ConfigQuery &query, const int32_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Begin to query config number.");
    // check dgw client initialized
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] please check whether datagw client has initialized successfully.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }

    // mbuf memory layout: 1. config query / 2.config result
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // calculate query length: 1. config query
    const size_t qryLen = sizeof(ConfigQuery);
    dataList.emplace_back(std::make_pair(PtrToValue(&query), sizeof(ConfigQuery)));
    // calculate result length: 2.config results
    constexpr size_t retLen = sizeof(CfgRetInfo);

    // operate config to server
    std::vector<int32_t> emptyVec;
    ConfigInfo unusedParam;
    const ConfigParams cfgParams = {
        .info = nullptr,
        .query = &query,
        .cfgInfo = &unusedParam,
        .cfgLen = 0UL,
        .totalLen = qryLen + retLen,
    };
    const auto ret = OperateConfigToServer(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, emptyVec, timeout);
    BQS_LOG_INFO("[DgwClient] Finish to query config number, ret is [%d].", ret);
    return ret;
}

int32_t DgwClient::OperateConfigToServer(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
                                         std::list<std::pair<uintptr_t, size_t>> &dataList,
                                         std::vector<int32_t> &cfgRets, const int32_t timeout)
{
    if (isProxy_) {
        return OperateToServerOnOtherSide(subEventId, cfgParams, dataList, cfgRets, timeout);
    } else {
        return OperateToServerOnSameSide(subEventId, cfgParams, dataList, cfgRets, timeout);
    }
}

static int32_t SetDataAndEnqueueForMbuf(const std::list<std::pair<uintptr_t, size_t>> &dataList,
                                        Mbuf * const mbuf, const size_t mbufLen, uint32_t deviceId,
                                        uint32_t piplineQueueId)
{
    // check mbuf and mbufLen
    if ((mbuf == nullptr) || (mbufLen == 0UL) || (dataList.empty())) {
        BQS_LOG_ERROR("[DgwClient] mbuf nullptr or mbufLen equal zero or dataList empty:%d.", dataList.empty());
        return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
    }

    // get mbuf data addr
    void *mbufData = nullptr;
    auto drvRet = halMbufGetBuffAddr(mbuf, &mbufData);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (mbufData == nullptr)) {
        BQS_LOG_ERROR("[DgwClient] Failed to get mbuf data, ret=[%d]", drvRet);
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }

    // copy data to mbuf
    size_t offset = 0UL;
    for (auto &data : dataList) {
        const size_t restMbufLen = mbufLen - offset;
        if (data.second > restMbufLen) {
            BQS_LOG_ERROR("[DgwClient] dataLen[%zu] is invalid. mbufLen is [%zu], offset is [%zu].",
                data.second, mbufLen, offset);
            return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        }
        const auto cpyRet = memcpy_s(ValueToPtr(PtrToValue(mbufData) + offset), restMbufLen,
                                     ValueToPtr(data.first), data.second);
        if (cpyRet != EOK) {
            BQS_LOG_ERROR("[DgwClient] Memcpy failed, dataSize[%zu], mbufLen[%zu] ret=[%d]",
                data.second, restMbufLen, cpyRet);
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
        offset += data.second;
    }
    // set mbuf len
    drvRet = halMbufSetDataLen(mbuf, mbufLen);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("[DgwClient] Failed to set data len[%zu] for mbuf, ret=[%d]", mbufLen, drvRet);
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }
    // mbuf enqueue
    const auto enqueueRet = halQueueEnQueue(deviceId, piplineQueueId, mbuf);
    if (enqueueRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("[DgwClient] Call halQueueEnQueue error, queue id[%u], ret=[%d]", piplineQueueId,
                      static_cast<int32_t>(enqueueRet));
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }
    BQS_LOG_INFO("[DgwClient] Call halQueueEnQueue success, queue id[%u], ret=[%d]", piplineQueueId,
                 static_cast<int32_t>(enqueueRet));
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::OperateToServerOnSameSide(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
                                             std::list<std::pair<uintptr_t, size_t>> &dataList,
                                             std::vector<int32_t> &cfgRets, const int32_t timeout)
{
    // alloc mbuf
    Mbuf *mbuf = nullptr;
    const size_t mbufLen = cfgParams.totalLen;
    auto drvRet = halMbufAlloc(mbufLen, &mbuf);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (mbuf == nullptr)) {
        BQS_LOG_ERROR("[DgwClient] failed to alloc mbuf, size[%zu], ret=[%d].", mbufLen, drvRet);
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }
    // copy data to mbuf and mbuf enqueue
    Mbuf *dequeMbuf = nullptr;
    int32_t cmdRet = static_cast<int32_t>(BQS_STATUS_OK);
    {
        const std::unique_lock<std::mutex> eventLock(eventMutex_);
        auto ret = SetDataAndEnqueueForMbuf(dataList, mbuf, mbufLen, deviceId_, piplineQueueId_);
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            // reaching here means mbuf was not enqueued, so we should free
            (void)halMbufFree(mbuf);
            mbuf = nullptr;
            return ret;
        }

        ret = InformServer(subEventId, cmdRet, timeout);
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            return ret;
        }

        drvRet = halQueueDeQueue(deviceId_, piplineQueueId_, reinterpret_cast<void**>(&dequeMbuf));
        if ((drvRet != DRV_ERROR_NONE) || (dequeMbuf == nullptr)) {
            BQS_LOG_ERROR("halQueueDeQueue from queue[%u] in device[%u] failed, error[%d]", piplineQueueId_,
                deviceId_, static_cast<int32_t>(drvRet));
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
    }

    void *dequeMbufData = nullptr;
    drvRet = halMbufGetBuffAddr(dequeMbuf, &dequeMbufData);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (dequeMbufData == nullptr)) {
        BQS_LOG_ERROR("[DgwClient] Failed to get mbuf data, ret=[%d]", drvRet);
        (void)halMbufFree(dequeMbuf);
        dequeMbuf = nullptr;
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }

    const uintptr_t dequeMbufDataAddr = PtrToValue(dequeMbufData);
    ExtractRetCode(subEventId, cfgParams, dequeMbufDataAddr, cfgRets, cmdRet);

    (void)halMbufFree(dequeMbuf);
    dequeMbuf = nullptr;
    return cmdRet;
}

int32_t DgwClient::OperateToServerOnOtherSide(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
                                              std::list<std::pair<uintptr_t, size_t>> &dataList,
                                              std::vector<int32_t> &cfgRets, const int32_t timeout)
{
    // alloc memory
    const size_t mbufLen = cfgParams.totalLen;
    std::unique_ptr<char_t[]> body(new (std::nothrow) char_t[mbufLen], std::default_delete<char_t[]>());
    if (body == nullptr) {
        BQS_LOG_ERROR("[DgwClient] failed to alloc memory for data, size[%zu].", mbufLen);
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }
    // copy data to mbuf
    size_t offset = 0UL;
    for (auto &data : dataList) {
        const size_t restMbufLen = mbufLen - offset;
        if (data.second > restMbufLen) {
            BQS_LOG_ERROR("[DgwClient] dataLen[%zu] is invalid. mbufLen is [%zu], offset is [%zu].",
                data.second, mbufLen, offset);
            return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        }
        const auto cpyRet = memcpy_s(ValueToPtr(PtrToValue(body.get()) + offset), restMbufLen,
                                     ValueToPtr(data.first), data.second);
        if (cpyRet != EOK) {
            BQS_LOG_ERROR("[DgwClient] Memcpy failed, dataSize[%zu], mbufLen[%zu] ret=[%d]",
                data.second, restMbufLen, cpyRet);
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
        offset += data.second;
    }
    const size_t totalLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen], std::default_delete<char_t[]>());
    if (vecUniquePtr == nullptr) {
        BQS_LOG_ERROR("[DgwClient] failed to alloc memory for buffIovec, size[%zu].", totalLen);
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }
    buff_iovec * const buffIovec = reinterpret_cast<buff_iovec *>(vecUniquePtr.get());
    buffIovec->context_base = nullptr;
    buffIovec->context_len = 0U;
    buffIovec->count = 1U;
    buffIovec->ptr[0U].iovec_base = body.get();
    buffIovec->ptr[0U].len = mbufLen;

    int32_t cmdRet = static_cast<int32_t>(BQS_STATUS_OK);
    {
        const std::unique_lock<std::mutex> eventLock(eventMutex_);
        auto drvRet = halQueueEnQueueBuff(deviceId_, piplineQueueId_, buffIovec, timeout);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueEnQueueBuff to queue[%u] in device[%u] failed, error[%d]",
                piplineQueueId_, deviceId_, static_cast<int32_t>(drvRet));
            return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
        }

        const auto ret = InformServer(subEventId, cmdRet, timeout);
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            return ret;
        }

        uint64_t respLen = 0U;
        drvRet = halQueuePeek(deviceId_, piplineQueueId_, &respLen, timeout);
        if ((drvRet != DRV_ERROR_NONE) || (respLen == 0U)) {
            BQS_LOG_ERROR("halQueuePeek from queue[%u] in device[%u] failed, ret[%d], respLen[%lu]",
                piplineQueueId_, deviceId_, static_cast<int32_t>(drvRet), respLen);
            return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
        }

        std::unique_ptr<char_t[]> respBody(new (std::nothrow) char_t[respLen], std::default_delete<char_t[]>());
        if (respBody == nullptr) {
            BQS_LOG_ERROR("[DgwClient] failed to alloc memory for response data, size[%lu].", respLen);
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
        buffIovec->context_base = nullptr;
        buffIovec->context_len = 0U;
        buffIovec->count = 1U;
        buffIovec->ptr[0U].iovec_base = respBody.get();
        buffIovec->ptr[0U].len = respLen;
        drvRet = halQueueDeQueueBuff(deviceId_, piplineQueueId_, buffIovec, timeout);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueDeQueueBuff from queue[%u] in device[%u] failed, ret[%d]",
                piplineQueueId_, deviceId_, static_cast<int32_t>(drvRet));
            return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
        }

        const uintptr_t dequeMbufDataAddr = PtrToValue(respBody.get());
        ExtractRetCode(subEventId, cfgParams, dequeMbufDataAddr, cfgRets, cmdRet);
    }
    return cmdRet;
}

void DgwClient::ExtractRetCode(const QueueSubEventType subEventId, const ConfigParams &cfgParams,
    const uintptr_t respPtr, std::vector<int32_t> &cfgRets, int32_t &cmdRet) const
{
    // create or destroy handle
    if ((subEventId == QueueSubEventType::DGW_CREATE_HCOM_HANDLE) ||
        (subEventId == QueueSubEventType::DGW_DESTORY_HCOM_HANDLE)) {
        if (cfgParams.info == nullptr) {
            cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        } else {
            (void)GetOperateHcomHandleRet(subEventId, *cfgParams.info, respPtr, cfgParams.cfgLen, cmdRet);
        }
    } else if (subEventId == QueueSubEventType::QUERY_CONFIG_NUM) { // qry config num get result outside
        if (cfgParams.query == nullptr) {
            cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        } else {
            (void)GetQryConfigNumRet(*cfgParams.query, respPtr, cmdRet);
        }
    } else {
        if (cfgParams.cfgInfo == nullptr) {
            cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        } else {
            (void)GetOperateConfigRet(*cfgParams.cfgInfo, respPtr, cfgParams.cfgLen, cfgRets, cmdRet);
        }
    }
}

int32_t DgwClient::InformServer(const QueueSubEventType subEventId, int32_t &cmdRet, const int32_t timeout)
{
    // send event to datagw server
    event_sync_msg syncMsg = {};
    QsProcMsgRsp procMsgRsp = {};
    const auto ret = SendEventToQsSync(&syncMsg, sizeof(event_sync_msg), subEventId, procMsgRsp, timeout);
    if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
        return ret;
    }
    cmdRet = procMsgRsp.retCode;
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::SendEventToQsSync(const void *const msg, const size_t msgLen,
                                     const QueueSubEventType subEventId,
                                     QsProcMsgRsp &qsProcMsgRsp, const int32_t timeout) const
{
    BQS_LOG_INFO("[DgwClient]SendEventToQsSync QsProcMsgRsp begin, timeout: %ds, deviceId: %u", timeout, deviceId_);
    event_reply drvAck;
    drvAck.buf = PtrToPtr<QsProcMsgRsp, char>(&qsProcMsgRsp);
    drvAck.buf_len = sizeof(QsProcMsgRsp);

    event_summary drvEventInfo = {};
    if (isProxy_) {
        drvEventInfo.dst_engine = static_cast<uint32_t>(CCPU_DEVICE);
    } else {
        // FlowGW host deployer client -- server used
        drvEventInfo.dst_engine = static_cast<uint32_t>(CCPU_LOCAL);
    }
    drvEventInfo.policy = ONLY;
    drvEventInfo.pid = qsPid_;
    drvEventInfo.grp_id = static_cast<uint32_t>(BIND_QUEUE_GROUP_ID);
    drvEventInfo.event_id = EVENT_QS_MSG;
    drvEventInfo.subevent_id = static_cast<uint32_t>(subEventId);
    drvEventInfo.msg_len = static_cast<uint32_t>(msgLen);
    drvEventInfo.msg = const_cast<char *>(static_cast<const char *>(msg));

    const int32_t timeOutMs = timeout > 0 ? timeout * 1000 : timeout;
    const auto drvRet = halEschedSubmitEventSync(deviceId_, &drvEventInfo, timeOutMs, &drvAck);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_WARN("[DgwClient] Failed to submit event to qs, ret=[%d].", static_cast<int32_t>(drvRet));
        if (drvRet == DRV_ERROR_SCHED_WAIT_TIMEOUT) {
            return static_cast<int32_t>(BQS_STATUS_TIMEOUT);
        }
        return static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    }
    if (static_cast<size_t>(drvAck.reply_len) != sizeof(QsProcMsgRsp)) {
        BQS_LOG_ERROR("[DgwClient] QsProcMsgRsp event_reply event message invalid, bufLen[%u], subEventId[%u]",
            drvAck.reply_len, static_cast<uint32_t>(subEventId));
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::GetQryConfigNumRet(ConfigQuery &query, const uintptr_t mbufData, int32_t &cmdRet) const
{
    if (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) {
        // return API operate result, not query config num ret
        return static_cast<int32_t>(BQS_STATUS_OK);
    }

    const uintptr_t retAddr = mbufData + sizeof(ConfigQuery);
    cmdRet = (PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr)))->retCode;

    const ConfigQuery *cfgQry = PtrToPtr<void, ConfigQuery>(ValueToPtr(mbufData));
    if (query.mode == QueryMode::DGW_QUERY_MODE_GROUP) {
        query.qry.groupQry.endpointNum = cfgQry->qry.groupQry.endpointNum;
    } else {
        query.qry.routeQry.routeNum = cfgQry->qry.routeQry.routeNum;
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::GetOperateConfigRet(ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                                       std::vector<int32_t> &cfgRets, int32_t &cmdRet) const
{
    int32_t ret = static_cast<int32_t>(BQS_STATUS_OK);
    switch (cfgInfo.cmd) {
        case ConfigCmd::DGW_CFG_CMD_BIND_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE: {
            ret = GetUpdateRouteRet(cfgInfo, mbufData, cfgLen, cfgRets, cmdRet);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_ADD_GROUP:
        case ConfigCmd::DGW_CFG_CMD_DEL_GROUP: {
            ret = GetUpdateGroupRet(cfgInfo, mbufData, cfgLen, cfgRets, cmdRet);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_QRY_GROUP: {
            ret = GetQryGroupRet(cfgInfo, mbufData, cfgLen, cfgRets, cmdRet);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_QRY_ROUTE: {
            ret = GetQryRouteRet(cfgInfo, mbufData, cfgLen, cfgRets, cmdRet);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING:
        case ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL:
        case ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE:
        case ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE:
        case ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE: {
            const uintptr_t retAddr = mbufData + cfgLen;
            cmdRet = (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) ?
                    cmdRet : PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr))->retCode;
            cfgRets.push_back(cmdRet);
            break;
        }
        default: {
            BQS_LOG_WARN("[DgwClient] cmd[%d] is invalid.", static_cast<int32_t>(cfgInfo.cmd));
            cmdRet = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            ret = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            break;
        }
    }
    return ret;
}

int32_t DgwClient::GetOperateHcomHandleRet(const QueueSubEventType subEventId, HcomHandleInfo &info,
                                           const uintptr_t mbufData, const size_t cfgLen, int32_t &cmdRet) const
{
    constexpr int32_t ret = static_cast<int32_t>(BQS_STATUS_OK);
    const uintptr_t retAddr = mbufData + cfgLen;
    cmdRet = (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) ?
            cmdRet : PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr))->retCode;
    if (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) {
        return static_cast<int32_t>(BQS_STATUS_OK);
    }

    if (subEventId == QueueSubEventType::DGW_CREATE_HCOM_HANDLE) {
        info.hcomHandle = PtrToPtr<void, HcomHandleInfo>(ValueToPtr(mbufData))->hcomHandle;
    }
    return ret;
}

int32_t DgwClient::CalcResultLen(const ConfigInfo &cfgInfo, size_t &retLen) const
{
    retLen = 0UL;
    switch (cfgInfo.cmd) {
        case ConfigCmd::DGW_CFG_CMD_BIND_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE: {
            retLen += cfgInfo.cfg.routesCfg.routeNum * sizeof(CfgRetInfo);
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_QRY_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_QRY_GROUP:
        case ConfigCmd::DGW_CFG_CMD_ADD_GROUP:
        case ConfigCmd::DGW_CFG_CMD_DEL_GROUP:
        case ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING:
        case ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL:
        case ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE:
        case ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE:
        case ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE: {
            retLen += sizeof(CfgRetInfo);
            break;
        }
        default: {
            break;
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

// Create a handler for each EndpointType
uint32_t HandleMemQueue(Endpoint &dstEndPoint, Endpoint &srcEndPoint)
{
    dstEndPoint.type = bqs::EndpointType::QUEUE;
    dstEndPoint.attr.queueAttr.queueId = srcEndPoint.attr.memQueueAttr.queueId;
    return static_cast<int32_t>(BQS_STATUS_OK);
}

uint32_t HandleGroup(Endpoint &dstEndPoint, Endpoint &srcEndPoint)
{
    size_t groupAttrSize = sizeof(srcEndPoint.attr.groupAttr);
    const auto cpyRet = memcpy_s(
        (void *)(&dstEndPoint.attr.groupAttr), groupAttrSize, (void *)(&srcEndPoint.attr.groupAttr), groupAttrSize);
    if (cpyRet != EOK) {
        BQS_LOG_ERROR("[HandleGroup] Memcpy failed, cpyLen[%zu], ret=[%d]", groupAttrSize, cpyRet);
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

uint32_t HandleCommChannel(Endpoint &dstEndPoint, Endpoint &srcEndPoint)
{
    size_t channelAttrSize = sizeof(srcEndPoint.attr.channelAttr);
    const auto cpyRet = memcpy_s((void *)(&dstEndPoint.attr.channelAttr), channelAttrSize,
        (void *)(&srcEndPoint.attr.channelAttr), channelAttrSize);
    if (cpyRet != EOK) {
        BQS_LOG_ERROR("[HandleCommChannel] Memcpy failed, cpyLen[%zu], ret=[%d]", channelAttrSize, cpyRet);
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

// Define the function pointer type
using EndpointHandler = uint32_t (*)(Endpoint&, Endpoint&);

// Creating Table Mappings
std::map<bqs::EndpointType, EndpointHandler> g_endpointHandlers = {
    {bqs::EndpointType::MEM_QUEUE, HandleMemQueue},
    {bqs::EndpointType::GROUP, HandleGroup},
    {bqs::EndpointType::COMM_CHANNEL, HandleCommChannel},
};

uint32_t EndpointTransformMemQ2Q(Endpoint &dstEndPoint, Endpoint &srcEndPoint)
{
    if (srcEndPoint.type == bqs::EndpointType::MEM_QUEUE &&
        srcEndPoint.attr.memQueueAttr.queueType == bqs::CLIENT_Q) {
        BQS_LOG_ERROR("[EndpointTransformMemQ2Q] CLIENT_Q interception");
        return static_cast<int32_t>(BQS_STATUS_ENDPOINT_MEM_TYPE_NOT_SUPPORT);
    }
    dstEndPoint.type = srcEndPoint.type;
    dstEndPoint.status = srcEndPoint.status;
    dstEndPoint.peerNum = srcEndPoint.peerNum;
    dstEndPoint.localId = srcEndPoint.localId;
    dstEndPoint.globalId = srcEndPoint.globalId;
    dstEndPoint.modelId = srcEndPoint.modelId;
    // localQ need transform
    auto it = g_endpointHandlers.find(srcEndPoint.type);
    if (it != g_endpointHandlers.end()) {
        return it->second(dstEndPoint, srcEndPoint);
    } else {
        BQS_LOG_ERROR("[EndpointTransformMemQ2Q] should not reach here");
        return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t EndpointTransformQ2MemQ(std::unique_ptr<Endpoint[]> &endpoints, uint32_t endpointNum)
{
    for (uint32_t rdx = 0; rdx < endpointNum; rdx++) {
        if (endpoints[rdx].type == bqs::EndpointType::QUEUE) {
            BQS_LOG_INFO("[EndpointTransformQ2MemQ] transfer q to memq");
            endpoints[rdx].type = bqs::EndpointType::MEM_QUEUE;
            endpoints[rdx].attr.memQueueAttr.queueId = endpoints[rdx].attr.queueAttr.queueId;
            endpoints[rdx].attr.memQueueAttr.queueType = 0;
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t GroupQueueTransform(Endpoint *endpoints, uint32_t endpointNum, std::unique_ptr<Endpoint[]> &spareEndpoints)
{
    bool isNeedTransform = false;
    for (uint32_t rdx = 0; rdx < endpointNum; rdx++) {
        if (endpoints[rdx].type == bqs::EndpointType::MEM_QUEUE) {
            isNeedTransform = true;
        }
    }

    if (!isNeedTransform) {
        BQS_LOG_INFO("[GroupQueueTransform] group no mem queue do not to transfer");
        return static_cast<int32_t>(BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM);
    }

    for (uint32_t rdx = 0; rdx < endpointNum; rdx++) {
        uint32_t ret = EndpointTransformMemQ2Q(spareEndpoints[rdx], endpoints[rdx]);
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[GroupQueueTransform] transfer error ret=%u", ret);
            return ret;
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t MemQueueAttr2queueAttrTransform(Route *routes, uint32_t routeNum, std::unique_ptr<Route[]> &spareRoutes)
{
    bool isNeedTransform = false;
    for (uint32_t rdx = 0; rdx < routeNum; rdx++) {
        if (routes[rdx].src.type == bqs::EndpointType::MEM_QUEUE ||
            routes[rdx].dst.type == bqs::EndpointType::MEM_QUEUE) {
            isNeedTransform = true;
        }
    }

    if (!isNeedTransform) {
        BQS_LOG_INFO("[MemQueueAttr2queueAttrTransform] no mem queue do not to transfer");
        return static_cast<int32_t>(BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM);
    }

    for (uint32_t rdx = 0; rdx < routeNum; rdx++) {
        spareRoutes[rdx].status = routes[rdx].status;
        // src copy
        uint32_t ret = EndpointTransformMemQ2Q(spareRoutes[rdx].src, routes[rdx].src);
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[MemQueueAttr2queueAttrTransform] transfer error ret=%u", ret);
            return ret;
        }

        // dst copy
        ret = EndpointTransformMemQ2Q(spareRoutes[rdx].dst, routes[rdx].dst);
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[MemQueueAttr2queueAttrTransform] transfer error ret=%u", ret);
            return ret;
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::ChangeDynamicScheduleDeviceId(const ConfigInfo &cfgInfo)
{
    BQS_LOG_INFO("[DgwClient] begin to process dynamic schedule device id.");
    if (cfgInfo.cfg.dynamicSchedCfgV2->requestQ.deviceType == 0) {
        uint32_t logicDeviceId = cfgInfo.cfg.dynamicSchedCfgV2->requestQ.deviceId;
        auto cRet = ChangeUserDeviceIdToLogicDeviceId(cfgInfo.cfg.dynamicSchedCfgV2->requestQ.deviceId, logicDeviceId);
        if (cRet != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[DgwClient] ChangeUserDeviceIdToLogicDeviceId failed ret [%d]", cRet);
            return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        }
        cfgInfo.cfg.dynamicSchedCfgV2->requestQ.deviceId = logicDeviceId;
    }
    if (cfgInfo.cfg.dynamicSchedCfgV2->responseQ.deviceType == 0) {
        uint32_t logicDeviceId = cfgInfo.cfg.dynamicSchedCfgV2->responseQ.deviceId;
        auto cRet = ChangeUserDeviceIdToLogicDeviceId(cfgInfo.cfg.dynamicSchedCfgV2->responseQ.deviceId, logicDeviceId);
        if (cRet != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[DgwClient] ChangeUserDeviceIdToLogicDeviceId failed ret [%d]", cRet);
            return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        }
        cfgInfo.cfg.dynamicSchedCfgV2->responseQ.deviceId = logicDeviceId;
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::ProcessEndpointDeviceId(Endpoint &endpoint) const
{
    BQS_LOG_INFO("[DgwClient] begin to process endpoint deviceId %u.", endpoint.resId);
    if (isProxy_ && QSFeatureCtrl::IsSupportSetVisibleDevices(g_chipType)) {
        bool isHostQueue = ((endpoint.resId >> RESOURCE_ID_HOST_DEVICE_BIT_NUM) & 1) ? true : false;
        if (!isHostQueue) {
            uint32_t frontPart = endpoint.resId & ROUCE_ID_FRONT_PART_DATA_MASK;
            uint32_t rearPart = endpoint.resId & ROUCE_ID_DEVICE_ID_DATA_MASK;
            uint32_t tmpRearPart = rearPart;
            auto cRet = ChangeUserDeviceIdToLogicDeviceId(rearPart, tmpRearPart);
            if (cRet != static_cast<int32_t>(BQS_STATUS_OK)) {
                BQS_LOG_ERROR("[DgwClient] ChangeUserDeviceIdToLogicDeviceId failed ret [%d]", cRet);
                return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            }
            endpoint.resId = static_cast<uint16_t>(frontPart) | static_cast<uint16_t>(tmpRearPart);
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::CalcConfigInfoLen(const ConfigInfo &cfgInfo, size_t &cfgLen,
                                     std::list<std::pair<uintptr_t, size_t>> &dataList,
                                     std::unique_ptr<Route[]> &spareRoutes,
                                     std::unique_ptr<Endpoint[]> &spareEndpoints) const
{
    switch (cfgInfo.cmd) {
        case ConfigCmd::DGW_CFG_CMD_BIND_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE:
        case ConfigCmd::DGW_CFG_CMD_QRY_ROUTE: {
            Route *routes = cfgInfo.cfg.routesCfg.routes;
            if (routes == nullptr) {
                BQS_LOG_ERROR("routes is nullptr.");
                return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            }
            const uint32_t routeNum = cfgInfo.cfg.routesCfg.routeNum;
            if ((routeNum == 0U) || (routeNum > MAX_ROUTES_NUM)) {
                BQS_LOG_ERROR("route num[%u] is invalid, max allowed value is [%u].", routeNum, MAX_ROUTES_NUM);
                return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            }

            for (uint32_t rdx = 0; rdx < routeNum; rdx++) {
                auto pRet = ProcessEndpointDeviceId(routes[rdx].src) + ProcessEndpointDeviceId(routes[rdx].dst);
                if (pRet != static_cast<int32_t>(BQS_STATUS_OK)) {
                    return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
                }
            }

            cfgLen += (sizeof(cfgInfo) + static_cast<size_t>(routeNum) * sizeof(Route));
            dataList.emplace_back(std::make_pair(PtrToValue(&cfgInfo), sizeof(ConfigInfo)));
            if (!isServerOldVersion_) {
                dataList.emplace_back(std::make_pair(PtrToValue(routes), routeNum * sizeof(Route)));
            } else {
                BQS_LOG_INFO("[CalcConfigInfoLen] old version try to transfer mem queue");
                const auto cpyRet = memcpy_s(static_cast<void *>(spareRoutes.get()), routeNum * sizeof(Route),
                                             routes, routeNum * sizeof(Route));
                if (cpyRet != EOK) {
                    BQS_LOG_ERROR("[CalcConfigInfoLen] Memcpy failed, cpyLen[%zu], ret=[%d]",
                        routeNum * sizeof(Route), cpyRet);
                    return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
                }
                const int32_t ret = MemQueueAttr2queueAttrTransform(routes, routeNum, spareRoutes);
                if (ret != static_cast<int32_t>(BQS_STATUS_OK) &&
                    ret != static_cast<int32_t>(BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM)) {
                    BQS_LOG_ERROR("[CalcConfigInfoLen] ret is not okay or routes client is nullptr");
                    return ret;
                }
                if (ret == static_cast<int32_t>(BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM)) {
                    dataList.emplace_back(std::make_pair(PtrToValue(routes), routeNum * sizeof(Route)));
                } else {
                    dataList.emplace_back(std::make_pair(PtrToValue(spareRoutes.get()), routeNum * sizeof(Route)));
                }
            }
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_ADD_GROUP:
        case ConfigCmd::DGW_CFG_CMD_QRY_GROUP: {
            Endpoint *endpoints = cfgInfo.cfg.groupCfg.endpoints;
            if (endpoints == nullptr) {
                BQS_LOG_ERROR("endpoints is nullptr.");
                return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            }
            
            for (uint32_t rdx = 0; rdx < cfgInfo.cfg.groupCfg.endpointNum; rdx++) {
                auto pRet = ProcessEndpointDeviceId(endpoints[rdx]);
                if (pRet != static_cast<int32_t>(BQS_STATUS_OK)) {
                    return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
                }
            }

            const uint32_t endpointNum = cfgInfo.cfg.groupCfg.endpointNum;
            if ((endpointNum == 0U) || (endpointNum > MAX_ENDPOINTS_NUM_IN_SINGLE_GROUP)) {
                BQS_LOG_ERROR("route num[%u] is invalid.", endpointNum);
                return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            }
            const size_t endpointsLen = endpointNum * sizeof(Endpoint);
            cfgLen += (sizeof(cfgInfo) + endpointsLen);
            dataList.emplace_back(std::make_pair(PtrToValue(&cfgInfo), sizeof(ConfigInfo)));
            if (!isServerOldVersion_) {
                dataList.emplace_back(std::make_pair(PtrToValue(endpoints), endpointsLen));
            } else {
                BQS_LOG_INFO("[CalcConfigInfoLen] old version group try to transfer mem queue");
                const auto cpyRet = memcpy_s(static_cast<void *>(spareEndpoints.get()), endpointNum * sizeof(Endpoint),
                                             endpoints, endpointNum * sizeof(Endpoint));
                if (cpyRet != EOK) {
                    BQS_LOG_ERROR("[CalcConfigInfoLen] Memcpy failed, cpyLen[%zu], ret=[%d]",
                        endpointsLen, cpyRet);
                    return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
                }
                const int32_t ret = GroupQueueTransform(endpoints, endpointNum, spareEndpoints);
                if (ret != static_cast<int32_t>(BQS_STATUS_OK) &&
                    ret != static_cast<int32_t>(BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM)) {
                    BQS_LOG_ERROR("[CalcConfigInfoLen] ret is not okay or routes client is nullptr");
                    return ret;
                }
                if (ret == static_cast<int32_t>(BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM)) {
                    dataList.emplace_back(std::make_pair(PtrToValue(endpoints), endpointsLen));
                } else {
                    dataList.emplace_back(std::make_pair(PtrToValue(spareEndpoints.get()), endpointsLen));
                }
            }
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING:
        case ConfigCmd::DGW_CFG_CMD_DEL_GROUP:
        case ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL: {
            cfgLen += sizeof(cfgInfo);
            dataList.emplace_back(std::make_pair(PtrToValue(&cfgInfo), sizeof(ConfigInfo)));
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE: {
            if (isProxy_ && QSFeatureCtrl::IsSupportSetVisibleDevices(g_chipType) && cfgInfo.cfg.dynamicSchedCfgV2 != nullptr) {
                auto cRet = ChangeDynamicScheduleDeviceId(cfgInfo);
                if (cRet != static_cast<int32_t>(BQS_STATUS_OK)) {
                    return cRet;
                }
            }

            cfgLen += sizeof(cfgInfo) + sizeof(DynamicSchedConfigV2);
            dataList.emplace_back(std::make_pair(PtrToValue(&cfgInfo), sizeof(ConfigInfo)));
            dataList.emplace_back(std::make_pair(PtrToValue(cfgInfo.cfg.dynamicSchedCfgV2),
                sizeof(DynamicSchedConfigV2)));
            break;
        }
        case ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE:
        case ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE: {
            const size_t rootModelIdsLen = cfgInfo.cfg.reDeployCfg.rootModelNum * sizeof(uint32_t);
            cfgLen += sizeof(cfgInfo) + rootModelIdsLen;
            dataList.emplace_back(std::make_pair(PtrToValue(&cfgInfo), sizeof(ConfigInfo)));
            dataList.emplace_back(std::make_pair(cfgInfo.cfg.reDeployCfg.rootModelIdsAddr, rootModelIdsLen));
            break;
        }
        default: {
            BQS_LOG_ERROR("calculate config info len failed, cmd[%d] is invalid.", static_cast<int32_t>(cfgInfo.cmd));
            return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::CheckConfigNum(const ConfigQuery &query, ConfigInfo &cfgInfo)
{
    int32_t ret = static_cast<int32_t>(BQS_STATUS_OK);
    switch (query.mode) {
        case QueryMode::DGW_QUERY_MODE_GROUP: {
            const uint32_t endpointNum = query.qry.groupQry.endpointNum;
            // query config num
            ConfigQuery tmpQry = query;
            ret = QueryConfigNum(tmpQry);
            if (ret == static_cast<int32_t>(BQS_STATUS_OK)) {
                // check endpointNum
                if ((endpointNum != tmpQry.qry.groupQry.endpointNum) || (endpointNum == 0U)) {
                    BQS_LOG_ERROR("[DgwClient] Param error! endpointNum in query is [%u], "
                        "but endpointNum searched from dgw server is [%u].",
                        endpointNum, tmpQry.qry.groupQry.endpointNum);
                    ret = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
                } else {
                    // set to cfgInfo
                    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_QRY_GROUP;
                    cfgInfo.cfg.groupCfg.endpointNum = endpointNum;
                }
            }
            break;
        }
        case QueryMode::DGW_QUERY_MODE_SRC_ROUTE:
        case QueryMode::DGW_QUERY_MODE_DST_ROUTE:
        case QueryMode::DGW_QUERY_MODE_SRC_DST_ROUTE:
        case QueryMode::DGW_QUERY_MODE_ALL_ROUTE: {
            uint32_t routeNum = query.qry.routeQry.routeNum;
            // query config num
            ConfigQuery tmpQry = query;
            ret = QueryConfigNum(tmpQry);
            if (ret == static_cast<int32_t>(BQS_STATUS_OK)) {
                // check routeNum
                if ((routeNum != tmpQry.qry.routeQry.routeNum) || (routeNum == 0U)) {
                    BQS_LOG_ERROR("[DgwClient] Param error! routeNum in query is [%u], "
                        "but routeNum searched from dgw server is [%u].",
                        routeNum, tmpQry.qry.routeQry.routeNum);
                    ret = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
                } else {
                    // set to cfgInfo
                    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_QRY_ROUTE;
                    cfgInfo.cfg.routesCfg.routeNum = routeNum;
                }
            }
            break;
        }
        default: {
            ret = static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
            BQS_LOG_ERROR("[DgwClient] query mode[%d] is invalid.", static_cast<int32_t>(query.mode));
            break;
        }
    }
    return ret;
}

int32_t DgwClient::GetUpdateRouteRet(const ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                                     std::vector<int32_t> &cfgRets, int32_t &cmdRet) const
{
    bool failFlag = false;
    const uintptr_t retAddr = mbufData + cfgLen;
    CfgRetInfo * const results = PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr));
    const size_t routeNum = static_cast<size_t>(cfgInfo.cfg.routesCfg.routeNum);
    for (size_t i = 0UL; i < routeNum; i++) {
        const int32_t retCode = (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) ?
            cmdRet : PtrAdd<CfgRetInfo>(results, routeNum, i)->retCode;
        cfgRets.push_back(retCode);
        failFlag = ((!failFlag) && (retCode != static_cast<int32_t>(BQS_STATUS_OK))) ? true : failFlag;
    }
    cmdRet = (failFlag) ? static_cast<int32_t>(BQS_STATUS_FAILED) : cmdRet;
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::GetUpdateGroupRet(ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                                     std::vector<int32_t> &cfgRets, int32_t &cmdRet) const
{
    const uintptr_t retAddr = mbufData + cfgLen;
    cmdRet = (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) ?
            cmdRet : PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr))->retCode;
    cfgRets.push_back(cmdRet);
    if (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) {
        return static_cast<int32_t>(BQS_STATUS_OK);
    }
    cfgInfo.cfg.groupCfg.groupId = PtrToPtr<void, ConfigInfo>(ValueToPtr(mbufData))->cfg.groupCfg.groupId;
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::GetQryGroupRet(const ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                                  std::vector<int32_t> &cfgRets, int32_t &cmdRet) const
{
    (void)cfgRets;
    const uintptr_t retAddr = mbufData + sizeof(ConfigQuery) + cfgLen;
    cmdRet = (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) ?
            cmdRet : PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr))->retCode;
    // cpy result to user memory
    if (cmdRet == static_cast<int32_t>(BQS_STATUS_OK)) {
        if (!isServerOldVersion_) {
            Endpoint *endpoints = cfgInfo.cfg.groupCfg.endpoints;
            const size_t endpointsLen =  cfgInfo.cfg.groupCfg.endpointNum * sizeof(Endpoint);
            const uintptr_t srcAddr = mbufData + sizeof(ConfigQuery) + sizeof(ConfigInfo);
            const size_t srcLen = cfgLen - sizeof(ConfigInfo);
            const auto cpyRet = memcpy_s(static_cast<void *>(endpoints), endpointsLen,
                                         ValueToPtr(srcAddr), srcLen);
            if (cpyRet != EOK) {
                cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
                BQS_LOG_ERROR("Memcpy failed, srcLen[%zu], dstLen[%zu] ret=[%d]", srcLen, endpointsLen, cpyRet);
                return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
            }
        } else {
            BQS_LOG_INFO("[GetQryGroupRet] old version need to transfer queue 2 mem queue");
            std::unique_ptr<Endpoint[]> spareEndpoints(new (std::nothrow) Endpoint[cfgInfo.cfg.groupCfg.endpointNum]);
            if (spareEndpoints == nullptr) {
                BQS_LOG_ERROR("[DgwClient] malloc failed on spareEndpoints.");
                return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
            }

            const size_t endpointsLen =  cfgInfo.cfg.groupCfg.endpointNum * sizeof(Endpoint);
            const uintptr_t srcAddr = mbufData + sizeof(ConfigQuery) + sizeof(ConfigInfo);
            const size_t srcLen = cfgLen - sizeof(ConfigInfo);
            auto cpyRet = memcpy_s(static_cast<void *>(spareEndpoints.get()), endpointsLen,
                                   ValueToPtr(srcAddr), srcLen);
            if (cpyRet != EOK) {
                cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
                BQS_LOG_ERROR("Memcpy failed, srcLen[%zu], dstLen[%zu] ret=[%d]", srcLen, endpointsLen, cpyRet);
                return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
            }
            const int32_t ret = EndpointTransformQ2MemQ(spareEndpoints, cfgInfo.cfg.groupCfg.endpointNum);
            if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
                BQS_LOG_ERROR("ret is not okay or routes client is nullptr");
                return ret;
            }
            Endpoint *endpoints = cfgInfo.cfg.groupCfg.endpoints;
            cpyRet = memcpy_s(static_cast<void *>(endpoints), endpointsLen,
                              static_cast<void *>(spareEndpoints.get()), srcLen);
            if (cpyRet != EOK) {
                cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
                BQS_LOG_ERROR("Memcpy failed, srcLen[%zu], dstLen[%zu] ret=[%d]", srcLen, endpointsLen, cpyRet);
                return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
            }
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

int32_t DgwClient::GetQryRouteRet(const ConfigInfo &cfgInfo, const uintptr_t mbufData, const size_t cfgLen,
                                  std::vector<int32_t> &cfgRets, int32_t &cmdRet) const
{
    (void)cfgRets;
    const uintptr_t retAddr = mbufData + sizeof(ConfigQuery) + cfgLen;
    cmdRet = (cmdRet != static_cast<int32_t>(BQS_STATUS_OK)) ?
            cmdRet : PtrToPtr<void, CfgRetInfo>(ValueToPtr(retAddr))->retCode;
    // cpy result to user memory
    if (cmdRet == static_cast<int32_t>(BQS_STATUS_OK)) {
        Route *routes = cfgInfo.cfg.routesCfg.routes;
        const size_t routesLen = cfgInfo.cfg.routesCfg.routeNum * sizeof(Route);
        const uintptr_t srcAddr = mbufData + sizeof(ConfigQuery) + sizeof(ConfigInfo);
        const size_t srcLen = cfgLen - sizeof(ConfigInfo);
        const auto cpyRet = memcpy_s(static_cast<void *>(routes), routesLen, ValueToPtr(srcAddr), srcLen);
        if (cpyRet != EOK) {
            cmdRet = static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
            BQS_LOG_ERROR("Memcpy failed, srcLen[%zu], dstLen[%zu] ret=[%d]", srcLen, routesLen, cpyRet);
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}

// 由于兼容性问题，该接口废弃
int32_t DgwClient::WaitConfigEffect(const uint64_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Begin to waitConfigEffect.");
    const std::lock_guard<std::mutex> lk(mutexForWaitConfig);
    // check dgw client initialized
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] please check whether datagw client has initialized successfully.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }

    // 隔1S发送一次事件到SERVER端检测建链是否成功
    int32_t cmdRet = static_cast<int32_t>(BQS_STATUS_FAILED);
    for (uint64_t index = 0; index <= timeout; index++) {
        event_sync_msg syncMsg = {};
        QsProcMsgRsp procMsgRsp = {};
        const int32_t ret = SendEventToQsSync(&syncMsg, sizeof(event_sync_msg), QueueSubEventType::QUERY_LINKSTATUS,
                                              procMsgRsp, static_cast<int32_t>(timeout));
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[DgwClient] SendEventToQsSync failed ret[%d]", ret);
            return ret;
        }
        cmdRet = procMsgRsp.retCode;
        if (cmdRet == static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_INFO("[DgwClient] WaitConfigEffect Success");
            return static_cast<int32_t>(BQS_STATUS_OK);
        } else {
            sleep(1);
        }
    }
    BQS_LOG_ERROR("[DgwClient] WaitConfigEffect Failed");
    return static_cast<int32_t>(BQS_STATUS_FAILED);
}

int32_t DgwClient::WaitConfigEffect(const int32_t rsv, const int32_t timeout)
{
    BQS_LOG_INFO("[DgwClient] Begin to waitConfigEffect rsv value:%d, timeout:%ds", rsv, timeout);
    if (rsv != 0) {
        BQS_LOG_ERROR("[DgwClient] please check rsv value:%d", rsv);
        return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
    }
    if (timeout <= 0) {
        BQS_LOG_ERROR("[DgwClient] please check timeout value:%ds", timeout);
        return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
    }
    const std::lock_guard<std::mutex> lk(mutexForWaitConfig);
    // check dgw client initialized
    if (!initFlag_) {
        BQS_LOG_ERROR("[DgwClient] please check whether datagw client has initialized successfully.");
        return static_cast<int32_t>(BQS_STATUS_NOT_INIT);
    }

    // 隔1S发送一次事件到SERVER端检测建链是否成功
    int32_t cmdRet = static_cast<int32_t>(BQS_STATUS_FAILED);
    for (uint64_t index = 0; index <= (QUERY_LINK_STATUS_UNIT / QUERY_LINK_STATUS_INTERVAL * timeout);
         index++) {
        event_sync_msg syncMsg = {};
        QsProcMsgRsp procMsgRsp = {};
        const int32_t ret = SendEventToQsSync(&syncMsg, sizeof(event_sync_msg),
                                              QueueSubEventType::QUERY_LINKSTATUS_V2,
                                              procMsgRsp, static_cast<int32_t>(timeout));
        if (ret != static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_ERROR("[DgwClient] SendEventToQsSync failed ret[%d]", ret);
            return ret;
        }
        cmdRet = procMsgRsp.retCode;
        if (cmdRet == static_cast<int32_t>(BQS_STATUS_OK)) {
            BQS_LOG_INFO("[DgwClient] WaitConfigEffect Success");
            return static_cast<int32_t>(BQS_STATUS_OK);
        } else if (cmdRet == static_cast<int32_t>(BQS_STATUS_PARAM_INVALID)) {
            BQS_LOG_INFO("[DgwClient] WaitConfigEffect not support");
            return static_cast<int32_t>(BQS_STATUS_NOT_SUPPORT);
        } else {
            usleep(QUERY_LINK_STATUS_INTERVAL);
        }
    }
    BQS_LOG_ERROR("[DgwClient] WaitConfigEffect Failed");
    return static_cast<int32_t>(BQS_STATUS_FAILED);
}

int32_t DgwClient::GetPlatformInfo(const uint32_t deviceId)
{
    BQS_LOG_INFO("[DgwClient] begin to GetPlatformInfo, deviceId=%u", deviceId);
    int64_t hardwareVersion = 0;
    auto drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device info by halGetDeviceInfo failed, errorCode[%d] deviceId[%u]", drvRet, deviceId);
        return static_cast<int32_t>(BQS_STATUS_FAILED);
    }
    g_chipType = AICPU_PLAT_GET_CHIP(static_cast<uint64_t>(hardwareVersion));
    g_hadGetChipType = true;
    BQS_LOG_INFO("[DgwClient] Get chip type [%u]", static_cast<uint32_t>(g_chipType));
    return static_cast<int32_t>(BQS_STATUS_OK);
}

bool DgwClient::IsNumeric(const std::string& str) {
    if (str.empty()) {
        return false;
    }
    for (char c : str) {
        if (!isdigit(c)) {
            return false;
        }
    }
    return true;
}

void DgwClient::SplitString(const std::string &str, std::vector<std::string> &result)
{
    size_t start = 0;
    size_t end = str.find(',');

    while (end != std::string::npos) {
        std::string substr = str.substr(start, end - start);
        if (!IsNumeric(substr)) {
            BQS_LOG_WARN("[DgwClient] invalid device id [%s]", substr.c_str());
            return;
        }
        result.push_back(substr);
        start = end + 1;
        end = str.find(',', start);
    }

    std::string substr = str.substr(start);
    if (!IsNumeric(substr)) {
        BQS_LOG_WARN("[DgwClient] invalid device id [%s]", substr.c_str());
        return;
    }
    result.push_back(substr);
}

bool DgwClient::GetVisibleDevices()
{
    // 标记hadGetVisibleDevices表示即将完成ASCEND_RT_VISIBLE_DEVICES解析
    g_hadGetVisibleDevices = true;
    // 获取并校验ASCEND_RT_VISIBLE_DEVICES环境变量配置
    std::string inputStr;
    bqs::GetEnvVal("ASCEND_RT_VISIBLE_DEVICES", inputStr);
    BQS_LOG_INFO("[DgwClient] Get env ASCEND_RT_VISIBLE_DEVICES [%s].", inputStr.c_str());
    if (inputStr.empty()) {
        return false;
    }
    // 清空userDeviceInfo中的内容
    g_userDeviceInfo.clear();
    // 配置解析并校验
    uint32_t deviceCnt = 0U;
    const drvError_t drvRet = drvGetDevNum(&deviceCnt);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("[DgwClient] get device count failed, errorCode [%d]", drvRet);
        return true;
    }
    std::vector<std::string> splitInputStr;
    SplitString(inputStr, splitInputStr);
    BQS_LOG_INFO("[DgwClient] splitInputStr size [%zu]", splitInputStr.size());
    for (uint32_t i = 0U; i < static_cast<uint32_t>(splitInputStr.size()); i++) {
        uint32_t tmpValue = 0U;
        try {
            tmpValue = static_cast<uint32_t>(std::stoi(splitInputStr[i]));
        } catch (std::exception &e) {
            BQS_LOG_ERROR("[DgwClient] splitInputStr [%s] is invalid, error: %s", splitInputStr[i].c_str(), e.what());
            break;
        }
        if (tmpValue >= deviceCnt) {
            BQS_LOG_ERROR("[DgwClient] splitInputStr [%s] is exceed device count [%u]", splitInputStr[i].c_str(), deviceCnt);
            break;
        }
        if (std::find(g_userDeviceInfo.begin(), g_userDeviceInfo.end(), tmpValue) != g_userDeviceInfo.end()) {
            BQS_LOG_ERROR("[DgwClient] splitInputStr [%s] is repeat", splitInputStr[i].c_str());
            break;
        }
        g_userDeviceInfo.push_back(tmpValue);
    }
    BQS_LOG_INFO("[DgwClient] g_userDeviceInfo size [%zu]", g_userDeviceInfo.size());
    return true;
}

int32_t DgwClient::ChangeUserDeviceIdToLogicDeviceId(const uint32_t userDevId, uint32_t &logicDevId)
{
    BQS_LOG_INFO("[DgwClient] begin to change user deviceId to logic deviceId, user deviceId=%u", userDevId);
    // 先判断是不是有内容，避免重复解析，再获取环境变量、解析和校验
    if (!g_hadGetVisibleDevices && !GetVisibleDevices()) {
        return static_cast<int32_t>(BQS_STATUS_OK);
    }

    // user device id匹配logic id
    if (g_userDeviceInfo.empty()) {
        return static_cast<int32_t>(BQS_STATUS_OK);
    } else if (userDevId >= g_userDeviceInfo.size()) {
        BQS_LOG_ERROR("[DgwClient] userDevId [%u] is exceed g_userDeviceInfo size [%zu]", userDevId, g_userDeviceInfo.size());
        return static_cast<int32_t>(BQS_STATUS_PARAM_INVALID);
    } else {
        logicDevId = g_userDeviceInfo[userDevId];
        BQS_LOG_INFO("[DgwClient] userDevId [%u] to logicDevId [%u]", userDevId, logicDevId);
    }
    return static_cast<int32_t>(BQS_STATUS_OK);
}
} // namespace bqs