/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_tensor_plugin.h"
#include "log/adx_log.h"
#include "lib_path.h"
#include "adump_pub.h"
#include "file_utils.h"
#include "sys_utils.h"
namespace Adx {

DumpTensorPlugin::~DumpTensorPlugin()
{
    // Close all plugin library and clear all map.
    for (auto &handle : pluginLibHandles_) {
        if (handle != nullptr) {
            dlclose(handle);
            handle = nullptr;
        }
    }
    headProcessMap_.clear();
    tensorProcessMap_.clear();
    pluginLibHandles_.clear();
}

/**
 * @name  ReceiveInitialFunc
 * @brief Load the initialization method and trigger it. If a new method needs to be loaded,
 *        it can be implemented and called in the same way as this method.
 * @param handle    [IN] The handle of the loaded target so by dlopen.
 * @return void
 */
void DumpTensorPlugin::ReceiveInitialFunc(void *handle) const
{
    AdumpPluginInitFunc initFunc = SysUtils::ReinterpretCast<AdumpPluginInit, void>(dlsym(handle, "AdumpPluginInit"));
    IDE_CTRL_VALUE_WARN(initFunc != nullptr, return, "Cannot find symbol AdumpPluginInit in library mentioned above.");
    initFunc();
}

/**
 * @name  InitPluginLib
 * @brief Load all plugin.so files, obtain and launch the corresponding method.
 * @return success: ADUMP_SUCCESS, fail: ADUMP_FAILED
 */
int32_t DumpTensorPlugin::InitPluginLib()
{
    std::lock_guard<std::mutex> lk(dlopenMtx_);
    IDE_CTRL_VALUE_WARN(pluginLibHandles_.empty(), return ADUMP_SUCCESS, "The plugin library has been loaded.");

    // Get plugin.so path
    const std::string pluginPath = LibPath::Instance().GetTargetPath("/plugin/adump");
    IDE_CTRL_VALUE_FAILED(!pluginPath.empty(), return ADUMP_FAILED, "Received an empty path for file %s.");
    IDE_LOGD("The path of the target plugin.so is %s.", pluginPath.c_str());

    // Obtaining the absolute path of all plugin.so files
    std::vector<std::string> pluginList = LibPath::Instance().ObtainAllPluginSo(pluginPath);
    for(const auto &plugin : pluginList) {
        // Check whether the path is reasonable.
        std::string realFile;
        IDE_CTRL_VALUE_WARN_NODO(FileUtils::FileNameIsReal(plugin, realFile) == IDE_DAEMON_OK, continue,
            "Unable to get real file %s and the search file is %s.", realFile.c_str(), plugin.c_str());
        IDE_CTRL_VALUE_WARN_NODO(FileUtils::IsFileExist(realFile), continue,
            "Unable to find plugin file from %s.", realFile.c_str());
        IDE_LOGD("The file of the target plugin.so is %s.", realFile.c_str());

        // Load target plugin so by dlopen
        IDE_LOGD("Load plugin librairy from %s.", realFile.c_str());
        void *handle = dlopen(realFile.c_str(), RTLD_NOW | RTLD_GLOBAL | RTLD_NODELETE);
        IDE_CTRL_VALUE_WARN_NODO(handle != nullptr, continue, "Cannot open library %s, error: %s.",
            realFile.c_str(), dlerror());

        // Load initialization method and trigger it
        ReceiveInitialFunc(handle);
        pluginLibHandles_.push_back(handle);
    }

    return ADUMP_SUCCESS;
}

void DumpTensorPlugin::HeadCallbackRegister(DfxTensorType tensorType, HeadProcess headProcess)
{
    std::lock_guard<std::mutex> lk(regMtx_);
    // Only one head process can be saved for each tensor type.
    headProcessMap_[tensorType] = headProcess;
}

void DumpTensorPlugin::TensorCallbackRegister(DfxTensorType tensorType, TensorProcess tensorProcess)
{
    std::lock_guard<std::mutex> lk(regMtx_);
    // Only one tensor process can be saved for each tensor type.
    tensorProcessMap_[tensorType] = tensorProcess;
}

/**
 * @name  IsTensorTypeRegistered
 * @brief Check whether the two associated map have registered the method of this tensor type.
 * @param tensorType    [IN] tensor type
 * @return exist: true, not exist: false
 */
bool DumpTensorPlugin::IsTensorTypeRegistered(DfxTensorType tensorType)
{
    std::lock_guard<std::mutex> lk(regMtx_);
    return (headProcessMap_.find(tensorType) != headProcessMap_.end()) &&
        (tensorProcessMap_.find(tensorType) != tensorProcessMap_.end());
}

/**
 * @name  NotifyHeadCallback
 * @brief Trigger the head callback of the corresponding tensor type.
 * @param tensorType    [IN] tensor type
 * @param addr          [IN] Pointer to the header addr
 * @param headerSize    [IN] Header size
 * @param newHeaderSize [OUT] New header size after target size is added
 * @return exist: true, not exist: false
 */
int32_t DumpTensorPlugin::NotifyHeadCallback(DfxTensorType tensorType, uint32_t devId, const void *addr,
    uint64_t headerSize, uint64_t &newHeaderSize)
{
    // If neither of the two associated callbacks is registered, indicating that the default function is used.
    std::lock_guard<std::mutex> lk(regMtx_);
    return headProcessMap_[tensorType](devId, addr, headerSize, newHeaderSize);
}

/**
 * @name  NotifyTensorCallback
 * @brief Trigger the tensor callback of the corresponding tensor type.
 * @param tensorType [IN] tensor type
 * @param addr       [IN] Pointer to the header addr
 * @param size       [IN] Header size
 * @param fd         [IN] File descriptor
 * @return exist: true, not exist: false
 */
int32_t DumpTensorPlugin::NotifyTensorCallback(DfxTensorType tensorType, uint32_t devId, const void *addr,
    uint64_t size, int32_t fd)
{
    std::lock_guard<std::mutex> lk(regMtx_);
    return tensorProcessMap_[tensorType](devId, addr, size, fd);
}
}  // namespace Adx
