/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string.h>
#include <stdio.h>

int g_sprintf_s_flag = 0;

#ifdef __cplusplus
extern "C" {
#endif

int memset_s(void *dest, int dest_max, int c, int count)
{
    memset(dest, 0, count);
    return 0;
}

int memcpy_s(void *dest, int dest_max, const void *src, int count)
{
    memcpy(dest, src, count);
    return 0;
}

int sprintf_s(char* strDest, int destMax,const char* format, const char* src)
{
    int ret = 0;

    if (g_sprintf_s_flag == 0) {
        ret = sprintf(strDest, format, src);
        return 0;
    } else if (g_sprintf_s_flag == 2) {
        ret = sprintf(strDest, format, src);
        return ret;
    } else { // g_sprintf_s_flag = 1 compatible with old code
        return -1;
    }
}

int strcpy_s(char* strDest,int dest_max,const char* strSrc)
{
    strcpy(strDest,strSrc);
    return 0;
}

int strcat_s(char* dest, int dest_max, const char* src)
{
    strcat(dest,src);
    return 0;

}

int strtok_s(char* strToken, const char* strDelimit, char** context)
{
    strtok(strToken,strDelimit);
    return 0;
}

int vsnprintf_s(char *strDest, size_t destMax, size_t count, const char *format, va_list argList)
{
    return 0;
}

#ifdef __cplusplus
}
#endif
