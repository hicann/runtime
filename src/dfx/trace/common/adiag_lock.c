/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adiag_lock.h"

/**
 * @brief       initial lock
 * @param [in]  lock:   lock pointer
 * @return      AdiagStatus
 */
AdiagStatus AdiagLockInit(AdiagLock *lock)
{
    return (mmMutexInit(lock) == EN_OK) ? ADIAG_SUCCESS : ADIAG_FAILURE;
}

/**
 * @brief       destroy lock
 * @param [in]  lock:   lock pointer
 * @return      AdiagStatus
 */
AdiagStatus AdiagLockDestroy(AdiagLock *lock)
{
    return (mmMutexDestroy(lock) == EN_OK) ? ADIAG_SUCCESS : ADIAG_FAILURE;
}

/**
 * @brief       lock
 * @param [in]  lock:   lock pointer
 * @return      AdiagStatus
 */
AdiagStatus AdiagLockGet(AdiagLock *lock)
{
    return (mmMutexLock(lock) == EN_OK) ? ADIAG_SUCCESS : ADIAG_FAILURE;
}

/**
 * @brief       unlock
 * @param [in]  lock:   lock pointer
 * @return      AdiagStatus
 */
AdiagStatus AdiagLockRelease(AdiagLock *lock)
{
    return (mmMutexUnLock(lock) == EN_OK) ? ADIAG_SUCCESS : ADIAG_FAILURE;
}

