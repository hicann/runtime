/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_layout.h"
#include "scd_threads.h"
#include "scd_thread.h"
#include "scd_frame.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "scd_log.h"

STATIC ScdSection *ScdLayoutGetEmptShdr(ScdProcess *pro)
{
    uint32_t offset = (uint32_t)sizeof(ScdProcess);
    for (uint32_t i = 0; i < SCD_MAX_SHDR_NUM; i++) {
        if (pro->shdr[i].use) {
            offset = pro->shdr[i].offset + pro->shdr[i].totalSize;
            continue;
        }
        (void)memset_s(&(pro->shdr[i]), sizeof(ScdSection), 0, sizeof(ScdSection));
        pro->shdr[i].use = true;
        pro->shdr[i].offset = offset;
        return &(pro->shdr[i]);
    }
    return NULL;
}

STATIC TraStatus ScdLayoutSetShdrFrames(ScdProcess *pro)
{
    ScdSection *tmp = ScdLayoutGetEmptShdr(pro);
    if (tmp == NULL) {
        SCD_DLOG_ERR("get empty section for frames failed.");
        return TRACE_FAILURE;
    }
    errno_t err = memcpy_s(tmp->name, SCD_SECTION_NAME_LEN, SCD_SECTION_STACK, strlen(SCD_SECTION_STACK));
    if (err != EOK) {
        SCD_DLOG_ERR("memcpy failed, err=%d, errno=%d.", (int32_t)err, errno);
        return TRACE_FAILURE;
    }

    tmp->org = (uintptr_t)&pro->thds.thdList;
    tmp->type = SCD_SHDR_TYPE_LIST;
    tmp->entSize = (uint32_t)sizeof(ScdFrame);
    // 遍历thds，遍历frames的frame，将frame放进section
    ScdThreads *thds = &pro->thds;
    uint32_t frameNum = 0;
    struct ListHead *pos = NULL;
    struct AdiagListNode *node = NULL;
    LIST_FOR_EACH(pos, &thds->thdList.list) {
        node = LIST_ENTRY(pos, struct AdiagListNode, list);
        ScdThread *threadInfo = (ScdThread *)node->data;
        frameNum += threadInfo->frames.frameList.cnt;
    }
    tmp->num = frameNum;
    tmp->totalSize = tmp->num * tmp->entSize;
    return TRACE_SUCCESS;
}

STATIC uint32_t ScdLayoutGetFileSize(int32_t pid, const char *fileName)
{
    int32_t fd = ScdUtilGetProcFd(pid, fileName);
    if (fd < 0) {
        return 0;
    }

    ssize_t fileSize = 0;
    char data[SCD_UTIL_TMP_BUF_LEN] = { 0 };
    ssize_t ret = ScdUtilReadLine(fd, data, SCD_UTIL_TMP_BUF_LEN);
    while(ret > 0) {
        fileSize += ret;
        ret = ScdUtilReadLine(fd, data, SCD_UTIL_TMP_BUF_LEN);
    }
    (void)close(fd);
    return (uint32_t)fileSize;
}

