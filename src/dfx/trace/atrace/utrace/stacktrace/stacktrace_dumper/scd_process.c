/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_process.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "scd_log.h"
#include "scd_layout.h"

#define SCD_FILE_TXT_SUFFIX                     ".txt"
#define SCD_FILE_BIN_SUFFIX                     ".bin"
#define SCD_BUFFER_LENGTH   1024U

STATIC ScdProcess *g_scdProcessCore = NULL;

static void ScdProcessRecordRegInfo(int32_t fd, const ScdRegs *info)
{
    char tmpBuf[SCD_BUFFER_LENGTH] = { 0 };
    TraStatus ret = ScdRegsGetString(info, tmpBuf, SCD_BUFFER_LENGTH);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("get register info string failed, ret=%d.", ret);
        return;
    }

    if (ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf)) != strlen(tmpBuf)) {
        SCD_DLOG_ERR("write regs info to file failed.");
        return;
    }
}

STATIC void ScdProcessRecordKernelVersion(int32_t fd)
{
    const char *unknownVersion = "kernel version: unknown\n";
    FILE *fp = popen("uname -a", "r");
    if (fp == NULL) {
        SCD_DLOG_ERR("get kernel version failed, errno=%d.", errno);
        (void)ScdUtilWrite(fd, unknownVersion, strlen(unknownVersion));
        return;
    }

    char tmpBuf[SCD_BUFFER_LENGTH] = { 0 };
    char kernelVersion[SCD_BUFFER_LENGTH] = { 0 };
    if (fgets(kernelVersion, (int32_t)sizeof(kernelVersion), fp) != NULL) {
        int32_t err = snprintf_s(tmpBuf, SCD_BUFFER_LENGTH, SCD_BUFFER_LENGTH - 1U,
            "kernel version: %s", kernelVersion);
        if (err == -1) {
            SCD_DLOG_ERR("snprintf_s kernel version failed, errno = %d.", errno);
            (void)ScdUtilWrite(fd, unknownVersion, strlen(unknownVersion));
            (void)pclose(fp);
            return;
        }
    }
    (void)pclose(fp);
    size_t ret = ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf));
    if (ret != strlen(tmpBuf)) {
        SCD_DLOG_ERR("write kernel version to file failed.");
        (void)ScdUtilWrite(fd, unknownVersion, strlen(unknownVersion));
        return;
    }
}

STATIC void ScdProcessRecordSiginfo(int32_t fd, const ScdProcess *info)
{
    char tmpBuf[SCD_BUFFER_LENGTH] = { 0 };
    int32_t err = snprintf_s(tmpBuf, SCD_BUFFER_LENGTH, SCD_BUFFER_LENGTH - 1U,
        "crash task:%s\n"
        "crash pid:%d\n"
        "crash tid:%d\n"
        "crash stack base:0x%016lx\n"
        "crash stack top:0x%016lx\n"
        "crash reason: signal %d\n",
        info->pname,
        info->args.pid,
        info->args.crashTid,
        info->args.stackBaseAddr,
        GET_SPREG_FROM_CONTEXT(&info->args.uc.uc_mcontext),
        info->args.signo);
    if (err == -1) {
        SCD_DLOG_ERR("snprintf_s failed, errno = %d.", errno);
        return;
    }

    size_t ret = ScdUtilWrite(fd, tmpBuf, strlen(tmpBuf));
    if (ret != strlen(tmpBuf)) {
        SCD_DLOG_ERR("write signal info to file failed.");
        return;
    }
}

