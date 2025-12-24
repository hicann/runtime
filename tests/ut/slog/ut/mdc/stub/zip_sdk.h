/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ZIP_SDK_H
#define ZIP_SDK_H
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief ZIP MACRO
 */
#define HZIP_LEVEL_DEFAULT          0
#define HZIP_VERSION                "1.0.1"
#define HZIP_METHOD_DEFAULT         0
#define HZIP_WINDOWBITS_GZIP        16
#define HZIP_MEM_LEVEL_DEFAULT      0
#define HZIP_STRATEGY_DEFAULT       0
#define HZIP_FLUSH_TYPE_SYNC_FLUSH  2
#define HZIP_FLUSH_TYPE_FINISH      3
#define HZIP_OK                     0
#define HZIP_STREAM_END             1
#define HZIP_STREAM_NEED_AGAIN      2

/**
 * @brief ZIP
 */
enum ZipErrorCode {
    /* Additional error codes may be extented after -1200 to avoid code collision */
    ZIP_ERROR_UNKNOWN_ERROR = -1200,
    ZIP_ERROR_SECMGR_ZIP_UNSUPPORT = -1201, // add for zip_hwacce not support
};

/**
 * @brief zip stream param
 */
struct zip_stream {
    void            *next_in;   /**< next input byte */
    unsigned long   avail_in;   /**< number of bytes available at next_in */
    unsigned long   total_in;   /**< total nb of input bytes read so far */
    void            *next_out;  /**< next output byte should be put there */
    unsigned long   avail_out;  /**< remaining free space at next_out */
    unsigned long   total_out;  /**< total nb of bytes output so far */
    char            *msg;       /**< last error message, NULL if no error */
    void            *workspace; /**< memory allocated for this stream */
    int             data_type;  /**< the data type: ascii or binary */
    unsigned long   adler;      /**< adler32 value of the uncompressed data */
    void            *reserved;  /**< reserved for future use */
};

/**
 * @brief zlib deflate init
 * @attention null
 * @param [out] zstrm   zip stream
 * @param [in] level    HZIP_LEVEL_DEFAULT
 * @param [in] version  HZIP_VERSION
 * @param [in] stream_size  size of zstrm
 * @return   HZIP_OK   success
 * @return   other  fail
 */
int hw_deflateInit_(struct zip_stream *zstrm, int level, const char *version, int stream_size);

/**
 * @brief gzip deflate init
 * @attention null
 * @param [out] zstrm  zip stream
 * @param [in] level   HZIP_LEVEL_DEFAULT
 * @param [in] method  HZIP_METHOD_DEFAULT
 * @param [in] windowBits  HZIP_WINDOWBITS_GZIP
 * @param [in] memLevel HZIP_MEM_LEVEL_DEFAULT
 * @param [in] strategy HZIP_STRATEGY_DEFAULT
 * @param [in] version  HZIP_VERSION
 * @param [in] stream_size  size of zstrm
 * @return   HZIP_OK   success
 * @return   other  fail
 */
int hw_deflateInit2_(struct zip_stream *zstrm, int level, int method, int windowBits,
                     int memLevel, int strategy, const char *version, int stream_size);

/**
 * @brief deflat data
 * @attention null
 * @param [in] zstrm  zip stream
 * @param [in] flush  HZIP_FLUSH_TYPE_SYNC_FLUSH/HZIP_FLUSH_TYPE_FINISH
 * @return   HZIP_OK   success
 * @return   HZIP_STREAM_END   stream end
 * @return   HZIP_STREAM_NEED_AGAIN  need again
 * @return   other  fail
 */
int hw_deflate(struct zip_stream *zstrm, int flush);

/**
 * @brief deflate end
 * @attention null
 * @param [in] zstrm  zip stream
 * @return   HZIP_OK   sucess
 * @return   other  fail
 */
int hw_deflateEnd(struct zip_stream *zstrm);

/**
 * @brief zlib deflate init
 * @attention null
 * @param [out] zstrm  zip stream
 * @param [in] version  HZIP_VERSION
 * @param [in] stream_size  size of zstrm
 * @return   HZIP_OK   success
 * @return   other  fail
 */
int hw_inflateInit_(struct zip_stream *zstrm, const char *version, int stream_size);

/**
 * @brief gzip inflate init
 * @attention null
 * @param [out] zstrm  zip stream
 * @param [in] windowBits  HZIP_WINDOWBITS_GZIP
 * @param [in] version  HZIP_VERSION
 * @param [in] stream_size  size of zstrm
 * @return   HZIP_OK   success
 * @return   other  fail
 */
int hw_inflateInit2_(struct zip_stream *zstrm, int windowBits, const char *version, int stream_size);

/**
 * @brief inflate data
 * @attention null
 * @param [in] zstrm  zip stream
 * @param [in] flush  HZIP_FLUSH_TYPE_SYNC_FLUSH/HZIP_FLUSH_TYPE_FINISH
 * @return   HZIP_OK   success
 * @return   HZIP_STREAM_END   stream end
 * @return   HZIP_STREAM_NEED_AGAIN  need again
 * @return   other  fail
 */
int hw_inflate(struct zip_stream *zstrm, int flush);

/**
 * @brief inflate end
 * @attention null
 * @param [in] zstrm  zip stream
 * @return   HZIP_OK   sucess
 * @return   other  fail
 */
int hw_inflateEnd(struct zip_stream *zstrm);

#ifdef __cplusplus
}
#endif

#endif
