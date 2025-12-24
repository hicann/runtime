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
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

const INT32 MMPA_MAX_BUF_SIZE = 4096;
const INT32 MMPA_MAX_PHYSICALCPU_COUNT = 64;
const INT32 MMPA_MAX_PROCESSOR_ARCHITECTURE_COUNT = 10;

typedef enum {
    MMPA_OS_VERSION_WINDOWS_2000 = 0,
    MMPA_OS_VERSION_WINDOWS_XP,
    MMPA_OS_VERSION_WINDOWS_XP_SP1,
    MMPA_OS_VERSION_WINDOWS_XP_SP2,
    MMPA_OS_VERSION_WINDOWS_SERVER_2003,
    MMPA_OS_VERSION_WINDOWS_HOME_SERVER,
    MMPA_OS_VERSION_WINDOWS_VISTA,
    MMPA_OS_VERSION_WINDOWS_SERVER_2008,
    MMPA_OS_VERSION_WINDOWS_SERVER_2008_R2,
    MMPA_OS_VERSION_WINDOWS_7,
    MMPA_OS_VERSION_WINDOWS_SERVER_2012,
    MMPA_OS_VERSION_WINDOWS_8,
    MMPA_OS_VERSION_WINDOWS_SERVER_2012_R2,
    MMPA_OS_VERSION_WINDOWS_8_1,
    MMPA_OS_VERSION_WINDOWS_SERVER_2016,
    MMPA_OS_VERSION_WINDOWS_10
}MMPA_OS_VERSION_WINDOWS_TYPE;

// windows 操作系统列表
CHAR g_winOps[][MMPA_MIN_OS_VERSION_SIZE] = {
    "Windows 2000",
    "Windows XP",
    "Windows XP SP1",
    "Windows XP SP2",
    "Windows Server 2003",
    "Windows Home Server",
    "Windows Vista",
    "Windows Server 2008",
    "Windows Server 2008 R2",
    "Windows 7",
    "Windows Server 2012",
    "Windows 8",
    "Windows Server 2012 R2",
    "Windows 8.1",
    "Windows Server 2016",
    "Windows 10"
};

// 操作系统架构表
CHAR g_arch[MMPA_MAX_PROCESSOR_ARCHITECTURE_COUNT][MMPA_MIN_OS_VERSION_SIZE] = {
    "x86",  // 0
    "MIPS", // 1
    "Alpha ",
    "PowerPC",
    "",
    "ARM",  // 5
    "ia64", // 6
    "",
    "",
    "x64",  // 9
};

/*
 * 描述:获取进程ID
 * 返回值:执行成功返回对应调用进程的id, 执行错误返回EN_ERROR
 */
INT32 mmGetPid(void)
{
    return static_cast<INT32>(GetCurrentProcessId());
}

/*
 * 描述:获取调用线程的线程ID
 * 返回值:执行成功返回对应调用线程的id, 执行错误返回EN_ERROR
 */
INT32 mmGetTid(void)
{
    return static_cast<INT32>(GetCurrentThreadId());
}

/*
 * 描述:获取进程ID
 * 参数:pstProcessHandle -- 存放进程ID的指向mmProcess类型的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetPidHandle(mmProcess *processHandle)
{
    if (processHandle == nullptr) {
        return EN_INVALID_PARAM;
    }
    *processHandle = GetCurrentProcess();
    return EN_OK;
}

/*
 * 描述:初始化一个信号量
 * 参数:sem--指向mmSem_t的指针
 *       value--信号量的初始值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemInit(mmSem_t *sem, UINT32 value)
{
    if (sem == nullptr || (value > (MMPA_MEM_MAX_LEN - MMPA_ONE_THOUSAND * MMPA_ONE_THOUSAND))) {
        return EN_INVALID_PARAM;
    }
    *sem = CreateSemaphore(nullptr, static_cast<LONG>(value),
        static_cast<LONG>(value) + MMPA_ONE_THOUSAND * MMPA_ONE_THOUSAND, nullptr);
    if (*sem == nullptr) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用来阻塞当前线程直到信号量sem的值大于0，解除阻塞后将sem的值减一
 * 参数:sem--指向mmSem_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemWait(mmSem_t *sem)
{
    if (sem == nullptr) {
        return EN_INVALID_PARAM;
    }

    DWORD result = WaitForSingleObject(*sem, INFINITE);
    if (result == WAIT_ABANDONED || result == WAIT_FAILED) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用来增加信号量的值
 * 参数:sem--指向mmSem_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemPost(mmSem_t *sem)
{
    if (sem == nullptr) {
        return EN_INVALID_PARAM;
    }

    BOOL result = ReleaseSemaphore(*sem, static_cast<LONG>(MMPA_VALUE_ONE), nullptr);
    if (!result) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用完信号量对它进行清理
 * 参数:sem--指向mmSem_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemDestroy(mmSem_t *sem)
{
    if (sem == nullptr) {
        return EN_INVALID_PARAM;
    }

    BOOL result = CloseHandle(*sem);
    if (!result) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述：调用fork（）产生子进程，然后从子进程中调用shell来执行参数command的指令。
 * 参数： command--参数是一个指向以 NULL 结束的 shell 命令字符串的指针。这行命令将被传到 bin/sh 并使用-c 标志，shell 将执行这个命令
 *        type--参数只能是读或者写中的一种，得到的返回值（标准 I/O 流）也具有和 type 相应的只读或只写类型。
 * 返回值：若成功则返回文件指针，否则返回NULL, 错误原因存于mmGetErrorCode中
 */
FILE *mmPopen(CHAR *command, CHAR *type)
{
    if ((command == NULL) || (type == NULL)) {
        return NULL;
    }
    FILE *stream = _popen(command, type);
    return stream;
}

/*
 * 描述：pclose（）用来关闭由popen所建立的管道及文件指针。
 * 参数: stream--为先前由popen（）所返回的文件指针
 * 返回值：执行成功返回cmdstring的终止状态，若出错则返回EN_ERROR，入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmPclose(FILE *stream)
{
    if (stream == NULL) {
        return EN_INVALID_PARAM;
    }
    return _pclose(stream);
}

/*
 * 描述:创建socket
 * 参数:sockFamily--协议域
 *       type--指定socket类型
 *       protocol--指定协议
 * 返回值:执行成功返回创建的socket id, 执行错误返回EN_ERROR
 */
