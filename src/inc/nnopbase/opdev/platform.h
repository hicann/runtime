/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_PLATFORM_H
#define OP_API_OP_API_COMMON_INC_OPDEV_PLATFORM_H

#include <string>
#include "aclnn/aclnn_base.h"
#include "graph/ascend_string.h"
#include "platform/platform_info.h"

namespace op {

enum class SocVersion {
    ASCEND910 = 0,
    ASCEND910B,
    ASCEND910_93,
    ASCEND910_95,
    ASCEND910E,
    ASCEND310,
    ASCEND310P,
    ASCEND310B,
    ASCEND310C,
    ASCEND610LITE,
    RESERVED_VERSION = 99999
};

enum class SocSpec { INST_MMAD = 0, RESERVED_SPEC = 99999 };

enum class SocSpecAbility {
    INST_MMAD_F162F16 = 0,
    INST_MMAD_F162F32,
    INST_MMAD_H322F32,
    INST_MMAD_F322F32,
    INST_MMAD_U32U8U8,
    INST_MMAD_S32S8S8,
    INST_MMAD_S32U8S8,
    INST_MMAD_F16F16F16,
    INST_MMAD_F32F16F16,
    INST_MMAD_F16F16U2,
    INST_MMAD_U8,
    INST_MMAD_S8,
    INST_MMAD_U8S8,
    INST_MMAD_F16U2,
};

class PlatformInfoImpl;

class PlatformThreadLocalCtx;

class PlatformInfo {
    friend const PlatformInfo &GetCurrentPlatformInfo();

    friend class PlatformThreadLocalCtx;

public:
    PlatformInfo() {};

    PlatformInfo(int32_t deviceId) : deviceId_(deviceId){};

    SocVersion GetSocVersion() const;

    const std::string &GetSocLongVersion() const;

    int32_t GetDeviceId() const;

    bool CheckSupport(SocSpec socSpec, SocSpecAbility ability) const;

    int64_t GetBlockSize() const;

    uint32_t GetCubeCoreNum() const;
 
    uint32_t GetVectorCoreNum() const;

    bool Valid() const;

    bool GetFftsPlusMode() const;

    fe::PlatFormInfos *GetPlatformInfos() const;

private:
    PlatformInfo &operator=(const PlatformInfo &other) = delete;

    PlatformInfo &operator=(const PlatformInfo &&other) = delete;

    PlatformInfo(const PlatformInfo &other) = delete;

    PlatformInfo(const PlatformInfo &&other) = delete;

    void SetPlatformImpl(PlatformInfoImpl *impl);

    bool valid_ = false;
    int32_t deviceId_{-1};
    PlatformInfoImpl *impl_ = nullptr;

    ~PlatformInfo();
};

const PlatformInfo &GetCurrentPlatformInfo();

ge::AscendString ToString(SocVersion socVersion);

}  // namespace op

#endif  // OP_API_OP_API_COMMON_INC_OPDEV_PLATFORM_H
