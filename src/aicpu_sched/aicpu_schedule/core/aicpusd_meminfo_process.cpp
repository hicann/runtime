/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <fstream>
#include <climits>
#include <cstdlib>
#include <securec.h>
#include "ascend_hal_define.h"
#include "aicpusd_util.h"
#include "aicpusd_drv_manager.h"
#include "aicpu_context.h"
#include "aicpusd_meminfo_process.h"

namespace AicpuSchedule {
    StatusCode AicpuMemInfoProcess::GetMemZoneInfo(BuffCfg &buffCfg)
    {
        aicpusd_info("Start get memzone info!");
        buffCfg = {}; // default
        auto ret = CheckRunMode();
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        std::string blockModePath = "";
        const bool envRet = AicpuUtil::GetEnvVal(ENV_NAME_BLOCK_CFG_PATH, blockModePath);
        if (!envRet) {
            aicpusd_run_info("The pointer of BLOCK_CFG_PATH is nullptr");
            return AICPU_SCHEDULE_OK;
        }

        if ((blockModePath.size() > 0U) && (blockModePath[blockModePath.size() - 1U] != '/')) {
            (void)blockModePath.append("/");
        }

        const std::string procName = AicpuDrvManager::GetInstance().GetHostProcName();
        const std::string memBuffCfgFile = blockModePath + "aifmk/" + procName + ".json";
        ret = CheckPathValid(memBuffCfgFile);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_run_info("The memBufCfgFile path is invalid: [%s]!", memBuffCfgFile.c_str());
            return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
        }

        nlohmann::json jsonRead;
        ret = ReadJsonFile(memBuffCfgFile, jsonRead);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_run_info("Execute ReadJsonFile returned [%d].", ret);
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        ret = ParseCfgData(jsonRead, buffCfg);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_run_info("Execute ParseCfgData returned [%d].", ret);
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuMemInfoProcess::ReadJsonFile(const std::string &filePath, nlohmann::json &jsonRead)
    {
        aicpusd_info("Read [%s] file", filePath.c_str());
        std::ifstream ifs(filePath);
        if (!ifs.is_open()) {
            aicpusd_run_info("Cant not open [%s], please check!", filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        try {
            ifs >> jsonRead;
            ifs.close();
        } catch (const nlohmann::json::exception &e) {
            if (ifs.is_open()) {
                ifs.close();
            }
            aicpusd_run_info("Exception: [%s]", e.what());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }

        aicpusd_info("Read [%s] file successfully, content is: [%s].", filePath.c_str(),
                     jsonRead.dump().c_str());
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuMemInfoProcess::ParseCfgData(const nlohmann::json &input,  BuffCfg &output)
    {
        aicpusd_info("Start parse cfg data!");
        const auto jsonSize = (input.size() < BUFF_MAX_CFG_NUM) ? input.size() : static_cast<size_t>(BUFF_MAX_CFG_NUM);
        for (size_t i = 0UL; i < jsonSize; ++i) {
            std::string key = std::to_string(i);
            if (!input.contains(key)) {
                aicpusd_run_info("The key [%s] is not in json content, please check the json file", key.c_str());
                return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
            }
            try {
                (void)input[key].at("cfg_id").get_to(output.cfg[i].cfg_id);
                (void)input[key].at("total_size").get_to(output.cfg[i].total_size);
                (void)input[key].at("blk_size").get_to(output.cfg[i].blk_size);
                (void)input[key].at("max_buf_size").get_to(output.cfg[i].max_buf_size);
                (void)input[key].at("page_type").get_to(output.cfg[i].page_type);
            } catch (nlohmann::json::exception &e) {
                aicpusd_run_info("The keys of json is not correct: [%s]", e.what());
                return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuMemInfoProcess::CheckPathValid(const std::string &cfgFullPath)
    {
        if (cfgFullPath.length() >= static_cast<size_t>(PATH_MAX)) {
            aicpusd_run_info(
                "cfgFullPath file length[%zu] must less than PATH_MAX[%u]", cfgFullPath.length(), PATH_MAX);
            return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
        }

        std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
        if (path == nullptr) {
            aicpusd_run_info("Alloc memory for path failed.");
            return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
        }

        const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
        if (eRet != EOK) {
            aicpusd_run_info("Mem set not success, ret=%d", eRet);
            return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
        }

        if (realpath(cfgFullPath.data(), path.get()) == nullptr) {
            aicpusd_run_info("Check cfg file full path:[%s], path:[%s]", cfgFullPath.c_str(), path.get());
            return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
        }
        const std::string normalPath(path.get());
        if (normalPath != cfgFullPath) {
            aicpusd_run_info("Invalid mem cfg file:[%s], should be [%s]", cfgFullPath.c_str(), normalPath.c_str());
            return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
        }
        aicpusd_info("Check mem cfg file [%s] success.", cfgFullPath.c_str());
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuMemInfoProcess::CheckRunMode()
    {
        uint32_t runMode;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("GetAicpuRunMode returned [%u]", status);
            return AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED;
        }
        if (runMode != static_cast<uint32_t>(aicpu::AicpuRunMode::PROCESS_SOCKET_MODE)) {
            aicpusd_run_info("Current aicpu mode is not socket_mode, please check!");
            return AICPU_SCHEDULE_OK;
        }
        return AICPU_SCHEDULE_OK;
    }
}