mmSockHandle mmSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    SOCKET socketHandle = socket(sockFamily, type, protocol);
    if (socketHandle == INVALID_SOCKET) {
        return EN_ERROR;
    }
    return socketHandle;
}

/*
 * 描述:把一个地址族中的特定地址赋给socket
 * 参数:sockFd--socket描述字，通过mmSocket函数创建
 *       addr--一个指向要绑定给sockFd的协议地址
 *       addrLen--对应地址的长度
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmBind(mmSockHandle sockFd, mmSockAddr *addr, mmSocklen_t addrLen)
{
    if ((sockFd == INVALID_SOCKET) || (addr == nullptr) || (addrLen <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 result = bind(sockFd, addr, addrLen);
    if (result != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:监听socket
 * 参数:sockFd--socket描述字，通过mmSocket函数创建
 *       backLog--相应socket可以排队的最大连接个数
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmListen(mmSockHandle sockFd, INT32 backLog)
{
    if ((sockFd == INVALID_SOCKET) || (backLog <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 result = listen(sockFd, backLog);
    if (result != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:监听指定的socket地址
 * 参数:sockFd--socket描述字，通过mmSocket函数创建
 *       addr--用于返回客户端的协议地址
 *       addrLen--协议地址的长度
 * 返回值:执行成功返回自动生成的一个全新的socket id, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSockHandle mmAccept(mmSockHandle sockFd, mmSockAddr *addr, mmSocklen_t *addrLen)
{
    if (sockFd == INVALID_SOCKET) {
        return EN_INVALID_PARAM;
    }

    SOCKET socketHandle = accept(sockFd, addr, addrLen);
    if (socketHandle == INVALID_SOCKET) {
        return EN_ERROR;
    }
    return socketHandle;
}

/*
 * 描述:发出socket连接请求
 * 参数:sockFd--socket描述字，通过mmSocket函数创建
 *      addr--服务器的socket地址
 *      addrLen--地址的长度
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmConnect(mmSockHandle sockFd, mmSockAddr *addr, mmSocklen_t addrLen)
{
    if ((sockFd == INVALID_SOCKET) || (addr == nullptr) || (addrLen <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 result = connect(sockFd, addr, addrLen);
    if (result < MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:在建立连接的socket上发送数据
 * 参数:sockFd--已建立连接的socket描述字
 *       pstSendBuf--需要发送的数据缓存，有用户分配
 *       sendLen--需要发送的数据长度
 *       sendFlag--发送的方式标志位，一般置0
 * 返回值:执行成功返回实际发送的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmSocketSend(mmSockHandle sockFd, VOID *sendBuf, INT32 sendLen, INT32 sendFlag)
{
    if ((sockFd == INVALID_SOCKET) || (sendBuf == nullptr) || (sendLen <= MMPA_ZERO) || (sendFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t sendRet = send(sockFd, reinterpret_cast<CHAR *>(sendBuf), sendLen, sendFlag);
    if (sendRet == SOCKET_ERROR) {
        return EN_ERROR;
    }
    return sendRet;
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
    if ((sockFd < MMPA_ZERO) || (sendMsg == NULL) || (sendLen <= MMPA_ZERO) || (addr == NULL) || (tolen <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    INT32 flag = static_cast<INT32>(sendFlag);
    INT32 ret = sendto(sockFd, reinterpret_cast<CHAR *>(sendMsg), sendLen, flag, addr, tolen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:在建立连接的socket上接收数据
 * 参数:sockFd--已建立连接的socket描述字
 *       pstRecvBuf--存放接收的数据的缓存，用户分配
 *       recvLen--需要发送的数据长度
 *       recvFlag--接收的方式标志位，一般置0
 * 返回值:执行成功返回实际接收的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmSocketRecv(mmSockHandle sockFd, VOID *recvBuf, INT32 recvLen, INT32 recvFlag)
{
    if ((sockFd == INVALID_SOCKET) || (recvBuf == nullptr) || (recvLen <= MMPA_ZERO) || (recvFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t recvRet = recv(sockFd, reinterpret_cast<CHAR *>(recvBuf), recvLen, recvFlag);
    if (recvRet == SOCKET_ERROR) {
        return EN_ERROR;
    }
    return recvRet;
}

/*
 * 描述：在建立连接的socket上接收数据
 * 参数： sockFd--已建立连接的socket描述字
 *       recvBuf--存放接收的数据的缓存，用户分配
 *       recvLen--需要接收的数据长度
 *       recvFlag--发送的方式标志位，一般置0
 *       addr--指向指定欲传送的套接字的地址
 *       tolen--addr所指地址的长度
 * 返回值：执行成功返回实际发送的buf长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmSocketRecvFrom(mmSockHandle sockFd,
                           VOID *recvBuf,
                           mmSize recvLen,
                           UINT32 recvFlag,
                           mmSockAddr* addr,
                           mmSocklen_t *FromLen)
{
    if ((sockFd < MMPA_ZERO) || (recvBuf == NULL) || (recvLen <= MMPA_ZERO) || (addr == NULL) || (FromLen == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 flag = static_cast<INT32>(recvFlag);
    mmSsize_t ret = recvfrom(sockFd, reinterpret_cast<CHAR *>(recvBuf), recvLen, flag, addr, FromLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:关闭建立的socket连接
 * 参数:sockFd--已打开或者建立连接的socket描述字
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCloseSocket(mmSockHandle sockFd)
{
    if (sockFd == INVALID_SOCKET) {
        return EN_INVALID_PARAM;
    }

    INT32 result = closesocket(sockFd);
    if (result != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:初始化winsockDLL, windows中有效, linux为空实现
 * 参数:空
 * 返回值:执行成功返回EN_OK，执行失败返回EN_ERROR
 */
