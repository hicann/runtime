/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/* If some platforms don't have wchar.h, don't include it */
#if !(defined(SECUREC_VXWORKS_PLATFORM))
/* If there is no macro below, it will cause vs2010 compiling alarm */
#if defined(_MSC_VER) && (_MSC_VER >= 1400)
#ifndef __STDC_WANT_SECURE_LIB__
/* The order of adjustment is to eliminate alarm of Duplicate Block */
#define __STDC_WANT_SECURE_LIB__ 0
#endif
#ifndef _CRTIMP_ALTERNATIVE
#define _CRTIMP_ALTERNATIVE     /* Comment microsoft *_s function */
#endif
#endif
#include <wchar.h>
#endif

/* Disable wchar func to clear vs warning */
#define SECUREC_ENABLE_WCHAR_FUNC       0
#define SECUREC_FORMAT_OUTPUT_INPUT     1

#ifndef SECUREC_FOR_WCHAR
#define SECUREC_FOR_WCHAR
#endif

#include "secinput.h"

#include "input.inl"

SECUREC_INLINE unsigned int SecWcharHighBits(SecInt ch)
{
    /* Convert int to unsigned int clear 571 */
    return ((unsigned int)(int)ch & (~0xffU));
}

SECUREC_INLINE unsigned char SecWcharLowByte(SecInt ch)
{
    /* Convert int to unsigned int clear 571 */
    return (unsigned char)((unsigned int)(int)ch & 0xffU);
}

SECUREC_INLINE int SecIsDigit(SecInt ch)
{
    if (SecWcharHighBits(ch) != 0) {
        return 0; /* Same as isdigit */
    }
    return isdigit((int)SecWcharLowByte(ch));
}

SECUREC_INLINE int SecIsXdigit(SecInt ch)
{
    if (SecWcharHighBits(ch) != 0) {
        return 0; /* Same as isxdigit */
    }
    return isxdigit((int)SecWcharLowByte(ch));
}

SECUREC_INLINE int SecIsSpace(SecInt ch)
{
    return iswspace((wint_t)(int)(ch));
}

