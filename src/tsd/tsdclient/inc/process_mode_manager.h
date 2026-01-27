/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_PROCESS_MODE_MANAGER_H
#define INNER_INC_PROCESS_MODE_MANAGER_H

#include "inc/client_manager.h"
#include "inc/hdc_client.h"
#include "proto/tsd_message.pb.h"
#ifndef WIN_TSD
#include "inc/domain_socket_client.h"
#endif

namespace tsd {
struct TsdStartStatusInfo {
    bool startHccp_;
    bool startCp_;
    bool startQs_;
};
class ProcessModeManager : public ClientManager {
public:
    explicit ProcessModeManager(const uint32_t deviceId, const uint32_t deviceMode);

    /**
     * @ingroup ProcessModeManager
     * @brief start hccp and computer_process
     * @param [in] logicDeviceId : logicDeviceId
     * @param [in] rankSize : 1(not use hccp); 2,3,4...(use hccp)
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT Open(const uint32_t rankSize) override;

    /**
     * @ingroup ProcessModeManager
     * @brief start computer_process
     * @param [in] logicDeviceId : logicDeviceId
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT OpenAicpuSd() override;

    TSD_StatusT OpenProcess(const uint32_t rankSize);

    /**
     * @ingroup ProcessModeManager
     * @brief close hccp and computer_process
     * @param [in] flag : tsd close flag
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT Close(const uint32_t flag) override;

    /**
     * @ingroup ProcessModeManager
     * @brief get hdc session status
     * @param [in] hdcSessStat : hdcSessStat
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT GetHdcConctStatus(int32_t &hdcSessStat) override;

    /**
     * @ingroup ProcessModeManager
     * @brief used for profiling
     * @param flag : control number
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT UpdateProfilingConf(const uint32_t &flag) override;

    TSD_StatusT InitQs(const InitFlowGwInfo * const initInfo) override;
    /**
     * @ingroup ProcessModeManager
     * @brief tsd capablity apply
     * @return TSD_OK when success
     */
    TSD_StatusT CapabilityGet(const int32_t type, const uint64_t ptr) override;

     /**
     * @ingroup ProcessModeManager
     * @brief is meet the capability get condition
     * @return true when success
     */
    bool IsOkToGetCapability(const int32_t type) const;
    /**
     * @ingroup ProcessModeManager
     * @brief construct capability msg
     * @return TSD_OK when success
     */
    void ConstructCapabilityMsg(HDCMessage &msg, const int32_t type);
    /**
     * @ingroup ProcessModeManager
     * @brief set capability proto msgtype by capability type
     * @return TSD_OK when success
     */
    void SetCapabilityMsgType(HDCMessage &msg, const int32_t type) const;

    /**
     * @ingroup ProcessModeManager
     * @brief send capability message to device
     * @return TSD_OK when success
     */
    TSD_StatusT SendCapabilityMsg(const int32_t type);
    /**
     * @ingroup ProcessModeManager
     * @brief handle open/close/updatefrom response from device
     * @param [in] sessionID : message from sessionId
     * @param [in] msg
     * @return TSD_OK when SUCCESS
     */
    static void ServerToClientMsgProc(const uint32_t sessionID, const HDCMessage &msg);

    /**
     * @ingroup ProcessModeManager
     * @brief handle capability rsp from device
     * @param [in] sessionID : message from sessionId
     * @param [in] msg
     * @return TSD_OK when SUCCESS
     */
    static void CapabilityResMsgProc(const uint32_t sessionID, const HDCMessage &msg);

    /**
     * @ingroup ProcessModeManager
     * @brief handle check message(whether need to send package) response from device
     * @param [in] sessionID : message from sessionId
     * @param [in] msg
     * @return TSD_OK when SUCCESS
     */
    static void PackageInfoMsgProc(const uint32_t sessionID, const HDCMessage &msg);

    /**
     * @ingroup ProcessModeManager
     * @brief  used for release resource when error occured
     * @return void
     */
    void Destroy() override;

    virtual ~ProcessModeManager() override;

    TSD_StatusT ConstructOpenMsg(HDCMessage &hdcMsg, const TsdStartStatusInfo &startInfo);

    TSD_StatusT ProcessQueueForAdc();

    TSD_StatusT CloseInHost();

    TSD_StatusT OpenInHost();

    TSD_StatusT ConstructCloseMsg(HDCMessage &msg);

    TSD_StatusT SendCloseMsgInHost();

    TSD_StatusT SendOpenMsgInHost();

    TSD_StatusT WaitHostRsp();

    TSD_StatusT InitDomainSocketClient();