INT32 mmSAStartup(VOID)
{
    WSADATA data;
    WORD wVersionRequested = MAKEWORD(MMPA_SOCKET_MAIN_EDITION, MMPA_SOCKET_SECOND_EDITION);
    INT32 result = WSAStartup(wVersionRequested, &data);
    if (result != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:注销winsockDLL, windows中有效, linux为空实现
 * 参数:空
 * 返回值:执行成功返回EN_OK，执行失败返回EN_ERROR
 */
INT32 mmSACleanup(VOID)
{
    INT32 result = WSACleanup();
    if (result != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:mmCreateAndSetTimer定时器的回调函数, 仅在内部使用
 * 参数:空
 * 返回值:空
 */
VOID CALLBACK mmTimerCallBack(_In_ PVOID lpParameter, _In_ BOOLEAN TimerOrWaitFired)
{
    mmUserBlock_t *pstTemp = reinterpret_cast<mmUserBlock_t *>(lpParameter);

    if ((pstTemp != nullptr) && (pstTemp->procFunc != nullptr)) {
        pstTemp->procFunc(pstTemp->pulArg);
    }
    return;
}

/*
 * 描述:创建特定的定时器
 * 参数:timerHandle--被创建的定时器的ID
 *       milliSecond:定时器首次timer到期的时间 单位ms
 *       period:定时器循环的周期值 单位ms
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateAndSetTimer(mmTimer *timerHandle, mmUserBlock_t *timerBlock, UINT milliSecond, UINT period)
{
    if ((timerHandle == nullptr) || (timerBlock == nullptr) || (timerBlock->procFunc == nullptr)) {
        return EN_INVALID_PARAM;
    }

    timerHandle->timerQueue = CreateTimerQueue();
    if (timerHandle->timerQueue == nullptr) {
        return EN_ERROR;
    }

    BOOL ret = CreateTimerQueueTimer(&(timerHandle->timerHandle), timerHandle->timerQueue,
        mmTimerCallBack, timerBlock, milliSecond, period, WT_EXECUTEDEFAULT);
    if (!ret) {
        (void)DeleteTimerQueue(timerHandle->timerQueue);
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:删除mmCreateAndSetTimer创建的定时器
 * 参数:timerHandle--对应的timer id
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR
 */
INT32 mmDeleteTimer(mmTimer timerHandle)
{
    BOOL ret = DeleteTimerQueueTimer(timerHandle.timerQueue, timerHandle.timerHandle, nullptr);
    if (!ret) {
        return EN_ERROR;
    }

    ret = DeleteTimerQueue(timerHandle.timerQueue);
    if (!ret) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:用来阻塞当前线程直到信号量sem的值大于0，解除阻塞后将sem的值减一, 同时指定最长阻塞时间
 * 参数:sem--指向mmSem_t的指针
 *       timeout--超时时间 单位ms
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSemTimedWait(mmSem_t *sem, INT32 timeout)
{
    if (sem == nullptr || timeout < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    DWORD result = WaitForSingleObject(*sem, (DWORD)timeout);
    if (result == WAIT_ABANDONED || result == WAIT_FAILED) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:用于在一次函数调用中写多个非连续缓冲区
 * 参数:fd -- 打开的资源描述符
 *       iov -- 指向非连续缓存区的首地址的指针
 *       iovcnt -- 非连续缓冲区的个数, 最大支持MAX_IOVEC_SIZE片非连续缓冲区
 * 返回值:执行成功返回实际写入的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmWritev(mmSockHandle fd, mmIovSegment *iov, INT32 iovcnt)
{
    if (fd < MMPA_ZERO || iovcnt < MMPA_ZERO || iov == nullptr || iovcnt > MAX_IOVEC_SIZE) {
        return EN_INVALID_PARAM;
    }

    INT32 i = 0;
    for (i = 0; i < iovcnt; i++) {
        INT32 sendRet = send(fd, reinterpret_cast<CHAR *>(iov[i].sendBuf), iov[i].sendLen, MSG_DONTROUTE);
        if (sendRet == SOCKET_ERROR) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

/*
 * 描述:一个字符串IP地址转换为一个32位的网络序列IP地址
 * 参数:addrStr -- 待转换的字符串IP地址
 *       addr -- 转换后的网络序列IP地址
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmInetAton(const CHAR *addrStr, mmInAddr *addr)
{
    if (addrStr == nullptr || addr == nullptr) {
        return EN_INVALID_PARAM;
    }
    DWORD result = inet_pton(AF_INET, (PCSTR)addrStr, addr);
    if (result == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    } else if (result == 1) { // inet_pton没有错误返回1
        return EN_OK;
    } else {
        return EN_ERROR;
    }
}

/*
 * 描述:创建命名管道 待废弃 请使用mmCreatePipe
 * 参数:pipeHandle管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞创建
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmCreateNamedPipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], INT32 waitMode)
{
    HANDLE namedPipe = CreateNamedPipe((LPCSTR)pipeName[0], PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED,
        0, 1, MMPA_PIPE_BUF_SIZE, MMPA_PIPE_BUF_SIZE, 0, nullptr);
    if (namedPipe == INVALID_HANDLE_VALUE) {
        namedPipe = nullptr;
        return EN_ERROR;
    }
    if (waitMode) {
        HANDLE hEvent = CreateEvent(nullptr, TRUE, FALSE, nullptr);
        if (hEvent == nullptr) {
            (void)CloseHandle(namedPipe);
            return EN_ERROR;
        }

        OVERLAPPED overlapped;
        SecureZeroMemory(&overlapped, sizeof(overlapped));
        overlapped.hEvent = hEvent;

        if (!ConnectNamedPipe(namedPipe, &overlapped)) {
            if (ERROR_IO_PENDING != GetLastError()) {
                (void)CloseHandle(namedPipe);
                (void)CloseHandle(hEvent);
                return EN_ERROR;
            }
        }

        if (WaitForSingleObject(hEvent, INFINITE) == WAIT_FAILED) {
            (void)CloseHandle(namedPipe);
            (void)CloseHandle(hEvent);
            return EN_ERROR;
        }

        (void)CloseHandle(hEvent);
    }
    pipeHandle[0] = namedPipe;
    pipeHandle[1] = namedPipe;
    return EN_OK;
}

/*
 * 描述:打开创建的命名管道 待废弃 请使用mmOpenPipe
 * 参数:pipeHandle管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞打开
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR
 */
INT32 mmOpenNamePipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], INT32 waitMode)
{
    DWORD  nTimeOut = 0;
    if (waitMode) {
        nTimeOut = NMPWAIT_WAIT_FOREVER;
    }
    (void)WaitNamedPipe((LPCSTR)pipeName[0], nTimeOut);

    pipeHandle[0] = CreateFile((LPCSTR)pipeName[0], GENERIC_READ | GENERIC_WRITE, 0, nullptr,
        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
    if (pipeHandle[0] == INVALID_HANDLE_VALUE) {
        return EN_ERROR;
    }
    pipeHandle[1] = pipeHandle[0];
    return EN_OK;
}

/*
 * 描述:关闭命名管道 待废弃 请使用mmClosePipe
 * 参数:namedPipe管道描述符, 必须是两个, 一个读一个写
 */
void mmCloseNamedPipe(mmPipeHandle namedPipe[])
{
    if (namedPipe[0] && namedPipe[1]) {
        (void)CloseHandle(namedPipe[0]);
    }
}

/*
 * 描述:创建管道, 类型(命名管道)
 * 参数:pipeHandle管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞创建
 *      pipeCount-管道个数，必须是MMPA_PIPE_COUNT
 *      waitMode非0表示阻塞调用
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmCreatePipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], UINT32 pipeCount, INT32 waitMode)
{
    if (pipeCount != MMPA_PIPE_COUNT || pipeHandle == nullptr || pipeName == nullptr ||
        pipeName[0] == nullptr || pipeName[1] == nullptr) {
        return EN_INVALID_PARAM;
    }

    HANDLE namedPipe = CreateNamedPipe((LPCSTR)pipeName[0], PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED, 0, 1,
                                       MMPA_PIPE_BUF_SIZE, MMPA_PIPE_BUF_SIZE, 0, nullptr);
    if (namedPipe == INVALID_HANDLE_VALUE) {
        namedPipe = nullptr;
        return EN_ERROR;
    }
    if (waitMode != MMPA_ZERO) {
        HANDLE event = CreateEvent(nullptr, TRUE, FALSE, nullptr);
        if (event == nullptr) {
            (void)CloseHandle(namedPipe);
            return EN_ERROR;
        }

        OVERLAPPED overlapped;
        SecureZeroMemory(&overlapped, sizeof(overlapped));
        overlapped.hEvent = event;

        if (ConnectNamedPipe(namedPipe, &overlapped) == MMPA_ZERO) {
            if (GetLastError() != ERROR_IO_PENDING) {
                (void)CloseHandle(namedPipe);
                (void)CloseHandle(event);
                return EN_ERROR;
            }
        }

        if (WaitForSingleObject(event, INFINITE) == WAIT_FAILED) {
            (void)CloseHandle(namedPipe);
            (void)CloseHandle(event);
            return EN_ERROR;
        }

        (void)CloseHandle(event);
    }

    pipeHandle[0] = namedPipe;
    pipeHandle[1] = namedPipe;

    return 0;
}

/*
 * 描述:打开创建的命名管道
 * 参数:pipeHandle管道描述符, 必须是两个, 一个读一个写
 *      pipeName-管道名, waitMode-是否阻塞打开
 *      pipeCount-管道个数，必须是MMPA_PIPE_COUNT
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmOpenPipe(mmPipeHandle pipeHandle[], CHAR *pipeName[], UINT32 pipeCount, INT32 waitMode)
{
    if (pipeCount != MMPA_PIPE_COUNT || pipeHandle == nullptr || pipeName == nullptr ||
        pipeName[0] == nullptr || pipeName[1] == nullptr) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = mmOpenNamePipe(pipeHandle, pipeName, waitMode);

    return ret;
}

/*
 * 描述:关闭命名管道
 * 参数:pipeHandle管道描述符, 必须是两个, 一个读一个写
 *      pipeCount-管道个数，必须是MMPA_PIPE_COUNT
 */
void mmClosePipe(mmPipeHandle pipeHandle[], UINT32 pipeCount)
{
    if (pipeCount != MMPA_PIPE_COUNT || pipeHandle == nullptr) {
        return;
    }
    if ((pipeHandle[0] != MMPA_ZERO) && (pipeHandle[1] != MMPA_ZERO)) {
        (void)CloseHandle(pipeHandle[0]);
    }
}

/*
 * 描述:创建完成端口, Linux内部为空实现, 主要用于windows系统
 */
mmCompletionHandle mmCreateCompletionPort()
{
    mmCompletionHandle handleComplete = CreateIoCompletionPort(INVALID_HANDLE_VALUE, nullptr, 0, 0);
    return handleComplete;
}

/*
 * 描述:关闭完成端口, Linux内部为空实现, 主要用于windows系统
 */
VOID mmCloseCompletionPort(mmCompletionHandle handle)
{
    if (handle != INVALID_HANDLE_VALUE) {
        (void)CloseHandle(handle);
    }
}

/*
 * 描述:mmPoll内部使用，用来接收数据
 * 参数:fd--需要poll的资源描述符
 *      polledData--读取/接收到的数据
 */
VOID LocalReceiveAction(mmPollfd fd, VOID *buf, UINT32 bufLen, LPOVERLAPPED poa)
{
    PPRE_IO_DATA pPreIoData = nullptr;
    mmPollType overlapType = fd.pollType;
    HANDLE handle = fd.handle;
    if (overlapType == pollTypeRead) { // read
        DWORD dwRead = 0;
        ReadFile(handle, buf, bufLen, &dwRead, poa);
    } else if (overlapType == pollTypeRecv) { // wsarecv
        DWORD dwRecv = 0;
        DWORD dwFlags = 0;
        PRE_IO_DATA ioData;
        pPreIoData = &ioData;
        SecureZeroMemory(pPreIoData, sizeof(PRE_IO_DATA));
        pPreIoData->DataBuf.len = bufLen;
        pPreIoData->DataBuf.buf = reinterpret_cast<CHAR *>(buf);
        pPreIoData->completionHandle = handle;
        WSARecv((SOCKET)handle, (LPWSABUF)&pPreIoData->DataBuf, 1, &dwRecv, &dwFlags, poa, nullptr);
    } else if (overlapType == pollTypeIoctl) { // ioctl
        DWORD dwRead = 0;
        DeviceIoControl(handle,           // device to be queried
                        fd.ioctlCode,     // operation to perform
                        nullptr,
                        0,                // no input buffer
                        buf,              // output buffer
                        bufLen,
                        &dwRead,          // bytes returned
                        poa);             // synchronous I/O
    }
}

/*
 * 描述:等待IO数据是否可读可接收
 * 参数:指向需要等待的fd的集合的指针和个数，timeout -- 超时等待时间,
 *       handleIOCP -- 对应的完成端口key,
 *       polledData -- 由用户分配的缓存,
 *       pollBack --用户注册的回调函数,
 *       polledData -- 若读取到会填充进缓存，回调出来，缓存大小由用户分配
 * 返回值:超时返回EN_ERR, 读取成功返回EN_OK, 失败返回EN_ERROR, 入参错误返回EN_INVALID_PARAM
 */
INT32 mmPoll(mmPollfd *fds, INT32 fdCount, INT32 timeout, mmCompletionHandle handleIOCP,
    pmmPollData polledData, mmPollBack pollBack)
{
    if (fds == nullptr || polledData == nullptr || polledData->buf == nullptr || fdCount < 0) {
        return EN_INVALID_PARAM;
    }
    DWORD tout = timeout;
    if (timeout == EN_ERROR) {
        tout = INFINITE;
    }
    for (INT32 i = 0; i < fdCount; i++) {
        pmmComPletionKey pCompletionKey = &fds[i].completionKey;
        OVERLAPPED  overlapped;
        SecureZeroMemory(&overlapped, sizeof(overlapped));
        if (fds[i].handle == INVALID_HANDLE_VALUE) {
            return EN_INVALID_PARAM;
        }
        pCompletionKey->completionHandle = fds[i].handle;
        pCompletionKey->overlapType = fds[i].pollType;
        pCompletionKey->oa = overlapped;

        CreateIoCompletionPort(fds[i].handle, handleIOCP, (ULONG_PTR)pCompletionKey, 0);
        LocalReceiveAction(fds[i], polledData->buf, polledData->bufLen, &pCompletionKey->oa);
    }
    DWORD dwTransCount = 0;
    pmmComPletionKey outCompletionKey = nullptr;
    pmmPollData outPolledData = nullptr;
    if (GetQueuedCompletionStatus(handleIOCP, &dwTransCount,
        reinterpret_cast<PULONG_PTR>(&outCompletionKey),
        reinterpret_cast<LPOVERLAPPED *>(&outPolledData), tout)) {
        polledData->bufHandle = outCompletionKey->completionHandle;
        polledData->bufRes = dwTransCount;
        polledData->bufType = outCompletionKey->overlapType;
        if (dwTransCount == MMPA_ZERO) {
            return EN_ERROR;
        }
        pollBack(polledData);
        return EN_OK;
    } else if (GetLastError() == WAIT_TIMEOUT) { // The wait operation timed out.
        return EN_ERR;
    } else {
        polledData->bufRes = dwTransCount;
        return EN_ERROR;
    }
}

/*
 * 描述:获取错误码
 * 返回值:error code
 */
INT32 mmGetErrorCode()
{
    if (GetLastError() == ERROR_ALREADY_EXISTS) {
        errno = EEXIST;
    }
    return GetLastError();
}

/*
 * 描述：将mmGetErrorCode函数得到的错误信息转化成字符串信息
 * 参数：errnum--错误码，即mmGetErrorCode的返回值
 *       buf--收错误信息描述的缓冲区指针
 *       size--缓冲区的大小
 * 返回值:成功返回错误信息的字符串，失败返回nullptr
 */
CHAR *mmGetErrorFormatMessage(mmErrorMsg errnum, CHAR *buf, mmSize size)
{
    if (buf == nullptr || size <= 0) {
        return nullptr;
    }

    mmErrorMsg ret = FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                                   nullptr,
                                   errnum,
                                   MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                                   reinterpret_cast<LPTSTR>(buf),
                                   size,
                                   nullptr);
    if (ret == MMPA_ZERO) {
        return nullptr;
    }
    return buf;
}

/*
 * 描述:内部使用,计算a和b的最大公约数
 */
static INT32 localGcd(INT32 a, INT32 b)
{
    INT32 c;
    if (b == MMPA_ZERO) {
        return MMPA_ZERO;
    }
    c = a % b;
    while (c != MMPA_ZERO) {
        a = b;
        b = c;
        c = a % b;
    }
    return (b);
}

/*
 * 描述:内部使用, 交换内容块
 */
static void LocalPermuteArgs(INT32 panonoptStart, INT32 panonoptEnd, INT32 optEnd, CHAR * const *nargv)
{
    INT32 start;
    INT32 i;
    INT32 j;
    INT32 pos;
    CHAR *swap = nullptr;

    INT32 nonOpts = panonoptEnd - panonoptStart;
    INT32 opts = optEnd - panonoptEnd;
    INT32 cycle = localGcd(nonOpts, opts);
    if (cycle == MMPA_ZERO) {
        return;
    }
    INT32 cycleLen = (optEnd - panonoptStart) / cycle;

    for (i = 0; i < cycle; i++) {
        start = panonoptEnd + i;
        pos = start;
        for (j = 0; j < cycleLen; j++) {
            if (pos >= panonoptEnd) {
                pos -= nonOpts;
            } else {
                pos += opts;
            }
            swap = nargv[pos];
            /* LINTED const cast */
            (const_cast<CHAR **>(nargv))[pos] = nargv[start];
            /* LINTED const cast */
            (const_cast<CHAR **>(nargv))[start] = swap;
        }
    }
}

/*
 * 描述:获取当前操作系统类型
 * 返回值:执行成功返回:LINUX--当前系统是Linux系统
 *                     WIN--当前系统是Windows系统
 */
INT32 mmGetOsType()
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
    return _umask(pmode);
}

/*
 * 描述:等待子进程结束并返回对应结束码
 * 参数:pid--欲等待的子进程ID
 *      status--保存子进程的状态信息
 *      options--options提供了一些另外的选项来控制waitpid()函数的行为
 *               M_WAIT_NOHANG--如果pid指定的子进程没有结束，则立即返回;如果结束了, 则返回该子进程的进程号
 *               M_WAIT_UNTRACED--如果子进程进入暂停状态，则马上返回
 * 返回值:子进程未结束返回EN_OK, 系统调用执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 *        进程已经结束返回EN_ERR
 */
INT32 mmWaitPid(mmProcess pid, INT32 *status, INT32 options)
{
    if (options != MMPA_ZERO && options != M_WAIT_NOHANG && options != M_WAIT_UNTRACED) {
        return EN_INVALID_PARAM;
    }

    DWORD  dwMilliseconds;
    if (options == M_WAIT_NOHANG || options == M_WAIT_UNTRACED) {
        dwMilliseconds = 0; // 不等待立即返回
    } else {
        dwMilliseconds = INFINITE;
    }

    DWORD ret = WaitForSingleObject(pid, dwMilliseconds);
    if (ret == WAIT_OBJECT_0) {
        if (status != nullptr) {
            GetExitCodeProcess(pid, (LPDWORD)status); // 按需获取退出码
        }
        return EN_ERR; // 进程已结束
    } else if (ret == WAIT_FAILED) {
        return EN_ERROR; // 调用异常
    } else {
        return EN_OK; // 进程未结束
    }
}

/*
 * 描述:字符串截取
 * 参数:str--待截取字符串
 *      delim --分隔符
 *      saveptr -- 一个供内部使用的指针，用于保存上次分割剩下的字串
 * 返回值:执行成功返回截取后的字符串指针, 执行失败返回nullptr
 */
CHAR *mmStrTokR(CHAR *str, const CHAR *delim, CHAR **saveptr)
{
    if (delim == nullptr) {
        return nullptr;
    }
    return strtok_s(str, delim, saveptr);
}

/*
 * 描述:获取环境变量
 * 参数:name --需要获取的环境变量名
 *      len --缓存长度,
 *      value -- 由用户分配用来存放环境变量的缓存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    if (name == nullptr || value == nullptr || len == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    DWORD ret = GetEnvironmentVariable(name, value, len);
    if (ret == MMPA_ZERO || ret > (len - 1)) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:设置环境变量
 * 参数:name --需要获取的环境变量名
 *      value -- 由用户分配用来存放环境变量的缓存
 *      overwrite -- 是否覆盖标志位 0 表示不覆盖
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetEnv(const CHAR *name, const CHAR *value, INT32 overwrite)
{
    if (name == nullptr || value == nullptr) {
        return EN_INVALID_PARAM;
    }
    BOOL ret = FALSE;
    if (overwrite != MMPA_ZERO) {
        ret = SetEnvironmentVariable(name, value);
        if (!ret) {
            return EN_ERROR;
        }
    } else {
        // 不覆盖设置,先获取是否存在该name的环境变量，已存在就忽略，不存在就设置下去
        CHAR env[MMPA_MAX_BUF_SIZE] = { 0 };
        DWORD result = GetEnvironmentVariable(name, env, MMPA_MAX_BUF_SIZE);
        if (result == MMPA_ZERO && GetLastError() == ERROR_ENVVAR_NOT_FOUND) {
            ret = SetEnvironmentVariable(name, value);
            if (!ret) {
                return EN_ERROR;
            }
        }
    }
    return EN_OK;
}

/*
 * 描述:获取当前指定路径下磁盘容量及可用空间
 * 参数:path--路径名
 *      diskSize--mmDiskSize结构内容
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetDiskFreeSpace(const CHAR *path, mmDiskSize *diskSize)
{
    ULONGLONG freeBytes;
    ULONGLONG freeBytesToCaller;
    ULONGLONG totalBytes;
    if (path == nullptr || diskSize == nullptr) {
        return EN_INVALID_PARAM;
    }
    BOOL ret = GetDiskFreeSpaceEx(path, (PULARGE_INTEGER)&freeBytesToCaller,
        (PULARGE_INTEGER)&totalBytes, (PULARGE_INTEGER)&freeBytes);
    if (ret) {
        diskSize->availSize = (ULONGLONG)freeBytesToCaller;
        diskSize->totalSize = (ULONGLONG)totalBytes;
        diskSize->freeSize = (ULONGLONG)freeBytes;
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
INT32 mmGetOsName(CHAR *name, INT32 nameSize)
{
    if ((name == nullptr) || (nameSize < MMPA_MIN_OS_NAME_SIZE)) {
        return EN_INVALID_PARAM;
    }
    DWORD nameLength = nameSize;
    BOOL ret = GetComputerName(name, &nameLength);
    if (!ret) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:内部调用 -根据versionIndex获取系统版本信息
 * 参数:versionLength--存放操作系统信息的缓存长度
 *      versionInfo--由用户分配缓存, 缓存长度必须>=MMPA_MIN_OS_VERSION_SIZE
 *      versionIndex--操作系统内部编号
 * 返回值:执行成功返回EN_OK, 执行失败返回EN_ERROR
 */
INT32 LocalGetVersionInfo(CHAR *versionInfo, INT32 versionLength, INT32 versionIndex)
{
    INT32 ret = _snprintf_s(versionInfo, versionLength - 1, MMPA_MIN_OS_VERSION_SIZE, "%s", g_winOps[versionIndex]);
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
INT32 mmGetOsVersion(CHAR *versionInfo, INT32 versionLength)
{
    if (versionInfo == nullptr || versionLength < MMPA_MIN_OS_VERSION_SIZE) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = 0;
    if (!IsWindowsXPOrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_2000);
    }
    if (!IsWindowsXPSP1OrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_XP);
    }
    if (!IsWindowsXPSP2OrGreater()) {
        if (IsWindowsServer) {
            return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_SERVER_2003);
        }
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_XP_SP1);
    }
    if (!IsWindowsXPSP3OrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_HOME_SERVER);
    }
    if (!IsWindowsVistaOrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_XP_SP1);
    }
    if (!IsWindows7SP1OrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_VISTA);
    }
    if (!IsWindows8OrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_7);
    }
    if (!IsWindows8Point1OrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_8);
    }
    if (!IsWindows10OrGreater()) {
        return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_8_1);
    }
    return LocalGetVersionInfo(versionInfo, versionLength, MMPA_OS_VERSION_WINDOWS_10);
}

