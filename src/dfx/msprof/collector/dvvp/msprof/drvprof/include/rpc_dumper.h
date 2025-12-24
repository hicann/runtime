/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_RPC_DUMPER_H
#define MSPROF_ENGINE_RPC_DUMPER_H

#include "data_dumper.h"
#include "receive_data.h"
#include "rpc_data_handle.h"
#include "proto/profiler.pb.h"

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::proto;
class RpcDumper : public DataDumper {
public:
    /**
    * @brief RpcDumper: the construct function
    * @param [in] module: the name of the plugin
    */
    explicit RpcDumper(const std::string &module);
    ~RpcDumper() override;

public:
    /**
    * @brief Report: API for user to report data to profiling
    * @param [in] rData: the data from user
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t Report(CONST_REPORT_DATA_PTR rData) override;

    /**
    * @brief Start: create a TCP collection to PROFILING SERVER
    *               start a new thread to deal with data from user
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t Start() override;

    /**
    * @brief Stop: stop the thread to deal with data
    *              disconnect the TCP to PROFILING SERVER
    */
    int32_t Stop() override;

    /**
    * @brief Flush: wait all datas to be send to remove host
    *               then send a FileChunkFlushReq data to remote host tell it data report finished
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t Flush() override;

    uint32_t GetReportDataMaxLen() const override;

protected:
    void WriteDone() override;
    /**
     * @brief Run: the thread function for deal with user data
     */
    void Run(const struct error_message::Context &errorContext) override;
private:
    /**
    * @brief Dump: transfer FileChunkReq
    * @param [in] message: the user data to be send to remote host
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t Dump(std::vector<SHARED_PTR_ALIA<FileChunkReq>> &messages);
    int32_t Dump(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>> &message) override;
    int32_t DumpData(std::vector<ReporterDataChunk> &message, SHARED_PTR_ALIA<FileChunkReq> fileChunk);
    void RunDefaultProfileData(const std::vector<SHARED_PTR_ALIA<FileChunkReq>>& fileChunks) const;
    void DoReportRun() override;
    void TimedTask() override;
    int32_t GetNameAndId(const std::string &module);

private:
    std::string module_; // the module name, like: DATA_PREPROCESS
    std::string moduleNameWithId_; // like: DATA_PREPROCESS-80858-3
    int32_t hostPid_;
    int32_t devId_;
    SHARED_PTR_ALIA<RpcDataHandle> dataHandle_;
};
}}
#endif
