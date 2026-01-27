/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_stub.h"

mmTimespec mmGetTickCount()
{
    mmTimespec rts;
    struct timespec ts = {0};
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    rts.tv_sec = ts.tv_sec;
    rts.tv_nsec = ts.tv_nsec;
    return rts;
}


INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    if (timeVal == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    INT32 result;
    UINT32 envLen = 0;
    CHAR *envPtr = NULL;
    if (name == NULL || value == NULL || len == 0) {
        return EN_INVALID_PARAM;
    }
    envPtr = getenv(name);
    if (envPtr == NULL) {
        return EN_ERROR;
    }

    UINT32 lenOfRet = (UINT32)strlen(envPtr);
    if( lenOfRet < (MMPA_MEM_MAX_LEN - 1)) {
        envLen = lenOfRet + 1;
    }

    if (envLen != 0 && len < envLen) {
        return EN_INVALID_PARAM;
    } else {
        result = memcpy_s(value, len, envPtr, envLen); //lint !e613
        if (result != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

CHAR *mmDirName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    CHAR *dir = dirname(path);
    return dir;
}

CHAR *mmBaseName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    CHAR *dir = basename(path);
    return dir;
}

INT32 mmGetFileSize(const CHAR *fileName, ULONGLONG *length)
{
    if(fileName == NULL || length == NULL){
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (void)memset(&fileStat, 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    int ret = lstat(fileName, &fileStat);
    if (ret < 0) {
        return EN_ERROR;
    }
    *length = (ULONGLONG)fileStat.st_size;
    return EN_OK;
}

INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == NULL) {
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (void)memset(&fileStat, 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    int ret = lstat(fileName, &fileStat);
    if (ret < 0) {
        return EN_ERROR;
    }

    if (!S_ISDIR(fileStat.st_mode)) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmAccess(const CHAR *lpPathName)
{
    if (lpPathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = access(lpPathName, F_OK);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmRmdir(const CHAR *lpPathName)
{
    INT32 ret;
    DIR *pDir = NULL;
    DIR *pChildDir = NULL;

    if (lpPathName == NULL) {
        return EN_INVALID_PARAM;
    }
    pDir = opendir(lpPathName);
    if (pDir == NULL) {
        return EN_INVALID_PARAM;
    }

    struct dirent *entry = NULL;
    while ((entry = readdir(pDir)) != NULL) {
        if (strcmp(".", entry->d_name) == MMPA_ZERO || strcmp("..", entry->d_name) == MMPA_ZERO) {
            continue;
        }
        CHAR buf[PATH_SIZE] = {0};
        ret = snprintf_s(buf, sizeof(buf), sizeof(buf) - 1, "%s/%s", lpPathName, entry->d_name);
        if (ret == EN_ERROR) {
            break;
        }
        pChildDir = opendir(buf);
        if (pChildDir != NULL) {
            closedir(pChildDir);
            ret = mmRmdir(buf);
            continue;
        } else {
            ret = unlink(buf);
            if (ret == EN_OK) {
                continue;
            }
    }
    }
    closedir(pDir);

    ret = rmdir(lpPathName);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmMkdir(const CHAR *lpPathName, mmMode_t mode)
{
    if (lpPathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = mkdir(lpPathName, mode);

    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32  mmAccess2(const CHAR *path, INT32 mode) {
    return EN_OK;
}


INT32 mmGetDiskFreeSpace(const char* path, mmDiskSize *diskSize)
{
    if (path == NULL || diskSize == NULL) {
        return EN_INVALID_PARAM;
    }
    struct statvfs buf;// 把文件系统信息读入 struct statvfs buf 中
    (void)memset(&buf,0,sizeof(buf)); /* unsafe_function_ignore: memset */

    INT32 ret = statvfs(path,&buf);
    if (ret == 0) {
        diskSize->totalSize = (ULONGLONG)(buf.f_blocks * buf.f_bsize);
        diskSize->availSize = (ULONGLONG)(buf.f_bavail * buf.f_bsize);
        diskSize->freeSize = (ULONGLONG)(buf.f_bfree * buf.f_bsize);
        return EN_OK;
    }
    return EN_ERROR;
}

INT32 mmRealPath(const CHAR *path, CHAR *realPath,INT32 realPathLen)
{
    INT32 ret = EN_OK;
    if (realPath == NULL || path == NULL || realPathLen < MMPA_MAX_PATH) {
        return EN_INVALID_PARAM;
    }
    char *pRet = realpath(path, realPath);  /* [false alarm]:realpath默认的系统调用 */
    if (pRet == NULL) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmGetLocalTime(mmSystemTime_t *sysTime)
{
    if (sysTime == NULL) {
        return EN_INVALID_PARAM;
    }

    struct timeval timeVal;
    (void)memset(&timeVal,0,sizeof(timeVal)); /* unsafe_function_ignore: memset */

    INT32 ret = gettimeofday(&timeVal,NULL);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    struct tm nowTime = {0};
    if(localtime_r(&timeVal.tv_sec,&nowTime) == NULL) {
        return EN_ERROR;
    }

    sysTime->wSecond = nowTime.tm_sec;
    sysTime->wMinute = nowTime.tm_min;
    sysTime->wHour = nowTime.tm_hour;
    sysTime->wDay = nowTime.tm_mday;
    sysTime->wMonth = nowTime.tm_mon + 1; // in localtime month is [0,11],but in fact month is [1,12]
    sysTime->wYear = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
    sysTime->wDayOfWeek = nowTime.tm_wday;
    sysTime->tm_yday = nowTime.tm_yday;
    sysTime->tm_isdst = nowTime.tm_isdst;
    sysTime->wMilliseconds = timeVal.tv_usec / MMPA_ONE_THOUSAND;

    return EN_OK;
}

INT32 mmSleep(UINT32 milliSecond)
{
    if (milliSecond == MMPA_ZERO) {
        return(EN_INVALID_PARAM);
    }
    unsigned int microSecond;
    if (milliSecond <= MMPA_MAX_SLEEP_MILLSECOND) {
        microSecond = milliSecond * MMPA_ONE_THOUSAND;
    } else { // 防止截断
        microSecond = 0xffffffff;
    }
    INT32 ret = usleep(microSecond);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmDup2(INT32 oldFd, INT32 newFd)
{
    if (oldFd <= MMPA_ZERO || newFd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = dup2(oldFd, newFd);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmCreateProcess(const CHAR* fileName, const mmArgvEnv *env, const CHAR* stdoutRedirectFile, mmProcess *id)
{
    if(id == NULL) {
        return EN_INVALID_PARAM;
    }
    pid_t child = 0;
    CHAR **argv = NULL;
    CHAR **envp = NULL;
    child = fork();
    if (child == EN_ERROR) {
        return EN_ERROR;
    }

    if (child == MMPA_ZERO) {
        if (stdoutRedirectFile != NULL) {
            INT32 fd = open(stdoutRedirectFile, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
            if (fd != EN_ERROR) {
                (void)mmDup2(fd, 1);
                (void)mmClose(fd);
            }
        }

        if(env != NULL) {
            if(env->argv) {
                argv = env->argv;
            }
            if(env->envp) {
                envp = env->envp;
            }
        }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"
        if(execvpe(fileName, argv, envp) < MMPA_ZERO)
#pragma GCC diagnostic pop
        {
            printf("subprocess error, errno is %s\n", strerror(errno));
            exit(1);
        }
    }
    *id = child;
    return EN_OK;
}

INT32 mmWaitPid(mmProcess pid, INT32 *status, INT32 options)
{
    if ((options != MMPA_ZERO) && (options != M_WAIT_NOHANG) && (options != M_WAIT_UNTRACED)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = waitpid(pid, status, options);
    if (ret == EN_ERROR) {
        ret = EN_ERROR;                 // 调用异常
    } else if (ret > MMPA_ZERO && ret == pid) { // 返回了子进程ID
        return EN_ERR;                  // 进程结束
    }
    return EN_OK;
}

INT32 mmGetMac(mmMacInfo **list, INT32 *count)
{
    if(list == NULL || count == NULL) {
        return EN_INVALID_PARAM;
    }
    mmMacInfo *macInfo = NULL;
    struct ifreq ifr;
    struct ifconf ifc;
    CHAR buf[2048] = {0};
    INT32 ret = 0;
    INT32 sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
    if (sock == EN_ERROR) {
        return EN_ERROR;
    }

    ifc.ifc_len = sizeof(buf);
    ifc.ifc_buf = buf;
    ret = ioctl(sock, SIOCGIFCONF, &ifc);
    if (ret == EN_ERROR) {
        (void)mmClose(sock);
        return EN_ERROR;
    }

    struct ifreq* it = ifc.ifc_req;
    INT32 len = (INT32)sizeof(struct ifreq);
    *count = (ifc.ifc_len / len);
    UINT32 needSize = (UINT32)(*count * sizeof(mmMacInfo)); //lint !e737


    macInfo = (mmMacInfo*)malloc(needSize);
    if (macInfo == NULL) {
        *count = MMPA_ZERO;
        (void)mmClose(sock);
        return EN_ERROR;
    }

    (void)memset(macInfo, 0, needSize); /* unsafe_function_ignore: memset */
    const struct ifreq* const end = it + *count;;
    INT32 i = 0;
    for (; it != end; ++it) {
        ret = strcpy_s(ifr.ifr_name, sizeof(ifr.ifr_name), it->ifr_name);
        if(ret != EOK) {
            *count = MMPA_ZERO;
            (void)mmClose(sock);
            (void)free(macInfo);
            return EN_ERROR;
        }
        ret = ioctl(sock, SIOCGIFFLAGS, &ifr);
        if (ret == MMPA_ZERO) {
            ret = ioctl(sock, SIOCGIFHWADDR, &ifr);
            if (ret == MMPA_ZERO) {
                UCHAR * ptr = (UCHAR *)&ifr.ifr_ifru.ifru_hwaddr.sa_data[0];
                ret = snprintf_s(macInfo[i].addr, sizeof(macInfo[i].addr), sizeof(macInfo[i].addr) - 1, \
                    "%02X-%02X-%02X-%02X-%02X-%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5));
                if (ret == EN_ERROR) {
                    *count = MMPA_ZERO;
                    (void)mmClose(sock);
                    (void)free(macInfo);
                    return EN_ERROR;
                }
                i++;
            }
        }
    }
    (void)mmClose(sock);

    *list = macInfo;
    return EN_OK;
}


INT32 mmGetMacFree(mmMacInfo *list, INT32 count)
{
    if(list == NULL || count < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    (void)free(list);
    list = NULL;
    return EN_OK;
}

INT32 mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    if (path == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < 0) {
        return EN_ERROR;
    }
    return count;
}

void mmScandirFree(mmDirent **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }
    int j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
}

INT32 mmGetOsName(CHAR* name, INT32 nameSize)
{
    return EN_OK;
}

INT32 mmGetOsVersion(CHAR* versionInfo, INT32 versionLength)
{
    return EN_OK;
}

static INT32 LocalLookup(CHAR *buf, UINT32 bufLen, const CHAR *pattern, CHAR *value, UINT32 valueLen)
{
    if (buf == nullptr) {
        return EN_ERROR;
    }
    CHAR *pValue = NULL;
    CHAR *pBuf = NULL;
    UINT32 len = strlen(pattern); //lint !e712

    // 空白字符过滤
    for (pBuf = buf; isspace(*pBuf); pBuf++) {}

    // 关键字匹配
    INT32 ret = strncmp(pBuf, pattern, len);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }
    // :之前空白字符过滤
    for (pBuf = pBuf + len; isspace(*pBuf); pBuf++) {}

    // :之后空白字符过滤
    for (++pBuf; isspace(*pBuf); pBuf++) {}

    pValue = pBuf;
    // 截取所需信息
    for (pBuf = buf + bufLen; isspace(*(pBuf-1)); pBuf--) {}

    *pBuf = '\0';

    ret = memcpy_s(value, valueLen, pValue, strlen(pValue) + 1);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}


static VOID LocalGetCpuProc(mmCpuDesc *cpuInfo, INT32 *physicalCount)
{
    CHAR buf[256] = {0};
    CHAR physicalID[64] = {0};
    CHAR cpuMhz[64] = {0};
    CHAR cpuCores[64] = {0};
    CHAR cpuCounts[64] = {0};

    FILE *fp = fopen("/proc/cpuinfo", "r");
    if(fp == NULL) {
        return;
    }
    while(fgets(buf, sizeof(buf), fp) != NULL) { //lint !e713
        UINT32 length = (UINT32)strlen(buf);

        if (LocalLookup(buf, length, "manufacturer", cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer)) == EN_OK) {
            ;
        } else if (LocalLookup(buf, length, "vendor_id",
            cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer)) == EN_OK) {
            ;
        } else if (LocalLookup(buf, length, "CPU implementer",
            cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer)) == EN_OK) {
            ; /* ARM and aarch64 */
        } else if (LocalLookup(buf, length, "model name", cpuInfo->version, sizeof(cpuInfo->version)) == EN_OK) {
            ;
        } else if (LocalLookup(buf, length, "cpu MHz", cpuMhz, sizeof(cpuMhz)) == EN_OK) {
            ;
        } else if (LocalLookup(buf, length, "cpu cores", cpuCores, sizeof(cpuCores)) == EN_OK) {
            ;
        } else if (LocalLookup(buf, length, "processor", cpuCounts, sizeof(cpuCounts)) == EN_OK) {
            ; // processor index + 1
        } else if (LocalLookup(buf, length, "physical id", physicalID, sizeof(physicalID)) == EN_OK) {
            ;
        }
    }
    cpuInfo->frequency = atoi(cpuMhz);
    cpuInfo->ncores = atoi(cpuCores);
    cpuInfo->ncounts = atoi(cpuCounts) + 1;
    *physicalCount += atoi(physicalID);

    (void)fclose(fp);
    return;
}

static VOID LocalGetDmiDecode(mmCpuDesc *cpuInfo)
{
    CHAR buf[256] = {0};
    CHAR cpuThreads[64] = {0};
    CHAR maxSpeed[64] = {0};
    FILE *stream = popen("dmidecode -t processor", "r");
    if(stream == NULL) {
        return;
    }
    while(fgets(buf, sizeof(buf), stream) != NULL) { //lint !e713
        UINT32 length = (UINT32)strlen(buf);
        if (LocalLookup(buf, length, "Thread Count", cpuThreads, sizeof(cpuThreads)) == EN_OK) {
            ;
        } else if (LocalLookup(buf, length, "Max Speed", maxSpeed, sizeof(maxSpeed)) == EN_OK) {
            ;
        }
    }
    cpuInfo->nthreads = atoi(cpuThreads);
    cpuInfo->maxFrequency = atoi(maxSpeed);
    (void)pclose(stream);
    return;
}

INT32 mmGetCpuInfo(mmCpuDesc **cpuInfo, INT32 *count)
{
    INT32 i = 0;
    INT32 ret = 0;
    mmCpuDesc cpuDest = {};
    // 默认一个CPU
    INT32 physicalCount = 1;
    mmCpuDesc *pCpuDesc = NULL;
    struct utsname sysInfo = {};

    LocalGetCpuProc(&cpuDest, &physicalCount);
    LocalGetDmiDecode(&cpuDest);

    UINT32 needSize = (UINT32)(physicalCount * sizeof(mmCpuDesc)); //lint !e737

    pCpuDesc = (mmCpuDesc*)malloc(needSize); /* [false alarm]:ignore fortity */
    if(pCpuDesc == NULL) {
        return EN_ERROR;
    }

    (void)memset(pCpuDesc, 0, needSize); /* unsafe_function_ignore: memset */

    if (uname(&sysInfo) == EN_OK) {
        ret = memcpy_s(cpuDest.arch, sizeof(cpuDest.arch), sysInfo.machine, strlen(sysInfo.machine) + 1);
        if(ret != EN_OK) {
            free(pCpuDesc);
            return EN_ERROR;
        }
    }

    INT32 cpuCount = physicalCount;
    for(i = 0; i < cpuCount; i++) {
        pCpuDesc[i] = cpuDest;
        //平均逻辑CPU个数
        pCpuDesc[i].ncounts = pCpuDesc[i].ncounts / cpuCount;
    }

    *cpuInfo = pCpuDesc;
    *count = cpuCount;
    return EN_OK;
}

INT32 mmCpuInfoFree(mmCpuDesc *cpuInfo, INT32 count)
{
    if(cpuInfo == NULL || count == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    (void)free(cpuInfo);
    return EN_OK;
}

INT32 mmGetPidHandle(mmProcess *pstProcessHandle)
{
    if (pstProcessHandle == NULL) {
        return EN_INVALID_PARAM;
    }
    *pstProcessHandle = (mmProcess)getpid();
    return EN_OK;
}

INT32 mmUnlink(const CHAR *filename)
{
    if (filename == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = unlink(filename);
    if (ret == EN_ERROR) {
    }
    return ret;
}

INT32 mmChdir(const CHAR *path)
{
    if (path == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = chdir(path);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return ret;
}

INT32 mmSetCurrentThreadName(const CHAR* name)
{
    if (name == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = prctl(PR_SET_NAME, name);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmOpen2(const CHAR *pathName, INT32 flags, MODE mode)
{
    UINT32 flag = (UINT32)flags;

    if (pathName == NULL) {
        return EN_INVALID_PARAM;
    }
    if (((flag & (O_TRUNC | O_WRONLY | O_RDWR | O_CREAT)) == MMPA_ZERO) && (flags != O_RDONLY)) {
        return EN_INVALID_PARAM;
    }
    if (((mode & (S_IRUSR | S_IREAD)) == MMPA_ZERO) &&
        ((mode & (S_IWUSR | S_IWRITE)) == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 fd = open(pathName, flags, mode); /* [false alarm]:ignore fortity */
    if (fd < MMPA_ZERO) {
        return EN_ERROR;
    }
    return fd;
}

mmSsize_t mmRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < MMPA_ZERO) || (buf == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = (INT32)read(fd, buf,(size_t)bufLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

mmSsize_t mmWrite(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < MMPA_ZERO) || (buf == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = (INT32)write(fd, buf,(size_t)bufLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

INT32 mmClose(INT32 fd)
{
    if (fd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = close(fd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmCloseSocket(mmSockHandle sockFd)
{
    if (sockFd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = close(sockFd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

mmSsize_t mmSocketSend(mmSockHandle sockFd,VOID *pstSendBuf,INT32 sendLen,INT32 sendFlag)
{
    if ((sockFd < MMPA_ZERO) || (pstSendBuf == NULL) || (sendLen <= MMPA_ZERO) || (sendFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 sndLen = (UINT32)sendLen;
    INT32 ret = (INT32)send(sockFd, pstSendBuf, sndLen, sendFlag);
    if (ret <= MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

mmSsize_t mmSocketRecv(mmSockHandle sockFd, VOID *pstRecvBuf,INT32 recvLen,INT32 recvFlag)
{
    if ((sockFd < MMPA_ZERO) || (pstRecvBuf == NULL) || (recvLen <= MMPA_ZERO) || (recvFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 rcvLen = (UINT32)recvLen;
    INT32 ret = (INT32)recv(sockFd, pstRecvBuf, rcvLen, recvFlag);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

mmSockHandle mmSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    INT32 socketHandle = socket(sockFamily, type, protocol);
    if (socketHandle < MMPA_ZERO) {
        return EN_ERROR;
    }
    return socketHandle;
}

INT32 mmBind(mmSockHandle sockFd, mmSockAddr* addr, mmSocklen_t addrLen)
{
    if ((sockFd < MMPA_ZERO) || (addr == NULL) || (addrLen == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = bind(sockFd, addr, addrLen);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmListen(mmSockHandle sockFd, INT32 backLog)
{
    if ((sockFd < MMPA_ZERO) || (backLog <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = listen(sockFd, backLog);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

mmSockHandle mmAccept(mmSockHandle sockFd, mmSockAddr *addr, mmSocklen_t *addrLen)
{
    if (sockFd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = accept(sockFd, addr, addrLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

INT32 mmConnect(mmSockHandle sockFd, mmSockAddr* addr, mmSocklen_t addrLen)
{
    if ((sockFd < MMPA_ZERO) || (addr == NULL) || (addrLen == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = connect(sockFd, addr, addrLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmSAStartup()
{
    return EN_OK;
}

INT32 mmSACleanup()
{
    return EN_OK;
}

INT32 mmGetPid()
{
    return (INT32)getpid();
}

INT32 mmCreateTask(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) || (funcBlock->procFunc == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_create(threadHandle, NULL, funcBlock->procFunc, funcBlock->pulArg);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }

    return ret;
}

INT32 LocalSetThreadAttr(pthread_attr_t *attr,const mmThreadAttr *threadAttr)
{
#ifndef __ANDROID__
        // 设置默认继承属性 PTHREAD_EXPLICIT_SCHED 使得调度属性生效
        if(threadAttr->policyFlag == true || threadAttr->priorityFlag == true) {
            if (pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED) != EN_OK) {
                return EN_ERROR;
            }
        }
#endif

    // 设置调度策略
    if (threadAttr->policyFlag == true) {
        if (threadAttr->policy != MMPA_THREAD_SCHED_FIFO && threadAttr->policy != MMPA_THREAD_SCHED_OTHER &&
            threadAttr->policy != MMPA_THREAD_SCHED_RR) {
            return EN_INVALID_PARAM;
        }
        if (pthread_attr_setschedpolicy(attr, threadAttr->policy) != EN_OK) {
            return EN_ERROR;
        }
    }

    // 设置优先级
    if (threadAttr->priorityFlag == true) {
        if (threadAttr->priority < MMPA_MIN_THREAD_PIO || threadAttr->priority > MMPA_MAX_THREAD_PIO) {
            return EN_INVALID_PARAM;
        }
        struct sched_param param;
        (void)memset_s(&param, sizeof(param), 0, sizeof(param));
        param.sched_priority = threadAttr->priority;
        if (pthread_attr_setschedparam(attr, &param) != EN_OK) {
            return EN_ERROR;
        }
    }

    // 设置堆栈
    if (threadAttr->stackFlag == true) {
        if (threadAttr->stackSize < MMPA_THREAD_MIN_STACK_SIZE) {
            return EN_INVALID_PARAM;
        }
        if (pthread_attr_setstacksize(attr, threadAttr->stackSize) != EN_OK) {
            return EN_ERROR;
        }
    }
    if (threadAttr->detachFlag == true) {
        // 设置默认线程分离属性
        if (pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED) != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

INT32 mmCreateTaskWithThreadAttr(mmThread *threadHandle, const mmUserBlock_t *funcBlock,
                                         const mmThreadAttr *threadAttr)
{
    if (threadHandle == NULL || funcBlock == NULL ||
        funcBlock->procFunc == NULL || threadAttr == NULL) {
        return EN_INVALID_PARAM;
    }

    pthread_attr_t attr;
    (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));

    // 初始化线程属性
    INT32 ret = pthread_attr_init(&attr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    ret = LocalSetThreadAttr(&attr,threadAttr);
    if (ret != EN_OK) {
        (void)pthread_attr_destroy(&attr);
        return ret;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (void)pthread_attr_destroy(&attr);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}
INT32 mmCreateTaskWithThreadAttrStub(mmThread *threadHandle, const mmUserBlock_t *funcBlock,
                                         const mmThreadAttr *threadAttr) 
{
    printf("start cloud thread stub");
    funcBlock->procFunc(funcBlock->pulArg);
    return EN_OK;
}

INT32 mmCreateTaskWithThreadAttrNormalStub(mmThread *threadHandle, const mmUserBlock_t *funcBlock,
                                         const mmThreadAttr *threadAttr) 
{
    if (threadHandle == NULL || funcBlock == NULL ||
        funcBlock->procFunc == NULL || threadAttr == NULL) {
        return EN_INVALID_PARAM;
    }

    pthread_attr_t attr;
    (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));

    // 初始化线程属性
    INT32 ret = pthread_attr_init(&attr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    ret = LocalSetThreadAttr(&attr,threadAttr);
    if (ret != EN_OK) {
        (void)pthread_attr_destroy(&attr);
        return ret;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (void)pthread_attr_destroy(&attr);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmJoinTask(mmThread *threadHandle)
{
    if (threadHandle == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_join(*threadHandle, NULL);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmGetErrorCode()
{
   return 0;
}

INT32 mmChmod(const CHAR *fileName, INT32 mode)
{
   return 0;
}

std::string GetAdxWorkPath()
{
    return "~/";
}

INT32 mmMutexInit(mmMutex_t *mutex)
 {
     if (mutex == NULL) {
         return EN_INVALID_PARAM;
     }
 
     INT32 ret = pthread_mutex_init(mutex, NULL);
     if (ret != EN_OK) {
         ret = EN_ERROR;
     }
 
     return ret;
 }

INT32 mmMutexLock(mmMutex_t *mutex)
 {
     if (mutex == NULL) {
         return EN_INVALID_PARAM;
     }
 
     INT32 ret = pthread_mutex_lock(mutex);
     if (ret != EN_OK) {
         ret = EN_ERROR;
     }
     return ret;
 }

 INT32 mmMutexUnLock(mmMutex_t *mutex)
 {
     if (mutex == NULL) {
         return EN_INVALID_PARAM;
     }
 
     INT32 ret = pthread_mutex_unlock(mutex);
     if (ret != EN_OK) {
         ret = EN_ERROR;
     }
     return ret;
 }

INT32 mmGetTid()
{
    INT32 ret = (INT32)syscall(SYS_gettid);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

INT32 mmStatGet(const CHAR *path, mmStat_t *buffer)
{
    if ((path == NULL) || (buffer == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = stat(path, buffer);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmGetOptLong(INT32 argc, CHAR * const * argv, const CHAR *opts, const mmStructOption *longopts, INT32 *longindex)
{
    return getopt_long(argc, argv, opts, longopts, longindex);
}

INT32 mmGetOpt(INT32 argc, CHAR * const * argv, const CHAR *opts)
{
    return getopt(argc, argv, opts);
}

char *mmGetOptArg()
{
    return optarg;
}

INT32 mmGetOptInd()
{
    return optind;
}

CHAR *mmGetErrorFormatMessage(int errnum, CHAR *buf, size_t  size)
{
    if (buf == NULL || size <= 0) {
        return NULL;
    }
    return strerror_r(errnum, buf, size);
}

INT32 mmGetCwd(CHAR *buffer, INT32 maxLen)
{
    if ((buffer == NULL) || (maxLen < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    const CHAR *ptr = getcwd(buffer, (UINT32)maxLen);
    if (ptr != NULL) {
        return EN_OK;
    } else {
        return EN_ERROR;
    }
}

typedef struct {
    mmEnvId id;
    const CHAR *name;
} mmEnvInfo;

static mmEnvInfo s_envList[] = {
    {MM_ENV_DUMP_GRAPH_PATH, "DUMP_GRAPH_PATH"},
    {MM_ENV_ACLNN_CACHE_LIMIT, "ACLNN_CACHE_LIMIT"},
    {MM_ENV_ASCEND_WORK_PATH, "ASCEND_WORK_PATH"},
    {MM_ENV_ASCEND_HOSTPID, "ASCEND_HOSTPID"},
    {MM_ENV_RANK_ID, "RANK_ID"},
    {MM_ENV_ASCEND_RT_VISIBLE_DEVICES, "ASCEND_RT_VISIBLE_DEVICES"},
    {MM_ENV_ASCEND_COREDUMP_SIGNAL, "ASCEND_COREDUMP_SIGNAL"},
    {MM_ENV_ASCEND_CACHE_PATH, "ASCEND_CACHE_PATH"},
    {MM_ENV_ASCEND_OPP_PATH, "ASCEND_OPP_PATH"},
    {MM_ENV_ASCEND_CUSTOM_OPP_PATH, "ASCEND_CUSTOM_OPP_PATH"},
    {MM_ENV_ASCEND_LOG_DEVICE_FLUSH_TIMEOUT, "ASCEND_LOG_DEVICE_FLUSH_TIMEOUT"},
    {MM_ENV_ASCEND_LOG_SAVE_MODE, "ASCEND_LOG_SAVE_MODE"},
    {MM_ENV_ASCEND_SLOG_PRINT_TO_STDOUT, "ASCEND_SLOG_PRINT_TO_STDOUT"},
    {MM_ENV_ASCEND_GLOBAL_EVENT_ENABLE, "ASCEND_GLOBAL_EVENT_ENABLE"},
    {MM_ENV_ASCEND_GLOBAL_LOG_LEVEL, "ASCEND_GLOBAL_LOG_LEVEL"},
    {MM_ENV_ASCEND_MODULE_LOG_LEVEL, "ASCEND_MODULE_LOG_LEVEL"},
    {MM_ENV_ASCEND_HOST_LOG_FILE_NUM, "ASCEND_HOST_LOG_FILE_NUM"},
    {MM_ENV_ASCEND_PROCESS_LOG_PATH, "ASCEND_PROCESS_LOG_PATH"},
    {MM_ENV_ASCEND_LOG_SYNC_SAVE, "ASCEND_LOG_SYNC_SAVE"},
    {MM_ENV_PROFILER_SAMPLECONFIG, "PROFILER_SAMPLECONFIG"},
    {MM_ENV_ACP_PIPE_FD, "ACP_PIPE_FD"},
    {MM_ENV_PROFILING_MODE, "PROFILING_MODE"},
    {MM_ENV_DYNAMIC_PROFILING_KEY_PID, "DYNAMIC_PROFILING_KEY_PID"},
    {MM_ENV_HOME, "HOME"},
    {MM_ENV_AOS_TYPE, "AOS_TYPE"},
    {MM_ENV_LD_LIBRARY_PATH, "LD_LIBRARY_PATH"},
};

static mmEnvInfo *GetEnvInfoById(mmEnvId id)
{
    ULONG i = 0;
    for (i = 0; i < sizeof(s_envList)/sizeof(s_envList[0]); ++i) {
        if (s_envList[i].id == id) {
            return &s_envList[i];
        }
    }
    return nullptr;
}

CHAR *mmSysGetEnv(mmEnvId id)
{
    mmEnvInfo *envInfo = GetEnvInfoById(id);
    if (envInfo != nullptr) {
        printf("==mmSysGetEnv==[id=%d,str=%s]", id, envInfo->name);
        return getenv(envInfo->name);
    }
    return nullptr;
}

INT32 mmSysSetEnv(mmEnvId id, const CHAR *value, INT32 overwrite)
{
    mmEnvInfo *envInfo = GetEnvInfoById(id);
    if (envInfo == nullptr) {
        return EN_INVALID_PARAM;
    }
    return setenv(envInfo->name, value, overwrite);
}