/*
 * 描述:获取当前系统下所有网卡的mac地址列表(不包括lo网卡)
 * 参数:list--获取到的mac地址列表指针数组, 缓存由函数内部分配, 需要调用mmGetMacFree释放
 *      count--获取到的mac地址的个数
 * 返回值:执行成功返回扫描到的EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetMac(mmMacInfo **list, INT32 *count)
{
    if (list == nullptr || count == nullptr) {
        return EN_INVALID_PARAM;
    }

    mmMacInfo *pMacInfo = nullptr;
    PIP_ADAPTER_INFO pAdapter = nullptr;
    UINT i = 0;

    ULONG ulOutBufLen = sizeof(IP_ADAPTER_INFO);
    PIP_ADAPTER_INFO pAdapterInfo = reinterpret_cast<IP_ADAPTER_INFO *>(HeapAlloc(GetProcessHeap(), \
        0, (sizeof(IP_ADAPTER_INFO))));
    if (pAdapterInfo == nullptr) {
        return EN_ERROR;
    }

    // 初始调用确保分配足够空间
    if (GetAdaptersInfo(pAdapterInfo, &ulOutBufLen) == ERROR_BUFFER_OVERFLOW) {
        (void)HeapFree(GetProcessHeap(), 0, pAdapterInfo);
        pAdapterInfo = reinterpret_cast<IP_ADAPTER_INFO *>(HeapAlloc(GetProcessHeap(), 0, ulOutBufLen));
        if (pAdapterInfo == nullptr) {
            return EN_ERROR;
        }
    }
    DWORD dwRetVal = GetAdaptersInfo(pAdapterInfo, &ulOutBufLen);
    if (dwRetVal == NO_ERROR) {
        pAdapter = pAdapterInfo;
        *count = ulOutBufLen / sizeof(IP_ADAPTER_INFO);
        pMacInfo = reinterpret_cast<mmMacInfo*>(HeapAlloc(GetProcessHeap(), 0, (*count * sizeof(mmMacInfo))));
        if (pMacInfo == nullptr) {
            (void)HeapFree(GetProcessHeap(), 0, pAdapterInfo);
            return EN_ERROR;
        }
        INT32 cycle = *count;
        while (cycle--) {
            // 0, 1, 2, 3, 4, 5是固定的MAC地址索引
            dwRetVal = _snprintf_s(pMacInfo[i].addr, sizeof(pMacInfo[i].addr)-1, "%02X-%02X-%02X-%02X-%02X-%02X", \
                pAdapter->Address[0], pAdapter->Address[1], pAdapter->Address[2], \
                pAdapter->Address[3], pAdapter->Address[4], pAdapter->Address[5]);
            if (dwRetVal < MMPA_ZERO) {
                (void)HeapFree(GetProcessHeap(), 0, pMacInfo);
                (void)HeapFree(GetProcessHeap(), 0, pAdapterInfo);
                return EN_ERROR;
            }
            pAdapter = pAdapter->Next;
            i++;
        }
    } else {
        (void)HeapFree(GetProcessHeap(), 0, pAdapterInfo);
        return EN_ERROR;
    }
    if (pAdapterInfo) {
        (void)HeapFree(GetProcessHeap(), 0, pAdapterInfo);
    }
    *list = pMacInfo;
    return EN_OK;
}

/*
 * 描述:释放由mmGetMac产生的动态内存
 * 参数:list--获取到的mac地址列表指针数组
 *      count--获取到的mac地址的个数
 * 返回值:执行成功返回扫描到的EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetMacFree(mmMacInfo *list, INT32 count)
{
    if (count <= 0 || list == nullptr) {
        return EN_INVALID_PARAM;
    }

    BOOL ret = HeapFree(GetProcessHeap(), 0, list);
    if (!ret) {
        return EN_ERROR;
    }
    list = nullptr;
    return EN_OK;
}

/*
 * 描述:内部使用, 获取当前系统cpu的部分物理硬件信息
 * 参数:pclsObj--对应的WMI服务指针
 *      cpuDesc--需要获取信息的结构体
 * 返回值:执行成功返回EN_OK，执行失败返回EN_ERROR
 */
