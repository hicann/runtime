/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_MODEL_ERR_PROCESS_H
#define CORE_AICPUSD_MODEL_ERR_PROCESS_H

#include <string>
#include <mutex>
#include "aicpusd_common.h"
#include "aicpusd_util.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_sqe_adapter.h"

namespace AicpuSchedule {
#pragma pack(push, 1)
    struct ErrLogRptInfo {
        uint32_t offset;
        uint32_t errCode;
        uint32_t streamId;
        uint32_t taskId;
        uint32_t modelId;
        uint32_t tsId;
    };
#pragma pack(pop)

    enum class ModelErrRptVer {
        LOG_ERROR_VERSION_1      = 0,  // first version of err log
        LOG_ERROR_VERSION_BUFF         // aicore error log
    };

    constexpr uint32_t ERRLOG_TS_MAXNUM = 2U;

    class AicpuModelErrProc {
    public:
        AicpuModelErrProc();
        ~AicpuModelErrProc() = default;

        /**
        * @ingroup AicpuModelErrProc
        * @brief it is used to get instance of AicpuModelErrProc.
        */
        static AicpuModelErrProc &GetInstance();

        /**
        * @ingroup ProcessLogBuffCfgMsg
        * @brief it is used to process the config of log buffer.
        * @param [in] cfgInfo : the config info of log buffer.
        */
        void ProcessLogBuffCfgMsg(const aicpu::AicpuConfigMsg &cfgInfo);

        /**
        * @ingroup RecordAicoreOpErrLog
        * @brief Aicore OP log process.
        * @param [in] info : the information of aicore stream ops.
        */
        void RecordAicoreOpErrLog(const AicpuSqeAdapter::AicpuTaskReportInfo &info, AicpuSqeAdapter &aicpuSqeAdapter);

        /**
        * @ingroup RecordAicpuOpErrLog
        * @brief Aicpu OP log process.
        * @param [in] taskContext : the context of aicpu stream ops.
        * @param [in] kernelTaskInfo : task information of aicpu stream ops.
        * @param [in] resultCode : result of aicpu stream ops.
        */
        void RecordAicpuOpErrLog(const RunContext &taskContext, const AicpuTaskInfo &kernelTaskInfo,
                                 const uint32_t resultCode);
    private:
        AicpuModelErrProc(const AicpuModelErrProc &) = delete;
        AicpuModelErrProc &operator=(const AicpuModelErrProc &) = delete;
        AicpuModelErrProc(AicpuModelErrProc&&) = delete;
        AicpuModelErrProc& operator=(AicpuModelErrProc&&) = delete;

        /**
        * @ingroup SetLogBuffAddr
        * @brief config the address of log buffer.
        * @param [in] tsId : the Id of TS.
        * @param [in] buffAddr : the address of log buffer.
        * @param [in] buffLen : task length of log buffer.
        */
        void SetLogBuffAddr(const uint32_t tsId, const uint64_t buffAddr, const uint16_t buffLen);

        /**
        * @ingroup SetUnitLogEmpy
        * @brief reset a unit log buffer.
        * @param [in] tsId : the Id of TS.
        * @param [in] offset : the offset of log buffer.
        */
        void SetUnitLogEmpy(const uint32_t tsId, const uint32_t offset);

        /**
        * @ingroup SetLogBuffInvalid
        * @brief set the free flag of the log buffer.
        * @param [in] tsId : the Id of TS.
        */
        void SetLogBuffInvalid(const uint32_t tsId);

        /**
        * @ingroup GetEmptLogOffset
        * @brief get an empt unit log buffer.
        * @param [in] tsId : the Id of TS.
        * @return UINT32_MAX: invalid offset, other: valid offset
        */
        uint32_t GetEmptLogOffset(const uint32_t tsId);

        /**
        * @ingroup CheckLogIsEmpt
        * @brief check if log unit is free.
        * @param [in] tsId : the Id of TS.
        * @param [in] offset : the offset of log buffer unit.
        * @return true: free, false: not free
        */
        bool CheckLogIsEmpt(const uint32_t tsId, const uint32_t offset) const;

        /**
        * @ingroup AddErrLog
        * @brief add an ERR log.
        * @param [in] errLog : aicore stream ops error information.
        * @param [in] tsId : the Id of TS.
        * @param [in] offset : the offset of log buffer unit.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        uint32_t AddErrLog(const aicpu::AicoreErrMsgInfo &errLog, const uint32_t tsId, uint32_t &offset);

        /**
        * @ingroup AddErrLog
        * @brief add an ERR log.
        * @param [in] errLog : aicpu stream ops error information.
        * @param [in] tsId : the Id of TS.
        * @param [in] offset : the offset of log buffer unit.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        uint32_t AddErrLog(const aicpu::AicpuErrMsgInfo &errLog, const uint32_t tsId, uint32_t &offset);

        /**
        * @ingroup ReportErrLog
        * @brief report an ERR log to TS.
        * @param [in] reportInfo : the error info report to TS.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        uint32_t ReportErrLog(const ErrLogRptInfo &reportInfo, AicpuSqeAdapter *aicpuSqeAdapterPtr = nullptr) const;
    private:
        SpinLock lockBuff_;       // SpinLock of operate buffBaseAddr_
        uint64_t buffBaseAddr_[ERRLOG_TS_MAXNUM];   // log addr
        uint32_t buffLen_[ERRLOG_TS_MAXNUM];        // log buff length
        bool isBuffValid_[ERRLOG_TS_MAXNUM];        // is buff addr valid
    };
}  // namespace

#endif // CORE_AICPUSD_MODEL_ERR_PROCESS_H
