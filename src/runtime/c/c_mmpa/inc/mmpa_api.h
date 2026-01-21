/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef C_MMPA_MMPA_API_H
#define C_MMPA_MMPA_API_H

#define LINUX 0
#define LITEOS 1

#if(NANO_OS_TYPE == LINUX) //lint !e553
#include "mmpa_linux.h"
#endif

#if(NANO_OS_TYPE == LITEOS) //lint !e553
#if defined(CPU_HIFI3Z) && CPU_HIFI3Z
#include "mmpa_dsp.h"
#else
#include "mmpa_liteos.h"
#endif
#endif
#endif // C_MMPA_MMPA_API_H