static INT32 LocalGetProcessorInfo(IWbemClassObject *pclsObj, mmCpuDesc *cpuDesc)
{
    VARIANT vtProp;
    // 制造商
    pclsObj->Get(L"Manufacturer", 0, &vtProp, 0, 0);
    INT32 ret = _snprintf_s(cpuDesc->manufacturer, sizeof(cpuDesc->manufacturer) - 1, "%ws", vtProp.bstrVal);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    // 架构 目前最多支持识别10种
    pclsObj->Get(L"Architecture", 0, &vtProp, 0, 0);
    if (vtProp.uiVal < MMPA_MAX_PROCESSOR_ARCHITECTURE_COUNT) {
        ret = _snprintf_s(cpuDesc->arch, sizeof(cpuDesc->arch) - 1, "%s", g_arch[vtProp.uiVal]);
        if (ret < MMPA_ZERO) {
            return EN_ERROR;
        }
    }

    // 版本
    pclsObj->Get(L"Name", 0, &vtProp, 0, 0);
    ret = _snprintf_s(cpuDesc->version, sizeof(cpuDesc->version) - 1, "%ws", vtProp.bstrVal);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    // 工作频率
    pclsObj->Get(L"CurrentClockSpeed", 0, &vtProp, 0, 0);
    cpuDesc->frequency = vtProp.uintVal;
    // 最大超频频率
    pclsObj->Get(L"MaxClockSpeed", 0, &vtProp, 0, 0);
    cpuDesc->maxFrequency = vtProp.uintVal;
    // cpu核个数
    pclsObj->Get(L"NumberOfCores", 0, &vtProp, 0, 0);
    cpuDesc->ncores = vtProp.uintVal;
    // 线程个数
    pclsObj->Get(L"ThreadCount", 0, &vtProp, 0, 0);
    cpuDesc->nthreads = vtProp.uintVal;
    // 逻辑cpu个数
    pclsObj->Get(L"NumberOfLogicalProcessors", 0, &vtProp, 0, 0);
    cpuDesc->ncounts = vtProp.uintVal;

    VariantClear(&vtProp);
    pclsObj->Release();
    return EN_OK;
}

