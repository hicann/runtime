/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "high_mem.h"
#include <errno.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <unistd.h>
#include "log_print.h"

/**
 * @brief       : write to himem
 * @param [in]  : fd        himem fd
 * @param [in]  : buffer    msg written to himem
 * @param [in]  : len       length of msg
 * @return      : ==LOG_FAILURE failure; ==LOG_SUCCESS success
 */
STATIC LogStatus HiMemWrite(int32_t fd, const char *buffer, size_t len)
{
    ONE_ACT_ERR_LOG(fd <= 0, return LOG_FAILURE, "write failed. invalied fd.");
    int32_t ret = (int32_t)write(fd, buffer, len);
    ONE_ACT_ERR_LOG((ret < 0) || (ret != (int32_t)len),
                    return LOG_FAILURE, "write failed. ret = %d, errno :%d", ret, errno);
    return LOG_SUCCESS;
}

/**
 * @brief       : read from himem
 * @param [in]  : fd        himem fd
 * @param [in]  : buffer    msg read from himem
 * @param [in]  : len       length of msg
 * @return      : ==LOG_FAILURE failure; >=0 success, return msg length
 */
STATIC int32_t HiMemRead(int32_t fd, char *buffer, size_t len)
{
    ONE_ACT_ERR_LOG(fd <= 0, return LOG_FAILURE, "read failed, invalied fd.");
    int32_t ret = (int32_t)read(fd, buffer, len);
    if (ret < 0) {
        return LOG_FAILURE;
    }
    return ret;
}

/**
 * @brief       : init himem
 * @param[out]  : fd        pointer to save himem fd
 * @return      : ==LOG_FAILURE failure; ==LOG_SUCCESS success
 */
LogStatus HiMemInit(int32_t *fd)
{
    int32_t himemFd = open(HM_DRV_CHAR_DEV_USER_PATH, O_RDWR);
    ONE_ACT_ERR_LOG(himemFd <= 0, return LOG_FAILURE, "open %s failed, errno :%d", HM_DRV_CHAR_DEV_USER_PATH, errno);

    int32_t ret = ioctl(himemFd, HM_DRV_IOCTL_BIND_BLOCK, HM_DRV_BLOCK_TYPE_SLOG);
    if (ret < 0) {
        SELF_LOG_ERROR("bind himem failed. ret = %d, errno :%d", ret, errno);
        (void)close(himemFd);
        return LOG_FAILURE;
    }
    *fd = himemFd;
    SELF_LOG_INFO("init himem fd success.");
    return LOG_SUCCESS;
}

/**
 * @brief       : free himem
 * @param[out]  : fd        pointer to save himem fd
 * @return      : NA
 */
void HiMemFree(int32_t *fd)
{
    if (*fd > 0) {
        (void)close(*fd);
        *fd  = 0;
    }
}

/**
 * @brief       : construct himem log msg and write log msg
 * @param[in]   : fd        himem fd
 * @param[in]   : buffer    log msg
 * @param[in]   : len       length of log msg
 * @param[in]   : type      log type
 * @return      : ==LOG_FAILURE failure; >=0 success, return msg length
 */
STATIC int32_t HiMemWriteLog(int32_t fd, const char* buffer, uint32_t len, const LogHead *head)
{
    HimemLogMsg logMsg;
    errno_t err = memcpy_s(&logMsg.head, LOGHEAD_LEN, head, LOGHEAD_LEN);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "memcpy failed. err = %d, errno :%d", err, errno);

    err = memset_s(logMsg.msg, HIMEM_LOG_LENGTH, 0, HIMEM_LOG_LENGTH);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "memset failed. err = %d, errno :%d", err, errno);

    uint32_t msgLen = (len <= (HIMEM_LOG_LENGTH - 1U)) ? len : (HIMEM_LOG_LENGTH - 1U);
    err = memcpy_s(logMsg.msg, HIMEM_LOG_LENGTH - 1U, buffer, msgLen);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "memcpy failed. err = %d, errno :%d", err, errno);

    return HiMemWrite(fd, (const char *)&logMsg, strlen(logMsg.msg) + LOGHEAD_LEN);
}

/**
 * @brief       : read log msg from himem and parse log
 * @param[in]   : fd        himem fd
 * @param[out]  : buffer    log msg
 * @param[in]   : len       read buffer length
 * @param[out]  : type      log type
 * @return      : ==SYS_ERROR failure; >=0 success, return msg length
 */
