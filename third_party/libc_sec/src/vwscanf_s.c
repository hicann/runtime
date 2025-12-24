/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SECUREC_FOR_WCHAR
#define SECUREC_FOR_WCHAR
#endif

#include "secinput.h"

/*
 * <FUNCTION DESCRIPTION>
 *    The  vwscanf_s  function  is  the  wide-character  equivalent  of the vscanf_s function
 *    The vwscanf_s function is the wide-character version of vscanf_s. The
 *    function reads data from the standard input stream stdin and writes the
 *    data into the location that's given by argument. Each argument  must be a
 *    pointer to a variable of a type that corresponds to a type specifier in
 *    format. If copying occurs between strings that overlap, the behavior is
 *    undefined.
 *
 * <INPUT PARAMETERS>
 *    format                 Format control string.
 *    argList                pointer to list of arguments
 *
 * <OUTPUT PARAMETERS>
 *    argList                the converted value stored in user assigned address
 *
 * <RETURN VALUE>
 *    Returns the number of fields successfully converted and assigned;
 *    the return value does not include fields that were read but not assigned.
 *    A return value of 0 indicates that no fields were assigned.
 *    return -1 if an error occurs.
 */
int vwscanf_s(const wchar_t *format, va_list argList)
{
    int retVal;                 /* If initialization causes  e838 */
    SecFileStream fStr;
    SECUREC_FILE_STREAM_FROM_STDIN(&fStr);
    if (format == NULL || fStr.pf == NULL) {
        SECUREC_ERROR_INVALID_PARAMTER("vwscanf_s");
        return SECUREC_SCANF_EINVAL;
    }

    SECUREC_LOCK_STDIN(0, fStr.pf);
    retVal = SecInputSW(&fStr, format, argList);
    SECUREC_UNLOCK_STDIN(0, fStr.pf);
    if (retVal < 0) {
        SECUREC_ERROR_INVALID_PARAMTER("vwscanf_s");
        return SECUREC_SCANF_EINVAL;
    }

    return retVal;
}

