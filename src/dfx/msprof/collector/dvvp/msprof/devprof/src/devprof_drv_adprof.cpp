/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "devprof_drv_adprof.h"
#include "error_code.h"
#include "config.h"
#include "ai_drv_prof_api.h"
#include "devprof_common.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::driver;
using namespace Devprof;

const char * const EVENT_ADPROF_MSG_GRP_NAME = "prof_adprof_grp";

int32_t ReportAdprofFileChunk(const void *data)
{
    if (data == nullptr) {
        MSPROF_LOGE("Report adprof file chunk interface input invalid data.");
        return PROFILING_FAILED;
    }

    const uint32_t ageFlag = 1;
    int32_t ret = DevprofDrvAdprof::instance()->adprofFileChunkBuffer.TryPush(
        ageFlag, *static_cast<const analysis::dvvp::ProfileFileChunk *>(data));
    if (ret != MSPROF_ERROR_NONE) {
        size_t buffUsedSize = DevprofDrvAdprof::instance()->adprofFileChunkBuffer.GetUsedSize();
        MSPROF_LOGE("Try push buff failed, buffUsedSize: %" PRIu64 " buffs.", buffUsedSize);
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStartAdprof(ProfSampleStartPara *para)
{
    UNUSED(para);
    MSPROF_EVENT("drv start adprof");
    DevprofDrvAdprof::instance()->adprofFileChunkBuffer.Init(REPORT_BUFF_CAPACITY, "AdprofBuffer");

    int32_t ret = DevprofDrvAdprof::instance()->adprofCallBack_.start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start aicpu report.");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

STATIC int32_t TransChunkToTlv(analysis::dvvp::ProfileFileChunk &fileChunk, ProfTlv *tlvBuff)
{
    tlvBuff->head = TLV_HEAD;
    tlvBuff->version = TLV_VERSION;
    tlvBuff->type = TLV_TYPE;
    tlvBuff->len = static_cast<uint32_t>(sizeof(ProfTlvValue));

    ProfTlvValue *tlvValue = reinterpret_cast<ProfTlvValue *>(tlvBuff->value);
    tlvValue->isLastChunk = fileChunk.isLastChunk;
    tlvValue->chunkModule = fileChunk.chunkModule;
    tlvValue->offset = fileChunk.offset;
    tlvValue->chunkSize = fileChunk.chunkSize;

    errno_t err = memcpy_s(tlvValue->chunk, TLV_VALUE_CHUNK_MAX_LEN, fileChunk.chunk.c_str(), fileChunk.chunkSize);
    if (err != EOK) {
        MSPROF_LOGE("Adprof memcpy_s chunk failed.");
        return PROFILING_FAILED;
    }
    err = strcpy_s(tlvValue->fileName, TLV_VALUE_FILENAME_MAX_LEN, fileChunk.fileName.c_str());
    if (err != EOK) {
        MSPROF_LOGE("Adprof strcpy_s fileName failed, ret is %d, fileName is %s.", err, fileChunk.fileName.c_str());
        return PROFILING_FAILED;
    }
    err = strcpy_s(tlvValue->extraInfo, TLV_VALUE_EXTRAINFO_MAX_LEN, fileChunk.extraInfo.c_str());
    if (err != EOK) {
        MSPROF_LOGE(
            "Adprof strcpy_s extraInfo failed, ret is %d, extraInfo is %s.", err, fileChunk.extraInfo.c_str());
        return PROFILING_FAILED;
    }
    err = strcpy_s(tlvValue->id, TLV_VALUE_ID_MAX_LEN, fileChunk.id.c_str());
    if (err != EOK) {
        MSPROF_LOGE("Adprof strcpy_s id failed, ret is %d, id is %s.", err, fileChunk.id.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfSampleAdprof(ProfSamplePara *para)
{
    ProfTlv *tlvBuff = static_cast<ProfTlv *>(para->buff);

    uint64_t totalReportLen = 0;
    uint32_t ageFlag = 1;
    analysis::dvvp::ProfileFileChunk fileChunk;
    uint32_t maxCount = para->buff_len / sizeof(ProfTlv);
    for (uint32_t i = 0; i < maxCount; i++) {
        bool isOK = DevprofDrvAdprof::instance()->adprofFileChunkBuffer.TryPop(ageFlag, fileChunk);
        if (!isOK) {
            break;
        }
        int32_t ret = TransChunkToTlv(fileChunk, tlvBuff);
        if (ret != PROFILING_SUCCESS) {
            break;
        }
        totalReportLen += sizeof(ProfTlv);
        tlvBuff++;
    }

    para->report_len = totalReportLen;
    MSPROF_LOGI("drv sample adprof data, total size:%lu", totalReportLen);
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfReportAdprofData(uint32_t devId, uint32_t channelId)
{
    void *buff = Utils::ProfMalloc(REPORT_BUFF_SIZE);
    if (buff == nullptr) {
        MSPROF_LOGE("malloc report buffer failed");
        return PROFILING_FAILED;
    }

    uint32_t totalReportLen = 0;
    uint32_t ageFlag = 1;
    analysis::dvvp::ProfileFileChunk fileChunk;
    uint32_t maxCount = 0;
    uint32_t bufLen = 0;
    int32_t ret = 0;
    while (DevprofDrvAdprof::instance()->adprofFileChunkBuffer.GetUsedSize() != 0) {
        totalReportLen = 0;
        ProfTlv *tlvBuff = static_cast<ProfTlv *>(buff);
        ret = halProfQueryAvailBufLen(devId, channelId, &bufLen);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId, channelId, ret);
            break;
        }
        bufLen = bufLen > REPORT_BUFF_SIZE ? REPORT_BUFF_SIZE : bufLen;
        maxCount = bufLen / sizeof(ProfTlv);
        if (maxCount == 0) {
            (void)OsalSleep(WAIT_DRV_TIME);
            continue;
        }
        for (uint32_t i = 0; i < maxCount; i++) {
            if (!DevprofDrvAdprof::instance()->adprofFileChunkBuffer.TryPop(ageFlag, fileChunk)) {
                break;
            }
            if (TransChunkToTlv(fileChunk, tlvBuff) != PROFILING_SUCCESS) {
                break;
            }
            totalReportLen += sizeof(ProfTlv);
            tlvBuff++;
        }
        if (totalReportLen == 0) {
            break;
        }
        struct prof_data_report_para profDataReportPara = {buff, totalReportLen};
        ret = halProfSampleDataReport(devId, channelId, 0, &profDataReportPara);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("report data failed, ret:%d, data size:%u", ret, totalReportLen);
        } else {
            MSPROF_LOGI("device id:%u, channel id:%u, report data size:%u", devId, channelId, totalReportLen);
        }
    }
    Utils::ProfFree(buff);
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStopAdprof(ProfSampleStopPara *para)
{
    UNUSED(para);
    MSPROF_EVENT("drv stop adprof");
    int32_t ret = DevprofDrvAdprof::instance()->adprofCallBack_.stop();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start aicpu report.");
        return PROFILING_FAILED;
    }
    ProfReportAdprofData(para->dev_id, PROF_CHANNEL_ADPROF);
    DevprofDrvAdprof::instance()->adprofFileChunkBuffer.UnInit();
    DevprofDrvAdprof::instance()->adprofCallBack_.exit();
    return PROFILING_SUCCESS;
}

int32_t AdprofStartRegister(struct AdprofCallBack &adprofCallBack, uint32_t devId, int32_t hostPid)
{
    MSPROF_EVENT("adprof start register");
    DevprofDrvAdprof::instance()->adprofCallBack_ = adprofCallBack;
    ProfSampleRegisterPara registerPara = {1, {ProfStartAdprof, ProfSampleAdprof, nullptr, ProfStopAdprof}};
    int32_t ret = halProfSampleRegister(devId, PROF_CHANNEL_ADPROF, &registerPara);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to regist adprof sample ops, ret = %d.", ret);
        return PROFILING_FAILED;
    }

    ret = ProfSendEvent(devId, hostPid, EVENT_ADPROF_MSG_GRP_NAME);
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}
