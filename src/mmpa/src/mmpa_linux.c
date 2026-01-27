/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mmpa_api.h"

#ifdef __cplusplus
#if    __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

#define MMPA_CPUINFO_DEFAULT_SIZE               64
#define MMPA_CPUINFO_DOUBLE_SIZE                128
#define MMPA_CPUPROC_BUF_SIZE                   256
#define MMPA_MAX_IF_SIZE                        2048
#define MMPA_SECOND_TO_MSEC                     1000
#define MMPA_MSEC_TO_NSEC                       1000000
#define MMPA_SECOND_TO_NSEC                     1000000000
#define MMPA_MAX_PHYSICALCPU_COUNT              4096
#define MMPA_MIN_PHYSICALCPU_COUNT              1

struct CpuTypeTable {
    const CHAR *key;
    const CHAR *value;
};

enum {
    MMPA_MAC_ADDR_FIRST_BYTE = 0,
    MMPA_MAC_ADDR_SECOND_BYTE,
    MMPA_MAC_ADDR_THIRD_BYTE,
    MMPA_MAC_ADDR_FOURTH_BYTE,
    MMPA_MAC_ADDR_FIFTH_BYTE,
    MMPA_MAC_ADDR_SIXTH_BYTE
};

/*
 * 描述:获取进程ID
 * 参数:无
 * 返回值:执行成功返回对应调用进程的id, 执行错误返回EN_ERROR
 */
INT32 mmGetPid(VOID)
{
    return (INT32)getpid();
}

/*
 * 描述:获取调用线程的线程ID
 * 参数:无
 * 返回值:执行成功返回对应调用线程的id, 执行错误返回EN_ERROR
 */
