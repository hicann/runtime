/**
  * Copyright (c) 2025 Huawei Technologies Co., Ltd.
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
  * CANN Open Software License Agreement Version 2.0 (the "License").
  * Please refer to the License for details. You may not use this file except in compliance with the License.
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
  * See LICENSE in the root of the software repository for the full text of the License.
  */

/*!
 * \file adx_component_api_c.h
 * \brief
*/

#ifndef ADX_COMPONENT_API_C_H
#define ADX_COMPONENT_API_C_H
#include "adx_service_config.h"
#define ADX_API __attribute__((visibility("default")))
#ifdef __cplusplus
extern "C" {
#endif
ADX_API int32_t AdxRegisterService(int32_t serverType, ComponentType componentType, AdxComponentInit init,
    AdxComponentProcess process, AdxComponentUnInit uninit);
ADX_API int32_t AdxUnRegisterService(int32_t serverType, ComponentType componentType);
ADX_API int32_t AdxServiceStartup(ServerInitInfo info);
ADX_API int32_t AdxServiceCleanup(int32_t serverType);
#ifdef __cplusplus
}
#endif
#endif // ADX_COMPONENT_API_C_H