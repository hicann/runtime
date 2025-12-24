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

#include "secinput.h"

#include "input.inl"

SECUREC_INLINE int SecIsDigit(SecInt ch)
{
    /* SecInt to unsigned char clear  571, use bit mask to clear negative return of ch */
    return isdigit((int)((unsigned int)(unsigned char)(ch) & 0xffU));
}
SECUREC_INLINE int SecIsXdigit(SecInt ch)
{
    return isxdigit((int)((unsigned int)(unsigned char)(ch) & 0xffU));
}
SECUREC_INLINE int SecIsSpace(SecInt ch)
{
    return isspace((int)((unsigned int)(unsigned char)(ch) & 0xffU));
}