STATIC TraStatus ScdProcessRecordInfo(int32_t fd, const ScdProcess *pro)
{
    // record [process]
    ScdUtilWriteTitle(fd, SCD_SECTION_PROCESS);
    ScdProcessRecordSiginfo(fd, pro);
    ScdProcessRecordKernelVersion(fd);
    ScdProcessRecordRegInfo(fd, &pro->thds.ucRegs);
    ScdUtilWriteNewLine(fd);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdProcessRecordStack(int32_t fd, const ScdProcess *pro)
{
    // record [stack]
    ScdUtilWriteTitle(fd, SCD_SECTION_STACK);
    if (ScdThreadsRecord(fd, &pro->thds) != TRACE_SUCCESS) {
        SCD_DLOG_ERR("record stack info failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC INLINE TraStatus ScdProcessRecordProcInfo(int32_t fd, pid_t pid, const char *name)
{
    // 拼接文件：/proc/{pid}/name
    // 从文件中逐行读取，逐行写
    TraStatus ret = TRACE_SUCCESS;
    if (strcmp(name, SCD_SECTION_MEMORY) == 0) {
        ScdUtilWriteTitle(fd, name);
        ret = ScdUtilWriteProcInfo(fd, -1, "meminfo");
    } else if (strcmp(name, SCD_SECTION_STATUS) == 0) {
        ScdUtilWriteTitle(fd, name);
        ret = ScdUtilWriteProcInfo(fd, pid, "status");
    } else if (strcmp(name, SCD_SECTION_LIMITS) == 0) {
        ScdUtilWriteTitle(fd, name);
        ret = ScdUtilWriteProcInfo(fd, pid, "limits");
    } else  if (strcmp(name, SCD_SECTION_MAPS) == 0) {
        ScdUtilWriteTitle(fd, name);
        ret = ScdUtilWriteProcInfo(fd, pid, "maps");
    } else {
        SCD_DLOG_WAR("invalid section name [%s].", name);
        return ret;
    }

    ScdUtilWriteNewLine(fd);
    return ret;
}

STATIC TraStatus ScdProcessLoadInfo(ScdProcess *pro)
{
    // get pname
    ScdUtilGetProcessName(pro->args.pid, pro->pname, SCD_PNAME_LEN);

    // get tname and regs
    return ScdThreadsLoadInfo(&pro->thds);
}

STATIC TraStatus ScdProcessLoad(ScdProcess *pro)
{
    TraStatus ret = ScdMapsLoad(&pro->maps);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("load maps failed, ret=%d.", ret);
        return ret;
    }

    ret = ScdProcessLoadInfo(pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("load process info failed, ret=%d.", ret);
        return ret;
    }

    ret = ScdThreadsLoadFrames(&pro->thds, &pro->maps);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("load frames failed, ret=%d.", ret);
        return ret;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdProcessInit(ScdProcess **process, const ScdProcessArgs *args)
{
    ScdProcess *pro = (ScdProcess *)AdiagMalloc(sizeof(ScdProcess));
    if (pro == NULL) {
        SCD_DLOG_ERR("malloc struct ScdProcess failed.");
        return TRACE_FAILURE;
    }

    pro->shdrUsed = false;
    errno_t err = memcpy_s(&pro->args, sizeof(ScdProcessArgs), args, sizeof(ScdProcessArgs));
    if (err != EOK) {
        AdiagFree(pro);
        SCD_DLOG_ERR("memcpy_s failed, err=%d.", err);
        return TRACE_FAILURE;
    }
    TraStatus ret = ScdMapsInit(&pro->maps, pro->args.pid);
    if (ret != TRACE_SUCCESS) {
        AdiagFree(pro);
        SCD_DLOG_ERR("init maps failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }
    ret = ScdThreadsInit(&pro->thds, pro->args.pid, pro->args.crashTid, &pro->args.uc);
    if (ret != TRACE_SUCCESS) {
        ScdMapsUninit(&pro->maps);
        AdiagFree(pro);
        SCD_DLOG_ERR("init threads failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }
    *process = pro;
    return TRACE_SUCCESS;
}

STATIC void ScdProcessUninit(ScdProcess **process)
{
    if (*process == NULL) {
        return;
    }
    ScdProcess *pro = *process;
    ScdMapsUninit(&pro->maps);
    ScdThreadsUninit(&pro->thds);
    AdiagFree(pro);
    pro = NULL;
    return;
}

STATIC TraStatus ScdProcessCreateFile(const ScdProcessArgs *args, const char *suffix, int32_t *fd)
{
    if (access(args->filePath, F_OK) != 0) {
        SCD_DLOG_ERR("file path \"%s\" does not exist.", args->filePath);
        return TRACE_FAILURE;
    }
    char path[SCD_MAX_FULLPATH_LEN + 1U] = {0};
    int32_t err = snprintf_s(path, SCD_MAX_FULLPATH_LEN + 1U, SCD_MAX_FULLPATH_LEN, "%s/%s%s",
        args->filePath, args->fileName, suffix);
    if (err == -1) {
        SCD_DLOG_ERR("snprintf_s failed, err=%d.", err);
        return TRACE_FAILURE;
    }

    char realPath[TRACE_MAX_PATH] = {0};
    if ((TraceRealPath(path, realPath, TRACE_MAX_PATH) != EN_OK) && (AdiagGetErrorCode() != ENOENT)) {
        SCD_DLOG_ERR("can not get realpath, path=%s, strerr=%s.", path, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }

    int32_t fileFd = open(realPath, O_CREAT | O_RDWR | O_TRUNC, 0640);
    if (fileFd < 0) {
        SCD_DLOG_ERR("open \"%s\" failed, fd=%d.", realPath, fileFd);
        return TRACE_FAILURE;
    }
    *fd = fileFd;
    SCD_DLOG_INF("create file \"%s\" successfully, fd=%d.", realPath, fileFd);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdProcessRecordTxt(const ScdProcess *pro)
{
    // open file
    int32_t fd = -1;
    TraStatus ret = ScdProcessCreateFile(&pro->args, SCD_FILE_TXT_SUFFIX, &fd);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("create txt file failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }

    // write [process] to txt
    (void)ScdProcessRecordInfo(fd, pro);

    if (pro->shdrUsed) {
        // write [stack] to txt
        (void)ScdSectionRecord(fd, pro, SCD_SECTION_STACK);

        // write proc([maps]、[meminfo]、[status]、[limits]...) to txt
        (void)ScdSectionRecord(fd, pro, SCD_SECTION_MAPS);
        (void)ScdSectionRecord(fd, pro, SCD_SECTION_MEMORY);
        (void)ScdSectionRecord(fd, pro, SCD_SECTION_STATUS);
        (void)ScdSectionRecord(fd, pro, SCD_SECTION_LIMITS);
    } else {
        // write [stack] to txt
        (void)ScdProcessRecordStack(fd, pro);

        // write proc([maps]、[meminfo]、[status]、[limits]...) to txt
        (void)ScdProcessRecordProcInfo(fd, pro->args.pid, SCD_SECTION_MAPS);
        (void)ScdProcessRecordProcInfo(fd, pro->args.pid, SCD_SECTION_MEMORY);
        (void)ScdProcessRecordProcInfo(fd, pro->args.pid, SCD_SECTION_STATUS);
        (void)ScdProcessRecordProcInfo(fd, pro->args.pid, SCD_SECTION_LIMITS);
    }

    (void)close(fd);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdProcessRecordCore(ScdProcess *pro)
{
    // create bin file
    int32_t fd = -1;
    TraStatus ret = ScdProcessCreateFile(&pro->args, SCD_FILE_BIN_SUFFIX, &fd);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("create bin file failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }

    ret = ScdLayoutWrite(fd, pro);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("write bin file failed, ret=%d.", ret);
        (void)close(fd);
        return TRACE_FAILURE;
    }
    (void)close(fd);
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdProcessReadCore(ScdProcess **pro, const char *filePath)
{
    return ScdLayoutRead(pro, filePath);
}

TraStatus ScdProcessDump(const ScdProcessArgs *args)
{
    // 1. init process object
    TraStatus ret = ScdProcessInit(&g_scdProcessCore, args);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    // 2. get tid
    ret = ScdThreadsLoad(&g_scdProcessCore->thds);
    if (ret != TRACE_SUCCESS) {
        STACKTRACE_LOG_ERR("load threads failed, ret=%d.", ret);
        ScdProcessUninit(&g_scdProcessCore);
        return TRACE_FAILURE;
    }

    // 3. suspend all threads
    ScdThreadsSuspend(&g_scdProcessCore->thds);
    STACKTRACE_LOG_RUN("suspend process(%d).", g_scdProcessCore->args.pid);

    // 4. load core info to global variable
    ret = ScdProcessLoad(g_scdProcessCore);
    if (ret != TRACE_SUCCESS) {
        STACKTRACE_LOG_ERR("load process failed, ret=%d.", ret);
        ScdThreadsResume(&g_scdProcessCore->thds);
        ScdProcessUninit(&g_scdProcessCore);
        return TRACE_FAILURE;
    }

    // 5. record to file (txt or core)
    if (g_scdProcessCore->args.handleType == SCD_DUMP_THREADS_TXT) {
        // write to txt
        ret = ScdProcessRecordTxt(g_scdProcessCore);
    } else {
        // write to core
        ret = ScdProcessRecordCore(g_scdProcessCore);
    }

    // 6. resume all threads
    ScdThreadsResume(&g_scdProcessCore->thds);
    STACKTRACE_LOG_RUN("resume process(%d).", g_scdProcessCore->args.pid);

    // 7. uninit process object
    ScdProcessUninit(&g_scdProcessCore);
    return ret;
}

static TraStatus ScdProcessCheckBinPath(const char *filePath, uint32_t len)
{
    if (len >= TRACE_MAX_PATH) {
        SCD_DLOG_ERR("path length [%u] bytes exceeds [%d] bytes", len, TRACE_MAX_PATH);
        return TRACE_INVALID_PARAM;
    }
    if (len == 0) {
        SCD_DLOG_ERR("path length is 0 bytes");
        return TRACE_INVALID_PARAM;
    }
    if (access(filePath, F_OK) != 0) {
        SCD_DLOG_ERR("input path [%s] does not exist", filePath);
        return TRACE_INVALID_PARAM;
    }
    char *suffix = strrchr(filePath, '.');
    if ((suffix != NULL) && strcmp(suffix, SCD_FILE_BIN_SUFFIX) == 0) {
        return TRACE_SUCCESS;
    } else {
        SCD_DLOG_ERR("invalid path [%s]", filePath);
        return TRACE_INVALID_PARAM;
    }
}

TraStatus ScdProcessParseCore(const char *filePath, uint32_t len)
{
    TraStatus ret = ScdProcessCheckBinPath(filePath, len);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("check bin path failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }

    char realPath[TRACE_MAX_PATH] = { 0 };
    if ((TraceRealPath(filePath, realPath, TRACE_MAX_PATH) != EN_OK) && (errno != ENOENT)) {
        SCD_DLOG_ERR("can not get realpath, path=%s, errno=%d.", filePath, errno);
        return TRACE_FAILURE;
    }

    // read from core
    SCD_DLOG_INF("parse core file=%s.", realPath);
    ret = ScdProcessReadCore(&g_scdProcessCore, realPath);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("read core file failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }

    // write to txt
    ret = ScdProcessRecordTxt(g_scdProcessCore);
    ADIAG_SAFE_FREE(g_scdProcessCore);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("record to txt failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }

    if (remove(realPath) != 0) {
        SCD_DLOG_WAR("can not remove file [%s]", realPath);
    }
    return TRACE_SUCCESS;
}