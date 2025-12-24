/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "share_mem.h"
#include <sys/ipc.h>
#include <sys/shm.h>
#include "log_print.h"

#define MSG_MEMORY_KEY  0x474f4c46

/*
 * @brief: get shared memory segment
 * @param [in]key: share memory key
 * @param [in]msgFlag: message flag
 * @return: failed:-1:;succeed:share memory key
 */
STATIC INLINE int32_t ToolShmGet(key_t key, size_t size, int32_t shmflg)
{
    return shmget(key, size, shmflg);
}

/*
 * @brief: shared memory attach operation
 * @param [in]shmid:identifier ID
 * @param [in]shmaddr:Points to the desired address of the shared memory segment.
 * @param [in]shmflg:Specifies a set of flags that indicate the specific shared.
 *            memory conditions and options to implement.
 *              shmflg=0:read &write; shmflg=SHM_RDONLY:read only;
 * @return: failed:-1;success:points to the desired address
 */
STATIC INLINE void *ToolShmAt(int32_t shmid, const void *shmaddr, int32_t shmflg)
{
    return shmat(shmid, shmaddr, shmflg);
}

/*
 * @brief:  detaches the shared memory segment located at the address specified by
 *          shmaddr. from the address space of the calling process.
 * @param [in]shmaddr: the data segment start address of a shared memory segment
 * @return: failed:-1;succeed:0;
 */
STATIC INLINE int32_t ToolShmDt(const void *shmaddr)
{
    return shmdt(shmaddr);
}

/*
 * @brief: shared memory control operations
 * @param [shmid]shared memory ID
 * @param [cmd]commond to do
 * @param [in]buf:the structure pointed
 * @return: failed:-1;succeed:0;
 */
STATIC INLINE int32_t ToolShmCtl(int32_t shmid, int32_t cmd, struct shmid_ds *buf)
{
    return shmctl(shmid, cmd, buf);
}

/**
 * @brief : create shared memory
 * @param [in/out]shmId: shared memory id
 * @return succeed:SHM_SUCCEED,failed:SHM_ERROR
*/
ShmErr ShMemCreat(int32_t *shmId, toolMode perm)
{
    if (shmId == NULL) {
        return SHM_ERROR;
    }
    uint32_t shmFlag = IPC_CREAT | IPC_EXCL | (uint32_t)perm;
    int32_t memId = ToolShmGet(MSG_MEMORY_KEY, SHM_SIZE, (int32_t)shmFlag);
    if (memId == -1) {
        SYSLOG_WARN("CreatShMem error, strerr=%s.try \"ipcs -m\" to check.\n", strerror(ToolGetErrorCode()));
        return SHM_ERROR;
    }
    *shmId = memId;
    return SHM_SUCCEED;
}

/**
 * @brief : open shared memory
 * @param [out]shmId:identifier ID
 * @return: SHM_SUCCEED/SHM_ERROR
*/
ShmErr ShMemOpen(int32_t *shmId)
{
    if (shmId == NULL) {
        return SHM_ERROR;
    }
    int32_t memId = ToolShmGet(MSG_MEMORY_KEY, 0, 0);
    if (memId == (int)SHM_ERROR) {
        return SHM_ERROR;
    }
    *shmId = memId;
    return SHM_SUCCEED;
}

/**
 * @brief : write string to shared memory
 * @param [in]shmId:share ID to identify shared memory
 * @param [in]value:string to be write
 * @param [in]len: max length of string
 * @return: SHM_SUCCEED/SHM_ERROR
*/
ShmErr ShMemWrite(int32_t shmId, const char *value, uint32_t len, uint32_t offset)
{
    if ((shmId == -1) || (value == NULL) || (len == 0)) {
        SYSLOG_WARN("[input]shmId or value is error, shmId = %d\n ", shmId);
        return SHM_ERROR;
    }
    char *shmvalue = (char *)ToolShmAt(shmId, NULL, 0);
    if ((intptr_t)shmvalue == -1) {
        SYSLOG_WARN("WriteToShMem shmat failed ,strerr=%s.\n", strerror(ToolGetErrorCode()));
        return SHM_ERROR;
    }
    if (shmvalue == NULL) {
        return SHM_ERROR;
    }
    int32_t ret = snprintf_truncated_s(shmvalue + offset, len, "%s", value);
    if (ret < 0) {
        return SHM_ERROR;
    }
    if (ToolShmDt(shmvalue) != (int)SHM_SUCCEED) {
        SYSLOG_WARN("shmdt failed, strerr=%s.\n", strerror(ToolGetErrorCode()));
        return SHM_ERROR;
    }
    return SHM_SUCCEED;
}

/**
* @brief : read string from shared memory
 * @param [in]shmId:share ID to identify shared memory
 * @param [in]value:buffer to store string
 * @param [in]len: max length of string
 * @return: SHM_SUCCEED/SHM_ERROR
*/
ShmErr ShMemRead(int32_t shmId, char *value, size_t len, size_t offset)
{
    if ((value == NULL) || (len == 0)) {
        return SHM_ERROR;
    }
    char *shmvalue = (char *)ToolShmAt(shmId, NULL, SHM_RDONLY);
    if ((intptr_t)shmvalue == -1) {
        return SHM_ERROR;
    }
    if (shmvalue == NULL) {
        return SHM_ERROR;
    }
    if ((strlen(shmvalue) == 0) || (strlen(shmvalue) > len)) {
        return SHM_ERROR;
    }
    int32_t ret = snprintf_truncated_s(value, len, "%s", shmvalue + offset);
    if (ret < 0) {
        return SHM_ERROR;
    }
    if (ToolShmDt(shmvalue) != 0) {
        return SHM_ERROR;
    }
    return SHM_SUCCEED;
}

/**
* @brief : remove the shared memory
 * @return: SHM_SUCCEED/SHM_ERROR
*/
void ShMemRemove(void)
{
    int32_t shmId;
    if (ShMemOpen(&shmId) == SHM_ERROR) {
        return;
    }
    if (ToolShmCtl(shmId, IPC_RMID, NULL) != 0) {
        SYSLOG_WARN("ToolShmCtl failed, strerr=%s.\n", strerror(ToolGetErrorCode()));
        return;
    }
    return;
}
