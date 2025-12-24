/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "osal_linux.h"
#include <stdbool.h>
#include <sys/time.h>
#include <pthread.h>
#include "osal_mem.h"

struct CpuInfoTable {
    CHAR physicalID[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR cpuMhz[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR cpuCores[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR cpuCnt[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR cpuImplememter[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR cpuPart[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR cpuThreads[OSAL_CPUINFO_DEFAULT_SIZE];
    CHAR maxSpeed[OSAL_CPUINFO_DEFAULT_SIZE];
};

/*
 * 描述:睡眠指定时间
 * 参数: milliSecond -- 睡眠时间 单位ms, linux下usleep函数microSecond入参必须小于1000000
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxSleep(uint32_t milliSecond)
{
    if (milliSecond == OSAL_ZERO) {
        return OSAL_EN_INVALID_PARAM;
    }
    uint32_t microSecond;

    // 防止截断
    if (milliSecond <= OSAL_MAX_SLEEP_MILLSECOND_USING_USLEEP) {
        microSecond = milliSecond * (uint32_t)OSAL_MSEC_TO_USEC;
    } else {
        microSecond = OSAL_MAX_SLEEP_MICROSECOND_USING_USLEEP;
    }

    int32_t ret = usleep(microSecond);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:获取进程ID
 * 参数:无
 * 返回值:执行成功返回对应调用进程的id, 执行错误返回OSAL_EN_ERROR
 */
int32_t LinuxGetPid(void)
{
    return (int32_t)(getpid());
}

/*
 * 描述:获取调用线程的线程ID
 * 参数:无
 * 返回值:执行成功返回对应调用线程的id, 执行错误返回OSAL_EN_ERROR
 */
int32_t LinuxGetTid(void)
{
    return OSAL_EN_ERROR;
}

/*
 * 描述:创建socket
 * 参数: sockFamily--协议域
 *       type--指定socket类型
 *       protocol--指定协议
 * 返回值:执行成功返回创建的socket id, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSockHandle LinuxSocket(int32_t sockFamily, int32_t type, int32_t protocol)
{
    (void)sockFamily;
    (void)type;
    (void)protocol;
    return OSAL_EN_ERROR;
}

/*
 * 描述:把一个地址族中的特定地址赋给socket
 * 参数: sockFd--socket描述字，通过LinuxSocket函数创建
 *       addr--一个指向要绑定给sockFd的协议地址
 *       addrLen--对应地址的长度
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxBind(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen)
{
    (void)sockFd;
    (void)addr;
    (void)addrLen;
    return OSAL_EN_ERROR;
}

/*
 * 描述:监听socket
 * 参数: sockFd--socket描述字，通过LinuxSocket函数创建
 *       backLog--相应socket可以排队的最大连接个数
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxListen(OsalSockHandle sockFd, int32_t backLog)
{
    (void)sockFd;
    (void)backLog;
    return OSAL_EN_ERROR;
}

/*
 * 描述:监听指定的socket地址
 * 参数: sockFd--socket描述字，通过LinuxSocket函数创建
 *       addr--用于返回客户端的协议地址, addr若为nullptr, addrLen也应该为nullptr
 *       addrLen--协议地址的长度
 * 返回值:执行成功返回自动生成的一个全新的socket id, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSockHandle LinuxAccept(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen *addrLen)
{
    (void)sockFd;
    (void)addr;
    (void)addrLen;
    return OSAL_EN_ERROR;
}

/*
 * 描述:发出socket连接请求
 * 参数:sockFd--socket描述字，通过LinuxSocket函数创建
 *      addr--服务器的socket地址
 *      addrLen--地址的长度
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxConnect(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen)
{
    (void)sockFd;
    (void)addr;
    (void)addrLen;
    return OSAL_EN_ERROR;
}

/*
 * 描述:在建立连接的socket上发送数据
 * 参数: sockFd--已建立连接的socket描述字
 *       pstSendBuf--需要发送的数据缓存，有用户分配
 *       sendLen--需要发送的数据长度
 *       sendFlag--发送的方式标志位，一般置0
 * 返回值:执行成功返回实际发送的buf长度, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSsize LinuxSocketSend(
    OsalSockHandle sockFd, VOID *sendBuf, int32_t sendLen, int32_t sendFlag)
{
    (void)sockFd;
    (void)sendBuf;
    (void)sendLen;
    (void)sendFlag;
    return OSAL_EN_ERROR;
}

/*
 * 描述:在建立连接的socket上接收数据
 * 参数: sockFd--已建立连接的socket描述字
 *       pstRecvBuf--存放接收的数据的缓存，用户分配
 *       recvLen--需要发送的数据长度
 *       recvFlag--接收的方式标志位，一般置0
 * 返回值:执行成功返回实际接收的buf长度, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSsize LinuxSocketRecv(
    OsalSockHandle sockFd, VOID *recvBuf, int32_t recvLen, int32_t recvFlag)
{
    (void)sockFd;
    (void)recvBuf;
    (void)recvLen;
    (void)recvFlag;
    return OSAL_EN_ERROR;
}

/*
 * 描述:获取错误码
 * 返回值:error code
 */
int32_t LinuxGetErrorCode(void)
{
    int32_t ret = (int32_t)errno;
    return ret;
}

/*
 * 描述:新创建进程执行可执行程序或者指定命令或者重定向输出文件
 * 参数:fileName--需要执行的可执行程序所在路径名
 *      env--保存子进程的状态信息
 *      stdoutRedirectFile--重定向文件路径, 若不为空, 则启用重定向功能
 *      id--创建的子进程ID号
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxCreateProcess(const CHAR *fileName, const OsalArgvEnv *env,
    const CHAR *stdoutRedirectFile, OsalProcess *id)
{
    (void)fileName;
    (void)env;
    (void)stdoutRedirectFile;
    (void)id;
    return OSAL_EN_ERROR;
}

/*
 * 描述:mmCreateTaskWithThreadAttr内部使用,设置线程调度相关属性
 * 参数: attr -- 线程属性结构体
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
static int32_t LocalSetSchedAttr(pthread_attr_t *attr, const OsalThreadAttr *threadAttr)
{
#ifndef __ANDROID__
    // 设置默认继承属性 PTHREAD_EXPLICIT_SCHED 使得调度属性生效
    if ((threadAttr->policyFlag == true) || (threadAttr->priorityFlag == true)) {
        if (pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED) != OSAL_EN_OK) {
            return OSAL_EN_ERROR;
        }
    }
#endif

    // 设置调度策略
    if (threadAttr->policyFlag == true) {
        if ((threadAttr->policy != OSAL_THREAD_SCHED_FIFO) && (threadAttr->policy != OSAL_THREAD_SCHED_OTHER) &&
            (threadAttr->policy != OSAL_THREAD_SCHED_RR)) {
            return OSAL_EN_INVALID_PARAM;
        }
        if (pthread_attr_setschedpolicy(attr, threadAttr->policy) != OSAL_EN_OK) {
            return OSAL_EN_ERROR;
        }
    }

    // 设置优先级
    if (threadAttr->priorityFlag == true) {
        if ((threadAttr->priority < OSAL_MIN_THREAD_PIO) || (threadAttr->priority > OSAL_MAX_THREAD_PIO)) {
            return OSAL_EN_INVALID_PARAM;
        }
        struct sched_param param;
        (VOID)memset_s(&param, sizeof(param), 0, sizeof(param)); /* unsafe_function_ignore: memset */
        param.sched_priority = threadAttr->priority;
        if (pthread_attr_setschedparam(attr, &param) != OSAL_EN_OK) {
            return OSAL_EN_ERROR;
        }
    }
    return OSAL_EN_OK;
}

/*
 * 描述:LinuxCreateTaskWithThreadAttr内部使用,创建带属性的线程, 支持调度策略、优先级、线程栈大小属性设置
 * 参数: attr -- 线程属性结构体
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
static int32_t LinuxLocalSetThreadAttr(pthread_attr_t *attr, const OsalThreadAttr *threadAttr)
{
    // 设置调度相关属性
    int32_t ret = LocalSetSchedAttr(attr, threadAttr);
    if (ret != OSAL_EN_OK) {
        return ret;
    }

    // 设置堆栈
    if (threadAttr->stackFlag == true) {
        if (threadAttr->stackSize < OSAL_THREAD_MIN_STACK_SIZE) {
            return OSAL_EN_INVALID_PARAM;
        }
        if (pthread_attr_setstacksize(attr, threadAttr->stackSize) != OSAL_EN_OK) {
            return OSAL_EN_ERROR;
        }
    }
    if (threadAttr->detachFlag == true) {
        // 设置默认线程分离属性
        if (pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED) != OSAL_EN_OK) {
            return OSAL_EN_ERROR;
        }
    }
    return OSAL_EN_OK;
}

/*
 * 描述:创建带属性的线程, 支持调度策略、优先级、线程栈大小、分离属性设置,除了分离属性,其他只在Linux下有效
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxCreateTaskWithThreadAttr(OsalThread *threadHandle,
    const OsalUserBlock *funcBlock, const OsalThreadAttr *threadAttr)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) ||
        (funcBlock->procFunc == NULL) || (threadAttr == NULL)) {
        return OSAL_EN_INVALID_PARAM;
    }

    pthread_attr_t attr;
    (VOID)memset_s(&attr, sizeof(attr), 0, sizeof(attr)); /* unsafe_function_ignore: memset */

    // 初始化线程属性
    int32_t ret = pthread_attr_init(&attr);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    ret = LinuxLocalSetThreadAttr(&attr, threadAttr);
    if (ret != OSAL_EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return ret;
    }
    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (VOID)pthread_attr_destroy(&attr);
    if (ret != OSAL_EN_OK) {
        ret = OSAL_EN_ERROR;
    }
    return ret;
}

/*
 * 描述:等待子进程结束并返回对应结束码
 * 参数:pid--欲等待的子进程ID
 *      status--保存子进程的状态信息
 *      options--options提供了一些另外的选项来控制waitpid()函数的行为
 *               OSAL_WAIT_NOHANG--如果pid指定的子进程没有结束，则立即返回;如果结束了, 则返回该子进程的进程号
 *               OSAL_WAIT_UNTRACED--如果子进程进入暂停状态，则马上返回
 * 返回值:子进程未结束返回EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 *        进程已经结束返回EN_ERR
 */
int32_t LinuxWaitPid(OsalProcess pid, int32_t *status, int32_t options)
{
    (void)pid;
    (void)status;
    (void)options;
    return OSAL_EN_ERROR;
}

/*
 * 描述:该函数等待线程结束并返回线程退出值"value_ptr"
 *       如果线程成功结束会detach线程
 *       注意:detached的线程不能用该函数或取消
 * 参数: threadHandle-- pthread_t类型的实例
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxJoinTask(OsalThread *threadHandle)
{
    if (threadHandle == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    int32_t ret = pthread_join(*threadHandle, NULL);
    if (ret != OSAL_EN_OK) {
        ret = OSAL_EN_ERROR;
    }
    return ret;
}

/*
 * 描述:获取系统开机到现在经过的时间
 * 返回值:执行成功返回类型OsalTimespec结构的时间
 */
OsalTimespec LinuxGetTickCount(void)
{
    OsalTimespec rts = {0, 0};
    struct timespec ts = {0, 0};
    (VOID)clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    rts.tv_sec = ts.tv_sec;
    rts.tv_nsec = ts.tv_nsec;
    return rts;
}

/*
 * 描述:获取当前工作目录路径
 * 参数:buffer--由用户分配用来存放工作目录路径的缓存
 *      maxLen--缓存长度
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetCwd(CHAR *buffer, int32_t maxLen)
{
    if ((buffer == NULL) || (maxLen < OSAL_ZERO)) {
        return OSAL_EN_INVALID_PARAM;
    }
    const CHAR *ptr = getcwd(buffer, (uint32_t)(maxLen));
    if (ptr != NULL) {
        return OSAL_EN_OK;
    } else {
        return OSAL_EN_ERROR;
    }
}

/*
 * 描述:获取当前指定路径下文件大小
 * 参数:fileName--文件路径名
 *      length--获取到的文件大小
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetFileSize(const CHAR *fileName, uint64_t *length)
{
    if ((fileName == NULL) || (length == NULL)) {
        return OSAL_EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (VOID)memset_s(&fileStat, sizeof(fileStat), 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    int32_t ret = lstat(fileName, &fileStat);
    if (ret < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }
    *length = (uint64_t)fileStat.st_size;
    return OSAL_EN_OK;
}

/*
 * 描述:获取当前指定路径下磁盘容量及可用空间
 * 参数:path--路径名
 *      diskSize--OsalDiskSize结构内容
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetDiskFreeSpace(const CHAR *path, OsalDiskSize *diskSize)
{
    if ((path == NULL) || (diskSize == NULL)) {
        return OSAL_EN_INVALID_PARAM;
    }

    // 把文件系统信息读入 struct statvfs buf 中
    struct statvfs buf;
    (VOID)memset_s(&buf, sizeof(buf), 0, sizeof(buf)); /* unsafe_function_ignore: memset */

    int32_t ret = statvfs(path, &buf);
    if (ret == OSAL_ZERO) {
        diskSize->totalSize = (uint64_t)(buf.f_blocks) * (uint64_t)(buf.f_bsize);
        diskSize->availSize = (uint64_t)(buf.f_bavail) * (uint64_t)(buf.f_bsize);
        diskSize->freeSize = (uint64_t)(buf.f_bfree) * (uint64_t)(buf.f_bsize);
        return OSAL_EN_OK;
    }
    return OSAL_EN_ERROR;
}

/*
 * 描述:判断是否是目录
 * 参数: fileName -- 文件路径名
 * 返回值:执行成功返回OSAL_EN_OK(是目录), 执行错误返回OSAL_EN_ERROR(不是目录), 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxIsDir(const CHAR *fileName)
{
    if (fileName == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (VOID)memset_s(&fileStat, sizeof(fileStat), 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    int32_t ret = lstat(fileName, &fileStat);
    if (ret < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }

    if (S_ISDIR(fileStat.st_mode) == 0) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数: pathName -- 文件路径名
 * 参数: mode -- 权限
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxAccess2(const CHAR *pathName, int32_t mode)
{
    if (pathName == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    int32_t ret = access(pathName, mode);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数: pathName -- 文件路径名
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxAccess(const CHAR *pathName)
{
    return LinuxAccess2(pathName, F_OK);
}

/*
 * 描述:截取目录, 比如/usr/bin/test, 截取后为 /usr/bin
 * 参数:path--路径，函数内部会修改path的值
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回nullptr
 */
CHAR *LinuxDirName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    return dirname(path);
}

/*
 * 描述:截取目录后面的部分, 比如/usr/bin/test, 截取后为 test
 * 参数:path--路径，函数内部会修改path的值(行尾有\\会去掉)
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回nullptr
 */
CHAR *LinuxBaseName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    return basename(path);
}

