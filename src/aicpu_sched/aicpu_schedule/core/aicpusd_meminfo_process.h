/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CORE_AICPUSD_MEMINFO_PROCESS_H
#define CORE_AICPUSD_MEMINFO_PROCESS_H

#include <nlohmann/json.hpp>
#include "aicpusd_status.h"
#include "ascend_hal.h"
#include "type_def.h"
namespace AicpuSchedule {
    class AicpuMemInfoProcess {
    public:
        /**
         * @brief get memzoneinfo for setting mbuf
         * @param [in] BuffCfg: buffCfg
         * @return AICPU_SCHEDULE_OK: success
         */
        static StatusCode GetMemZoneInfo(BuffCfg &buffCfg);

        /**
         * @brief read the memzone cfg file which is json format.
         * @param [in] string: filePath
         * @param [in] json: jsonRead
         * @return AICPU_SCHEDULE_OK: success
         */
        static StatusCode ReadJsonFile(const std::string &filePath, nlohmann::json &jsonRead);

        /**
         * @brief parse the cfg data from json input to BuffCfg.
         * @param [in] json: input
         * @param [in] BuffCfg: output
         * @return AICPU_SCHEDULE_OK: success
         */
        static StatusCode ParseCfgData(const nlohmann::json &input,  BuffCfg &output);

        /**
         * @brief check the cfg file path.
         * @param [in] string: cfgFullfilePath
         * @return AICPU_SCHEDULE_OK: success
         */
        static StatusCode CheckPathValid(const std::string &cfgFullPath);

        /**
         * @brief check aicpu run mode.
         * @return AICPU_SCHEDULE_OK: success
         */
        static StatusCode CheckRunMode();
    };
}
#endif // CORE_AICPUSD_JSON_READ_H