STATIC TraStatus ScdLayoutSetFdType(ScdSection *shdr, int32_t pid, const char *fileName)
{
    uint32_t fileSize = ScdLayoutGetFileSize(pid, fileName);
    if (fileSize == 0) {
        return TRACE_FAILURE;
    }

    int32_t procFd = ScdUtilGetProcFd(pid, fileName);
    if (procFd < 0) {
        return TRACE_FAILURE;
    }
    SCD_DLOG_INF("set proc file[%s] fileSize=%u, fd=%d.", fileName, fileSize, procFd);

    shdr->entSize = fileSize;
    shdr->org = (uintptr_t)procFd;
    shdr->type = SCD_SHDR_TYPE_FD;
    shdr->num = 1U;
    shdr->totalSize = shdr->num * shdr->entSize;
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdLayoutSetShdrProcMaps(ScdProcess *pro)
{
    ScdSection *tmp = ScdLayoutGetEmptShdr(pro);
    if (tmp == NULL) {
        SCD_DLOG_ERR("get empty section for maps failed.");
        return TRACE_FAILURE;
    }
    errno_t err = memcpy_s(tmp->name, SCD_SECTION_NAME_LEN, SCD_SECTION_MAPS, strlen(SCD_SECTION_MAPS));
    if (err != EOK) {
        SCD_DLOG_ERR("memcpy failed, err=%d, errno=%d.", (int32_t)err, errno);
        return TRACE_FAILURE;
    }

    return ScdLayoutSetFdType(tmp, pro->args.pid, "maps");
}
 
STATIC TraStatus ScdLayoutSetShdrProcMeminfo(ScdProcess *pro)
{
    ScdSection *tmp = ScdLayoutGetEmptShdr(pro);
    if (tmp == NULL) {
        SCD_DLOG_ERR("get empty section for meminfo failed.");
        return TRACE_FAILURE;
    }
    errno_t err = memcpy_s(tmp->name, SCD_SECTION_NAME_LEN, SCD_SECTION_MEMORY, strlen(SCD_SECTION_MEMORY));
    if (err != EOK) {
        SCD_DLOG_ERR("memcpy failed, err=%d, errno=%d.", (int32_t)err, errno);
        return TRACE_FAILURE;
    }
    return ScdLayoutSetFdType(tmp, -1, "meminfo");
}

STATIC TraStatus ScdLayoutSetShdrProcStatus(ScdProcess *pro)
{
    ScdSection *tmp = ScdLayoutGetEmptShdr(pro);
    if (tmp == NULL) {
        SCD_DLOG_ERR("get empty section for status failed.");
        return TRACE_FAILURE;
    }
    errno_t err = memcpy_s(tmp->name, SCD_SECTION_NAME_LEN, SCD_SECTION_STATUS, strlen(SCD_SECTION_STATUS));
    if (err != EOK) {
        SCD_DLOG_ERR("memcpy failed, err=%d, errno=%d.", (int32_t)err, errno);
        return TRACE_FAILURE;
    }
    return ScdLayoutSetFdType(tmp, pro->args.pid, "status");
}

STATIC TraStatus ScdLayoutSetShdrProcLimits(ScdProcess *pro)
{
    ScdSection *tmp = ScdLayoutGetEmptShdr(pro);
    if (tmp == NULL) {
        SCD_DLOG_ERR("get empty section for limits failed.");
        return TRACE_FAILURE;
    }
    errno_t err = memcpy_s(tmp->name, SCD_SECTION_NAME_LEN, SCD_SECTION_LIMITS, strlen(SCD_SECTION_LIMITS));
    if (err != EOK) {
        SCD_DLOG_ERR("memcpy failed, err=%d, errno=%d.", (int32_t)err, errno);
        return TRACE_FAILURE;
    }
    return ScdLayoutSetFdType(tmp, pro->args.pid, "limits");
}

STATIC TraStatus ScdLayoutSetShdr(ScdProcess *pro)
{
    // frame section header
    TraStatus ret = ScdLayoutSetShdrFrames(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("set stack section failed.");
        return TRACE_FAILURE;
    }

    ret = ScdLayoutSetShdrProcMaps(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("set maps section failed.");
        return TRACE_FAILURE;
    }

    ret = ScdLayoutSetShdrProcMeminfo(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("set memory section failed.");
        return TRACE_FAILURE;
    }

    ret = ScdLayoutSetShdrProcStatus(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("set status section failed.");
        return TRACE_FAILURE;
    }

    ret = ScdLayoutSetShdrProcLimits(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("set limits section failed.");
        return TRACE_FAILURE;
    }

    pro->shdrUsed = true;
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdLayoutWriteShdrProc(int32_t fd, ScdSection *shdr)
{
    if (lseek(fd, shdr->offset, SEEK_SET) < 0) {
        SCD_DLOG_ERR("lseek failed, offset=%d, fd=%d, errno=%d.", shdr->offset, fd, errno);
        return TRACE_FAILURE;
    }
    if (shdr->org == SCD_SHDR_INVALID_FD) {
        SCD_DLOG_ERR("get proc file fd failed.");
        return TRACE_FAILURE;
    }
    int32_t procFd = (int32_t)shdr->org;
    size_t fileSize = 0;
    char data[SCD_UTIL_TMP_BUF_LEN] = { 0 };
    while (ScdUtilReadLine(procFd, data, SCD_UTIL_TMP_BUF_LEN) > 0) {
        size_t ret = ScdUtilWrite(fd, data, strlen(data));
        if (ret != strlen(data)) {
            SCD_DLOG_ERR("write proc info to file failed.");
            (void)close(procFd);
            shdr->org = SCD_SHDR_INVALID_FD;
            return TRACE_FAILURE;
        }
        fileSize += ret;
    }
    SCD_DLOG_INF("write section %s info, totalSize=%u, size=%ld, fd=%d.", shdr->name, shdr->totalSize, fileSize, procFd);
    size_t totalSize = (size_t)shdr->totalSize;
    while(fileSize < totalSize) {
        (void)ScdUtilWrite(fd, " ", 1);
        fileSize++;
    }

    (void)close(procFd);
    shdr->org = SCD_SHDR_INVALID_FD;
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdLayoutWriteShdrFrames(int32_t fd, ScdSection *shdr)
{
    if (lseek(fd, shdr->offset, SEEK_SET) < 0) {
        SCD_DLOG_ERR("lseek failed, offset=%d, fd=%d, errno=%d.", shdr->offset, fd, errno);
        return TRACE_FAILURE;
    }
    struct ListHead *pos = NULL;
    struct AdiagListNode *node = NULL;
    struct AdiagList *threadList = (struct AdiagList *)shdr->org;
    LIST_FOR_EACH(pos, &threadList->list) {
        node = LIST_ENTRY(pos, struct AdiagListNode, list);
        ScdThread *threadInfo = (ScdThread *)node->data;

        // record frame info
        struct ListHead *posFrame = NULL;
        struct AdiagListNode *nodeFrame = NULL;
        LIST_FOR_EACH(posFrame, &threadInfo->frames.frameList.list) {
            nodeFrame = LIST_ENTRY(posFrame, struct AdiagListNode, list);
            ScdFrame *frame = (ScdFrame *)nodeFrame->data;
            size_t len = ScdUtilWrite(fd, frame, sizeof(ScdFrame));
            if (len != sizeof(ScdFrame)) {
                SCD_DLOG_ERR("write frame section to file failed.");
                return TRACE_FAILURE; 
            }
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdLayoutWriteShdr(int32_t fd, ScdProcess *pro)
{
    for (uint32_t i = 0; i < SCD_MAX_SHDR_NUM; i++) {
        if (!pro->shdr[i].use) {
            break;
        } 
        ScdShdrType type = pro->shdr[i].type;
        if (type == SCD_SHDR_TYPE_FD) {
            // read fd , then write
            if (ScdLayoutWriteShdrProc(fd, &pro->shdr[i]) != TRACE_SUCCESS) {
                SCD_DLOG_ERR("write frame section failed.");
                return TRACE_FAILURE;
            }
        } else if (type == SCD_SHDR_TYPE_LIST) {
            // 遍历list，获取node，按node大小写入
            if (ScdLayoutWriteShdrFrames(fd, &pro->shdr[i]) != TRACE_SUCCESS) {
                SCD_DLOG_ERR("write frame section failed.");
                return TRACE_FAILURE;
            }
        } else {
            ;
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdLayoutWritePhdr(int32_t fd, ScdProcess *pro)
{
    size_t len = ScdUtilWrite(fd, pro, sizeof(ScdProcess));
    if (len != sizeof(ScdProcess)) {
        SCD_DLOG_ERR("write phdr failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdSectionProcRecord(int32_t fd, const ScdSection *shdr, const ScdProcess *pro)
{
    uintptr_t pos = (uintptr_t)pro + shdr->offset;
    size_t len = ScdUtilWrite(fd, (const void *)pos, shdr->totalSize);
    if (len != shdr->totalSize) {
        SCD_DLOG_ERR("write proc section \"%s\" failed.", shdr->name);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdSectionStackRecord(int32_t fd, const ScdSection *shdr, const ScdProcess *pro)
{
    uint32_t frameNum = shdr->num;
    int32_t threadIdx = 0;
    int32_t tid = -1;
    int32_t err = 0;
    char tmpBuf[SCD_FRAME_LENGTH] = {0};
    uintptr_t pos = (uintptr_t)pro + shdr->offset;
    for (uint32_t i = 0; i < frameNum; i++) {
        uintptr_t framePos = pos + i * (uintptr_t)shdr->entSize;
        ScdFrame *frame = (ScdFrame *)framePos;
        if (frame->tid != tid) {
            if (threadIdx != 0) {
                ScdUtilWriteNewLine(fd);
            }
            tid = frame->tid;
            threadIdx++;
            err = snprintf_s(tmpBuf, SCD_FRAME_LENGTH, SCD_FRAME_LENGTH - 1U, "Thread %d (%d)\n", threadIdx, tid);
            if (err == -1) {
                SCD_DLOG_ERR("snprintf_s thread header failed, tid=%d.", tid);
                return TRACE_FAILURE;
            }
            if (ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf)) != strlen(tmpBuf)) {
                SCD_DLOG_ERR("write thread header failed, tid=%d.", tid);
                return TRACE_FAILURE;
            }
        }
        if (strlen(frame->funcName) == 0) {
            err = snprintf_s(tmpBuf, SCD_FRAME_LENGTH, SCD_FRAME_LENGTH - 1U,
                "#%02u 0x%016lx 0x%016lx %s\n", frame->num, frame->pc, frame->base, frame->soName);
        } else {
            err = snprintf_s(tmpBuf, SCD_FRAME_LENGTH, SCD_FRAME_LENGTH - 1U,
                "#%02u 0x%016lx 0x%016lx %s (%s)\n", frame->num, frame->pc, frame->base, frame->soName, frame->funcName);
        }
        if (err == -1) {
            SCD_DLOG_ERR("snprintf_s frame failed, tid=%d, frame index=%u.", frame->tid, frame->num);
            return TRACE_FAILURE;
        }
        if (ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf)) != strlen(tmpBuf)) {
            SCD_DLOG_ERR("write frame failed, tid=%d, frame index=%u.", frame->tid, frame->num);
            return TRACE_FAILURE;
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdSectionRecordByName(int32_t fd, const ScdSection *shdr, const ScdProcess *pro)
{
    size_t len = ScdUtilWrite(fd, shdr->name, strlen(shdr->name));
    if (len != strlen(shdr->name)) {
        SCD_DLOG_ERR("write \"%s\" section failed.", shdr->name);
        return TRACE_FAILURE;
    }
    ScdUtilWriteNewLine(fd);
    TraStatus ret = TRACE_SUCCESS;
    if (strncmp(shdr->name, SCD_SECTION_STACK, SCD_SECTION_NAME_LEN) == 0) {
        ret = ScdSectionStackRecord(fd, shdr, pro);
    } else {
        ret = ScdSectionProcRecord(fd, shdr, pro);
    }
    ScdUtilWriteNewLine(fd);
    return ret;
}

TraStatus ScdSectionRecord(int32_t fd, const ScdProcess *pro, const char *name)
{
    for (uint32_t i = 0; i < SCD_MAX_SHDR_NUM; i++) {
        const ScdSection *shdr = &pro->shdr[i];
        if (!shdr->use) {
            continue;
        }
        if (strncmp(shdr->name, name, SCD_SECTION_NAME_LEN) != 0) {
            continue;
        }
        if (ScdSectionRecordByName(fd, shdr, pro) != TRACE_SUCCESS) {
            SCD_DLOG_ERR("write \"%s\" section failed.", name);
            return TRACE_FAILURE;
        }
    }
    return TRACE_SUCCESS;
}

TraStatus ScdLayoutWrite(int32_t fd, ScdProcess *pro)
{
    // calculate core layout
    TraStatus ret = ScdLayoutSetShdr(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("set section layout failed.");
        return TRACE_FAILURE;
    }

    // write process struct to core
    ret = ScdLayoutWritePhdr(fd, pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("write process struct failed.");
        return TRACE_FAILURE;
    }

    // write section([maps]、[meminfo]、[status]、[limits]...) to core
    ret = ScdLayoutWriteShdr(fd, pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("write section layout failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

TraStatus ScdLayoutRead(ScdProcess **pro, const char *filePath)
{
    // open bin
    int32_t fd = ScdUtilOpen(filePath);
    if (fd < 0) {
        SCD_DLOG_ERR("open bin file failed.");
        return TRACE_FAILURE;
    }

    off_t ret = lseek(fd, 0, SEEK_END);
    if (ret < 0) {
        SCD_DLOG_ERR("lseek failed, errno=%d.", errno);
        (void)close(fd);
        return TRACE_FAILURE;
    }
    size_t fileSize = (size_t)ret;
    void *buffer = AdiagMalloc(fileSize);
    if (buffer == NULL) {
        SCD_DLOG_ERR("malloc failed.");
        (void)close(fd);
        return TRACE_FAILURE;
    }
    // 从fd里读取，然后写入pro中
    (void)lseek(fd, 0, SEEK_SET);
    ssize_t readBytes = read(fd, buffer, fileSize);
    if ((size_t)readBytes != fileSize) {
        (void)close(fd);
        ADIAG_SAFE_FREE(buffer);
        SCD_DLOG_ERR("can not read data from file [%s], errno=%d.", filePath, errno);
        return TRACE_FAILURE;
    }

    (void)close(fd);
    *pro = (ScdProcess *)buffer;
    return TRACE_SUCCESS;
}