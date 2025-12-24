/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#define SECUREC_FORMAT_OUTPUT_INPUT 1

#ifdef SECUREC_FOR_WCHAR
#undef SECUREC_FOR_WCHAR
#endif

#include "secureprintoutput.h"
#if SECUREC_WARP_OUTPUT
#define SECUREC_FORMAT_FLAG_TABLE_SIZE 128
SECUREC_INLINE const char *SecSkipKnownFlags(const char *format)
{
    static const unsigned char flagTable[SECUREC_FORMAT_FLAG_TABLE_SIZE] = {
        /*
         * Known flag is  "0123456789 +-#hlLwZzjqt*I$"
         */
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x01, 0x00, 0x00,
        0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00,
        0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
    };
    const char *fmt = format;
    while (*fmt != '\0') {
        char fmtChar = *fmt;
        if ((unsigned char)fmtChar > 0x7f) { /* 0x7f is upper limit of format char value */
            break;
        }
        if (flagTable[(unsigned char)fmtChar] == 0) {
            break;
        }
        ++fmt;
    }
    return fmt;
}

SECUREC_INLINE int SecFormatContainN(const char *format)
{
    const char *fmt = format;
    while (*fmt != '\0') {
        ++fmt;
        /* Skip normal char */
        if (*(fmt - 1) != '%') {
            continue;
        }
        /* Meet %% */
        if (*fmt == '%') {
            ++fmt; /* Point to  the character after the %. Correct handling %%xx */
            continue;
        }
        /* Now parse %..., fmt point to the character after the % */
        fmt = SecSkipKnownFlags(fmt);
        if (*fmt == 'n') {
            return 1;
        }
    }
    return 0;
}
/*
 * Multi character formatted output implementation, the count include \0 character, must be greater than zero
 */
int SecVsnprintfImpl(char *string, size_t count, const char *format, va_list argList)
{
    int retVal;
    if (SecFormatContainN(format) != 0) {
        string[0] = '\0';
        return -1;
    }
    SECUREC_MASK_VSPRINTF_WARNING
    retVal = vsnprintf(string, count, format, argList);
    SECUREC_END_MASK_VSPRINTF_WARNING
    if (retVal >= (int)count) { /* The size_t to int is ok, count max is SECUREC_STRING_MAX_LEN */
        /* The buffer was too small; we return truncation */
        string[count - 1] = '\0';
        return SECUREC_PRINTF_TRUNCATE;
    }
    if (retVal < 0) {
        string[0] = '\0'; /* Empty the dest strDest */
        return -1;
    }
    return retVal;
}
#else
#if SECUREC_IN_KERNEL
#include <linux/ctype.h>
#endif

#ifndef EOF
#define EOF (-1)
#endif

#include "output.inl"

#endif

