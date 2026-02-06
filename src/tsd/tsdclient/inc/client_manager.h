/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef INNER_INC_CLIENT_MANAGER_H
#define INNER_INC_CLIENT_MANAGER_H

#include <mmpa/mmpa_api.h>
#include <atomic>
#include "inc/internal_api.h"
#include "proto/tsd_message.pb.h"
#include "tsd/status.h"
#include "tsd/tsd_client.h"
#include "inc/basic_define.h"
#define TSD_PLAT_GET_CHIP(type)           (((type) >> 8U) & 0xffU)

namespace tsd {
enum class ProfilingMode {
    PROFILING_CLOSE = 0,
    PROFILING_OPEN,
};

enum class RunningMode {
    UNSET_MODE = 0,
    PROCESS_MODE,
    THREAD_MODE,
    AICPU_THREAD_MODE,
};

typedef enum tagChipType {
    CHIP_BEGIN = 0,
    CHIP_MINI = CHIP_BEGIN,
    CHIP_ASCEND_910A = 1,
    CHIP_ADC = 2,
    CHIP_DC = 4,
    CHIP_ASCEND_910B = 5,
    CHIP_MINI_V3 = 7,
    CHIP_AS31XM1 = 11,
    CHIP_610LITE = 12,
    CHIP_ASCEND_950 = 15,
    CHIP_CLOUD_V5 = 16,
    CHIP_MC62CM12A = 17,  /* MC62CM12A */
    CHIP_END
} ChipType_t;

class ClientManager {
public:
    /**
     * @ingroup ClientManager
     * @brief 支持host侧单个APP进程,拉起多个device
     * @param [in] deviceId : 设备号
     * @return TsdClient对象的引用
     */
    static std::shared_ptr<ClientManager> GetInstance(const uint32_t &deviceId, const uint32_t deviceMode = DIE_MODE, const bool transDevIdFlag = true);

    static TSD_StatusT GetPlatformInfo(const uint32_t deviceId);

    static bool CheckDestructFlag(const uint32_t &logicDevId);

    static void SetProfilingCallback(const MsprofReporterCallback &callback);

    static TSD_StatusT SetRunMode(const std::string &valueStr);

    static TSD_StatusT SetAicpuSchedMode(const uint32_t schedMode);

    /**
     * @ingroup ClientManager
     * @brief 构造函数
     */
    explicit ClientManager(const uint32_t &deviceId);

    /**
     * @ingroup ClientManager
     * @brief 析构函数
     */
    virtual ~ClientManager();
    /**
     * @ingroup ClientManager
     * @brief framework发送拉起hccp和computer process的命令
     * @param [in] logicDeviceId : FMK传入逻辑ID
     * @param [in] rankSize : FMK传入rankSize
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT Open(const uint32_t rankSize) = 0;

    /**
     * @ingroup ClientManager
     * @brief framework发送拉起computer process的命令
     * @param [in] logicDeviceId : FMK传入逻辑ID
     * @param [in] rankSize : FMK传入rankSize
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT OpenAicpuSd() = 0;

    /**
     * @ingroup ClientManager
     * @brief 通知ClientManager关闭相关资源
     * @param [in] flag: 关闭标志位
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT Close(const uint32_t flag) = 0;

    /**
     * @ingroup ClientManager
     * @brief 通知ClientManager更新profiling状态
     * @param [in] flag:  profiling 标志位
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT UpdateProfilingConf(const uint32_t &flag) = 0;

    /**
     * @ingroup ClientManager
     * @brief 用于按需拉起QS的接口
     * @param [in] initInfo : QS初始化参数
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT InitQs(const InitFlowGwInfo * const initInfo) = 0;

    /**
     * @ingroup ClientManager
     * @brief carry aicpu ops package to device
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual void Destroy() = 0;

    /**
     * @ingroup ClientManager
     * @brief 通过tsd获取一些能力
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT CapabilityGet(const int32_t type, const uint64_t ptr) = 0;

    /**
     * @ingroup ClientManager
     * @brief get hdc session status
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT GetHdcConctStatus(int32_t &hdcSessStat);

    static RunningMode GetClientRunMode(const uint32_t logicDeviceId);

    virtual TSD_StatusT LoadFileToDevice(const char_t *const filePath, const uint64_t pathLen,
                                         const char_t *const fileName, const uint64_t fileNameLen) = 0;

    virtual TSD_StatusT ProcessOpenSubProc(ProcOpenArgs *openArgs) = 0;

    virtual TSD_StatusT ProcessCloseSubProc(const pid_t closePid) = 0;

    virtual TSD_StatusT GetSubProcStatus(ProcStatusInfo *pidInfo, const uint32_t arrayLen) = 0;

    virtual TSD_StatusT RemoveFileOnDevice(const char_t *const filePath, const uint64_t pathLen) = 0;

    virtual TSD_StatusT GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen) = 0;

    bool IsAdcEnv() const;
 
    static uint32_t GetPlatInfoChipType();

    virtual TSD_StatusT NotifyPmToStartTsdaemon() = 0;

    virtual TSD_StatusT ProcessCloseSubProcList(const ProcStatusParam *closeList, const uint32_t listSize) = 0;

    static TSD_StatusT GetDriverVersion(uint64_t *driverVersion);

    static bool IsNumeric(const std::string& str);

    static bool IsSupportSetVisibleDevices();

    static void SplitString(const std::string &str, std::vector<std::string> &result);

    static bool GetVisibleDevices();

    static TSD_StatusT ChangeUserDeviceIdToLogicDeviceId(const uint32_t userDevId, uint32_t &logicDevId);

    virtual TSD_StatusT OpenNetService(const NetServiceOpenArgs *args) = 0;

    virtual TSD_StatusT CloseNetService() = 0;

    bool GetPackageTitle(std::string &packageTitle) const;
protected:
    /**
     * @ingroup ClientManager
     * @brief GetProfilingMode获取pid
     */
    void GetProfilingMode();

    /**
     * @ingroup ClientManager
     * @brief GetPlatInfoMode get platinfo mode
     */
    uint32_t GetPlatInfoMode() const;

    /**
     * @ingroup ClientManager
     * @brief SetPlatInfoMode set platinfo mode value
     * @param [in] platInfoMode : used to set g_platInfo.mode
     */
    void SetPlatInfoMode(const uint32_t platInfoMode) const;

    /**
     * @ingroup ClientManager
     * @brief carry aicpu ops package to device
     * @return true: exist; false：not exist
     */
    bool CheckPackageExists(const bool loadAicpuKernelFlag = true);

    static void SetPlatInfoChipType(const ChipType_t curType);

    static void ResetPlatInfoFlag();

    uint32_t logicDeviceId_;
    std::atomic_bool initFlag_;
    ProfilingMode profilingMode_;
    std::string packagePath_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    static RunningMode g_runningMode;
    static std::mutex g_profilingCallbackMut;
    static MsprofReporterCallback g_profilingCallback;
    static SchedMode aicpuSchedMode_;
    std::string packageName_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];

private:
    ClientManager(const ClientManager &) = delete;
    ClientManager(ClientManager &&) = delete;
    ClientManager &operator=(const ClientManager &) = delete;
    ClientManager &operator=(ClientManager &) = delete;
    ClientManager &operator=(ClientManager &&) = delete;
    bool GetPackagePath(std::string &packagePath, const uint32_t packageType) const;
    static bool ResetClientManagerByConfig(RunningMode &runningMode);
    bool CheckPackageExistsOnce(const uint32_t packageType);
    std::string packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
};
}  // namespace tsd
#endif  // INNER_INC_CLIENT_MANAGER_H
