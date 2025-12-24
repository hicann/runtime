/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_maps.h"
#include "scd_map.h"
#include "scd_log.h"
#include "adiag_list.h"
#include "scd_util.h"
#include "atrace_types.h"
#include "trace_system_api.h"

#define SCD_MAPS_BUF_LEN     512U

STATIC ScdMaps g_maps;

ScdMaps *ScdMapsGet(void)
{
    return &g_maps;
}

STATIC TraStatus ScdMapsCmpName(const void *nodeData, const void *data)
{
    const ScdMap *node = (const ScdMap *)nodeData;
    const char *name = (const char *)data;
    if (strcmp(node->name, name) == 0) {
        return TRACE_SUCCESS;
    }
    return TRACE_FAILURE;
}

STATIC ScdMap *ScdMapsGetMapByName(ScdMaps *maps, const char *name)
{
    return AdiagListForEach(&maps->mapList, ScdMapsCmpName, name);
}

STATIC TraStatus ScdMapsCmpPcRange(const void *nodeData, const void *data)
{
    const ScdMap *node = (const ScdMap *)nodeData;
    uintptr_t pc = (uintptr_t)data;
    if (pc >= node->start && pc < node->end) {
        return TRACE_SUCCESS;
    }
    return TRACE_FAILURE;
}

ScdMap *ScdMapsGetMapByPc(ScdMaps *maps, uintptr_t pc)
{
    return AdiagListForEach(&maps->mapList, ScdMapsCmpPcRange, (const void *)pc);
}

STATIC ScdMap *ScdMapsParseLine(ScdMaps *maps, char *line, uint32_t len)
{
    uintptr_t start = 0;
    uintptr_t end = 0;
    size_t offset = 0;
    int32_t pos = 0;

    // scan
    int32_t ret = sscanf_s(line, "%lx-%lx %*s %lx %*x:%*x %*d%n", &start, &end, &offset, &pos);
    if ((ret <= 0) || (pos >= (int32_t)len) || (pos <= 0)) {
        SCD_DLOG_ERR("sscanf_s failed, ret = %d, line = %s.", ret, line);
        return NULL;
    }

    const char *name = NULL;
    if (ScdUtilTrim(line + pos, len - (uint32_t)pos, &name) != TRACE_SUCCESS) {
        return NULL;
    }
    if ((name == NULL) || (strlen(name) == 0)) {
        return NULL;
    }
    char realPath[TRACE_MAX_PATH] = { 0 };
    errno = 0;
    if ((TraceRealPath(name, realPath, TRACE_MAX_PATH) != EN_OK) && (errno != ENOENT)) {
        SCD_DLOG_ERR("can not get realpath, path=%s, strerr=%s.", name, strerror(errno));
        return NULL;
    }

    // find map
    ScdMap *map = ScdMapsGetMapByName(maps, realPath);
    if (map != NULL) {
        // the start and end of the multi-segment code segment of the map are updated each time
        if (ScdMapUpdata(map, start, end, offset) == TRACE_SUCCESS) {
            return NULL;
        }
    }
    // create map
    return ScdMapCreate(start, end, offset, realPath);
}

/**
 * @brief       load maps
 * @param [in]  maps:       maps info
 * @return      TraStatus
 */
TraStatus ScdMapsLoad(ScdMaps *maps)
{
    char buf[SCD_MAPS_BUF_LEN] = {0};
    int32_t err = snprintf_s(buf, SCD_MAPS_BUF_LEN, SCD_MAPS_BUF_LEN - 1U, "/proc/%d/maps", maps->pid);
    if (err == -1) {
        SCD_DLOG_ERR("snprintf_s failed, get maps file name failed.");
        return TRACE_FAILURE;
    }

    FILE *fp = fopen(buf, "r");
    if (fp == NULL) {
        SCD_DLOG_ERR("open maps file failed.");
        return TRACE_FAILURE;
    }

    while (fgets(buf, SCD_MAPS_BUF_LEN, fp) != NULL) {
        ScdMap *node = ScdMapsParseLine(maps, buf, SCD_MAPS_BUF_LEN);
        if (node == NULL) {
            continue;
        }

        AdiagStatus ret = AdiagListInsert(&maps->mapList, node);
        if (ret != ADIAG_SUCCESS) {
            SCD_DLOG_ERR("add map to map list failed.");
            ScdMapDestroy(&node);
            (void)fclose(fp);
            return TRACE_FAILURE;
        }
    }

    (void)fclose(fp);
    return TRACE_SUCCESS;
}

/**
 * @brief       init maps
 * @param [in]  maps:       maps info
 * @param [in]  pid:        process id
 * @return      TraStatus
 */
TraStatus ScdMapsInit(ScdMaps *maps, int32_t pid)
{
    SCD_CHK_PTR_ACTION(maps, return TRACE_FAILURE);

    maps->pid = pid;
    AdiagStatus adiagRet = AdiagListInit(&maps->mapList);
    if (adiagRet != ADIAG_SUCCESS) {
        SCD_DLOG_ERR("init maps list failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       init maps
 * @param [in]  maps:       maps info
 * @return      NA
 */
void ScdMapsUninit(ScdMaps *maps)
{
    ScdMap *node = (ScdMap *)AdiagListTakeOut(&maps->mapList);
    while (node != NULL) {
        ScdMapDestroy(&node);
        node = (ScdMap *)AdiagListTakeOut(&maps->mapList);
    }
}