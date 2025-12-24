/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_hardware_zip.h"
#include "securec.h"
#include "log_print.h"
#include "zip_sdk.h"
#include "log_compress.h"
#include "log_file_info.h"

#if defined(HARDWARE_ZIP)

#define ZIP_RATIO           1U
#ifndef ST_GZIP_HEADER_SZ
#define ST_GZIP_HEADER_SZ   10U
#endif
#ifndef ST_GZIP_HEADER
#define ST_GZIP_HEADER      "\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\x03"
#endif
#define BLOCK_SIZE          1048576 // 1MB

/*
 * @brief       : compress deinit
 * @param [in]  : stream data struct
 * @return      : NA
 */
STATIC void HardwareCompressEnd(struct zip_stream *zipStream)
{
    int32_t ret = hw_deflateEnd(zipStream);
    if (ret != HZIP_OK) {
        SELF_LOG_ERROR("[input] zipStream deinit failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return;
    }
}

/*
 * @brief       : hardware zip init
 * @param [in]  : fd        zip file fd
 * @param [in]  : zipStream stream data struct
 * @return      : LOG_SUCCESS: succeed; others: failed;
 */
STATIC LogStatus HardwareCompressInit(int32_t fd, struct zip_stream *zipStream)
{
    /* deflate for gzip data */
    int32_t ret = hw_deflateInit2_(zipStream, HZIP_LEVEL_DEFAULT, HZIP_METHOD_DEFAULT, HZIP_WINDOWBITS_GZIP,
                                   HZIP_MEM_LEVEL_DEFAULT, HZIP_STRATEGY_DEFAULT, HZIP_VERSION,
                                   (int32_t)sizeof(struct zip_stream));
    if (ret != HZIP_OK) {
        SELF_LOG_ERROR("[input] zipStream init failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // write head data to file
    int32_t bytes = ToolWrite(fd, ST_GZIP_HEADER, ST_GZIP_HEADER_SZ); // write log data
    if (bytes == INVALID) {
        SELF_LOG_ERROR("write gzip head to file failed, result=%d, strerr=%s.", bytes, strerror(ToolGetErrorCode()));
        HardwareCompressEnd(zipStream);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC LogStatus HardwareCompressBufferInit(struct zip_stream *zipStream, char *dest, uint32_t destTotalLen)
{
    /* deflate for gzip data */
    int32_t ret = hw_deflateInit2_(zipStream, HZIP_LEVEL_DEFAULT, HZIP_METHOD_DEFAULT, HZIP_WINDOWBITS_GZIP,
                                   HZIP_MEM_LEVEL_DEFAULT, HZIP_STRATEGY_DEFAULT, HZIP_VERSION,
                                   (int32_t)sizeof(struct zip_stream));
    if (ret != HZIP_OK) {
        SELF_LOG_ERROR("[input] zipStream init failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // write head data to buffer
    ret = memcpy_s(dest, (size_t)destTotalLen - 1U, ST_GZIP_HEADER, ST_GZIP_HEADER_SZ);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, ret=%d.", ret);
        HardwareCompressEnd(zipStream);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/*
 * @brief       : source data copy to zip stream
 * @param [in]  : source        origin buffer
 * @param [in]  : sourceLen     origin buffer length
 * @param [out] : zipStream     zip stream data struct
 * @return      : data copy length, if failed, return INVALID(-1)
 */
STATIC int32_t HardwareSrcDataCopy(const char *source, int32_t *sourceLen, struct zip_stream *zipStream)
{
    errno_t ret = EOK;
    int32_t length = INVALID;
    if (*sourceLen <= 0) {
        SELF_LOG_WARN("input is invalid, sourceLen=%u.", *sourceLen);
        return INVALID;
    }

    if (*sourceLen > BLOCK_SIZE) {
        ret = memcpy_s(zipStream->next_in, BLOCK_SIZE, source, BLOCK_SIZE);
        if (ret != EOK) {
            SELF_LOG_ERROR("memcpy failed, ret=%d.", (int32_t)ret);
            return INVALID;
        }
        length = BLOCK_SIZE;
        zipStream->avail_in = BLOCK_SIZE;
        *sourceLen -= BLOCK_SIZE;
    } else {
        ret = memcpy_s(zipStream->next_in, (size_t)*sourceLen, source, (size_t)*sourceLen);
        if (ret != EOK) {
            SELF_LOG_ERROR("memcpy failed, ret=%d.", (int32_t)ret);
            return INVALID;
        }
        length = (int32_t)(*sourceLen);
        zipStream->avail_in = (unsigned long)length;
        *sourceLen = 0;
    }
    return length;
}

/*
 * @brief       : compress <source> to <dest>
 * @param [in]  : zipStream     origin buffer length
 * @param [in]  : flush         flush flag
 * @param [out] : dest          ptr point to output buffer
 * @param [out] : destAvailLen  available output buffer length
 * @return      : compress data length, if failed, return INVALID(-1)
 */
STATIC int32_t HardwareZipProcess(struct zip_stream *zipStream, int32_t flush, char *dest, size_t destAvailLen)
{
    zipStream->avail_out = BLOCK_SIZE;
    int32_t ret = hw_deflate(zipStream, flush);
    if ((ret != HZIP_OK) && (ret != HZIP_STREAM_END)) {
        SELF_LOG_ERROR("hw_deflate failed, flush=%d, ret=%d, strerr=%s.", flush, ret, strerror(ToolGetErrorCode()));
        return INVALID;
    }

    if (zipStream->avail_out >= (uint64_t)BLOCK_SIZE) {
        SELF_LOG_WARN("hw_deflate wrong, avail_out=%ld", zipStream->avail_out);
        return INVALID;
    }

    int32_t length = BLOCK_SIZE - (int32_t)zipStream->avail_out;

    if ((length < 0) || (destAvailLen < (size_t)length)) {
        SELF_LOG_WARN("hw_deflate wrong, length = %d, avail out=%ld, destAvailLen=%zu",
            length, zipStream->avail_out, destAvailLen);
        return INVALID;
    }

    ret = memcpy_s(dest, destAvailLen, zipStream->next_out, (size_t)length);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, ret=%d, destAvailLen=%zu, length=%d.", ret, destAvailLen, length);
        return INVALID;
    }
    return length;
}

/*
 * @brief       : hardware zip from in to out
 * @param [in]  : in        source log file fd
 * @param [in]  : fileSize  source log file size
 * @param [in]  : out       dest zip file fd
 * @return      : LOG_SUCCESS: succeed; others: failed;
 */
STATIC LogStatus HardwareCompressProc(int32_t in, uint32_t fileSize, int32_t out)
{
    struct zip_stream zipStream = { 0 };
    ONE_ACT_ERR_LOG(HardwareCompressInit(out, &zipStream) != LOG_SUCCESS, return LOG_FAILURE, "hardware init failed.");
    char *buf = (char *)LogMalloc(BLOCK_SIZE);
    size_t zippedBufLen = (uint32_t)BLOCK_SIZE << ZIP_RATIO;
    char *zippedBuf = (char *)LogMalloc(zippedBufLen);
    if ((buf == NULL) || (zippedBuf == NULL)) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        XFREE(buf);
        XFREE(zippedBuf);
        return LOG_FAILURE;
    }

    LogStatus ret = LOG_SUCCESS;
    uint32_t size = fileSize;
    do {
        (void)memset_s(buf, BLOCK_SIZE, 0, BLOCK_SIZE);
        (void)memset_s(zippedBuf, zippedBufLen, 0, zippedBufLen);

        int32_t len = ToolRead(in, buf, BLOCK_SIZE);
        if (len < 0) {
            SELF_LOG_ERROR("fread failed, strerr=%s.", strerror(ToolGetErrorCode()));
            ret = LOG_FAILURE;
            break;
        }
        if (len == 0) {
            break;
        }
        size = size - (uint32_t)len;
        int32_t length = HardwareSrcDataCopy(buf, &len, &zipStream);
        if (length == INVALID) {
            SELF_LOG_ERROR("copy src data failed, strerr=%s.", strerror(ToolGetErrorCode()));
            ret = LOG_FAILURE;
            break;
        }
        int32_t flush = (size > 0) ? HZIP_FLUSH_TYPE_SYNC_FLUSH : HZIP_FLUSH_TYPE_FINISH;
        int32_t dataLen = HardwareZipProcess(&zipStream, flush, zippedBuf, zippedBufLen);
        if (dataLen == INVALID) {
            ret = LOG_FAILURE;
            break;
        }
        int32_t bytes = ToolWrite(out, zippedBuf, dataLen); // write log data
        if (bytes == INVALID) {
            SELF_LOG_ERROR("write log data failed, dataLen=%d, writen=%d, strerr=%s.", dataLen, bytes,
                           strerror(ToolGetErrorCode()));
            ret = LOG_FAILURE;
            break;
        }
    } while (ret == LOG_SUCCESS);
    HardwareCompressEnd(&zipStream);
    XFREE(buf);
    XFREE(zippedBuf);
    return ret;
}

/*
 * @brief       : hardware zip file
 * @param [in]  : file      source log file
 * @return      : LOG_SUCCESS: succeed; others: failed;
 */
LogStatus HardwareCompressFile(const char *file)
{
    ONE_ACT_ERR_LOG(file == NULL, return LOG_FAILURE, "[input] file is invalid.");
    size_t length = strlen(file);
    if ((length == 0) || (length >= MAX_FILEPATH_LEN) || (length + strlen(GZIP_SUFFIX)) >= GZIP_MAX_NAME_LEN) {
        SELF_LOG_ERROR("filename too long: %zu.", length);
        return LOG_FAILURE;
    }

    char outfile[GZIP_MAX_NAME_LEN] = {0};
    int32_t ret = snprintf_s(outfile, GZIP_MAX_NAME_LEN, GZIP_MAX_NAME_LEN - 1U, "%s%s", file, GZIP_SUFFIX);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s filename failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    int32_t in = ToolOpenWithMode(file, O_RDONLY, LOG_FILE_ARCHIVE_MODE);
    ONE_ACT_WARN_LOG(in < 0, return LOG_FAILURE,
                     "open %s failed, strerr=%s.", file, strerror(ToolGetErrorCode()));

    int32_t out = ToolOpenWithMode(outfile, (uint32_t)O_CREAT | (uint32_t)O_WRONLY, LOG_FILE_RDWR_MODE);
    if (out < 0) {
        SELF_LOG_ERROR("can't open %s, strerr=%s.", outfile, strerror(ToolGetErrorCode()));
        (void)ToolClose(in);
        return LOG_FAILURE;
    }
    ToolStat statbuff = { 0 };
    if (ToolStatGet(file, &statbuff) != SYS_OK) {
        (void)ToolClose(in);
        (void)ToolClose(out);
        (void)ToolUnlink(outfile);
        return LOG_FAILURE;
    }
    LogStatus err = HardwareCompressProc(in, (uint32_t)statbuff.st_size, out);
    (void)ToolClose(in);
    (void)ToolClose(out);
    if (err != LOG_SUCCESS) {
        NO_ACT_ERR_LOG(ToolUnlink(outfile) != LOG_SUCCESS, "can not unlink file, file=%s, strerr=%s.",
                       outfile, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    } else {
        NO_ACT_WARN_LOG(ToolUnlink(file) != LOG_SUCCESS, "can not unlink file, file=%s, strerr=%s.",
                        file, strerror(ToolGetErrorCode()));
        return LOG_SUCCESS;
    }
}

LogStatus HardwareCompressBuffer(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen)
{
    ONE_ACT_WARN_LOG(source == NULL, return LOG_INVALID_PTR, "compress source is invalid.");
    ONE_ACT_WARN_LOG(dest == NULL, return LOG_INVALID_PTR, "compress dest is invalid.");
    ONE_ACT_WARN_LOG(destLen == NULL, return LOG_INVALID_PTR, "compress destLen is invalid.");
    ONE_ACT_WARN_LOG((sourceLen == 0) || (sourceLen > INT_MAX), return LOG_INVALID_PARAM,
        "compress sourceLen[%u] is invalid.", sourceLen);

    uint32_t destTotalLen = sourceLen << ZIP_RATIO;
    *dest = (char *)LogMalloc(destTotalLen);
    if (*dest == NULL) {
        SELF_LOG_ERROR("malloc for dest failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    struct zip_stream zipStream = { 0 };
    LogStatus ret = HardwareCompressBufferInit(&zipStream, *dest, destTotalLen);
    if (ret != LOG_SUCCESS) {
        XFREE(*dest);
        return LOG_FAILURE;
    }
    char *dstTmp = *dest + ST_GZIP_HEADER_SZ;
    *destLen = ST_GZIP_HEADER_SZ;
    destTotalLen -= ST_GZIP_HEADER_SZ;
    int32_t flush = HZIP_FLUSH_TYPE_SYNC_FLUSH;
    int32_t sourceLenTmp = (int32_t)sourceLen;

    do {
        int32_t length = HardwareSrcDataCopy(source, &sourceLenTmp, &zipStream);
        if (length == INVALID) {
            ret = LOG_FAILURE;
            break;
        }
        ONE_ACT_NO_LOG(length == BLOCK_SIZE, (source += BLOCK_SIZE));
        flush = (sourceLenTmp != 0) ? HZIP_FLUSH_TYPE_SYNC_FLUSH : HZIP_FLUSH_TYPE_FINISH;
        length = HardwareZipProcess(&zipStream, flush, dstTmp, destTotalLen);
        if (length == INVALID) {
            ret = LOG_FAILURE;
            break;
        }
        dstTmp += length;
        *destLen += (uint32_t)length;
    } while (flush != HZIP_FLUSH_TYPE_FINISH);
    HardwareCompressEnd(&zipStream);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, XFREE(*dest), "compress failed.");
    return ret;
}

#endif // HARDWARE_ZIP