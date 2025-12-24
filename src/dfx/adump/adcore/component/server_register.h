/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_SERVER_REGISTER_H
#define ADX_SERVER_REGISTER_H
#include <unordered_map>
#include <mutex>
#include "ascend_hal.h"
#include "component/adx_component.h"
#include "adx_server_manager.h"
#include "create_func.h"
#include "singleton.h"
namespace Adx {
class ServerRegister : public Adx::Common::Singleton::Singleton<ServerRegister> {
public:
    int32_t RegisterComponent(int32_t serverType, std::unique_ptr<AdxComponent> &adxComponent);
    int32_t UnRegisterComponent(int32_t serverType, ComponentType cmpt);
    int32_t ComponentServerStartup(ServerInitInfo info) const;
    int32_t ComponentServerCleanup(int32_t serverType);
private:
    bool ServerManagerInit(const ServerInitInfo info);
    std::unordered_map<int32_t, AdxServerManager> services_;
    mutable std::mutex mtx_;
};
}
#define ADX_API __attribute__((visibility("default")))
#ifdef __cplusplus
extern "C" {
#endif
ADX_API int32_t AdxRegisterComponentFunc(drvHdcServiceType serverType, std::unique_ptr<Adx::AdxComponent> &adxComponent);
ADX_API int32_t AdxComponentServerStartup(ServerInitInfo info);
ADX_API int32_t AdxComponentServerCleanup(drvHdcServiceType serverType, ComponentType cmpt = ComponentType::NR_COMPONENTS);
#ifdef __cplusplus
}
#endif
#endif