/*
 * 描述:创建一个目录
 * 参数: pathName -- 需要创建的目录路径名, 比如 CHAR dirName[256]="/home/test";
 *       mode -- 新目录的权限
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxMkdir(const CHAR *pathName, OsalMode mode)
{
    if (pathName == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    int32_t ret = mkdir(pathName, mode);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:修改文件读写权限，目前仅支持读写权限修改
 * 参数:filename--文件路径
 *      mode--需要修改的权限
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxChmod(const CHAR *filename, int32_t mode)
{
    if (filename == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    return chmod(filename, (uint32_t)(mode));
}

/*
 * 描述:改变当前工作目录
 * 参数:path--需要切换到的工作目录
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxChdir(const CHAR *path)
{
    (void)path;
    return OSAL_EN_ERROR;
}

/*
 * 描述:扫描目录
 * 参数:path--目录路径
 *      filterFunc--用户指定的过滤回调函数
 *      sort--用户指定的排序回调函数
 *      entryList--扫描到的目录结构指针, 用户不需要分配缓存, 内部分配, 需要调用LinuxScandirFree释放
 * 返回值:执行成功返回扫描到的子目录数量, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxScandir(const CHAR *path, OsalDirent ***entryList, OsalFilter filterFunc, OsalSort sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return OSAL_EN_INVALID_PARAM;
    }
    int32_t count = scandir(path, entryList, filterFunc, sort);
    if (count < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }
    return count;
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:entryList--LinuxScandir扫描到的目录结构指针
 *      count--扫描到的子目录数量
 * 返回值:无
 */
