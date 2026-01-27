/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COMMON_TSD_FEATURE_CTRL_H
#define COMMON_TSD_FEATURE_CTRL_H

#include <cstdint>
#include "inc/log.h"
#include "inc/internal_api.h"
namespace tsd {
// min number of vDeviceId
constexpr const uint32_t VDEVICE_MIN_CPU_NUM = 32U;
// mid number of vDeviceId
constexpr const uint32_t VDEVICE_MID_CPU_NUM = 48U;
// max number of vDeviceId
constexpr const uint32_t VDEVICE_MAX_CPU_NUM = 64U;
const std::string AOSCORE_PREFIX = "sea_";
const std::string AOSCORE_DIR_PREFIX = "/usr/utils/rootfs";

class FeatureCtrl {
public:
    static inline bool IsAosCore()
    {
#ifdef _AOSCORE_
        return true;
#else
        return false;
#endif
    }

    /**
     * @ingroup IsSupportIAM
     * @brief tsdaemon is support IAM
     * @return : true: support IAM， false: not support IAM
     */
    static inline bool IsSupportIAM()
    {
#ifdef SUPPORT_IAM
        return true;
#else
        return false;
#endif
    }

    static inline bool IsSupportSelinux()
    {
#ifdef SUPPORT_SELINUX
        return true;
#else
        return false;
#endif
    }

    static inline bool IsVfMode(const uint32_t deviceId, const uint32_t vfId)
    {
        if ((IsVfModeCheckedByDeviceId(deviceId)) || (vfId > 0)) {
            return true;
        } else {
            return false;
        }
    }

    static inline bool IsVfModeCheckedByDeviceId(const uint32_t deviceId)
    {
        if ((deviceId >= VDEVICE_MIN_CPU_NUM) && (deviceId < VDEVICE_MAX_CPU_NUM)) {
            return true;
        } else {
            return false;
        }
    }

    static inline bool IsVfModeDie1(const uint32_t deviceId)
    {
        if ((deviceId >= VDEVICE_MID_CPU_NUM) && (deviceId < VDEVICE_MAX_CPU_NUM)) {
            return true;
        } else {
            return false;
        }
    }

    static inline bool IsTinyRuntime()
    {
#ifdef TINY_RUNTIME
        return true;
#else
        return false;
#endif
    }

    static inline bool IsNeedCheckOOM()
    {
#ifdef NUMA_CHECK_OOM
        return true;
#else
        return false;
#endif
    }

    static inline bool IsHeterogeneousProduct()
    {
#ifdef TSD_HELPER
        return true;
#else
        return false;
#endif
    }

    static inline bool IsSupportDriverExtendPkg()
    {
#ifdef TSD_SUPPORT_DRIVER_EXTEND
        return true;
#else
        return false;
#endif        
    }

    static inline bool SupportSubProcSafeStart()
    {
#ifdef TSD_SUPPORT_SUBPROC_SAFE_START
        TSD_INFO("SupportSubProcSafeStart mode");
        return true;
#else
        TSD_INFO("no SupportSubProcSafeStart mode");
        return false;
#endif
    }

    static inline bool IsDoubleDieProduct()
    {
#ifdef PRODUCT_910_93
        return true;
#else
        return false;
#endif
    }

    static inline bool IsSupportAscendcppPkg()
    {
#ifdef TSD_SUPPORT_ASCENDCPP
        return true;
#else
        return false;
#endif        
    }

    static inline bool IsStarsProduct()
    {
#ifdef TSD_STARS_PRODUCT
        return true;
#else
        return false;
#endif        
    }

    static inline bool IsOldVfProduct()
    {
#ifdef TSD_OLD_VF_PRODUCT
        return true;
#else
        return false;
#endif        
    }

    static inline bool IsMdcFpga()
    {
#ifdef FPGA_MDC
        if (IsFpgaEnv()) {
            return true;
        } else {
            return false;
        }
#else
        return false;
#endif
    }

    static inline bool IsMc62cm12a()
    {
#ifdef MC62CM12A
        return true;
#else
        return false;
#endif
    }

    static inline bool IsSupportLoadPkgWithCfg()
    {
#ifdef SUPPORT_LOAD_PKG_WITH_CFG
        return true;
#else
        return false;
#endif        
    }

private:
    FeatureCtrl() = default;
    ~FeatureCtrl() = default;

    FeatureCtrl(FeatureCtrl const&) = delete;
    FeatureCtrl& operator=(FeatureCtrl const&) = delete;
    FeatureCtrl(FeatureCtrl&&) = delete;
    FeatureCtrl& operator=(FeatureCtrl&&) = delete;
};

} // namespace tsd

#endif // COMMON_TSD_FEATURE_CTRL_H