    TSD_StatusT LoadFileToDevice(const char_t *const filePath, const uint64_t pathLen, const char_t *const fileName,
                                 const uint64_t fileNameLen) override;
    TSD_StatusT SendFileToDevice(const char_t *const filePath, const uint64_t pathLen, const char_t *const fileName,
                                 const uint64_t fileNameLen, const bool addPreFix = false);
    TSD_StatusT SaveCapabilityResult(const int32_t type, const uint64_t ptr) const;

    TSD_StatusT LoadRuntimePkgToDevice();

    TSD_StatusT GetDeviceHsPkgCheckCode(const uint32_t checkCode, const HDCMessage::MsgType msgType,
                                        const bool beforeSendFlag);

    TSD_StatusT ProcessOpenSubProc(ProcOpenArgs *openArgs) override;

    TSD_StatusT ProcessCloseSubProc(const pid_t closePid) override;

    TSD_StatusT GetSubProcStatus(ProcStatusInfo *pidInfo, const uint32_t arrayLen) override;

    TSD_StatusT RemoveFileOnDevice(const char_t *const filePath, const uint64_t pathLen) override;

    TSD_StatusT SendCommonOpenMsg(const ProcOpenArgs *procArgs) const;

    TSD_StatusT ConstructCommonOpenMsg(HDCMessage &hdcMsg, const ProcOpenArgs *procArgs) const;

    bool SetCommonOpenParamList(HDCMessage &hdcMsg, const ProcOpenArgs *const procArgs) const;

    bool IsSupportHeterogeneousInterface();

    bool IsSupportCommonInterface(const uint32_t level);

    bool IsSupportBuiltinUdfInterface();

    bool IsSupportAdprofInterface();

    TSD_StatusT LoadDShapePkgToDevice();

    TSD_StatusT LoadOmFileToDevice(const char_t *const filePath, const uint64_t pathLen, const char_t *const fileName,
                                   const uint64_t fileNameLen);

    bool IsOkToLoadFileToDevice(const char_t *const fileName, const uint64_t fileNameLen);

    void GetAscendLatestIntallPath(std::string &pkgBasePath) const;

    TSD_StatusT GetCurDriverPkgVersion(const uint64_t ptr);

    TSD_StatusT NotifyPmToStartTsdaemon() override;

    TSD_StatusT ProcessCloseSubProcList(const ProcStatusParam *closeList, const uint32_t listSize) override;

    TSD_StatusT ExecuteClosePidList(const ProcStatusParam *closeList, const uint32_t startIndex, const uint32_t pidCnt);

    TSD_StatusT GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen) override;

    void StoreProcListStatus(const HDCMessage &msg);

        /**
     * @ingroup ProcessModeManager
     * @brief save start status
     * @param [in] cpStatus
     * @param [in] hccpStatus
     * @return void
     */
    void SetTsdStartInfo(const bool cpStatus, const bool hccpStatus, const bool qsStatus);

    void DestroyHdcClientConnectChannel();

