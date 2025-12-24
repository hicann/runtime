/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#if defined(SOFTWARE_ZIP)

#include "log_software_zip.h"
#include <zlib.h>
#include <stdio.h>
#include "log_compress.h"
#include "log_print.h"
#include "securec.h"
#include "log_system_api.h"
#include "log_file_info.h"

STATIC INLINE LogStatus GzCloseFile(gzFile gz)
{
    if (gzclose(gz) != Z_OK) {
        SELF_LOG_ERROR("gzclose failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC LogStatus GzCompress(FILE *in, gzFile out)
{
    char *buf = (char *)LogMalloc(GZIP_BUFLEN);
    if (buf == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    while (feof(in) == 0) {
        int32_t len = (int32_t)fread(buf, 1, GZIP_BUFLEN, in);
        if (ferror(in) != 0) {
            SELF_LOG_ERROR("fread failed, strerr=%s.", strerror(ToolGetErrorCode()));
            XFREE(buf);
            return LOG_FAILURE;
        }

        if (gzwrite(out, buf, (unsigned)len) != len) {
            SELF_LOG_ERROR("gzwrite failed, strerr=%s.", strerror(ToolGetErrorCode()));
            XFREE(buf);
            return LOG_FAILURE;
        }
    }
    XFREE(buf);
    return LOG_SUCCESS;
}

LogStatus SoftwareCompressFile(const char *file)
{
    ONE_ACT_ERR_LOG(file == NULL, return LOG_FAILURE, "[input] file is invalid.");

    size_t length = strlen(file);
    if ((length == 0) || (length >= MAX_FILEPATH_LEN) || (length + strlen(GZIP_SUFFIX)) >= GZIP_MAX_NAME_LEN) {
        SELF_LOG_ERROR("filename too long: %u.", length);
        return LOG_FAILURE;
    }

    char outfile[GZIP_MAX_NAME_LEN] = {0};
    int32_t ret = snprintf_s(outfile, GZIP_MAX_NAME_LEN, GZIP_MAX_NAME_LEN - 1U, "%s%s", file, GZIP_SUFFIX);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s filename failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    FILE *in = fopen(file, "rb");
    ONE_ACT_WARN_LOG(in == NULL, return LOG_FAILURE,
                     "open %s failed, strerr=%s.", file, strerror(ToolGetErrorCode()));

    gzFile out = gzopen(outfile, "wb");
    if (out == NULL) {
        SELF_LOG_ERROR("can't open %s, strerr=%s.", outfile, strerror(ToolGetErrorCode()));
        (void)fclose(in);
        return LOG_FAILURE;
    }

    int32_t err = GzCompress(in, out);
    (void)fclose(in);
    (void)GzCloseFile(out);
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

#endif
