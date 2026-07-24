/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASIC_COMPONENT_DEVICE_COMM_DEVICE_COMM_H
#define TSD_BASIC_COMPONENT_DEVICE_COMM_DEVICE_COMM_H

#include <map>
#include <memory>
#include <mutex>
#include <functional>
#include <unordered_map>

#include "proto/tsd_message.pb.h"
#include "tsd/status.h"
#include "tsd_version_verify.h"

namespace tsd {
/**
 * @ingroup DeviceComm
 * @brief 设备通信类型枚举，用于 DeviceComm 工厂模式实例化
 */
enum class DeviceCommType : uint32_t { HDC = 0, DEVICE_COMM_TYPE_TOTAL_NUM };

inline uint64_t KeyCompose(const uint32_t& devId, const DeviceCommType& type)
{
    return ((static_cast<uint64_t>(devId)) << 32U) | (static_cast<uint64_t>(type));
}

/**
 * @ingroup DeviceComm
 * @brief 设备通信基类，对外提供与device建立连接、通信的统一接口。
 *        外部模块只依赖此基类，具体连接方式由派生类实现。
 */
class DeviceComm {
public:
    // 工厂函数类型：接收 devId，返回具体子类实例
    using CreatorFunc = std::function<std::shared_ptr<DeviceComm>(uint32_t)>;

    // 注册接口，供各子类在静态初始化阶段调用
    static bool Register(DeviceCommType type, CreatorFunc creator);
    /**
     * @ingroup DeviceComm
     * @brief 根据devId和commType获得单例类实例，内部根据commType进行工厂模式生成
     * @param [in] devId : 设备device ID
     * @param [in] commType : 设备通信类型
     * @return DeviceComm单例类实例
     */
    static std::shared_ptr<DeviceComm> GetInstance(const uint32_t devId, const DeviceCommType commType);

    /**
     * @ingroup DeviceComm
     * @brief 初始化与device的连接通道
     * @return TSD_OK:成功，或者其他错误码
     */
    virtual TSD_StatusT CommInit(const uint32_t clientPid, const bool isAdcEnv) = 0;

    /**
     * @ingroup DeviceComm
     * @brief 创建会话
     * @param [out] sessionId : 会话ID
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT CommCreateSession(uint32_t& sessionId) = 0;

    /**
     * @ingroup DeviceComm
     * @brief 关闭与device的连接，释放相关资源
     */
    virtual void CommDestroy() = 0;

    /**
     * @ingroup DeviceComm
     * @brief 接收device发送过来的数据
     * @param [in] sessionId : 某个连接sessionId
     * @param [in] ignoreRecvErr : 是否忽略接收错误
     * @param [in] timeout : 超时时间（毫秒）
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT CommRecvData(
        const uint32_t sessionId, const bool ignoreRecvErr = false, const uint32_t timeout = 0U) = 0;

    /**
     * @ingroup DeviceComm
     * @brief 获取设备连接状态
     * @param [out] sessStat : 会话连接状态
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT CommGetConctStatus(int32_t& sessStat) = 0;

    /**
     * @ingroup DeviceComm
     * @brief 向device发送消息
     * @param [in] sessionId : 会话ID
     * @param [in] msg : 待发送消息
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT CommSendMsg(const uint32_t sessionId, const HDCMessage& msg) = 0;

    /**
     * @ingroup DeviceComm
     * @brief 获取版本校验信息
     * @param [in] sessionId : 会话ID
     * @param [out] inspector : 版本校验对象
     * @return TSD_OK:成功 或者其他错误码
     */
    virtual TSD_StatusT CommGetVersionVerify(const uint32_t sessionId, std::shared_ptr<VersionVerify>& inspector) = 0;

    /**
     * @ingroup DeviceComm
     * @brief 析构函数
     */
    virtual ~DeviceComm() = default;

    DeviceComm(const DeviceComm&) = delete;
    DeviceComm(DeviceComm&&) = delete;
    DeviceComm& operator=(const DeviceComm&) = delete;
    DeviceComm& operator=(DeviceComm&&) = delete;

protected:
    /**
     * @ingroup DeviceComm
     * @brief 构造函数
     * @param [in] devId : 设备device ID
     * @param [in] commType : 设备通信类型
     */
    DeviceComm(const uint32_t devId, const DeviceCommType commType);

    // deviceId 和 DeviceComm 指针对象的 Map
    static std::map<uint64_t, std::shared_ptr<DeviceComm>>* DeviceCommMap()
    {
        static std::map<uint64_t, std::shared_ptr<DeviceComm>>* instance =
            new (std::nothrow) std::map<uint64_t, std::shared_ptr<DeviceComm>>();
        return instance;
    }
    // deviceCommMap_ 的锁
    static std::recursive_mutex* MutexForDeviceCommMap()
    {
        static std::recursive_mutex* instance = new (std::nothrow) std::recursive_mutex();
        return instance;
    }
    // 注册表：DeviceCommType -> 工厂函数
    static std::unordered_map<uint32_t, CreatorFunc>* CreatorMap()
    {
        static std::unordered_map<uint32_t, CreatorFunc>* instance =
            new (std::nothrow) std::unordered_map<uint32_t, CreatorFunc>();
        return instance;
    }
    // 设备 ID
    uint32_t deviceId_;
    // 设备通信类型
    DeviceCommType commType_;
};
} // namespace tsd
#endif // TSD_BASIC_COMPONENT_DEVICE_COMM_DEVICE_COMM_H
