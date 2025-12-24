/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COLLECT_IO_FILE_H_INCLUDED
#define COLLECT_IO_FILE_H_INCLUDED

#include <memory>
#include <string>
#include "common.h"
#include "memory/chunk_pool.h"
#include "message/prof_params.h"
#include "config/config.h"

namespace analysis {
namespace dvvp {
namespace streamio {
namespace client {
class File {
public:
    File(SHARED_PTR_ALIA<analysis::dvvp::common::memory::ChunkPool> chunkPool,
         SHARED_PTR_ALIA<analysis::dvvp::common::memory::Chunk> chunk,
         const std::string &jobCtx, const std::string &fileName)
        : chunkPool_(chunkPool),
          chunk_(chunk), jobCtx_(jobCtx), fileName_(fileName), mode_(analysis::dvvp::streamio::common::STREAM_MODE),
          chunkStartTime_(0), chunkEndTime_(0),
          dataModule_(analysis::dvvp::common::config::FileChunkDataModule::PROFILING_DEFAULT_DATA_MODULE)
        {
    }
    virtual ~File()
    {
        Uinit();
    }

public:
    int32_t Init()
    {
        int32_t ret = analysis::dvvp::common::error::PROFILING_FAILED;

        do {
            MSVP_MAKE_SHARED0_NODO(jobCtxPtr_, analysis::dvvp::message::JobContext, break);
            if (!jobCtxPtr_->FromString(jobCtx_)) {
                MSPROF_LOGE("invalid job_ctx_json:%s", jobCtx_.c_str());
                break;
            }
            mode_ = (jobCtxPtr_->stream_enabled.compare("off") == 0)
                ? analysis::dvvp::streamio::common::FILE_MODE : mode_;
            if (mode_ == analysis::dvvp::streamio::common::FILE_MODE) {
                writeFileName_ = jobCtxPtr_->result_dir;
                writeFileName_.append(analysis::dvvp::common::utils::MSVP_SLASH)
                    .append("data").append(analysis::dvvp::common::utils::MSVP_SLASH);
                writeFileName_.append(fileName_).append(".").append(jobCtxPtr_->dev_id);
            } else {
                tag_ = jobCtxPtr_->tag;
                module_ = jobCtxPtr_->module;
                chunkStartTime_ = jobCtxPtr_->chunkStartTime;
                chunkEndTime_ = jobCtxPtr_->chunkEndTime;
                dataModule_ = jobCtxPtr_->dataModule;
            }
            ret = analysis::dvvp::common::error::PROFILING_SUCCESS;
        } while (0);

        return ret;
    }

    void Uinit()
    {
        chunk_->Clear();
        if (chunkPool_ != nullptr) {
            chunkPool_->Release(chunk_);
        }
    }
    const SHARED_PTR_ALIA<analysis::dvvp::common::memory::Chunk> GetChunk() const
    {
        return chunk_;
    }
    const std::string &GetJobCtx() const
    {
        return jobCtx_;
    }
    const std::string &GetFileName() const
    {
        return fileName_;
    }
    const std::string &GetModule() const
    {
        return module_;
    }
    const std::string &GetWriteFileName() const
    {
        return writeFileName_;
    }
    const std::string &GetTag() const
    {
        return tag_;
    }
    uint64_t GetChunkStartTime() const
    {
        return chunkStartTime_;
    }
    uint64_t GetChunkEndTime() const
    {
        return chunkEndTime_;
    }
    int32_t GetChunkDataModule() const
    {
        return dataModule_;
    }
    bool IsStreamMode() const
    {
        return (mode_ == analysis::dvvp::streamio::common::STREAM_MODE);
    }

private:
    SHARED_PTR_ALIA<analysis::dvvp::common::memory::ChunkPool> chunkPool_;
    SHARED_PTR_ALIA<analysis::dvvp::common::memory::Chunk> chunk_;
    std::string jobCtx_;
    std::string fileName_;
    analysis::dvvp::streamio::common::IO_MODE mode_;
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtxPtr_;
    std::string writeFileName_;
    std::string tag_;
    std::string module_;
    uint64_t chunkStartTime_;
    uint64_t chunkEndTime_;
    int32_t dataModule_;
};
}  // namespace client
}  // namespace streamio
}  // namespace dvvp
}  // namespace analysis

#endif
