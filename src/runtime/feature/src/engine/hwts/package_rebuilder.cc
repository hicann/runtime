/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "package_rebuilder.hpp"
#include "engine.hpp"
#include "runtime.hpp"
#include "securec.h"
#include "profiler.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "task_info.hpp"
#include "task_res.hpp"
#include "thread_local_container.hpp"
#include "atrace_log.hpp"

namespace cce {
namespace runtime {
PackageRebuilder::~PackageRebuilder()
{
    for (auto &iter : rptPkgTbl_) {
        if (iter.second != nullptr) {
            free(iter.second);
            iter.second = nullptr;
        }
    }
}

bool PackageRebuilder::PackageReportReceive(const rtTaskReport_t * const report, uint8_t * const package,
                                            const size_t pkgLen, const TaskInfo * const reportTask)
{
    const uint16_t streamId = static_cast<uint16_t>((static_cast<uint32_t>(report->streamID)) |
                              (static_cast<uint32_t>(report->streamIDEx) << RT_STREAM_ID_OFFSET));
    const uint8_t packageReportNum = reportTask->pkgStat[report->packageType].packageReportNum;
    if (likely(packageReportNum == 1U)) {
        if (unlikely((report->SOP == 0U) || (report->EOP == 0U))) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Report missing SOP/EOP flag, "
                "SOP=%hu,MOP=%hu,EOP=%hu,packType=%hu,stream_id=%hu,task_id=%hu,"
                "payLoad=0x%x,sq_id=%hu,phase=%hu,sq_head=%hu",
                report->SOP, report->MOP, report->EOP, report->packageType, streamId, report->taskID,
                report->payLoad, report->SQ_id, report->phase, report->SQ_head);
            return false;
        }
        *(RtPtrToPtr<uint32_t *>(package)) = report->payLoad;
        // get task id for model execute failed
        *(RtPtrToPtr<uint32_t *>(package) + 1U) = report->reserved;
        // get stream id high bit for model execute failed
        *(RtPtrToPtr<uint32_t *>(package) + 2U) = report->faultStreamIDEx;
        return true;
    }

    const uint64_t reportHashVal =
        static_cast<uint64_t>(REPORT_HASH_KEY(report->taskID, streamId, report->packageType));
    rtPackageBuf_t *pkgBuf = rptPkgTbl_[reportHashVal];

    if (report->SOP != 0U) {
        if (report->MOP != 0U) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Report invalid MOP flag, "
                "SOP=%hu,MOP=%hu,EOP=%hu,packType=%hu,stream_id=%hu,task_id=%hu,"
                "payLoad=0x%x,sq_id=%hu,phase=%hu,sq_head=%hu",
                report->SOP, report->MOP, report->EOP, report->packageType, streamId, report->taskID,
                report->payLoad, report->SQ_id, report->phase, report->SQ_head);
            return false;
        }
        if (pkgBuf != nullptr) {
            RT_LOG(RT_LOG_INFO, "Package rebuild: missing EOP report in last task! recvNum:%u expectNum:%u",
                   static_cast<uint32_t>(pkgBuf->len), static_cast<uint32_t>(packageReportNum));
            free(pkgBuf);
            pkgBuf = nullptr;
            (void)rptPkgTbl_.erase(reportHashVal);
        }

        const size_t packageBufLen = (packageReportNum + 1U) * sizeof(uint32_t);
        pkgBuf = static_cast<rtPackageBuf_t *>(malloc(packageBufLen));
        COND_PROC_RETURN_ERROR(pkgBuf == nullptr, false,
                               RT_LOG_INNER_DETAIL_MSG(RT_SYSTEM_INNER_ERROR, {"target", "size"},
                                            {"pkgBuf", std::to_string(packageBufLen)});,
                               "Report rebuilder memory alloc fail, SOP=%hu,MOP=%hu,EOP=%hu,packType=%hu,stream_id=%hu,"
                               "task_id=%hu,payLoad=0x%x,sq_id=%hu,phase=%hu,sq_head=%hu.",
                               report->SOP, report->MOP, report->EOP, report->packageType, streamId, report->taskID,
                               report->payLoad, report->SQ_id, report->phase, report->SQ_head);
        const errno_t rc = memset_s(pkgBuf, packageBufLen, 0, packageBufLen);
        if (rc != EOK) {
            RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "Report rebuilder memory set zero fail, "
                "SOP=%hu,MOP=%hu,EOP=%hu,packType=%hu,stream_id=%hu,task_id=%hu,"
                "payLoad=0x%x,sq_id=%hu,phase=%hu,sq_head=%hu"
                ",retCode=%d,size=%zu(bytes).", report->SOP, report->MOP, report->EOP, report->packageType,
                streamId, report->taskID, report->payLoad, report->SQ_id, report->phase, report->SQ_head,
                rc, packageBufLen);
            free(pkgBuf);
            pkgBuf = nullptr;
            return false;
        }

        rptPkgTbl_[reportHashVal] = pkgBuf;
    }

    if (pkgBuf != nullptr) {
        if (static_cast<uint32_t>(pkgBuf->len) < static_cast<uint32_t>(packageReportNum)) {
            pkgBuf->buf[pkgBuf->len] = report->payLoad;
        }
        pkgBuf->len++;
    }

    if (report->EOP != 0U) {
        if (pkgBuf == nullptr) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                "Report rebuilder memory not found, "
                "SOP=%hu,MOP=%hu,EOP=%hu,packType=%hu,stream_id=%hu,task_id=%hu,payLoad=0x%x,"
                "sq_id=%hu,phase=%hu,sq_head=%hu",
                report->SOP, report->MOP, report->EOP, report->packageType, streamId, report->taskID,
                report->payLoad, report->SQ_id, report->phase, report->SQ_head);
            (void)rptPkgTbl_.erase(reportHashVal);
            return false;
        }
        if (static_cast<uint32_t>(packageReportNum) != static_cast<uint32_t>(pkgBuf->len)) {
            RT_LOG(RT_LOG_INFO, "Package rebuild: missing MOP report in current task! recvNum:%u expectNum:%u",
                   static_cast<uint32_t>(pkgBuf->len), static_cast<uint32_t>(packageReportNum));
            free(pkgBuf);
            pkgBuf = nullptr;
            (void)rptPkgTbl_.erase(reportHashVal);
            return false;
        }
        const errno_t ret = memcpy_s(package, pkgLen, pkgBuf->buf, pkgBuf->len * sizeof(uint32_t));
        COND_LOG_ERROR(ret != EOK,
                       "memcpy_s failed,SOP=%hu,MOP=%hu,EOP=%hu,packType=%hu,stream_id=%hu,task_id=%hu,"
                       "payLoad=0x%x,sq_id=%hu,phase=%hu,sq_head=%hu, retCode=%d, copySize=%zu(bytes),"
                       "targetSize=%zu(bytes)",
                       report->SOP, report->MOP, report->EOP, report->packageType, streamId, report->taskID,
                       report->payLoad, report->SQ_id, report->phase, report->SQ_head, ret,
                       pkgBuf->len * sizeof(uint32_t), pkgLen);

        free(pkgBuf);
        pkgBuf = nullptr;
        (void)rptPkgTbl_.erase(reportHashVal);
        return true;
    }
    return false;
}
}  // namespace runtime
}  // namespace cce