/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_dl.h"
#include "scd_elf.h"
#include "scd_log.h"
#include "adiag_utils.h"

STATIC TraStatus ScdDlMmap(ScdDl *dl, const char *dlName)
{
    // open file
    int32_t fd = ScdUtilOpen(dlName);
    SCD_CHK_EXPR_ACTION(fd < 0, return TRACE_FAILURE, "open %s failed.", dlName);

    // get file size
    struct stat st = {0};
    int32_t ret = fstat(fd, &st);
    if ((ret != 0) || (st.st_size == 0)) {
        SCD_DLOG_ERR("get file[%s] size failed, ret = %d, errno = %s.", dlName, ret, strerror(AdiagGetErrorCode()));
        (void)close(fd);
        return TRACE_FAILURE;
    }
    ScdMemoryInitLocal(&dl->memory);
    // mmap the file
    void *mapAddr = mmap(NULL, (size_t)st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (mapAddr == MAP_FAILED) {
        SCD_DLOG_ERR("mmap file[%s] failed, errno = %s.", dlName, strerror(AdiagGetErrorCode()));
        (void)close(fd);
        return TRACE_FAILURE;
    }
    SCD_DLOG_INF("map so %s to %p, size %zu", dlName, dl->memory.data, st.st_size);
    dl->fd = fd;
    dl->memory.data = (uintptr_t)mapAddr;
    dl->memory.size = (size_t)st.st_size; 
    return TRACE_SUCCESS;
}

STATIC void ScdDlMunmap(ScdDl *dl)
{
    if (dl->memory.data != 0) {
        (void)munmap((void *)dl->memory.data, dl->memory.size);
        dl->memory.data = 0;
        dl->memory.size = 0;
    }
    
    if (dl->fd >= 0) {
        (void)close(dl->fd);
        dl->fd = -1;
    }
}

/**
 * @brief       load dynamic library info
 * @param [in]  dl:        dynamic library info
 * @param [in]  pid:       process id
 * @param [in]  dlName:    dynamic library name
 * @return      TraStatus
 */
TraStatus ScdDlLoad(ScdDl *dl, int32_t pid, const char *dlName)
{
    SCD_CHK_PTR_ACTION(dl, return TRACE_FAILURE);
    if (dl->elfLoaded) {
        return TRACE_SUCCESS;
    }

    TraStatus ret = ScdDlMmap(dl, dlName);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = ScdElfLoad(&dl->elf, pid, &dl->memory);
    if (ret != TRACE_SUCCESS) {
        ScdDlMunmap(dl);
        return TRACE_FAILURE;
    }
    dl->elfLoaded = true;
    dl->pid = pid;
    SCD_RLOG_INF("load %s successfully.", dlName);
    return TRACE_SUCCESS;
}

/**
 * @brief       init dynamic library info
 * @param [in]  dl:        dynamic library info
 * @return      TraStatus
 */
TraStatus ScdDlInit(ScdDl *dl)
{
    dl->pid = 0;
    dl->fd = -1;
    dl->memory.data = 0;
    dl->memory.size = 0;
    dl->elfLoaded = false;
    return ScdElfInit(&dl->elf);
}

/**
 * @brief       uninit dynamic library info
 * @param [in]  dl:        dynamic library info
 * @return      NA
 */
void ScdDlUninit(ScdDl *dl)
{
    if (dl->elfLoaded) {
        dl->elfLoaded = false;
        ScdElfUninit(&dl->elf);
    }
    ScdDlMunmap(dl);
    return;
}
