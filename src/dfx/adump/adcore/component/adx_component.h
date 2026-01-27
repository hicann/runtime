/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_COMMON_COMPONENT_H
#define ADX_COMMON_COMPONENT_H
#include <cstdint>
#include <string>
#include "adx_service_config.h"
#include "common_utils.h"
#include "ide_tlv.h"
#include "adx_msg.h"
namespace Adx {
struct AdxComponentMap {
    ComponentType cmptType;  // component type
    CmdClassT cmdType;       // request type
    std::string cmptName;    // name of request
    std::string oprtName;    // name of record opreate log
};

const AdxComponentMap g_componentsInfo[] = {
    {ComponentType::COMPONENT_GETD_FILE,     IDE_FILE_GETD_REQ,     "file_getd",     "TransferFile"  },
    {ComponentType::COMPONENT_LOG_BACKHAUL,  IDE_LOG_BACKHAUL_REQ,  "log_backhaul",  "BackhaulLog"   },
    {ComponentType::COMPONENT_LOG_LEVEL,     IDE_LOG_LEVEL_REQ,     "log_level",     "OperateLevel"  },
    {ComponentType::COMPONENT_DUMP,          IDE_DUMP_REQ,          "dump",          "DataDump"      },
    {ComponentType::COMPONENT_TRACE,         IDE_TRACE_REQ,         "trace",         "Trace"         },
    {ComponentType::COMPONENT_MSNPUREPORT,   IDE_MSN_REQ,           "msnpureport",   "Msnpureport"   },
    {ComponentType::COMPONENT_HBM_DETECT,    IDE_HBM_REQ,           "hbm_detect",    "HbmDetect"     },
    {ComponentType::COMPONENT_SYS_GET,       IDE_SYS_GET_REQ,       "sys_get",       "SysGet"        },
    {ComponentType::COMPONENT_SYS_REPORT,    IDE_SYS_REPORT_REQ,    "sys_report",    "SysReport"     },
    {ComponentType::COMPONENT_FILE_REPORT,   IDE_FILE_REPORT_REQ,   "file_report",   "FileReport"    },
    {ComponentType::COMPONENT_CPU_DETECT,    IDE_CPU_DETECT_REQ,    "cpu_detect",    "CpuDetect"     },
    {ComponentType::COMPONENT_DETECT_LIB_LOAD , IDE_DETECT_LIB_LOAD_REQ, "lib_load", "LibLoad"       }
};

class AdxComponent {
public:
    AdxComponent() {}
    virtual ~AdxComponent() {}
    virtual int32_t Init() = 0;
    virtual const std::string GetInfo() { return "None"; }
    virtual ComponentType GetType() = 0;
    virtual int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &req) = 0;
    virtual int32_t UnInit() = 0;
    virtual int32_t Terminate() { return 0; }
};
}
#endif // ADX_COMMON_COMPONENT_H