VOID LinuxScandirFree(OsalDirent **entryList, int32_t count)
{
    if (entryList == NULL) {
        return;
    }
    int32_t j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            OsalFree(entryList[j]);
            entryList[j] = NULL;
        }
    }
    OsalFree(entryList);
}

static int32_t DataPackaged(CHAR *buf, size_t bufSize, const struct dirent *entry, const CHAR *pathName)
{
    int32_t ret = memset_s(buf, bufSize, 0, bufSize);
    if (ret != EOK) {
        OsalFree(buf);
        buf = NULL;
        return OSAL_EN_ERROR;
    }
    ret = snprintf_s(buf, bufSize, bufSize - 1U, "%s/%s", pathName, entry->d_name);
    if (ret == OSAL_EN_ERROR) {
        OsalFree(buf);
        buf = NULL;
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:删除目录下所有文件及目录, 包括子目录
 * 参数: pathName -- 目录名全路径
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxRmdir(const CHAR *pathName)
{
    int32_t ret;
    DIR *childDir = NULL;

    if (pathName == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }
    DIR *dir = opendir(pathName);
    if (dir == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    const struct dirent *entry = NULL;
    size_t bufSize = strlen(pathName) + (size_t)(OSAL_PATH_SIZE + 2); // make sure the length is large enough
    while ((entry = readdir(dir)) != NULL) {
        if ((strcmp(".", entry->d_name) == OSAL_ZERO) || (strcmp("..", entry->d_name) == OSAL_ZERO)) {
            continue;
        }
        if (bufSize == 0 || bufSize > OSAL_MAX_PATH) {
            (VOID)closedir(dir);
            return OSAL_EN_INVALID_PARAM;
        }
        CHAR *buf = (CHAR *)OsalMalloc(bufSize);
        if (buf == NULL) {
            break;
        }
        ret = DataPackaged(buf, bufSize, entry, pathName);
        if (ret != OSAL_EN_OK) {
            break;
        }

        childDir = opendir(buf);
        if (childDir != NULL) {
            (VOID)closedir(childDir);
            (VOID)LinuxRmdir(buf);
            OsalFree(buf);
            buf = NULL;
            continue;
        } else {
            ret = unlink(buf);
            if (ret == OSAL_EN_OK) {
                OsalFree(buf);
                continue;
            }
        }
        OsalFree(buf);
        buf = NULL;
    }
    (VOID)closedir(dir);

    ret = rmdir(pathName);
    if (ret == OSAL_EN_ERROR) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:删除一个文件
 * 参数:filename--文件路径
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxUnlink(const CHAR *filename)
{
    if (filename == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    return unlink(filename);
}

/*
 * 描述:将参数path所指的相对路径转换成绝对路径
 * 参数: path--原始路径相对路径
 *       realPath--规范化后的绝对路径, 由用户分配内存
 *       realPathLen--realPath缓存的长度, 长度必须要>= OSAL_MAX_PATH
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxRealPath(const CHAR *path, CHAR *realPath, int32_t realPathLen)
{
    int32_t ret = OSAL_EN_OK;
    if ((realPath == NULL) || (path == NULL) || (realPathLen < OSAL_MAX_PATH)) {
        return OSAL_EN_INVALID_PARAM;
    }
    const CHAR *ptr = realpath(path, realPath);
    if (ptr == NULL) {
        ret = OSAL_EN_ERROR;
    }
    return ret;
}

/*
* 描述：将LinuxGetErrorCode函数得到的错误信息转化成字符串信息
* 参数： errnum--错误码，即LinuxGetErrorCode的返回值
*       buf--收错误信息描述的缓冲区指针
*       size--缓冲区的大小
* 返回值:成功返回错误信息的字符串，失败返回nullptr
*/
CHAR *LinuxGetErrorFormatMessage(OsalErrorMsg errnum, CHAR *buf, OsalSize size)
{
    (void)errnum;
    (void)buf;
    (void)size;
    return NULL;
}

/*
 * 描述:获取文件状态
 * 参数: path--需要获取的文件路径名
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxStatGet(const CHAR *path, OsalStat *buffer)
{
    (void)path;
    (void)buffer;
    return OSAL_EN_ERROR;
}

/*
 * 描述:复制一个文件的描述符
 * 参数:oldFd -- 需要复制的fd
 *      newFd -- 新的生成的fd
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxDup(int32_t oldFd, int32_t newFd)
{
    (void)oldFd;
    (void)newFd;
    return OSAL_EN_ERROR;
}

/*
 * 描述:打开或者创建一个文件
 * 参数: pathName--需要打开或者创建的文件路径名，由用户确保绝对路径
 *       flags--打开或者创建的文件标志位
 *       mode -- 打开或者创建的权限
 * 返回值:执行成功返回对应打开的文件描述符, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxOpen(const CHAR *pathName, int32_t flags, OsalMode mode)
{
    if ((pathName == NULL) || (flags < OSAL_ZERO)) {
        return OSAL_EN_INVALID_PARAM;
    }
    uint32_t tmp = (uint32_t)(flags);

    if (((tmp & ((uint32_t)O_TRUNC | (uint32_t)O_WRONLY | (uint32_t)O_RDWR |
        (uint32_t)O_CREAT)) == OSAL_ZERO) && (flags != O_RDONLY)) {
        return OSAL_EN_INVALID_PARAM;
    }
    if (((mode & ((uint32_t)S_IRUSR | (uint32_t)S_IREAD)) == (uint32_t)OSAL_ZERO)
        && ((mode & ((uint32_t)S_IWUSR | (uint32_t)S_IWRITE)) == (uint32_t)OSAL_ZERO)) {
        return OSAL_EN_INVALID_PARAM;
    }

    int32_t fd = open(pathName, flags, mode);
    if (fd < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }
    return fd;
}

/*
 * 描述:关闭打开的文件
 * 参数: fd--指向打开文件的资源描述符
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxClose(int32_t fd)
{
    if (fd < OSAL_ZERO) {
        return OSAL_EN_INVALID_PARAM;
    }

    int32_t ret = close(fd);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:写数据到一个资源文件中
 * 参数:fd--指向打开文件的资源描述符
 *       buf--需要写入的数据
 *       bufLen--需要写入的数据长度
 * 返回值:执行成功返回写入的长度, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSsize LinuxWrite(int32_t fd, VOID *buf, uint32_t bufLen)
{
    if ((fd < OSAL_ZERO) || (buf == NULL)) {
        return OSAL_EN_INVALID_PARAM;
    }

    OsalSsize ret = write(fd, buf, (size_t)bufLen);
    if (ret < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }
    return ret;
}

/*
 * 描述:设置当前执行的线程的线程名-线程体内调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:name--需要设置的线程名
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxSetCurrentThreadName(const CHAR* name)
{
    if (name == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }
    int32_t ret = prctl(PR_SET_NAME, name);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:获取变量optind的值
 * 返回值：获取到optind的值
 */
int32_t LinuxGetOptInd(void)
{
    return optind;
}

/*
* 描述:获取变量optarg的值
* 返回值：获取到optarg的指针
*/
CHAR *LinuxGetOptArg(void)
{
    return optarg;
}

/*
 * 描述:获取系统名字
 * 参数:nameSize--存放系统名的缓存长度
 *      name--由用户分配缓存, 缓存长度必须>=OSAL_MIN_OS_VERSION_SIZE
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAMs
 */
int32_t LinuxGetOsName(CHAR* name, int32_t nameSize)
{
    if ((name == NULL) || (nameSize < OSAL_MIN_OS_NAME_SIZE)) {
        return OSAL_EN_INVALID_PARAM;
    }
    uint32_t length = (uint32_t)(nameSize);
    int32_t ret = gethostname(name, length);
    if (ret < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:加载一个动态库中的符号
 * 参数:fileName--动态库文件名
 *      mode--打开方式
 * 返回值:执行成功返回动态链接库的句柄, 执行错误返回nullptr, 入参检查错误返回nullptr
 */
VOID *LinuxDlopen(const CHAR *fileName, int32_t mode)
{
    if ((fileName == NULL) || (mode < 0)) {
        return NULL;
    }

    return dlopen(fileName, mode);
}

/*
 * 描述:获取LinuxDlopen打开的动态库中的指定符号地址
 * 参数: handle--LinuxDlopen 返回的指向动态链接库指针
 *       funcName--要求获取的函数的名称
 * 返回值:执行成功返回指向函数的地址, 执行错误返回nullptr, 入参检查错误返回nullptr
 */
VOID *LinuxDlsym(VOID *handle, const CHAR *funcName)
{
    if ((handle == NULL) || (funcName == NULL)) {
        return NULL;
    }

    return dlsym(handle, funcName);
}

/*
 * 描述:关闭LinuxDlopen加载的动态库
 * 参数: handle--LinuxDlopen 返回的指向动态链接库指针
 *       funcName--要求获取的函数的名称
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxDlclose(VOID *handle)
{
    if (handle == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    int32_t ret = dlclose(handle);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:当LinuxDlopen动态链接库操作函数执行失败时，LinuxDlerror可以返回出错信息
 * 返回值:执行成功返回nullptr
 */
CHAR *LinuxDlerror(void)
{
    return dlerror();
}

/*
 * 描述:分析命令行参数-长参数
 * 参数:argc--传递的参数个数
 *      argv--传递的参数内容
 *      opts--用来指定可以处理哪些选项
 *      longOpts--指向一个OsalStructOption的数组
 *      longIndex--表示长选项在longopts中的位置
 * 返回值:执行错误, 找不到选项元素, 返回EN_ERROR
 */
int32_t LinuxGetOptLong(int32_t argc, CHAR *const *argv, const CHAR *opts,
    const OsalStructOption *longOpts, int32_t *longIndex)
{
    return getopt_long(argc, argv, opts, longOpts, longIndex);
}

/*
 * 描述:获取当前操作系统版本信息
 * 参数:versionLength--存放操作系统信息的缓存长度
 *      versionInfo--由用户分配缓存, 缓存长度必须>=OSAL_MIN_OS_VERSION_SIZE
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetOsVersion(CHAR *versionInfo, int32_t versionLength)
{
    if ((versionInfo == NULL) || (versionLength < OSAL_MIN_OS_VERSION_SIZE)) {
        return OSAL_EN_INVALID_PARAM;
    }
    int32_t ret = 0;
    struct utsname sysInfo;
    (VOID)memset_s(&sysInfo, sizeof(sysInfo), 0, sizeof(sysInfo)); /* unsafe_function_ignore: memset */
    uint32_t length = (uint32_t)(versionLength);
    size_t len = (size_t)(length);
    int32_t fb = uname(&sysInfo);
    if (fb < OSAL_ZERO) {
        return OSAL_EN_ERROR;
    } else {
        ret = snprintf_s(versionInfo, len, (len - 1U), "%s-%s-%s",
            sysInfo.sysname, sysInfo.release, sysInfo.version);
        if (ret == OSAL_EN_ERROR) {
            return OSAL_EN_ERROR;
        }
        return OSAL_EN_OK;
    }
}

/*
 * 描述:内部使用, 查找是否存在关键字的信息,buf为 xxx   :   xxx 形式
 * 参数:buf--需要查找的当前行数的字符串
 *      bufLen--字符串长度
 *      pattern--关键字子串
 *      value--查找到后存放关键信息的缓存
 *      valueLen--缓存长度
 * 返回值:执行成功返回EN_OK, 执行失败返回EN_ERROR
 */
static int32_t LocalLookup(CHAR *buf, uint32_t bufLen, const CHAR *pattern, CHAR *value, size_t valueLen)
{
    if (buf == NULL || bufLen == 0) {
        return OSAL_EN_ERROR;
    }
    const CHAR *pValue = NULL;
    CHAR *pBuf = NULL;
    size_t len = strlen(pattern);

    // 空白字符过滤
    for (pBuf = buf; isspace((unsigned char)*pBuf) != 0; pBuf++) {}

    int32_t ret = strncmp(pBuf, pattern, len);
    if (ret != OSAL_ZERO) {
        return OSAL_EN_ERROR;
    }

    for (pBuf = pBuf + len; isspace((unsigned char)*pBuf) != 0; pBuf++) {}
    if (*pBuf == '\0') {
        return OSAL_EN_ERROR;
    }

    for (pBuf = pBuf + 1; isspace((unsigned char)*pBuf) != 0; pBuf++) {}

    pValue = pBuf;
    for (pBuf = buf + bufLen; isspace((unsigned char)*(pBuf - 1)) != 0; pBuf--) {}

    *pBuf = '\0';
    ret = memcpy_s(value, valueLen, pValue, strlen(pValue) + 1U);
    if (ret != EOK) {
        return OSAL_EN_ERROR;
    }
    return OSAL_EN_OK;
}

/*
 * 描述:内部使用, miniRC环境下通过拼接获取arm信息
 * 参数:cpuImplememter--存放cpuImplememter信息指针
 *      implememterLen--指针长度
 *      cpuPart--存放cpuPart信息指针
 *      partLen--指针长度
 * 返回值:无
 */
static const CHAR* LocalGetArmVersion(const CHAR *cpuImplememter, const CHAR *cpuPart)
{
    static struct CpuTypeTable paramatersTable[] = {
        { "0x410xd03", "ARMv8_Cortex_A53"},
        { "0x410xd05", "ARMv8_Cortex_A55"},
        { "0x410xd07", "ARMv8_Cortex_A57"},
        { "0x410xd08", "ARMv8_Cortex_A72"},
        { "0x410xd09", "ARMv8_Cortex_A73"},
        { "0x480xd01", "TaishanV110"}
    };
    CHAR cpuArmVersion[OSAL_CPUINFO_DOUBLE_SIZE] = {0};
    int32_t ret = snprintf_s(cpuArmVersion, sizeof(cpuArmVersion), sizeof(cpuArmVersion) - 1U,
                           "%s%s", cpuImplememter, cpuPart);
    if (ret == OSAL_EN_ERROR) {
        return NULL;
    }
    int32_t i = 0;
    for (i = (int32_t)(sizeof(paramatersTable) / sizeof(paramatersTable[0])) - 1; i >= 0; i--) {
        ret = strcasecmp(cpuArmVersion, paramatersTable[i].key);
        if (ret == 0) {
            return paramatersTable[i].value;
        }
    }
    return NULL;
}

/*
 * 描述:内部使用, miniRC环境下通过cpuImplememter获取manufacturer信息
 * 参数:cpuImplememter--存放cpuImplememter信息指针
 *      cpuInfo--存放获取的物理CPU信息
 * 返回值:无
 */

static VOID LocalGetArmManufacturer(const CHAR *cpuImplememter, OsalCpuDesc *cpuInfo)
{
    size_t len = strlen(cpuInfo->manufacturer);
    if (len != 0U) {
        return;
    }
    int32_t ret = OSAL_EN_ERROR;
    static struct CpuTypeTable manufacturerTable[] = {
        { "0x41", "ARM"},
        { "0x42", "Broadcom"},
        { "0x43", "Cavium"},
        { "0x44", "DigitalEquipment"},
        { "0x48", "HiSilicon"},
        { "0x49", "Infineon"},
        { "0x4D", "Freescale"},
        { "0x4E", "NVIDIA"},
        { "0x50", "APM"},
        { "0x51", "Qualcomm"},
        { "0x56", "Marvell"},
        { "0x69", "Intel"}
    };

    int32_t i = 0;
    for (i = (int32_t)(sizeof(manufacturerTable) / sizeof(manufacturerTable[0])) - 1; i >= 0; --i) {
        ret = strcasecmp(cpuImplememter, manufacturerTable[i].key);
        if (ret == 0) {
            (VOID)memcpy_s(cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer),
                manufacturerTable[i].value, (strlen(manufacturerTable[i].value) + 1U));
            return;
        }
    }
    return;
}

static int32_t CpuInfoStrToInt(const CHAR *str)
{
    if (str == NULL) {
        return 0;
    }

    errno = 0;
    char *endPtr = NULL;
    const int32_t decimalBase = 10;
    int64_t out = strtol(str, &endPtr, decimalBase);
    if (str == endPtr || *endPtr != '\0') {
        return 0;
    } else if ((out == LONG_MIN || out == LONG_MAX) && (errno == ERANGE)) {
        return 0;
    } else {
        if (out <= INT_MAX && out >= INT_MIN) {
            return (int32_t)out;
        } else {
            return 0;
        }        
    }
}

static VOID LocalLookupCpuInfo(struct CpuInfoTable infoTab, OsalCpuDesc *cpuInfo, FILE *fp)
{
    uint32_t length = 0U;
    CHAR buf[OSAL_CPUPROC_BUF_SIZE] = {0};
    while (fgets(buf, (int32_t)(sizeof(buf)), fp) != NULL) {
        length = (uint32_t)(strlen(buf));
        if (LocalLookup(buf, length, "manufacturer", cpuInfo->manufacturer,
            sizeof(cpuInfo->manufacturer)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "vendor_id", cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "CPU implementer", infoTab.cpuImplememter,
            sizeof(infoTab.cpuImplememter)) == OSAL_EN_OK) {
            continue; /* ARM and aarch64 */
        }
        if (LocalLookup(buf, length, "CPU part", infoTab.cpuPart, sizeof(infoTab.cpuPart)) == OSAL_EN_OK) {
            continue; /* ARM and aarch64 */
        }
        if (LocalLookup(buf, length, "model name", cpuInfo->version, sizeof(cpuInfo->version)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "cpu MHz", infoTab.cpuMhz, sizeof(infoTab.cpuMhz)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "cpu cores", infoTab.cpuCores, sizeof(infoTab.cpuCores)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "processor", infoTab.cpuCnt, sizeof(infoTab.cpuCnt)) == OSAL_EN_OK) {
            continue; // processor index + 1
        }
        if (LocalLookup(buf, length, "physical id", infoTab.physicalID, sizeof(infoTab.physicalID)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "Thread Count", infoTab.cpuThreads, sizeof(infoTab.cpuThreads)) == OSAL_EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "Max Speed", infoTab.maxSpeed, sizeof(infoTab.maxSpeed)) == OSAL_EN_OK) {
            ;
        }
    }
}

/*
 * 描述:内部使用, 读取/proc/cpuinfo信息中的部分信息
 * 参数:cpuInfo--存放获取的物理CPU信息
 *      physicalCount--物理CPU个数
 * 返回值:无
 */
static VOID LocalGetCpuProc(OsalCpuDesc *cpuInfo, int32_t *physicalCount)
{
    struct CpuInfoTable cpuInfoTable;
    (VOID)memset_s(&cpuInfoTable, sizeof(cpuInfoTable), 0, sizeof(cpuInfoTable));
    FILE *fp = fopen("/proc/cpuinfo", "r");
    if (fp == NULL) {
        return;
    }
    LocalLookupCpuInfo(cpuInfoTable, cpuInfo, fp);
    (VOID)fclose(fp);
    fp = NULL;
    cpuInfo->frequency = CpuInfoStrToInt(cpuInfoTable.cpuMhz);
    cpuInfo->ncores = CpuInfoStrToInt(cpuInfoTable.cpuCores);
    cpuInfo->ncounts = CpuInfoStrToInt(cpuInfoTable.cpuCnt) + 1;
    *physicalCount += CpuInfoStrToInt(cpuInfoTable.physicalID);
    cpuInfo->nthreads = CpuInfoStrToInt(cpuInfoTable.cpuThreads);
    cpuInfo->maxFrequency = CpuInfoStrToInt(cpuInfoTable.maxSpeed);
    const CHAR* tmp = LocalGetArmVersion(cpuInfoTable.cpuImplememter, cpuInfoTable.cpuPart);
    if (tmp != NULL) {
        (VOID)memcpy_s(cpuInfo->version, sizeof(cpuInfo->version), tmp, strlen(tmp) + 1U);
    }
    LocalGetArmManufacturer(cpuInfoTable.cpuImplememter, cpuInfo);
    return;
}

/*
 * 描述:获取当前系统cpu的部分物理硬件信息
 * 参数:cpuInfo--包含需要获取信息的结构体, 函数内部分配, 需要调用LinuxCpuInfoFree释放
 *      count--读取到的物理cpu个数
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetCpuInfo(OsalCpuDesc **cpuInfo, int32_t *count)
{
    if (count == NULL || cpuInfo == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }
    int32_t ret = 0;
    OsalCpuDesc cpuDest = {};
    (VOID)memset_s(&cpuDest, sizeof(cpuDest), 0, sizeof(cpuDest));
    // 默认一个CPU
    int32_t physicalCount = 1;
    OsalCpuDesc *pCpuDesc = NULL;
    struct utsname sysInfo = {};
    (VOID)memset_s(&sysInfo, sizeof(sysInfo), 0, sizeof(sysInfo));
    LocalGetCpuProc(&cpuDest, &physicalCount);

    if ((physicalCount < OSAL_MIN_PHYSICALCPU_COUNT) || (physicalCount > OSAL_MAX_PHYSICALCPU_COUNT)) {
        return OSAL_EN_ERROR;
    }
    uint32_t needSize = (uint32_t)(physicalCount) * (uint32_t)(sizeof(OsalCpuDesc));

    pCpuDesc = (OsalCpuDesc*)OsalMalloc(needSize);
    if (pCpuDesc == NULL) {
        return OSAL_EN_ERROR;
    }

    (VOID)memset_s(pCpuDesc, needSize, 0, needSize); /* unsafe_function_ignore: memset */
    if (uname(&sysInfo) == OSAL_EN_OK) {
        size_t sysMachineLen = strnlen(sysInfo.machine, sizeof(cpuDest.arch));
        if (sysMachineLen == sizeof(cpuDest.arch)) {
            OsalFree(pCpuDesc);
            return OSAL_EN_ERROR;
        }
        ret = memcpy_s(cpuDest.arch, sizeof(cpuDest.arch), sysInfo.machine, sysMachineLen + 1U);
        if (ret != EOK) {
            OsalFree(pCpuDesc);
            return OSAL_EN_ERROR;
        }
    }
    int32_t cpuCnt = physicalCount;
    for (int32_t i = 0; i < cpuCnt; i++) {
        pCpuDesc[i] = cpuDest;
        // 平均逻辑CPU个数
        pCpuDesc[i].ncounts = pCpuDesc[i].ncounts / cpuCnt;
    }

    *cpuInfo = pCpuDesc;
    *count = cpuCnt;
    return OSAL_EN_OK;
}

/*
 * 描述:释放LinuxGetCpuInfo生成的动态内存
 * 参数:cpuInfo--LinuxGetCpuInfo获取到的信息的结构体指针
 *      count--LinuxGetCpuInfo获取到的物理cpu个数
 * 返回值:执行成功返回OSAL_EN_OK, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxCpuInfoFree(OsalCpuDesc *cpuInfo, int32_t count)
{
    if ((cpuInfo == NULL) || (count == OSAL_ZERO)) {
        return OSAL_EN_INVALID_PARAM;
    }
    OsalFree(cpuInfo);
    return OSAL_EN_OK;
}

/*
 * 描述:获取本地时间
 * 参数: sysTimePtr -- 指向OsalSystemTime 结构的指针
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetLocalTime(OsalSystemTime *sysTimePtr)
{
    if (sysTimePtr == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }

    struct timeval timeVal;
    (VOID)memset_s(&timeVal, sizeof(timeVal), 0, sizeof(timeVal)); /* unsafe_function_ignore: memset */

    int32_t ret = gettimeofday(&timeVal, NULL);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }

    struct tm nowTime;
    (VOID)memset_s(&nowTime, sizeof(nowTime), 0, sizeof(nowTime)); /* unsafe_function_ignore: memset */

    const struct tm *tmp = localtime_r(&timeVal.tv_sec, &nowTime);
    if (tmp == NULL) {
        return OSAL_EN_ERROR;
    }

    sysTimePtr->wSecond = nowTime.tm_sec;
    sysTimePtr->wMinute = nowTime.tm_min;
    sysTimePtr->wHour = nowTime.tm_hour;
    sysTimePtr->wDay = nowTime.tm_mday;
    sysTimePtr->wMonth = nowTime.tm_mon + 1; // in localtime month is [0, 11], but in fact month is [1, 12]
    sysTimePtr->wYear = nowTime.tm_year + OSAL_COMPUTER_BEGIN_YEAR;
    sysTimePtr->wDayOfWeek = nowTime.tm_wday;
    sysTimePtr->tm_yday = nowTime.tm_yday;
    sysTimePtr->tm_isdst = nowTime.tm_isdst;
    sysTimePtr->wMilliseconds = (int64_t)(timeVal.tv_usec / (int32_t)OSAL_MSEC_TO_USEC);

    return OSAL_EN_OK;
}

/*
 * 描述:获取当前系统时间和时区信息, windows不支持时区获取
 * 参数:timeVal--当前系统时间, 不能为nullptr
        timeZone--当前系统设置的时区信息, 可以为nullptr, 表示不需要获取时区信息
 * 返回值:执行成功返回OSAL_EN_OK, 失败返回OSAL_EN_ERROR，入参错误返回OSAL_EN_INVALID_PARAM
 */
int32_t LinuxGetTimeOfDay(OsalTimeval *timeVal, OsalTimezone *timeZone)
{
    if (timeVal == NULL) {
        return OSAL_EN_INVALID_PARAM;
    }
    int32_t ret = gettimeofday((struct timeval *)(timeVal), (struct timezone *)(timeZone));
    if (ret != OSAL_EN_OK) {
        ret = OSAL_EN_ERROR;
    }
    return ret;
}