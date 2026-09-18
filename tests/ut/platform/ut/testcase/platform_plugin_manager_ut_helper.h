/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __PLATFORM_PLUGIN_MANAGER_UT_HELPER_H__
#define __PLATFORM_PLUGIN_MANAGER_UT_HELPER_H__

// 先于 #define private public 包含依赖头，避免影响 std 头解析（include guard 防止重复展开）。
#include <mutex>
#include "driver/ascend_hal_base.h"
#define private public
#include "platform_plugin_manager.h"
#undef private

namespace fe {
namespace ut_helper {
// 将单例配置为"已加载"状态：懒加载 flag 置位以跳过 mmDlopen，三个 HAL 函数指针直接绑定
// depends/ascend_hal_stub.cc 的实现，供所有经由 GetInstance() 触发 HAL 查询的用例
// （如 EnrichSectionsByHAL）使用。plugin_handle_ 保持空指针：initialized_ 短路后无人读取，
// 进程退出时析构也不会触发 mmDlclose。
inline void ConfigurePluginManagerForUt()
{
    auto& plugin_manager = PlatformPluginManager::GetInstance();
    plugin_manager.initialized_ = true;
    plugin_manager.drv_get_dev_ids_func_ = &drvGetDevIDs;
    plugin_manager.hal_get_soc_version_func_ = &halGetSocVersion;
    plugin_manager.hal_get_device_info_func_ = &halGetDeviceInfo;
}
} // namespace ut_helper
} // namespace fe

// 进程启动（main 之前）完成单例配置，与用例执行顺序无关。
static const bool g_platform_plugin_manager_ut_configured = (fe::ut_helper::ConfigurePluginManagerForUt(), true);
#endif // __PLATFORM_PLUGIN_MANAGER_UT_HELPER_H__
