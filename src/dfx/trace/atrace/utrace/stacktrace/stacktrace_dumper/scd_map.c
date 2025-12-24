/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_map.h"
#include "scd_log.h"
#include "adiag_utils.h"

uintptr_t ScdMapGetRelPc(ScdMap *map, uintptr_t absPc)
{
    return absPc - (map->start - map->offset) + map->dl.elf.memory->data + map->dl.elf.loadBias;
}

uintptr_t ScdMapGetBase(ScdMap *map)
{
    return map->start - (uintptr_t)map->offset;
}

/**
 * @brief       update map node based on start addr and end addr
 * @param [in]  map:        map node
 * @param [in]  start:      start addr
 * @param [in]  end:        end addr
 * @param [in]  offset:     offset
 * @return      NA
 */
TraStatus ScdMapUpdata(ScdMap *map, uintptr_t start, uintptr_t end, size_t offset)
{
    SCD_CHK_PTR_ACTION(map, return TRACE_FAILURE);
    if ((map->end != start) && (map->start != end)) {
        return TRACE_FAILURE;
    }

    map->start  = SCD_MIN(start, map->start);
    map->end    = SCD_MAX(end, map->end);
    map->offset = SCD_MIN(offset, map->offset);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdMapInit(ScdMap *map, uintptr_t start, uintptr_t end, size_t offset, const char *name)
{
    // obtain the data from the file.
    // fault tolerance processing will be added later : if failed from the file, use the ptrace to obtain the data
    SCD_CHK_PTR_ACTION(name, return TRACE_FAILURE);

    // map
    map->name = strdup(name);
    SCD_CHK_PTR_ACTION(map->name, return TRACE_FAILURE);

    map->nameLength = strlen(name);
    map->start = start;
    map->end = end;
    map->offset = offset;

    // dl
    TraStatus ret = ScdDlInit(&map->dl);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("dl[%s] init failed.", name);
        ADIAG_SAFE_FREE(map->name);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC void ScdMapUninit(ScdMap *map)
{
    SCD_CHK_PTR_ACTION(map, return);
    ScdDlUninit(&map->dl);
    ADIAG_SAFE_FREE(map->name);
}

/**
 * @brief       create map node
 * @param [in]  start:      start addr
 * @param [in]  end:        end addr
 * @param [in]  offset:     offset
 * @param [in]  name:       dynamic library name
 * @return      ScdMap *
 */
ScdMap *ScdMapCreate(uintptr_t start, uintptr_t end, size_t offset, const char *name)
{
    ScdMap *map = (ScdMap *)AdiagMalloc(sizeof(ScdMap)); 
    if (map != NULL) {
        TraStatus ret = ScdMapInit(map, start, end, offset, name);
        if (ret != TRACE_SUCCESS) {
            SCD_DLOG_ERR("init map in %s failed, ret = %d", name, ret);
            ADIAG_SAFE_FREE(map);
        }
    }
    return map;
}

/**
 * @brief       destroy a map node
 * @param [in]  map:        a map node
 * @return      NA
 */
void ScdMapDestroy(ScdMap **map)
{
    SCD_CHK_PTR_ACTION(map, return);
    ScdMapUninit(*map);
    ADIAG_SAFE_FREE(*map);
}