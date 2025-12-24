/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_frames.h"
#include "scd_regs.h"
#include "scd_maps.h"
#include "scd_log.h"
#include "scd_dl.h"
#include "scd_frame.h"

#define SCD_MAX_STACK_LAYER         32U

STATIC TraStatus ScdFramesFpStep(ScdFrame *frame, ScdRegs *regs)
{
    uintptr_t fp = frame->fp;
    SCD_CHK_EXPR_ACTION(fp == 0, return TRACE_FAILURE, "invalid fp 0, frame pointer is not supported");
    uintptr_t lr = fp + 8U;  // LR_OFFSET
    uintptr_t nextPc;
    size_t size = ScdMemoryRead(NULL, lr, &nextPc, sizeof(uintptr_t));
    SCD_CHK_EXPR_ACTION(size == 0, return TRACE_FAILURE, "scd read memory from 0x%llx, failed ", lr);
    ScdRegsSetPc(regs, nextPc);
    SCD_DLOG_INF("update pc to 0x%llx get from 0x%llx",nextPc, lr);

    uintptr_t nextFp;
    size = ScdMemoryRead(NULL, fp, &nextFp, sizeof(uintptr_t));
    SCD_CHK_EXPR_ACTION(size == 0, return TRACE_FAILURE, "scd read memory from 0x%llx, failed ", fp);
    ScdRegsSetFp(regs, nextFp);
    SCD_DLOG_INF("update fp to 0x%llx get from 0x%llx", nextFp, fp);
    return TRACE_SUCCESS;
}

STATIC ScdFrame *ScdFramesCreateFrame(ScdFrames *frames, uintptr_t pc, uintptr_t sp, uintptr_t fp)
{
    ScdMap *map = ScdMapsGetMapByPc(frames->maps, pc);
    if (map == NULL) {
        SCD_DLOG_ERR("can not find map, pc = %p, sp = %p.", pc, sp);
        return NULL;
    }
    SCD_DLOG_INF("find pc 0x%llx in map %s",pc, map->name);

    TraStatus ret = ScdDlLoad(&map->dl, frames->pid, map->name);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("load map(%s) failed, pc = %p, sp = %p.", map->name, pc, sp);
        return NULL;
    }
    uintptr_t relPc = ScdMapGetRelPc(map, pc);
    ScdFrame *frame = ScdFrameCreate(map, pc, sp, fp);
    if (frame == NULL) {
        SCD_DLOG_ERR("create frame failed, map = %s, pc = %p, sp = %p.", map->name, pc, sp);
        return NULL;
    }
    frame->base = ScdMapGetBase(map);
    frame->num = frames->framesNum;
    frame->tid = frames->tid;
    frame->relPc = relPc;

    if (AdiagListInsert(&frames->frameList, frame) != ADIAG_SUCCESS) {
        SCD_DLOG_ERR("insert frame to list failed, map = %s, pc = %p, sp = %p.", map->name, pc, sp);
        ScdFrameDestroy(&frame);
        return NULL;
    }
    frames->framesNum++;
    ScdElfGetFunctionInfo(&map->dl.elf, relPc, frame->funcName, SCD_FUNC_NAME_LENGTH, &frame->funcOffset);

    SCD_DLOG_DBG("map info: name = %s, start = 0x%lx, end = 0x%lx, memory data = 0x%lx, loadBias = 0x%lx.",
        map->name, map->start, map->end, map->dl.elf.memory->data, map->dl.elf.loadBias);
    SCD_DLOG_DBG("create thread(%d) frame[%u] successfully,"
                 " pc = %p, relPc = %p, base = %p, sp = %p, fp = %p, function(%s: %d).",
                 frames->tid, frame->num, frame->pc, frame->relPc, frame->base, frame->sp, frame->fp,
                 strlen(frame->funcName) != 0 ? frame->funcName : "unknown", frame->funcOffset);
    return frame;
}

TraStatus ScdFramesLoad(ScdFrames *frames, ScdMaps *maps, ScdRegs *regs)
{
    SCD_CHK_PTR_ACTION(frames, return TRACE_FAILURE);
    SCD_CHK_PTR_ACTION(maps, return TRACE_FAILURE);
    SCD_CHK_PTR_ACTION(regs, return TRACE_FAILURE);
    frames->regs = regs;
    frames->maps = maps;
    ScdRegs frameRegs = *(frames->regs);
    while (frames->framesNum < SCD_MAX_STACK_LAYER) {
        uintptr_t framePc = ScdRegsGetPc(&frameRegs);
        uintptr_t frameSp = ScdRegsGetSp(&frameRegs);
        uintptr_t frameFp = ScdRegsGetFp(&frameRegs);

        // 1. create new frame
        ScdFrame *frame = ScdFramesCreateFrame(frames, framePc, frameSp, frameFp);
        if (frame == NULL) {
            SCD_DLOG_ERR("create frame failed.");
            return TRACE_FAILURE;
        }

        // 2. do step, get next frame regs
        TraStatus ret = ScdElfStep(&frame->map->dl.elf, frame->relPc, &frameRegs, frames->framesNum == 1);
        if (ret != TRACE_SUCCESS) {
            SCD_DLOG_WAR("get from regs, pc = 0x%lx, sp = 0x%lx, fp = 0x%lx.", framePc, frameSp, frameFp);
            SCD_DLOG_WAR("can not step by elf, pid = %d, tid = %d, num = %u, pc = 0x%lx, sp = 0x%lx, fp = 0x%lx.",
                frames->maps->pid, frame->tid, frames->framesNum, frame->pc, frame->sp, frame->fp);
            ret = ScdFramesFpStep(frame, &frameRegs);
            if (ret != TRACE_SUCCESS) {
                SCD_DLOG_ERR("step by fp failed, pid = %d, tid = %d, num = %u, pc = 0x%lx, sp = 0x%lx, fp = 0x%lx.",
                    frames->maps->pid, frame->tid, frames->framesNum, frame->pc, frame->sp, frame->fp);
                return TRACE_FAILURE;
            }
        }
        if (ScdRegsGetPc(&frameRegs) == 0) {
            break;
        }
        // 3. if the pc and sp didn't change, stop.
        if ((framePc == ScdRegsGetPc(&frameRegs)) && (frameSp == ScdRegsGetSp(&frameRegs))) {
            break;
        }
    }
    return TRACE_SUCCESS;
}

TraStatus ScdFramesInit(ScdFrames *frames, int32_t pid, int32_t tid)
{
    SCD_CHK_PTR_ACTION(frames, return TRACE_FAILURE);
    frames->pid = pid;
    frames->tid = tid;
    frames->regs = NULL;
    frames->maps = NULL;
    frames->framesNum = 0;
    AdiagStatus adiagRet = AdiagListInit(&frames->frameList);
    if (adiagRet != ADIAG_SUCCESS) {
        SCD_DLOG_ERR("frame list of frames init failed, pid = %d, tid = %d.", pid, tid);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

void ScdFramesUninit(ScdFrames *frames)
{
    SCD_CHK_PTR_ACTION(frames, return);
    ScdFrame *node = (ScdFrame *)AdiagListTakeOut(&frames->frameList);
    while (node != NULL) {
        ScdFrameDestroy(&node);
        node = (ScdFrame *)AdiagListTakeOut(&frames->frameList);
    }
}