INT32 mmGetTid(VOID)
{
    INT32 ret = (INT32)syscall(SYS_gettid);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

/*
 * 描述:获取进程ID
 * 参数: pstProcessHandle -- 存放进程ID的指向mmProcess类型的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetPidHandle(mmProcess *processHandle)
{
    if (processHandle == NULL) {
        return EN_INVALID_PARAM;
    }
    *processHandle = (mmProcess)getpid();
    return EN_OK;
}

/*
 * 描述:初始化一个信号量
 * 参数: sem--指向mmSem_t的指针
 *       value--信号量的初始值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemInit(mmSem_t *sem, UINT32 value)
{
    if (sem == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = sem_init(sem, MMPA_ZERO, value);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用来阻塞当前线程直到信号量sem的值大于0，解除阻塞后将sem的值减一
 * 参数: sem--指向mmSem_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemWait(mmSem_t *sem)
{
    if (sem == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = sem_wait(sem);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用来增加信号量的值
 * 参数: sem--指向mmSem_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemPost(mmSem_t *sem)
{
    if (sem == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = sem_post(sem);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用完信号量对它进行清理
 * 参数: sem--指向mmSem_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemDestroy(mmSem_t *sem)
{
    if (sem == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = sem_destroy(sem);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:打开或者创建一个文件
 * 参数: pathName--需要打开或者创建的文件路径名，由用户确保绝对路径
 *       flags--打开或者创建的文件标志位, 默认 user和group的权限
 * 返回值:执行成功返回对应打开的文件描述符, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmOpen(const CHAR *pathName, INT32 flags)
{
    return mmOpen2(pathName, flags, S_IRWXU | S_IRWXG);
}

/*
 * 描述:打开或者创建一个文件
 * 参数: pathName--需要打开或者创建的文件路径名，由用户确保绝对路径
 *       flags--打开或者创建的文件标志位
 *       mode -- 打开或者创建的权限
 * 返回值:执行成功返回对应打开的文件描述符, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmOpen2(const CHAR *pathName, INT32 flags, MODE mode)
{
    if ((pathName == NULL) || (flags < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 tmp = (UINT32)flags;

    if (((tmp & (O_TRUNC | O_WRONLY | O_RDWR | O_CREAT)) == MMPA_ZERO) && (flags != O_RDONLY)) {
        return EN_INVALID_PARAM;
    }
    if (((mode & (S_IRUSR | S_IREAD)) == MMPA_ZERO) &&
        ((mode & (S_IWUSR | S_IWRITE)) == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 fd = open(pathName, flags, mode);
    if (fd < MMPA_ZERO) {
        return EN_ERROR;
    }
    return fd;
}

/*
 * 描述:内部使用
 */
static INT32 IdeCheckPopenArgs(const CHAR *type, size_t len)
{
    if (len < 1U) {
        return EN_INVALID_PARAM;
    }

    if (((type[0] != 'r') && (type[0] != 'w'))) {
        return EN_ERROR;
    }
    if ((len > 1) && (type[1] != '\0')) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述：调用fork（）产生子进程，然后从子进程中调用shell来执行参数command的指令。
 * 参数： command--参数是一个指向以 NULL 结束的 shell 命令字符串的指针。这行命令将被传到 bin/sh 并使用-c 标志，
 *                shell 将执行这个命令
 *        type--参数只能是读或者写中的一种，得到的返回值（标准 I/O 流）也具有和 type 相应的只读或只写类型。
 * 返回值：若成功则返回文件指针，否则返回NULL，错误原因存于mmGetErrorCode中
 * 说明：popen是危险函数，请使用白名单机制调用
 */
FILE *mmPopen(CHAR *command, CHAR *type)
{
    if ((command == NULL) || (type == NULL)) {
        return NULL;
    }
    if (IdeCheckPopenArgs(type, strlen(type)) != EN_OK) {
        return NULL;
    }

    return popen(command, type);
}

/*
 * 描述:关闭打开的文件
 * 参数: fd--指向打开文件的资源描述符
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述：pclose（）用来关闭由popen所建立的管道及文件指针。
 * 参数: stream--为先前由popen（）所返回的文件指针
 * 返回值：执行成功返回cmdstring的终止状态，若出错则返回EN_OK，入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmPclose(FILE *stream)
{
    if (stream == NULL) {
        return EN_INVALID_PARAM;
    }
    return pclose(stream);
}

/*
 * 描述:创建socket
 * 参数: sockFamily--协议域
 *       type--指定socket类型
 *       protocol--指定协议
 * 返回值:执行成功返回创建的socket id, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSockHandle mmSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    INT32 socketHandle = socket(sockFamily, type, protocol);
    if (socketHandle < MMPA_ZERO) {
        return EN_ERROR;
    }
    return socketHandle;
}

/*
 * 描述:把一个地址族中的特定地址赋给socket
 * 参数: sockFd--socket描述字，通过mmSocket函数创建
 *       addr--一个指向要绑定给sockFd的协议地址
 *       addrLen--对应地址的长度
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:监听socket
 * 参数: sockFd--socket描述字，通过mmSocket函数创建
 *       backLog--相应socket可以排队的最大连接个数
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:监听指定的socket地址
 * 参数: sockFd--socket描述字，通过mmSocket函数创建
 *       addr--用于返回客户端的协议地址, addr若为NULL, addrLen也应该为NULL
 *       addrLen--协议地址的长度
 * 返回值:执行成功返回自动生成的一个全新的socket id, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:发出socket连接请求
 * 参数:sockFd--socket描述字，通过mmSocket函数创建
 *      addr--服务器的socket地址
 *      addrLen--地址的长度
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:在建立连接的socket上发送数据
 * 参数: sockFd--已建立连接的socket描述字
 *       pstSendBuf--需要发送的数据缓存，有用户分配
 *       sendLen--需要发送的数据长度
 *       sendFlag--发送的方式标志位，一般置0
 * 返回值:执行成功返回实际发送的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmSocketSend(mmSockHandle sockFd, VOID *sendBuf, INT32 sendLen, INT32 sendFlag)
{
    if ((sockFd < MMPA_ZERO) || (sendBuf == NULL) || (sendLen <= MMPA_ZERO) || (sendFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 sndLen = (UINT32)sendLen;
    mmSsize_t ret = send(sockFd, sendBuf, sndLen, sendFlag);
    if (ret <= MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

/*
 * 描述：适用于发送未建立连接的UDP数据包 （参数为SOCK_DGRAM）
 * 参数： sockFd--socket描述字
 *       sendMsg--需要发送的数据缓存，用户分配
 *       sendLen--需要发送的数据长度
 *       sendFlag--发送的方式标志位，一般置0
 *       addr--指向目的套接字的地址
 *       tolen--addr所指地址的长度
 * 返回值：执行成功返回实际发送的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSocketSendTo(mmSockHandle sockFd,
                     VOID *sendMsg,
                     INT32 sendLen,
                     UINT32 sendFlag,
                     const mmSockAddr* addr,
                     INT32 tolen)
{
    if ((sockFd < MMPA_ZERO) || (sendMsg == NULL) ||
        (sendLen <= MMPA_ZERO) || (addr == NULL) || (tolen <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    ssize_t ret = sendto(sockFd, sendMsg, (size_t)(LONG)sendLen, (INT)sendFlag, addr, (socklen_t)tolen);
    if (ret < 0U) {
        return EN_ERROR;
    }
    return (INT32)ret;
}

/*
 * 描述:在建立连接的socket上接收数据
 * 参数: sockFd--已建立连接的socket描述字
 *       pstRecvBuf--存放接收的数据的缓存，用户分配
 *       recvLen--需要发送的数据长度
 *       recvFlag--接收的方式标志位，一般置0
 * 返回值:执行成功返回实际接收的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmSocketRecv(mmSockHandle sockFd, VOID *recvBuf, INT32 recvLen, INT32 recvFlag)
{
    if ((sockFd < MMPA_ZERO) || (recvBuf == NULL) || (recvLen <= MMPA_ZERO) || (recvFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 rcvLen = (UINT32)recvLen;
    mmSsize_t ret = recv(sockFd, recvBuf, rcvLen, recvFlag);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

/*
 * 描述：在建立连接的socket上接收数据
 * 参数： sockFd--已建立连接的socket描述字
 *       recvBuf--存放接收的数据的缓存，用户分配
 *       recvLen--需要接收的数据长度
 *       recvFlag--发送的方式标志位，一般置0
 *       addr--指向指定欲传送的套接字的地址
 *       FromLen--addr所指地址的长度
 * 返回值：执行成功返回实际发送的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmSocketRecvFrom(mmSockHandle sockFd,
                           VOID *recvBuf,
                           mmSize recvLen,
                           UINT32 recvFlag,
                           mmSockAddr* addr,
                           mmSocklen_t *FromLen)
{
    if ((sockFd < MMPA_ZERO) || (recvBuf == NULL) || (recvLen == MMPA_ZERO) || (addr == NULL) || (FromLen == NULL)) {
        return EN_INVALID_PARAM;
    }
    mmSsize_t ret = recvfrom(sockFd, recvBuf, recvLen, (INT)recvFlag, addr, FromLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:关闭建立的socket连接
 * 参数: sockFd--已打开或者建立连接的socket描述字
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:初始化winsockDLL, windows中有效, linux为空实现
 */
INT32 mmSAStartup(VOID)
{
    return EN_OK;
}

/*
 * 描述:注销winsockDLL, windows中有效, linux为空实现
 */
INT32 mmSACleanup(VOID)
{
    return EN_OK;
}

/*
 * 描述:mmCreateAndSetTimer定时器的回调函数, 仅在内部使用
 */
static VOID mmTimerCallBack(union sigval userData)
{
    const mmUserBlock_t * const tmp = (mmUserBlock_t *)userData.sival_ptr;
    tmp->procFunc(tmp->pulArg);
    return;
}

/*
 * 描述:创建特定的定时器
 * 参数: timerHandle--被创建的定时器的ID
 *       milliSecond:定时器首次timer到期的时间 单位ms
 *       period:定时器循环的周期值 单位ms
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateAndSetTimer(mmTimer *timerHandle, mmUserBlock_t *timerBlock, UINT milliSecond, UINT period)
{
    if ((timerHandle == NULL) || (timerBlock == NULL) || (timerBlock->procFunc == NULL)) {
        return EN_INVALID_PARAM;
    }

    struct sigevent event;
    (VOID)memset_s(&event, sizeof(event), MMPA_ZERO, sizeof(event)); /* unsafe_function_ignore: memset */
    event.sigev_value.sival_ptr = timerBlock;
    event.sigev_notify = SIGEV_THREAD;
    event.sigev_notify_function = mmTimerCallBack;
    event.sigev_signo = SIGUSR1;

    INT32 ret = timer_create(CLOCK_MONOTONIC, &event, timerHandle);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    struct itimerspec waitTime;
    (VOID)memset_s(&waitTime, sizeof(waitTime), MMPA_ZERO, sizeof(waitTime)); /* unsafe_function_ignore: memset */

    waitTime.it_interval.tv_sec =  (LONG)period / MMPA_SECOND_TO_MSEC;
    waitTime.it_interval.tv_nsec = ((LONG)period % MMPA_SECOND_TO_MSEC) * MMPA_MSEC_TO_NSEC;

    waitTime.it_value.tv_sec = (LONG)milliSecond / MMPA_SECOND_TO_MSEC;
    waitTime.it_value.tv_nsec = ((LONG)milliSecond % MMPA_SECOND_TO_MSEC) * MMPA_MSEC_TO_NSEC;

    ret = timer_settime(*timerHandle, MMPA_ZERO, &waitTime, NULL);
    if (ret != EN_OK) {
        (VOID)timer_delete(*timerHandle);
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:删除mmCreateAndSetTimer创建的定时器
 * 参数: timerHandle--对应的timer id
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR
 */
INT32 mmDeleteTimer(mmTimer timerHandle)
{
    INT32 ret = timer_delete(timerHandle);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取自系统启动的调单递增的时间
 * 参数: 无
 * 返回值:自系统启动的调单递增的时间单位为毫秒
 */
static LONG GetMonnotonicTime(VOID)
{
    struct timespec curTime = {0};
    (VOID)clock_gettime(CLOCK_MONOTONIC, &curTime);
    // 以毫秒为单位
    LONG result = (LONG)((curTime.tv_sec) * MMPA_SECOND_TO_MSEC);
    result += (LONG)((curTime.tv_nsec) / MMPA_MSEC_TO_NSEC);
    return result;
}

/*
 * 描述:用来阻塞当前线程直到信号量sem的值大于0，解除阻塞后将sem的值减一, 同时指定最长阻塞时间
 * 参数: sem--指向mmSem_t的指针
 *       timeout--超时时间 单位ms
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemTimedWait(mmSem_t *sem, INT32 timeout)
{
    if ((sem == NULL) || (timeout < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    LONG startTime = GetMonnotonicTime();
    LONG endTime = startTime + timeout;
    do {
        if (sem_trywait(sem) == EN_OK) {
            return EN_OK;
        }
        (VOID)mmSleep(1); // 延时1毫秒再检测
    } while (GetMonnotonicTime() <= endTime);
    return EN_OK;
}

/*
 * 描述:用于在一次函数调用中写多个非连续缓冲区
 * 参数: fd -- 打开的资源描述符
 *       iov -- 指向非连续缓存区的首地址的指针
 *       iovcnt -- 非连续缓冲区的个数, 最大支持MAX_IOVEC_SIZE片非连续缓冲区
 * 返回值:执行成功返回实际写入的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmWritev(mmProcess fd, mmIovSegment *iov, INT32 iovcnt)
{
    INT32 i = 0;
    if ((fd < MMPA_ZERO) || (iov == NULL) || (iovcnt < MMPA_ZERO) || (iovcnt > MAX_IOVEC_SIZE)) {
        return EN_INVALID_PARAM;
    }
    struct iovec tmpSegment[MAX_IOVEC_SIZE];
    (VOID)memset_s(tmpSegment, sizeof(tmpSegment), 0, sizeof(tmpSegment)); /* unsafe_function_ignore: memset */

    for (i = 0; i < iovcnt; i++) {
        tmpSegment[i].iov_base = iov[i].sendBuf;
        tmpSegment[i].iov_len = (UINT32)iov[i].sendLen;
    }

    mmSsize_t ret = writev(fd, tmpSegment, iovcnt);
    if (ret < EN_OK) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:一个字符串IP地址转换为一个32位的网络序列IP地址
 * 参数: addrStr -- 待转换的字符串IP地址
 *       addr -- 转换后的网络序列IP地址
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmInetAton(const CHAR *addrStr, mmInAddr *addr)
{
    if ((addr == NULL) || (addrStr == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = inet_aton(addrStr, addr);
    if (ret > MMPA_ZERO) {
        return EN_OK;
    } else {
        return EN_ERROR;
    }
}

/*
 * 描述:创建命名管道 待废弃 请使用mmCreatePipe
 * 参数:pipe管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞创建
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmCreateNamedPipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], INT32 waitMode)
{
    INT32 ret = EN_ERROR;
    INT32 i = 0;

    for (i = 0; i < MAX_PIPE_COUNT; i++) {
        ret = mmAccess(pipeName[i]);
        if (ret == EN_ERROR) {
            ret = mkfifo(pipeName[i], MMPA_DEFAULT_PIPE_PERMISSION);
            if (ret != MMPA_ZERO) {
                return EN_ERROR;
            }
        }
    }

    if (waitMode == 0) {
        pipeHandle[0] = open(pipeName[0], O_RDONLY | O_NONBLOCK);
        pipeHandle[1] = open(pipeName[1], O_WRONLY | O_NONBLOCK);
    } else {
        pipeHandle[0] = open(pipeName[0], O_RDONLY);
        pipeHandle[1] = open(pipeName[1], O_WRONLY);
    }

    if ((pipeHandle[0] == EN_ERROR) || (pipeHandle[1] == EN_ERROR)) {
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:打开创建的命名管道 待废弃 请使用mmOpenPipe
 * 参数:pipe管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞打开
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmOpenNamePipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], INT32 waitMode)
{
    if (waitMode == 0) {
        pipeHandle[0] = open(pipeName[0], O_WRONLY | O_NONBLOCK);
        pipeHandle[1] = open(pipeName[1], O_RDONLY | O_NONBLOCK);
    } else {
        pipeHandle[0] = open(pipeName[0], O_WRONLY);
        pipeHandle[1] = open(pipeName[1], O_RDONLY);
    }

    if ((pipeHandle[0] == EN_ERROR) || (pipeHandle[1] == EN_ERROR)) {
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:关闭命名管道 待废弃 请使用mmClosePipe
 * 参数:namedPipe管道描述符, 必须是两个, 一个读一个写
 * 返回值:无
 */
VOID mmCloseNamedPipe(mmPipeHandle namedPipe[])
{
    if (namedPipe[0] != 0) {
        (VOID)close(namedPipe[0]);
    }
    if (namedPipe[1] != 0) {
        (VOID)close(namedPipe[1]);
    }
    return;
}

/*
 * 描述:创建管道, 类型(命名管道)
 * 参数:pipe管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞创建
 *      pipeCount-管道个数，必须是MMPA_PIPE_COUNT
 *      waitMode非0表示阻塞调用
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmCreatePipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], UINT32 pipeCount, INT32 waitMode)
{
    if ((pipeCount != MMPA_PIPE_COUNT) || (pipeHandle == NULL) || (pipeName == NULL) ||
        (pipeName[0] == NULL) || (pipeName[1] == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 writePipe = EN_ERROR;
    INT32 ret = EN_ERROR;
    INT32 i = 0;

    for (i = 0; i < MMPA_PIPE_COUNT; i++) {
        ret = mmAccess(pipeName[i]);
        if (ret == EN_ERROR) {
            ret = mkfifo(pipeName[i], MMPA_DEFAULT_PIPE_PERMISSION);
            if (ret != MMPA_ZERO) {
                return EN_ERROR;
            }
        }
    }

    if (waitMode == MMPA_ZERO) {
        pipeHandle[0] = open(pipeName[0], O_RDONLY | O_NONBLOCK);

        // 为了pipe1使得O_WRONLY open成功
        writePipe = open(pipeName[1], O_RDONLY | O_NONBLOCK);

        // 如果没有其他进程以读的方式打开，O_WRONLY open会失败
        pipeHandle[1] = open(pipeName[1], O_WRONLY | O_NONBLOCK);
    } else {
        pipeHandle[0] = open(pipeName[0], O_RDONLY);
        pipeHandle[1] = open(pipeName[1], O_WRONLY);
    }

    if ((pipeHandle[0] == EN_ERROR) || (pipeHandle[1] == EN_ERROR)) {
        (VOID)mmClose(pipeHandle[0]);
        (VOID)mmClose(pipeHandle[1]);
        (VOID)mmClose(writePipe);
        return EN_ERROR;
    } else {
        (VOID)mmClose(writePipe);
        return EN_OK;
    }
}

/*
 * 描述:打开创建的命名管道
 * 参数:pipe管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞打开 非0表示阻塞打开 0表示非阻塞打开
 *      pipeCount-管道个数，必须是MMPA_PIPE_COUNT
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmOpenPipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], UINT32 pipeCount, INT32 waitMode)
{
    if ((pipeCount != MMPA_PIPE_COUNT) || (pipeHandle == NULL) || (pipeName == NULL) ||
        (pipeName[0] == NULL) || (pipeName[1] == NULL)) {
        return EN_INVALID_PARAM;
    }
    if (waitMode == MMPA_ZERO) {
        pipeHandle[0] = open(pipeName[0], O_WRONLY | O_NONBLOCK);
        pipeHandle[1] = open(pipeName[1], O_RDONLY | O_NONBLOCK);
    } else {
        pipeHandle[0] = open(pipeName[0], O_WRONLY);
        pipeHandle[1] = open(pipeName[1], O_RDONLY);
    }

    if ((pipeHandle[0] == EN_ERROR) || (pipeHandle[1] == EN_ERROR)) {
        (VOID)mmClose(pipeHandle[0]);
        (VOID)mmClose(pipeHandle[1]);
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:关闭命名管道
 * 参数:pipe管道描述符, 必须是两个, 一个读一个写
 *      pipeCount-管道个数，必须是MMPA_PIPE_COUNT
 * 返回值:无
 */
VOID mmClosePipe(mmPipeHandle pipeHandle[], UINT32 pipeCount)
{
    if ((pipeCount != MMPA_PIPE_COUNT) || (pipeHandle == NULL)) {
        return;
    }
    (VOID)mmClose(pipeHandle[0]);
    (VOID)mmClose(pipeHandle[1]);
    return;
}

/*
 * 描述:创建完成端口, Linux内部为空实现, 主要用于windows系统
 */
mmCompletionHandle mmCreateCompletionPort(VOID)
{
    return EN_OK;
}

/*
 * 描述:关闭完成端口, Linux内部为空实现, 主要用于windows系统
 */
VOID mmCloseCompletionPort(mmCompletionHandle handle)
{
    return;
}

/*
 * 描述:mmPoll内部使用，用来接收数据
 * 参数:fd--需要poll的资源描述符
 *        polledData--读取/接收到的数据
 */
static INT32 LocalGetData(mmPollfd fd, pmmPollData polledData)
{
    INT32 ret = 0;
    switch (fd.pollType) {
        case pollTypeIoctl: // ioctl获取数据
            ret = ioctl(fd.handle, (ULONG)(LONG)fd.ioctlCode, polledData->buf);
            if (ret < MMPA_ZERO) {
                polledData->bufRes = 0;
                return EN_ERROR;
            }
            break;
        case pollTypeRead: // read读取数据
            ret = (INT32)read(fd.handle, polledData->buf, (size_t)polledData->bufLen);
            if (ret <= MMPA_ZERO) {
                polledData->bufRes = 0;
                return EN_ERROR;
            }
            break;
        case pollTypeRecv: // recv接收数据
            ret = (INT32)recv(fd.handle, polledData->buf, (size_t)polledData->bufLen, 0);
            if (ret <= MMPA_ZERO) {
                polledData->bufRes = 0;
                return EN_ERROR;
            }
            break;
        default:
            break;
    }
    polledData->bufHandle = fd.handle;
    polledData->bufType = fd.pollType;
    polledData->bufRes = (UINT)ret;
    return EN_OK;
}

/*
 * 描述:内部使用
 */
static INT32 CheckPollParam(const mmPollfd *fds, INT32 fdCount, const pmmPollData polledData, mmPollBack pollBack)
{
    if ((fds == NULL) || (fdCount == MMPA_ZERO) || (fdCount > FDSIZE) ||
        (polledData == NULL) || (polledData->buf == NULL) || (pollBack == NULL)) {
        return EN_INVALID_PARAM;
    }
    return EN_OK;
}

/*
 * 描述:等待IO数据是否可读可接收
 * 参数: 指向需要等待的fd的集合的指针和个数，timeout -- 超时等待时间,
         handleIOCP -- 对应的完成端口key,
         polledData -- 由用户分配的缓存,
         pollBack --用户注册的回调函数,
 *       polledData -- 若读取到会填充进缓存，回调出来，缓存大小由用户分配
 * 返回值:超时返回EN_ERR, 读取成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmPoll(mmPollfd *fds, INT32 fdCount, INT32 timeout,
    mmCompletionHandle handleIOCP, pmmPollData polledData, mmPollBack pollBack)
{
    INT32 checkParamRet = CheckPollParam(fds, fdCount, polledData, pollBack);
    if (checkParamRet != EN_OK) {
        return checkParamRet;
    }
    INT32 i;
    UINT16 pollRevent;
    struct pollfd polledFd[FDSIZE];
    (VOID)memset_s(polledFd, sizeof(polledFd), 0, sizeof(polledFd)); /* unsafe_function_ignore: memset */

    for (i = 0; i < fdCount; i++) {
        polledFd[i].fd = fds[i].handle;
        polledFd[i].events = POLLIN;
    }
    UINT32 count = (UINT32)fdCount;
    INT32 ret = poll(polledFd, count, timeout);
    // poll调用返回-1表示失败，返回0表示超时，大于0正常
    if (ret == -1) {
        return EN_ERROR;
    }
    if (ret == MMPA_ZERO) {
        return EN_ERR;
    }
    for (i = 0; i < fdCount; i++) {
        pollRevent = (UINT16)polledFd[i].revents;
        if (((pollRevent & POLLIN) != MMPA_ZERO) || (fds[i].pollType == pollTypeIoctl)) {
            ret = LocalGetData(fds[i], polledData);
            if (ret == EN_OK) {
                pollBack(polledData);
                return EN_OK;
            } else {
                return EN_ERROR;
            }
        } else {
            continue;
        }
    }
    return EN_ERROR;
}

/*
 * 描述:获取错误码
 * 返回值:error code
 */
INT32 mmGetErrorCode(VOID)
{
    INT32 ret = (INT32)errno;
    return ret;
}

/*
 * 描述：将mmGetErrorCode函数得到的错误信息转化成字符串信息
 * 参数： errnum--错误码，即mmGetErrorCode的返回值
 *       buf--收错误信息描述的缓冲区指针
 *       size--缓冲区的大小
 * 返回值:成功返回错误信息的字符串，失败返回NULL
 */
CHAR *mmGetErrorFormatMessage(mmErrorMsg errnum, CHAR *buf, mmSize size)
{
    if ((buf == NULL) || (size == 0)) {
        return NULL;
    }
#ifdef STRERROR_R_RETURN_INT
    INT32 ret = strerror_r(errnum, buf, size);
    if (ret != 0) {
        return NULL;
    }
    return buf;
#else
    return strerror_r(errnum, buf, size);
#endif
}

/*
 * 描述:获取当前操作系统类型
 * 返回值:执行成功返回:LINUX--当前系统是Linux系统
 *              WIN--当前系统是Windows系统
 */
INT32 mmGetOsType(VOID)
{
    return OS_TYPE;
}

/*
 * 描述:为每一个进程设置文件模式创建屏蔽字，并返回之前的值
 * 参数:pmode--需要修改的权限值
 * 返回值:执行成功返回先前的pmode的值
 */
INT32 mmUmask(INT32 pmode)
{
    mode_t mode = (mode_t)pmode;
    return (INT32)umask(mode);
}

/*
 * 描述:等待子进程结束并返回对应结束码
 * 参数:pid--欲等待的子进程ID
 *      status--保存子进程的状态信息
 *      options--options提供了一些另外的选项来控制waitpid()函数的行为
 *               M_WAIT_NOHANG--如果pid指定的子进程没有结束，则立即返回;如果结束了, 则返回该子进程的进程号
 *               M_WAIT_UNTRACED--如果子进程进入暂停状态，则马上返回
 * 返回值:子进程未结束返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 *        进程已经结束返回EN_ERR
 */
INT32 mmWaitPid(mmProcess pid, INT32 *status, INT32 options)
{
    if ((options != MMPA_ZERO) && (options != M_WAIT_NOHANG) && (options != M_WAIT_UNTRACED)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = waitpid(pid, status, options);
    if (ret == EN_ERROR) {
        return EN_ERROR;                 // 调用异常
    }
    if ((ret > MMPA_ZERO) && (ret == pid)) { // 返回了子进程ID
        if (status != NULL) {
            if (WIFEXITED(*status)) {
                *status = WEXITSTATUS(*status); // 正常退出码
            }
            if (WIFSIGNALED(*status)) {
                *status = WTERMSIG(*status); // 信号中止退出码
            }
        }
        return EN_ERR;                  // 进程结束
    }
    return EN_OK; // 进程未结束
}

/*
 * 描述:字符串截取
 * 参数:str--待截取字符串
 *      delim --分隔符
 *      saveptr -- 一个供内部使用的指针，用于保存上次分割剩下的字串
 * 返回值:执行成功返回截取后的字符串指针, 执行失败返回NULL
 */
CHAR *mmStrTokR(CHAR *str, const CHAR *delim, CHAR **saveptr)
{
    if (delim == NULL) {
        return NULL;
    }

    return strtok_r(str, delim, saveptr);
}

/*
 * 描述:获取当前指定路径下磁盘容量及可用空间
 * 参数:path--路径名
 *      diskSize--mmDiskSize结构内容
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetDiskFreeSpace(const CHAR *path, mmDiskSize *diskSize)
{
    if ((path == NULL) || (diskSize == NULL)) {
        return EN_INVALID_PARAM;
    }

    // 把文件系统信息读入 struct statvfs buf 中
    struct statvfs buf;
    (VOID)memset_s(&buf, sizeof(buf), 0, sizeof(buf)); /* unsafe_function_ignore: memset */

    INT32 ret = statvfs(path, &buf);
    if (ret == MMPA_ZERO) {
        diskSize->totalSize = (ULONGLONG)(buf.f_blocks) * (ULONGLONG)(buf.f_bsize);
        diskSize->availSize = (ULONGLONG)(buf.f_bavail) * (ULONGLONG)(buf.f_bsize);
        diskSize->freeSize = (ULONGLONG)(buf.f_bfree) * (ULONGLONG)(buf.f_bsize);
        return EN_OK;
    }
    return EN_ERROR;
}

/*
 * 描述:获取系统名字
 * 参数:nameSize--存放系统名的缓存长度
 *      name--由用户分配缓存, 缓存长度必须>=MMPA_MIN_OS_NAME_SIZE
 * 返回值:入参错误返回EN_INVALID_PARAM, 返回值:执行成功返回EN_OK, 执行失败返回EN_ERROR
 */
INT32 mmGetOsName(CHAR* name, INT32 nameSize)
{
    if ((name == NULL) || (nameSize < MMPA_MIN_OS_NAME_SIZE)) {
        return EN_INVALID_PARAM;
    }
    UINT32 length = (UINT32)nameSize;
    INT32 ret = gethostname(name, length);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取当前操作系统版本信息
 * 参数:versionLength--存放操作系统信息的缓存长度
 *      versionInfo--由用户分配缓存, 缓存长度必须>=MMPA_MIN_OS_VERSION_SIZE
 * 返回值:入参错误返回EN_INVALID_PARAM, 返回值:执行成功返回EN_OK, 执行失败返回EN_ERROR
 */
INT32 mmGetOsVersion(CHAR* versionInfo, INT32 versionLength)
{
    if ((versionInfo == NULL) || (versionLength < MMPA_MIN_OS_VERSION_SIZE)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = 0;
    struct utsname sysInfo;
    (VOID)memset_s(&sysInfo, sizeof(sysInfo), 0, sizeof(sysInfo)); /* unsafe_function_ignore: memset */
    UINT32 length = (UINT32)versionLength;
    size_t len = (size_t)length;
    INT32 fb = uname(&sysInfo);
    if (fb < MMPA_ZERO) {
        return EN_ERROR;
    } else {
        ret = snprintf_s(versionInfo, len, (len - 1U), "%s-%s-%s",
            sysInfo.sysname, sysInfo.release, sysInfo.version);
        if (ret == EN_ERROR) {
            return EN_ERROR;
        }
        return EN_OK;
    }
}

/*
 * 描述:获取当前系统下所有网卡的mac地址列表(不包括lo网卡)
 * 参数:list--获取到的mac地址列表指针数组, 缓存由函数内部分配, 需要调用mmGetMacFree释放
 *      count--获取到的mac地址的个数
 * 返回值:执行成功返回扫描到的EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetMac(mmMacInfo **list, INT32 *count)
{
    if ((list == NULL) || (count == NULL)) {
        return EN_INVALID_PARAM;
    }
    struct ifreq ifr;
    CHAR buf[MMPA_MAX_IF_SIZE] = {0};
    struct ifconf ifc;
    mmMacInfo *macInfo = NULL;
    INT32 sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
    if (sock == EN_ERROR) {
        return EN_ERROR;
    }
    ifc.ifc_buf = buf;
    ifc.ifc_len = (INT)sizeof(buf);
    INT32 ret = ioctl(sock, SIOCGIFCONF, &ifc);
    if (ret == EN_ERROR) {
        (VOID)close(sock);
        return EN_ERROR;
    }

    INT32 len = (INT32)sizeof(struct ifreq);
    const struct ifreq* it = ifc.ifc_req;
    *count = (ifc.ifc_len / len);
    UINT32 cnt = (UINT32)(*count);
    size_t needSize = (size_t)(cnt) * sizeof(mmMacInfo);

    macInfo = (mmMacInfo*)malloc(needSize);
    if (macInfo == NULL) {
        *count = MMPA_ZERO;
        (VOID)close(sock);
        return EN_ERROR;
    }

    (VOID)memset_s(macInfo, needSize, 0, needSize); /* unsafe_function_ignore: memset */
    const struct ifreq* const end = it + *count;
    INT32 i = 0;
    for (; it != end; ++it) {
        ret = strcpy_s(ifr.ifr_name, sizeof(ifr.ifr_name), it->ifr_name);
        if (ret != EOK) {
            *count = MMPA_ZERO;
            (VOID)close(sock);
            free(macInfo);
            return EN_ERROR;
        }
        if (ioctl(sock, SIOCGIFFLAGS, &ifr) != MMPA_ZERO) {
            continue;
        }
        UINT16 ifrFlag = (UINT16)ifr.ifr_flags;
        if ((ifrFlag & IFF_LOOPBACK) == MMPA_ZERO) { // ignore loopback
            ret = ioctl(sock, SIOCGIFHWADDR, &ifr);
            if (ret != MMPA_ZERO) {
                continue;
            }
            const UCHAR *ptr = (UCHAR *)&ifr.ifr_ifru.ifru_hwaddr.sa_data[0];
            ret = snprintf_s(macInfo[i].addr,
                sizeof(macInfo[i].addr), sizeof(macInfo[i].addr) - 1U,
                "%02X-%02X-%02X-%02X-%02X-%02X",
                *(ptr + MMPA_MAC_ADDR_FIRST_BYTE),
                *(ptr + MMPA_MAC_ADDR_SECOND_BYTE),
                *(ptr + MMPA_MAC_ADDR_THIRD_BYTE),
                *(ptr + MMPA_MAC_ADDR_FOURTH_BYTE),
                *(ptr + MMPA_MAC_ADDR_FIFTH_BYTE),
                *(ptr + MMPA_MAC_ADDR_SIXTH_BYTE));
            if (ret == EN_ERROR) {
                *count = MMPA_ZERO;
                (VOID)close(sock);
                free(macInfo);
                return EN_ERROR;
            }
            i++;
        } else {
            *count = *count - 1;
        }
    }
    (VOID)close(sock);
    if (*count <= 0) {
        free(macInfo);
        return EN_ERROR;
    } else {
        *list = macInfo;
        return EN_OK;
    }
}

/*
 * 描述:释放由mmGetMac产生的动态内存
 * 参数:list--获取到的mac地址列表指针数组
 *      count--获取到的mac地址的个数
 * 返回值:执行成功返回扫描到的EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetMacFree(mmMacInfo *list, INT32 count)
{
    if ((list == NULL) || (count < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    free(list);
    return EN_OK;
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
static INT32 LocalLookup(CHAR *buf, UINT32 bufLen, const CHAR *pattern, CHAR *value, size_t valueLen)
{
    const CHAR *pValue = NULL;
    CHAR *pBuf = NULL;
    size_t len = strlen(pattern); //lint !e712

    // 空白字符过滤
    for (pBuf = buf; isspace(*pBuf) != 0; pBuf++) {}

    // 关键字匹配
    INT32 ret = strncmp(pBuf, pattern, len);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }
    // :之前空白字符过滤
    for (pBuf = pBuf + len; isspace(*pBuf) != 0; pBuf++) {}

    if (*pBuf == '\0') {
        return EN_ERROR;
    }

    // :之后空白字符过滤
    for (pBuf = pBuf + 1; isspace(*pBuf) != 0; pBuf++) {}

    pValue = pBuf;
    // 截取所需信息
    for (pBuf = buf + bufLen; isspace(*(pBuf - 1)) != 0; pBuf--) {}

    *pBuf = '\0';

    ret = memcpy_s(value, valueLen, pValue, strlen(pValue) + 1U);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:内部使用, miniRC环境下通过拼接获取arm信息
 * 参数:cpuImplememter--存放cpuImplememter信息指针
 *      implememterLen--指针长度
 *      cpuPart--存放cpuPart信息指针
 *      partLen--指针长度
 * 返回值:无
 */
static const CHAR* LocalGetArmVersion(CHAR *cpuImplememter, CHAR *cpuPart)
{
    static struct CpuTypeTable g_paramatersTable[] = {
        { "0x410xd03", "ARMv8_Cortex_A53"},
        { "0x410xd05", "ARMv8_Cortex_A55"},
        { "0x410xd07", "ARMv8_Cortex_A57"},
        { "0x410xd08", "ARMv8_Cortex_A72"},
        { "0x410xd09", "ARMv8_Cortex_A73"},
        { "0x480xd01", "TaishanV110"}
    };
    CHAR cpuArmVersion[MMPA_CPUINFO_DOUBLE_SIZE] = {0};
    INT32 ret = snprintf_s(cpuArmVersion, sizeof(cpuArmVersion), sizeof(cpuArmVersion) - 1U,
                           "%s%s", cpuImplememter, cpuPart);
    if (ret == EN_ERROR) {
        return NULL;
    }
    INT32 i = 0;
    for (i = (INT32)(sizeof(g_paramatersTable) / sizeof(g_paramatersTable[0])) - 1; i >= 0; i--) {
        ret = strcasecmp(cpuArmVersion, g_paramatersTable[i].key);
        if (ret == 0) {
            return g_paramatersTable[i].value;
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
static VOID LocalGetArmManufacturer(CHAR *cpuImplememter, mmCpuDesc *cpuInfo)
{
    size_t len = strlen(cpuInfo->manufacturer);
    if (len != 0U) {
        return;
    }
    INT32 ret = EN_ERROR;
    static struct CpuTypeTable g_manufacturerTable[] = {
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

    INT32 i = 0;
    for (i = (INT32)(sizeof(g_manufacturerTable) / sizeof(g_manufacturerTable[0])) - 1; i >= 0; --i) {
        ret = strcasecmp(cpuImplememter, g_manufacturerTable[i].key);
        if (ret == 0) {
            (VOID)memcpy_s(cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer),
                g_manufacturerTable[i].value, (strlen(g_manufacturerTable[i].value) + 1U));
            return;
        }
    }
    return;
}

/*
 * 描述:内部使用, 去重返回实际物理CPU个数
 * 参数:cpuInfo--存放physical id的数组指针
 *      size--数组长度
 *      id--当前物理cpu的id
 *      physicalCount--当前物理CPU个数，入参和出参
 * 返回值:无
 */
static VOID LocalGetDeduplicateCnt(INT32 *physicalIds, INT32 size, INT32 id, INT32 *physicalIdCnt)
{
    size_t i = 0U;
    for (; i < *physicalIdCnt; ++i) {
        if (physicalIds[i] == id) {
            return;
        }
    }
    if (*physicalIdCnt < size) {
        physicalIds[*physicalIdCnt] = id;
        ++(*physicalIdCnt);
    }
}

/*
 * 描述:内部使用, 读取/proc/cpuinfo信息中的部分信息
 * 参数:cpuInfo--存放获取的物理CPU信息
 *      physicalCount--物理CPU个数
 * 返回值:无
 */
static VOID LocalGetCpuProc(mmCpuDesc *cpuInfo, INT32 *physicalCount)
{
    CHAR buf[MMPA_CPUPROC_BUF_SIZE]                 = {0};
    CHAR physicalID[MMPA_CPUINFO_DEFAULT_SIZE]      = {0};
    CHAR cpuMhz[MMPA_CPUINFO_DEFAULT_SIZE]          = {0};
    CHAR cpuCores[MMPA_CPUINFO_DEFAULT_SIZE]        = {0};
    CHAR cpuCnt[MMPA_CPUINFO_DEFAULT_SIZE]          = {0};
    CHAR cpuImplememter[MMPA_CPUINFO_DEFAULT_SIZE]  = {0};
    CHAR cpuPart[MMPA_CPUINFO_DEFAULT_SIZE]         = {0};
    CHAR cpuThreads[MMPA_CPUINFO_DEFAULT_SIZE]      = {0};
    CHAR maxSpeed[MMPA_CPUINFO_DEFAULT_SIZE]        = {0};
    INT32 physicalIdCnt = 0U;
    INT32* physicalIds = (INT32*)malloc(MMPA_MAX_PHYSICALCPU_COUNT * sizeof(INT32));
    if (physicalIds == NULL) {
        return;
    }
    FILE *fp = fopen("/proc/cpuinfo", "r");
    if (fp == NULL) {
        (VOID)free(physicalIds);
        return;
    }
    UINT32 length = 0U;
    while (fgets(buf, (INT)sizeof(buf), fp) != NULL) {
        length = (UINT32)strlen(buf);
        if (LocalLookup(buf, length, "manufacturer", cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer)) == EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "vendor_id", cpuInfo->manufacturer, sizeof(cpuInfo->manufacturer)) == EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "CPU implementer", cpuImplememter, sizeof(cpuImplememter)) == EN_OK) {
            continue; /* ARM and aarch64 */
        }
        if (LocalLookup(buf, length, "CPU part", cpuPart, sizeof(cpuPart)) == EN_OK) {
            continue; /* ARM and aarch64 */
        }
        if (LocalLookup(buf, length, "model name", cpuInfo->version, sizeof(cpuInfo->version)) == EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "cpu MHz", cpuMhz, sizeof(cpuMhz)) == EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "cpu cores", cpuCores, sizeof(cpuCores)) == EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "processor", cpuCnt, sizeof(cpuCnt)) == EN_OK) {
            continue; // processor index + 1
        }
        if (LocalLookup(buf, length, "physical id", physicalID, sizeof(physicalID)) == EN_OK) {
            LocalGetDeduplicateCnt(physicalIds, MMPA_MAX_PHYSICALCPU_COUNT, atoi(physicalID), &physicalIdCnt);
            continue;
        }
        if (LocalLookup(buf, length, "Thread Count", cpuThreads, sizeof(cpuThreads)) == EN_OK) {
            continue;
        }
        if (LocalLookup(buf, length, "Max Speed", maxSpeed, sizeof(maxSpeed)) == EN_OK) {
            ;
        }
    }
    (VOID)free(physicalIds);
    (VOID)fclose(fp);
    fp = NULL;
    cpuInfo->frequency = atoi(cpuMhz);
    cpuInfo->ncores = atoi(cpuCores);
    cpuInfo->ncounts = atoi(cpuCnt) + 1;
    if (physicalIdCnt != 0) {
        *physicalCount = physicalIdCnt; // only update physicalCount when cpuinfo has physical id
    }
    cpuInfo->nthreads = atoi(cpuThreads);
    cpuInfo->maxFrequency = atoi(maxSpeed);
    const CHAR* tmp = LocalGetArmVersion(cpuImplememter, cpuPart);
    if (tmp != NULL) {
        (VOID)memcpy_s(cpuInfo->version, sizeof(cpuInfo->version), tmp, strlen(tmp) + 1U);
    }
    LocalGetArmManufacturer(cpuImplememter, cpuInfo);
    return;
}

/*
 * 描述:获取当前系统cpu的部分物理硬件信息
 * 参数:cpuInfo--包含需要获取信息的结构体, 函数内部分配, 需要调用mmCpuInfoFree释放
 *      count--读取到的物理cpu个数
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetCpuInfo(mmCpuDesc **cpuInfo, INT32 *count)
{
    if (count == NULL) {
        return EN_INVALID_PARAM;
    }
    if (cpuInfo == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 i = 0;
    INT32 ret = 0;
    mmCpuDesc cpuDest = {};
    // 默认一个CPU
    INT32 physicalCount = 1;
    mmCpuDesc *pCpuDesc = NULL;
    struct utsname sysInfo = {};

    LocalGetCpuProc(&cpuDest, &physicalCount);

    if ((physicalCount < MMPA_MIN_PHYSICALCPU_COUNT) || (physicalCount > MMPA_MAX_PHYSICALCPU_COUNT)) {
        return EN_ERROR;
    }
    UINT32 needSize = (UINT32)(physicalCount) * (UINT32)(sizeof(mmCpuDesc));

    pCpuDesc = (mmCpuDesc*)malloc(needSize);
    if (pCpuDesc == NULL) {
        return EN_ERROR;
    }

    (VOID)memset_s(pCpuDesc, needSize, 0, needSize); /* unsafe_function_ignore: memset */

    if (uname(&sysInfo) == EN_OK) {
        ret = memcpy_s(cpuDest.arch, sizeof(cpuDest.arch), sysInfo.machine, strlen(sysInfo.machine) + 1U);
        if (ret != EN_OK) {
            free(pCpuDesc);
            return EN_ERROR;
        }
    }

    INT32 cpuCnt = physicalCount;
    for (i = 0; i < cpuCnt; i++) {
        pCpuDesc[i] = cpuDest;
        // 平均逻辑CPU个数
        pCpuDesc[i].ncounts = pCpuDesc[i].ncounts / cpuCnt;
    }

    *cpuInfo = pCpuDesc;
    *count = cpuCnt;
    return EN_OK;
}

/*
 * 描述:释放mmGetCpuInfo生成的动态内存
 * 参数:cpuInfo--mmGetCpuInfo获取到的信息的结构体指针
 *      count--mmGetCpuInfo获取到的物理cpu个数
 * 返回值:执行成功返回EN_OK, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCpuInfoFree(mmCpuDesc *cpuInfo, INT32 count)
{
    if ((cpuInfo == NULL) || (count == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    free(cpuInfo);
    return EN_OK;
}

/*
 * 描述： 获取系统内存页大小
 * 返回值：返系统回内存页大小
 */
mmSize mmGetPageSize(VOID)
{
    return (mmSize)(LONG)getpagesize();
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