/*
 * 描述:内部使用, 释放WMI服务申请的资源
 */
static void LocalWMIServiceRelease(IWbemServices *pSvc, IWbemLocator *pLoc, IEnumWbemClassObject *pEnumerator)
{
    if (pSvc != nullptr) {
        pSvc->Release();
        pSvc = nullptr;
    }
    if (pLoc != nullptr) {
        pLoc->Release();
        pLoc = nullptr;
    }
    if (pEnumerator != nullptr) {
        pEnumerator->Release();
        pEnumerator = nullptr;
    }
    CoUninitialize();
    return;
}

/*
 * 描述:内部使用, 连接WMI服务并返回Wbem类对象指针
 */
static IEnumWbemClassObject *LocalConnectWMIService(IWbemServices **pSvc, IWbemLocator **pLoc)
{
    IEnumWbemClassObject *pEnumerator = nullptr;
    // Step 1:创建COM对象
    HRESULT hres = CoInitializeEx(0, COINIT_MULTITHREADED);
    if (FAILED(hres)) {
        return nullptr;
    }
    // Step 2:设置COM对象安全等级
    hres = CoInitializeSecurity(nullptr, -1, nullptr, nullptr, RPC_C_AUTHN_LEVEL_DEFAULT,
        RPC_C_IMP_LEVEL_IMPERSONATE, nullptr, EOAC_NONE, nullptr);
    if (FAILED(hres)) {
        LocalWMIServiceRelease(*pSvc, *pLoc, pEnumerator);
        return nullptr;
    }
    // Step 3:获取WMI初始探测器
    hres = CoCreateInstance(CLSID_WbemLocator, 0, CLSCTX_INPROC_SERVER,
        IID_IWbemLocator, reinterpret_cast<LPVOID *>(pLoc));
    if (FAILED(hres)) {
        LocalWMIServiceRelease(*pSvc, *pLoc, pEnumerator);
        return nullptr;
    }
    // Step 4:通过ConnectServer连接到WMI服务 ROOT\\CIMV2
    hres = (*pLoc)->ConnectServer((BSTR)(L"ROOT\\CIMV2"), nullptr, nullptr, 0, 0, 0, 0, pSvc);
    if (FAILED(hres)) {
        LocalWMIServiceRelease(*pSvc, *pLoc, pEnumerator);
        return nullptr;
    }
    // Step 5:设置安全等级
    hres = CoSetProxyBlanket(*pSvc, RPC_C_AUTHN_WINNT, RPC_C_AUTHZ_NONE, nullptr, RPC_C_AUTHN_LEVEL_CALL,
        RPC_C_IMP_LEVEL_IMPERSONATE, nullptr, EOAC_NONE);
    if (FAILED(hres)) {
        LocalWMIServiceRelease(*pSvc, *pLoc, pEnumerator);
        return nullptr;
    }

    hres = (*pSvc)->ExecQuery((BSTR)(L"WQL"), (BSTR)(L"SELECT * FROM Win32_Processor"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY, nullptr, &pEnumerator);
    if (FAILED(hres)) {
        LocalWMIServiceRelease(*pSvc, *pLoc, pEnumerator);
        return nullptr;
    }

    return pEnumerator;
}

/*
 * 描述:获取当前系统cpu的部分物理硬件信息
 * 参数:cpuInfo--包含需要获取信息的结构体, 函数内部分配, 需要调用mmCpuInfoFree释放
 *      count--读取到的物理cpu个数
 * 返回值:入参错误返回EN_INVALID_PARAM, 执行成功返回EN_OK，执行失败返回EN_ERROR
 */
INT32 mmGetCpuInfo(mmCpuDesc **cpuInfo, INT32 *count)
{
    if (cpuInfo == nullptr || count == nullptr) {
        return EN_INVALID_PARAM;
    }

    IWbemLocator *pLoc = nullptr;
    IWbemServices *pSvc = nullptr;

    IEnumWbemClassObject *pEnumerator = LocalConnectWMIService(&pSvc, &pLoc);
    if (pEnumerator == nullptr) {
        return EN_ERROR;
    }

    // 获取请求的服务的数据
    IWbemClassObject *pclsObj = nullptr;
    ULONG uReturn = 0;
    // 目前最多支持MMPA_MAX_PHYSICALCPU_COUNT
    mmCpuDesc cpuDesc[MMPA_MAX_PHYSICALCPU_COUNT] = {};
    SecureZeroMemory(cpuDesc, sizeof(cpuDesc));
    INT32 i = 0;
    while (pEnumerator != nullptr) {
        pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);
        if (uReturn == MMPA_ZERO) {
            break;
        }

        if (LocalGetProcessorInfo(pclsObj, &cpuDesc[i]) == EN_ERROR) {
            *count = 0;
            LocalWMIServiceRelease(pSvc, pLoc, pEnumerator);
            return EN_ERROR;
        }
        if (i < MMPA_MAX_PHYSICALCPU_COUNT - 1) {
            i++;
        } else {
            break;
        }
    }
    if (i == MMPA_ZERO) {
        LocalWMIServiceRelease(pSvc, pLoc, pEnumerator);
        return EN_ERROR;
    }
    *count = i;
    mmCpuDesc *pCpuDesc = reinterpret_cast<mmCpuDesc *>(HeapAlloc(GetProcessHeap(), 0, i * (sizeof(mmCpuDesc))));
    if (pCpuDesc == nullptr) {
        LocalWMIServiceRelease(pSvc, pLoc, pEnumerator);
        return EN_ERROR;
    }
    for (i = 0; i < *count; i++) {
        pCpuDesc[i] = cpuDesc[i];
    }
    *cpuInfo = pCpuDesc;
    // 释放资源
    LocalWMIServiceRelease(pSvc, pLoc, pEnumerator);
    return EN_OK;
}

/*
 * 描述:释放mmGetCpuInfo生成的动态内存
 * 参数:cpuInfo--mmGetCpuInfo获取到的信息的结构体指针
 *      count--mmGetCpuInfo获取到的物理cpu个数
 * 返回值:入参错误返回EN_INVALID_PARAM, 执行成功返回EN_OK，执行失败返回EN_ERROR
 */
INT32 mmCpuInfoFree(mmCpuDesc *cpuInfo, INT32 count)
{
    if (cpuInfo == nullptr || count == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    BOOL ret = HeapFree(GetProcessHeap(), 0, cpuInfo);
    if (!ret) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述： 获取系统内存页大小
 * 返回值：返系统回内存页大小
 */
mmSize mmGetPageSize()
{
    SYSTEM_INFO systemInfo = { 0 };
    GetSystemInfo(&systemInfo);
    return static_cast<mmSize>(systemInfo.dwPageSize);
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