STATIC int32_t HiMemReadLog(int32_t fd, char* buffer, size_t len, LogHead *head)
{
    HimemLogMsg logMsg;
    int32_t ret = HiMemRead(fd, (char *)&logMsg, sizeof(HimemLogMsg));
    ONE_ACT_INFO_LOG(ret == 0, return 0, "read log length equal 0. ret = %d, errno :%d", ret, errno);
    ONE_ACT_ERR_LOG((ret < 0) || (ret < (int32_t)LOGHEAD_LEN), return SYS_ERROR,
                    "read log length less then log size. ret = %d, errno :%d", ret, errno);
    errno_t err = memset_s(buffer, len, 0, len);
    ONE_ACT_ERR_LOG(err != EOK, return SYS_ERROR, "memset failed. err = %d, errno :%d", err, errno);
    err = memcpy_s(buffer, len, logMsg.msg, (size_t)(long)ret - LOGHEAD_LEN);
    ONE_ACT_ERR_LOG(err != EOK, return SYS_ERROR, "memcpy failed. err = %d, errno :%d", err, errno);
    err = memcpy_s(head, LOGHEAD_LEN, &logMsg.head, LOGHEAD_LEN);
    ONE_ACT_ERR_LOG(err != EOK, return SYS_ERROR, "memcpy failed. err = %d, errno :%d", err, errno);
    return ret - (int32_t)LOGHEAD_LEN;
}

/**
 * @brief       : write log msg from iambuf to himem
 * @param[in]   : fd        himem fd
 * @param[in]   : logBuf    iam log msg
 * @return      : ==SYS_ERROR failure; ==SYS_OK success
 */
int32_t HiMemWriteIamLog(int32_t fd, RingBufferStat *logBuf)
{
    ONE_ACT_ERR_LOG(fd <= 0, return SYS_ERROR, "[input] fd=%d is invalid.", fd);
    ONE_ACT_ERR_LOG(((logBuf == NULL) || (logBuf->ringBufferCtrl == NULL)), return SYS_ERROR, "no log write to himem.");
    uint32_t count = 0;
    RingBufferCtrl *ringBufferCtrl = logBuf->ringBufferCtrl;

    int readRes = 0;
    static ReadContext readContext = { 0U, 0U, 0U }; // record read pointer, each time read from the last time
    if (readContext.readIdx == 0U) {
        LogBufReStart(logBuf->ringBufferCtrl, &readContext); // a process restart once
    }
    char buf[MSG_LENGTH];
    LogHead msgRes;
    while (true) {
        readRes = LogBufRead(&readContext, ringBufferCtrl, buf, MSG_LENGTH, &msgRes);
        if (readRes < 0) {
            NO_ACT_ERR_LOG((readRes != (-(int32_t)BUFFER_READ_FINISH)),
                           "HiMemWriteIamLog read err res = %d check", readRes);
            break;
        }
        if (readContext.lostCount != 0) {
            NO_ACT_ERR_LOG((readContext.lostCount != 0), "LogBufRead lost = %lu check", readContext.lostCount);
            readContext.lostCount = 0;
        }
        if (HiMemWriteLog(fd, buf, (uint32_t)msgRes.msgLength, &msgRes) == SYS_ERROR) {
            count++;
        }
    }
    NO_ACT_WARN_LOG(count > 0, "write log to himem loss %u log.", count);
    return SYS_OK;
}

/**
 * @brief       : read log msg frmm himem to iambuf
 * @param[in]   : fd        himem fd
 * @param[out]  : logBuf    iam log msg
 * @return      : ==0 failure; >=0 success
 */
uint32_t HiMemReadIamLog(int32_t fd, RingBufferStat *logBuf)
{
    ONE_ACT_ERR_LOG(fd <= 0, return 0, "[input] fd=%d is invalid.", fd);
    if ((logBuf == NULL) || (logBuf->ringBufferCtrl == NULL)) {
        return 0;
    }
    LogHead head;
    char msg[MSG_LENGTH];
    RingBufferCtrl *ringBufferCtrl = logBuf->ringBufferCtrl;
    uint32_t counts = 0;
    while (true) {
        int32_t len = HiMemReadLog(fd, msg, MSG_LENGTH, &head);
        if (len <= 0) {
            break;
        }
        head.msgLength = (uint16_t)len;
        int32_t writeRes = LogBufWrite(ringBufferCtrl, msg, &head, NULL);
        NO_ACT_ERR_LOG(writeRes < 0, "HiMemReadIamLog fail %d", writeRes);
        counts++;
    }
    SELF_LOG_INFO("read log node count: %u", counts);
    return counts;
}
