/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include <climits>
#include <memory>
#include "securec.h"
#include "aicpusd_common.h"
#include "aicpusd_status.h"
#include "aicpusd_so_manager.h"

namespace AicpuSchedule {
AicpuSoManager::~AicpuSoManager()
{
    // close so
    CloseSo();
}

AicpuSoManager &AicpuSoManager::GetInstance()
{
    static AicpuSoManager instance;
    return instance;
}

bool AicpuSoManager::OpenSo(const std::string &soFile)
{
    // Use API in glibc to open the so lib, load this so to process.
    std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        aicpusd_err("Alloc memory for path failed.");
        return false;
    }

    const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        aicpusd_err("Mem set error, ret=%d", eRet);
        return false;
    }

    if (realpath(soFile.data(), path.get()) == nullptr) {
        aicpusd_err("Format to realpath failed:%s", soFile.c_str());
        return false;
    }
    aicpusd_info("Open so %s begin.", path.get());
    soHandle_ = dlopen(path.get(),
        static_cast<int32_t>((static_cast<uint32_t>(RTLD_LAZY)) | (static_cast<uint32_t>(RTLD_NODELETE)) |
        (static_cast<uint32_t>(RTLD_GLOBAL))));
    if (soHandle_ == nullptr) {
        aicpusd_err("Open so %s failed", path.get());
        return false;
    }
    aicpusd_info("Open so %s success.", soFile.c_str());
    return true;
}

void AicpuSoManager::CloseSo()
{
    if (soHandle_ != nullptr) {
        (void)dlclose(soHandle_);
        soHandle_ = nullptr;
    }
    aicpusd_info("dlclose soHandle_ success");
}

void AicpuSoManager::SetDeviceIdToDvpp(uint32_t deviceId)
{
    if (soHandle_ != nullptr) {
        aicpusd_info("Already load libmpi_dvpp_adapter.so");
    } else {
        bool retOpenSo = OpenSo("/lib64/libmpi_dvpp_adapter.so");
        if ((retOpenSo == false) || (soHandle_ == nullptr)) {
            aicpusd_warn("cannot open libmpi_dvpp_adapter.so");
            return;
        }
    }

    using SetDeviceIdFunc = int32_t (*)(uint32_t);
    SetDeviceIdFunc funcSetDeviceId =
        reinterpret_cast<SetDeviceIdFunc>(dlsym(soHandle_, "HiMpiSysSetDeviceId"));
    if (funcSetDeviceId == nullptr) {
        aicpusd_err("cannot find HiMpiSysSetDeviceId");
        return;
    }

    const int32_t ret = funcSetDeviceId(deviceId);
    if (ret != 0) {
        aicpusd_err("HiMpiSysSetDeviceId fail");
    }
}
}  // namespace AicpuSchedule