    /**
     * @ingroup ProcessModeManager
     * @brief
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT InitTsdClient();

    TSD_StatusT OpenNetService(const NetServiceOpenArgs *args) override;

    TSD_StatusT CloseNetService() override;

    uint32_t SetTsdClientCapabilityLevel() const;

    TSD_StatusT CompareAndSendCommonSinkPkg(const std::string &pkgPureName, const std::string &hostPkgHash,
        const int32_t peerNode, const std::string &orgFile, const std::string &dstFile);
private:
    struct TsdCloseFlag {
        uint32_t quickCloseFlag : 1; /* [0, 0] */
        uint32_t res : 31;           /* [31, 1] */
    };
    enum TsdCloseMode {
        QUICK_CLOSE_MODE = 1
    };
    /**
     * @ingroup ProcessModeManager
     * @brief carry aicpu ops package to device
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT LoadSysOpKernel();

    /**
     * @ingroup ProcessModeManager
     * @brief used for ServerToClientMsgProc
     * @param [in] msg
     * @return void
     */
    void DeviceMsgProcess(const HDCMessage &msg);
    /**
     * @ingroup ProcessModeManager
     * @brief used for pidqosres msg proc
     * @param [in] msg
     * @return void
     */
    void PidQosMsgProc(const HDCMessage &msg);

    /**
     * @ingroup ProcessModeManager
     * @brief get log level from log config
     */
    void GetLogLevel();

    /**
     * @ingroup ProcessModeManager
     * @brief parse module log level by key
     * @param [in] keyStr
     * @param [in] valStr
     * @return void
     */
    void ParseModuleLogLevelByKey(const std::string &keyStr, const std::string &valStr);

    /**
     * @ingroup ProcessModeManager
     * @brief parse module log level
     * @param [in] envModuleLogLevel
     * @return void
     */
    void ParseModuleLogLevel(const std::string &envModuleLogLevel);

    /**
     * @ingroup ProcessModeManager
     * @brief send open message to device
     * @param [in] rankSize
     * @param [in] start details
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT SendOpenMsg(const uint32_t rankSize, const TsdStartStatusInfo startInfo);

    /**
     * @ingroup ProcessModeManager
     * @brief wait device response
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT WaitRsp(const uint32_t timeout, const bool ignoreRecvErr = false, const bool isClose = false);

    /**
     * @ingroup ProcessModeManager
     * @brief send aicpu package to device
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT SendAICPUPackage(const int32_t peerNode, const std::string &path);

    /**
     * @ingroup ProcessModeManager
     * @brief send aicpu package to device simple
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT SendAICPUPackageSimple(const int32_t peerNode, const std::string &orgFile, const std::string &dstFile,
        bool useCannPath);

    /**
     * @ingroup ProcessModeManager
     * @brief send host package to device mul process exclusive
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT SendHostPackageComplex(const int32_t peerNode, const std::string &orgFile,
                                       const std::string &dstFile, HDCMessage &msg,
                                       const std::function<bool(void)> &compareCallBack,
                                       bool useCannPath);

    TSD_StatusT SendMsgAndHostPackage(const int32_t peerNode, const std::string &orgFile,
                                      const std::string &dstFile, HDCMessage &msg,
                                      const std::function<bool(void)> &compareCallBack,
                                      bool useCannPath);

    std::string GetHostSoPath() const;

    /**
     * @ingroup ProcessModeManager
     * @brief send close to device
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT SendCloseMsg();

    /**
     * @ingroup ProcessModeManager
     * @brief send updateProfiling to device
     * @param [in] profiling
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT SendUpdateProfilingMsg(const uint32_t flag);

    /**
     * @ingroup ProcessModeManager
     * @brief check whether need to open tsd
     * @param [in] rankSize : rankSize
     * @param [out] startInfo
     * @return true: open false：not open
     */
    bool CheckNeedToOpen(const uint32_t rankSize, TsdStartStatusInfo &startInfo);

    /**
     * @ingroup ProcessModeManager
     * @brief query queue ids and attributes of current proccess and grant autority to aicpu_scheduler
     * @return void
     */
    TSD_StatusT SyncQueueAuthority() const;

    TSD_StatusT ProcessQueueGrant(const QueueQueryOutputPara &queueInfoOutBuff,
                                  const QueueQueryOutput * const queueInfoList,
                                  const pid_t aicpuPid) const;

    /**
     * @ingroup ProcessModeManager
     * @brief get aicpusd pid
     * @param [out] aicpuPid invalid value is -1
     * @return void
     */
    TSD_StatusT GetAicpusdPid(pid_t &aicpusdPid) const;

    /**
     * @ingroup ProcessModeManager
     * @brief send check code msg once
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT GetDeviceCheckCodeOnce(const HDCMessage msg);

    /**
     * @ingroup ProcessModeManager
     * @brief check wheteher need to send aicpu package to device
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT GetDeviceCheckCode();

    /**
     * @ingroup ProcessModeManager
     * @brief check check aicpu package retry support
     * @return void
     */
    void GetDeviceCheckCodeRetrySupport();

    /**
     * @ingroup ProcessModeManager
     * @brief check wheteher need to send aicpu package to device
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT GetDeviceCheckCodeRetry(const HDCMessage &msg);

    /**
     * @ingroup ProcessModeManager
     * @brief get dieId from chipId for chip mode
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT GetDeviceIdForChipMode();

    /**
     * @ingroup ProcessModeManager
     * @brief save check code from device package
     * @return void
     */
    void SaveDeviceCheckCode(const HDCMessage &msg);

    TSD_StatusT WaitCapabilityRsp(const int32_t type, const uint64_t ptr);

    bool UseStoredCapabityInfo(const int32_t type, const uint64_t ptr);

    /**
     * @ingroup ProcessModeManager
     * @brief Parse tsd close flag and update tsdCloseFlag
     * @return void
     */
    void ParseTsdCloseFlag(const uint32_t flag, TsdCloseFlag &tsdCloseFlag) const;

    TSD_StatusT SendCommonPackage(const int32_t peerNode, const std::string &path, const uint32_t packageType);

    void SetHostAicpuCheckCode(HDCMessage &msg);

    void SetHostExtendCheckCode(HDCMessage &msg);

    void SetHostAscendcppCheckCode(HDCMessage &msg);

    TSD_StatusT LoadDriverExtendPkg();

    TSD_StatusT GetDriverExtendPkgName(std::string &orgFile, std::string &dstFile, int32_t &peerNode);

    TSD_StatusT LoadPackageConfigInfoToDevice();

    TSD_StatusT LoadPackageToDeviceByConfig();

    void SetDeviceCommonSinkPackHashValue(const std::string pkgName, const std::string hashValue)
    {
        pkgDeviceHashValue_[pkgName] = hashValue;
        TSD_INFO("update device package:%s hash value:%s", pkgName.c_str(), hashValue.c_str());
    }

    void SetHostCommonSinkPackHashValue(const std::string pkgName, const std::string hashValue)
    {
        pkgHostHashValue_[pkgName] = hashValue;
        TSD_INFO("update host package:%s hash value:%s", pkgName.c_str(), hashValue.c_str());
    }

    std::string GetDeviceCommonSinkPackHashValue(const std::string pkgName)
    {
        auto iter = pkgDeviceHashValue_.find(pkgName);
        if (iter != pkgDeviceHashValue_.end()) {
            TSD_INFO("get device package:%s, hash value:%s", pkgName.c_str(), iter->second.c_str());
            return iter->second;
        }
        return "";
    }

    std::string GetHostCommonSinkPackHashValue(const std::string pkgName)
    {
        auto iter = pkgHostHashValue_.find(pkgName);
        if (iter != pkgHostHashValue_.end()) {
            TSD_INFO("get host package:%s, hash value:%s", pkgName.c_str(), iter->second.c_str());
            return iter->second;
        }
        return "";
    }

    bool IsCommonSinkHostAndDevicePkgSame(const std::string pkgName)
    {
        return ((GetHostCommonSinkPackHashValue(pkgName) == GetDeviceCommonSinkPackHashValue(pkgName)) &&
            (!GetHostCommonSinkPackHashValue(pkgName).empty()));
    }
    void StoreAllPkgHashValue(const HDCMessage &msg);

    bool SupportLoadPkg(const std::string &pkgName) const;

    std::string GetCurHostMutexFile(bool useCannPath) const;
    TSD_StatusT LoadCannHsPkgToDevice(const std::string &pkgPureName);
    TSD_StatusT LoadFileAndWaitRsp(const std::string &pkgPureName, const std::string &hostPkgHash,
                                   const int32_t peerNode, const std::string &orgFile, const std::string &dstFile);
    TSD_StatusT GetCannHsPkgCheckCode(const std::string &pkgPureName, const std::string &hostPkgHash);
    std::string logLevel_;
    uint32_t tsdSessionId_;
    std::shared_ptr<HdcClient> hdcTsdClient_;
    process_sign procSign_;
    std::string errMsg_;
    std::string errorLog_;
    // rspCode: 0 拉起hccp和cp成功  1：拉起hccp和cp失败, respond结果
    ResponseCode rspCode_;
    TsdStartStatusInfo tsdStartStatus_;
    uint32_t rankSize_;
    bool aicpuPackageExistInDevice_;
    uint32_t aicpuDeviceMode_;
    std::string qsInitGrpName_;
    std::string startOrStopFailCode_;
    uint64_t schedPolicy_;
    int64_t pidQos_;
