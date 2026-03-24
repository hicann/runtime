/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_QOS_HPP__
#define __CCE_RUNTIME_QOS_HPP__

#include "base.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t QOS_INFO_LEN = 512;    // 每个配置24Byte，当前使用4个，实际总数14个，留点余量
constexpr uint32_t RINGBUFFER_QOS_MAGIC = 0xA55A3023U;

#define QOS_CFG_RESERVED_LEN 8
#define QOS_MASTER_BITMAP_LEN 4

enum class QosMasterType : uint32_t {
    MASTER_DVPP_ALL     = 0,
    MASTER_DVPP_VPC     = 1,
    MASTER_DVPP_VDEC    = 2,
    MASTER_DVPP_JPEGE   = 3,
    MASTER_DVPP_JPEGD   = 4,
    MASTER_ROCE         = 5,
    MASTER_NIC          = 6,
    MASTER_PCIE         = 7,
    MASTER_AICPU        = 8,
    MASTER_AIC_DAT      = 9,
    MASTER_AIC_INS      = 10,
    MASTER_AIV_DAT      = 11,
    MASTER_AIV_INS      = 12,
    MASTER_SDMA         = 13,
    MASTER_STARS        = 14,
    MASTER_INVALID,
};

// 这个结构体需要和QOS drv中定义的结构体保持一致
typedef struct QosMasterConfigType {
    QosMasterType type;
    uint32_t mpamId;
    uint32_t qos;
    uint32_t pmg;
    uint64_t bitmap[QOS_MASTER_BITMAP_LEN];
    uint32_t mode = MAX_UINT32_NUM;
    uint32_t reserved[QOS_CFG_RESERVED_LEN - 1];
} QosMasterConfigType_t;

// 这个结构体需要和tsch中定义的结构体保持一致
typedef struct TsQosCfg {
    uint64_t bitmap;
    uint32_t mpamId;
    uint32_t qos;
    uint32_t pmg;
    uint8_t type;
    uint8_t replaceEn;
    uint8_t vfEn;
    uint8_t status;
} TsQosCfg_t;

typedef struct RtQosHeader {
    uint32_t magic;
    uint32_t depth;         // 实际写入的 TsQosCfg_t 的数量
    uint32_t len;           // 数据区的长度
    uint32_t reserved[3];
} RtQosHeader_t;

typedef struct RtQos {
    RtQosHeader_t header;
    uint8_t qos[QOS_INFO_LEN - sizeof(RtQosHeader_t)];
} RtQos_t;

} // namespace runtime
} // namespace cce
#endif // __CCE_RUNTIME_QOS_HPP__
