/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_threads.h"
#include "adiag_utils.h"
#include "scd_thread.h"
#include "scd_log.h"
#include "scd_frame.h"

TraStatus ScdThreadsRecord(int32_t fd, const ScdThreads *thds)
{
    SCD_CHK_PTR_ACTION(thds, return TRACE_INVALID_PARAM);
    char tmpBuf[SCD_FRAME_LENGTH] = {0};
    int32_t threadIdx = 0;
    struct ListHead *pos = NULL;
    struct AdiagListNode *node = NULL;
    LIST_FOR_EACH(pos, &thds->thdList.list) {
        node = LIST_ENTRY(pos, struct AdiagListNode, list);
        threadIdx++;
        ScdThread *threadInfo = (ScdThread *)node->data;
        int32_t err = snprintf_s(tmpBuf, SCD_FRAME_LENGTH, SCD_FRAME_LENGTH - 1U,
            "Thread %d (%d, %s)\n", threadIdx, threadInfo->tid, threadInfo->tname);
        if (err == -1) {
            SCD_DLOG_ERR("snprintf_s thread header failed, tid=%d.", threadInfo->tid);
            return TRACE_FAILURE;
        }
        (void)ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf));

        // record frame info
        struct ListHead *posFrame = NULL;
        struct AdiagListNode *nodeFrame = NULL;
        int32_t frameIdx = -1;
        LIST_FOR_EACH(posFrame, &threadInfo->frames.frameList.list) {
            nodeFrame = LIST_ENTRY(posFrame, struct AdiagListNode, list);
            frameIdx++;
            ScdFrame *frame = (ScdFrame *)nodeFrame->data;
            if (strlen(frame->funcName) == 0) {
                err = snprintf_s(tmpBuf, SCD_FRAME_LENGTH, SCD_FRAME_LENGTH - 1U,
                    "#%02u 0x%016lx 0x%016lx %s\n", frame->num, frame->pc, frame->base, frame->soName);
            } else {
                err = snprintf_s(tmpBuf, SCD_FRAME_LENGTH, SCD_FRAME_LENGTH - 1U,
                    "#%02u 0x%016lx 0x%016lx %s (%s)\n", frame->num, frame->pc, frame->base, frame->soName, frame->funcName);
            }
            if (err == -1) {
                SCD_DLOG_ERR("snprintf_s frame failed, tid=%d, frame index=%d.", threadInfo->tid, frameIdx);
                return TRACE_FAILURE;
            }
            (void)ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf));
        }
        ScdUtilWriteNewLine(fd);
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdThreadsTraverseLoadFrames(void *node, void *data)
{
    ScdThread *thd = (ScdThread *)node;
    ScdMaps *maps = (ScdMaps *)data;
    if (ScdThreadLoadFrames(thd, maps) != TRACE_SUCCESS) {
        SCD_DLOG_WAR("can not load thread frames, pid=%d, tid=%d.", thd->pid, thd->tid);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

TraStatus ScdThreadsLoadFrames(ScdThreads *thds, ScdMaps *maps)
{
    // 遍历tid
    AdiagListForEachTraverse(&thds->thdList, ScdThreadsTraverseLoadFrames, maps);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdThreadsTraverseLoadInfo(void *node, void *data)
{
    ScdThread *thd = (ScdThread *)node;
    ScdThreads *thds = (ScdThreads *)data;

    //load thread regs
    if(thd->tid != thds->crashTid) {
        return ScdThreadLoadInfo(thd);
    } else {
        return ScdThreadLoadInfoForCrash(thd, &thds->ucRegs);
    }
}

TraStatus ScdThreadsLoadInfo(ScdThreads *thds)
{
    // 遍历tid
    AdiagListForEachTraverse(&thds->thdList, ScdThreadsTraverseLoadInfo, thds);
    return TRACE_SUCCESS;
}

TraStatus ScdThreadsLoad(ScdThreads *thds)
{
    SCD_CHK_PTR_ACTION(thds, return TRACE_FAILURE);

    char buf[SCD_UTIL_TMP_BUF_LEN] = {0};
    int32_t ret = snprintf_s(buf, SCD_UTIL_TMP_BUF_LEN, SCD_UTIL_TMP_BUF_LEN - 1U, "/proc/%d/task", thds->pid);
    if (ret == -1) {
        SCD_DLOG_ERR("snprintf_s task path failed, pid=%d, errno=%d.", thds->pid, errno);
        return TRACE_FAILURE;
    }

    DIR *dir = opendir(buf);
    if (dir == NULL) {
        SCD_DLOG_ERR("open dir %s failed, errno=%d", buf, errno);
        return TRACE_FAILURE;
    }

    struct dirent *ent = NULL;
    while ((ent = readdir(dir)) != NULL) {
        if ((strcmp(ent->d_name, ".") == 0) || (strcmp(ent->d_name, "..") == 0)) {
            continue;
        }

        int32_t tid = -1;
        if (AdiagStrToInt(ent->d_name, &tid) != ADIAG_SUCCESS) {
            continue;
        }

        ScdThread *thd = ScdThreadCreate(thds->pid, tid);
        if (thd == NULL) {
            SCD_DLOG_ERR("create thread failed, pid=%d, tid=%d.", thds->pid, tid);
            (void)closedir(dir);
            return TRACE_FAILURE;
        }

        ret = AdiagListInsert(&thds->thdList, (void *)thd);
        if (ret != ADIAG_SUCCESS) {
            ScdThreadDestroy(&thd);
            (void)closedir(dir);
            SCD_DLOG_ERR("insert thread failed, pid=%d, tid=%d.", thds->pid, tid);
            return TRACE_FAILURE;
        }
        SCD_DLOG_INF("load thread successfully, pid=%d, tid=%d.", thds->pid, tid);
    }
    (void)closedir(dir);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdThreadsTraverseSuspend(void *node, void *data)
{
    (void)data;
    return ScdThreadSuspend((ScdThread *)node);
}

void ScdThreadsSuspend(ScdThreads *thds)
{
    // 遍历tid
    AdiagListForEachTraverse(&thds->thdList, ScdThreadsTraverseSuspend, NULL);
}

STATIC TraStatus ScdThreadsTraverseResume(void *node, void *data)
{
    (void)data;
    ScdThreadResume((ScdThread *)node);
    return TRACE_SUCCESS;
}

void ScdThreadsResume(ScdThreads *thds)
{
    // 遍历tid
    AdiagListForEachTraverse(&thds->thdList, ScdThreadsTraverseResume, NULL);
}

TraStatus ScdThreadsInit(ScdThreads *thds, int32_t pid, int32_t crashTid, ucontext_t *uc)
{
    SCD_CHK_PTR_ACTION(thds, return TRACE_FAILURE);
    SCD_CHK_PTR_ACTION(uc, return TRACE_FAILURE);
    thds->pid = pid;
    thds->crashTid = crashTid;
    ScdRegsLoadFromUcontext(&thds->ucRegs, uc);
    AdiagStatus ret = AdiagListInit(&thds->thdList);
    if (ret != ADIAG_SUCCESS) {
        SCD_DLOG_ERR("init thread list failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }
    SCD_DLOG_DBG("init all threads successfully, pid=%d, crash tid=%d, pc=0x%lx, sp=0x%lx, fp=0x%lx.",
        pid, crashTid, GET_PCREG(thds->ucRegs.r), GET_SPREG(thds->ucRegs.r), GET_FPREG(thds->ucRegs.r));
    return TRACE_SUCCESS;
}

void ScdThreadsUninit(ScdThreads *thds)
{
    if (thds == NULL) {
        return;
    }
    ScdThread *node = (ScdThread *)AdiagListTakeOut(&thds->thdList);
    while (node != NULL) {
        ScdThreadDestroy(&node);
        node = (ScdThread *)AdiagListTakeOut(&thds->thdList);
    }
}