#ifndef WIN_TSD
    std::atomic_bool initHostFlag_;
    std::shared_ptr<DomainSocketClient> domainSocketClientPtr_;
#endif
    uint32_t tsdSupportLevel_;
    uint32_t openSubPid_;
    ProcStatusInfo *pidArry_;
    uint32_t pidArryLen_;
    bool supportOmInnerDec_;
    ProcStatusParam *pidList_;
    uint64_t tsdVersion_;
    bool adprofSupport_;
    using VersionCheckFunc = bool (ProcessModeManager::*)();
    std::map<SubProcType, VersionCheckFunc> versionCheckMap_;
    bool getCheckCodeRetrySupport_;
    uint32_t hccpPid_;
    bool isStartedHccp_;
    std::string ccecpuLogLevel_;
    std::string aicpuLogLevel_;
    uint32_t packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    uint32_t packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    bool deviceIdle_;
    std::string hostSoPath_;
    bool hasGetHostSoPath_;
    std::map<std::string, std::string> pkgHostHashValue_;
    std::map<std::string, std::string> pkgDeviceHashValue_;
    bool hasSendConfigFile_;
    std::string loadPackageErrorMsg_;
};
}  // namespace tsd
#endif  // INNER_INC_PROCESS_MODE_MANAGER_H
