/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "osal.h"
#include "osal_linux.h"

/*
 * 描述:睡眠指定时间
 * 参数: milliSecond -- 睡眠时间 单位ms, linux下usleep函数microSecond入参必须小于1000000
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalSleep(uint32_t milliSecond)
{
    return mmSleep(milliSecond);
}

/*
 * 描述:获取进程ID
 * 参数:无
 * 返回值:执行成功返回对应调用进程的id, 执行错误返回OSAL_EN_ERROR
 */
int32_t OsalGetPid(void)
{
    return mmGetPid();
}

/*
 * 描述:获取调用线程的线程ID
 * 参数:无
 * 返回值:执行成功返回对应调用线程的id, 执行错误返回OSAL_EN_ERROR
 */
int32_t OsalGetTid(void)
{
    return mmGetTid();
}

/*
 * 描述:创建socket
 * 参数: sockFamily--协议域
 *       type--指定socket类型
 *       protocol--指定协议
 * 返回值:执行成功返回创建的socket id, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSockHandle OsalSocket(int32_t sockFamily, int32_t type, int32_t protocol)
{
    return mmSocket(sockFamily, type, protocol);
}

/*
 * 描述:把一个地址族中的特定地址赋给socket
 * 参数: sockFd--socket描述字，通过OsalSocket函数创建
 *       addr--一个指向要绑定给sockFd的协议地址
 *       addrLen--对应地址的长度
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalBind(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen)
{
    return mmBind(sockFd, addr, addrLen);
}

/*
 * 描述:监听socket
 * 参数: sockFd--socket描述字，通过OsalSocket函数创建
 *       backLog--相应socket可以排队的最大连接个数
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalListen(OsalSockHandle sockFd, int32_t backLog)
{
    return mmListen(sockFd, backLog);
}

/*
 * 描述:监听指定的socket地址
 * 参数: sockFd--socket描述字，通过OsalSocket函数创建
 *       addr--用于返回客户端的协议地址, addr若为nullptr, addrLen也应该为nullptr
 *       addrLen--协议地址的长度
 * 返回值:执行成功返回自动生成的一个全新的socket id, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSockHandle OsalAccept(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen *addrLen)
{
    return mmAccept(sockFd, addr, addrLen);
}

/*
 * 描述:发出socket连接请求
 * 参数:sockFd--socket描述字，通过OsalSocket函数创建
 *      addr--服务器的socket地址
 *      addrLen--地址的长度
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalConnect(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen)
{
    return mmConnect(sockFd, addr, addrLen);
}

/*
 * 描述:在建立连接的socket上发送数据
 * 参数: sockFd--已建立连接的socket描述字
 *       pstSendBuf--需要发送的数据缓存，有用户分配
 *       sendLen--需要发送的数据长度
 *       sendFlag--发送的方式标志位，一般置0
 * 返回值:执行成功返回实际发送的buf长度, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSsize OsalSocketSend(OsalSockHandle sockFd, VOID *sendBuf, int32_t sendLen, int32_t sendFlag)
{
    return mmSocketSend(sockFd, sendBuf, sendLen, sendFlag);
}
/*
 * 描述:在建立连接的socket上接收数据
 * 参数: sockFd--已建立连接的socket描述字
 *       pstRecvBuf--存放接收的数据的缓存，用户分配
 *       recvLen--需要发送的数据长度
 *       recvFlag--接收的方式标志位，一般置0
 * 返回值:执行成功返回实际接收的buf长度, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSsize OsalSocketRecv(OsalSockHandle sockFd, VOID *recvBuf, int32_t recvLen, int32_t recvFlag)
{
    return mmSocketRecv(sockFd, recvBuf, recvLen, recvFlag);
}

/*
 * 描述:获取错误码
 * 返回值:error code
 */
int32_t OsalGetErrorCode(void)
{
    return mmGetErrorCode();
}

/*
 * 描述:新创建进程执行可执行程序或者指定命令或者重定向输出文件
 * 参数:fileName--需要执行的可执行程序所在路径名
 *      env--保存子进程的状态信息
 *      stdoutRedirectFile--重定向文件路径, 若不为空, 则启用重定向功能
 *      id--创建的子进程ID号
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalCreateProcess(const CHAR *fileName, const OsalArgvEnv *env, const CHAR *stdoutRedirectFile, OsalProcess *id)
{
    return mmCreateProcess(fileName, env, stdoutRedirectFile, id);
}

/*
 * 描述:创建带属性的线程, 支持调度策略、优先级、线程栈大小、分离属性设置,除了分离属性,其他只在linux下有效
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalCreateTaskWithThreadAttr(OsalThread *threadHandle,
    const OsalUserBlock *funcBlock, const OsalThreadAttr *threadAttr)
{
    return mmCreateTaskWithThreadAttr(threadHandle, funcBlock, threadAttr);
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
int32_t OsalWaitPid(OsalProcess pid, int32_t *status, int32_t options)
{
    return mmWaitPid(pid, status, options);
}

/*
 * 描述:该函数等待线程结束并返回线程退出值"value_ptr"
 *       如果线程成功结束会detach线程
 *       注意:detached的线程不能用该函数或取消
 * 参数: threadHandle-- pthread_t类型的实例
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalJoinTask(OsalThread *threadHandle)
{
    return mmJoinTask(threadHandle);
}
/*
 * 描述:获取系统开机到现在经过的时间
 * 返回值:执行成功返回类型OsalTimespec结构的时间
 */
OsalTimespec OsalGetTickCount(void)
{
    return mmGetTickCount();
}

/*
 * 描述:获取当前指定路径下文件大小
 * 参数:fileName--文件路径名
 *      length--获取到的文件大小
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetFileSize(const CHAR *fileName, uint64_t *length)
{
    return mmGetFileSize(fileName, (ULONGLONG*)(length));
}

/*
 * 描述:获取当前指定路径下磁盘容量及可用空间
 * 参数:path--路径名
 *      diskSize--OsalDiskSize结构内容
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetDiskFreeSpace(const CHAR *path, OsalDiskSize *diskSize)
{
    return mmGetDiskFreeSpace(path, diskSize);
}

/*
 * 描述:判断是否是目录
 * 参数: fileName -- 文件路径名
 * 返回值:执行成功返回OSAL_EN_OK(是目录), 执行错误返回OSAL_EN_ERROR(不是目录), 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalIsDir(const CHAR *fileName)
{
    return mmIsDir(fileName);
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数: pathName -- 文件路径名
 * 参数: mode -- 权限
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalAccess2(const CHAR *pathName, int32_t mode)
{
    return mmAccess2(pathName, mode);
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数: pathName -- 文件路径名
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalAccess(const CHAR *pathName)
{
    return mmAccess(pathName);
}
/*
 * 描述:截取目录, 比如/usr/bin/test, 截取后为 /usr/bin
 * 参数:path--路径，函数内部会修改path的值
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回nullptr
 */
CHAR *OsalDirName(CHAR *path)
{
    return mmDirName(path);
}

/*
 * 描述:截取目录后面的部分, 比如/usr/bin/test, 截取后为 test
 * 参数:path--路径，函数内部会修改path的值(行尾有\\会去掉)
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回nullptr
 */
CHAR *OsalBaseName(CHAR *path)
{
    return mmBaseName(path);
}

/*
 * 描述:获取当前工作目录路径
 * 参数:buffer--由用户分配用来存放工作目录路径的缓存
 *      maxLen--缓存长度
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetCwd(CHAR *buffer, int32_t maxLen)
{
    return mmGetCwd(buffer, maxLen);
}

/*
 * 描述:创建一个目录
 * 参数: pathName -- 需要创建的目录路径名, 比如 CHAR dirName[256]="/home/test";
 *       mode -- 新目录的权限
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalMkdir(const CHAR *pathName, OsalMode mode)
{
    return mmMkdir(pathName, mode);
}

/*
 * 描述:修改文件读写权限，目前仅支持读写权限修改
 * 参数:filename--文件路径
 *      mode--需要修改的权限
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalChmod(const CHAR *filename, int32_t mode)
{
    return mmChmod(filename, mode);
}
/*
 * 描述:改变当前工作目录
 * 参数:path--需要切换到的工作目录
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalChdir(const CHAR *path)
{
    return mmChdir(path);
}

/*
 * 描述:扫描目录
 * 参数:path--目录路径
 *      filterFunc--用户指定的过滤回调函数
 *      sort--用户指定的排序回调函数
 *      entryList--扫描到的目录结构指针, 用户不需要分配缓存, 内部分配, 需要调用OsalScandirFree释放
 * 返回值:执行成功返回扫描到的子目录数量, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalScandir(const CHAR *path, OsalDirent ***entryList, OsalFilter filterFunc, OsalSort sort)
{
    return mmScandir(path, entryList, filterFunc, sort);
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:entryList--OsalScandir扫描到的目录结构指针
 *      count--扫描到的子目录数量
 * 返回值:无
 */
VOID OsalScandirFree(OsalDirent **entryList, int32_t count)
{
    return mmScandirFree(entryList, count);
}
/*
 * 描述:删除目录下所有文件及目录, 包括子目录
 * 参数: pathName -- 目录名全路径
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalRmdir(const CHAR *pathName)
{
    return mmRmdir(pathName);
}

/*
 * 描述:删除一个文件
 * 参数:filename--文件路径
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalUnlink(const CHAR *filename)
{
    return mmUnlink(filename);
}

/*
 * 描述:将参数path所指的相对路径转换成绝对路径
 * 参数: path--原始路径相对路径
 *       realPath--规范化后的绝对路径, 由用户分配内存
 *       realPathLen--realPath缓存的长度, 长度必须要>= OSAL_MAX_PATH
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalRealPath(const CHAR *path, CHAR *realPath, int32_t realPathLen)
{
    return mmRealPath(path, realPath, realPathLen);
}

/*
* 描述：将OsalGetErrorCode函数得到的错误信息转化成字符串信息
* 参数： errnum--错误码，即OsalGetErrorCode的返回值
*       buf--收错误信息描述的缓冲区指针
*       size--缓冲区的大小
* 返回值:成功返回错误信息的字符串，失败返回nullptr
*/
CHAR *OsalGetErrorFormatMessage(OsalErrorMsg errnum, CHAR *buf, OsalSize size)
{
    return mmGetErrorFormatMessage(errnum, buf, size);
}

/*
 * 描述:获取文件状态
 * 参数: path--需要获取的文件路径名
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalStatGet(const CHAR *path, OsalStat *buffer)
{
    return mmStatGet(path, buffer);
}

/*
 * 描述:打开或者创建一个文件
 * 参数: pathName--需要打开或者创建的文件路径名，由用户确保绝对路径
 *       flags--打开或者创建的文件标志位
 *       mode -- 打开或者创建的权限
 * 返回值:执行成功返回对应打开的文件描述符, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalOpen(const CHAR *pathName, int32_t flags, OsalMode mode)
{
    return mmOpen2(pathName, flags, mode);
}

/*
 * 描述:关闭打开的文件
 * 参数: fd--指向打开文件的资源描述符
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalClose(int32_t fd)
{
    return mmClose(fd);
}

/*
 * 描述:写数据到一个资源文件中
 * 参数:fd--指向打开文件的资源描述符
 *       buf--需要写入的数据
 *       bufLen--需要写入的数据长度
 * 返回值:执行成功返回写入的长度, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
OsalSsize OsalWrite(int32_t fd, VOID *buf, uint32_t bufLen)
{
    return mmWrite(fd, buf, bufLen);
}

/*
 * 描述:设置当前执行的线程的线程名-线程体内调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:name--需要设置的线程名
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalSetCurrentThreadName(const CHAR* name)
{
    return mmSetCurrentThreadName(name);
}

int32_t OsalGetOptInd(void)
{
    return mmGetOptInd();
}

CHAR *OsalGetOptArg(void)
{
    return mmGetOptArg();
}

/*
 * 描述:获取系统名字
 * 参数:nameSize--存放系统名的缓存长度
 *      name--由用户分配缓存, 缓存长度必须>=OSAL_MIN_OS_VERSION_SIZE
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAMs
 */
int32_t OsalGetOsName(CHAR *name, int32_t nameSize)
{
    return mmGetOsName(name, nameSize);
}

/*
 * 描述:加载一个动态库中的符号
 * 参数:fileName--动态库文件名
 *      mode--打开方式
 * 返回值:执行成功返回动态链接库的句柄, 执行错误返回nullptr, 入参检查错误返回nullptr
 */
VOID *OsalDlopen(const CHAR *fileName, int32_t mode)
{
    return mmDlopen(fileName, mode);
}

/*
 * 描述:获取OsalDlopen打开的动态库中的指定符号地址
 * 参数: handle--OsalDlopen 返回的指向动态链接库指针
 *       funcName--要求获取的函数的名称
 * 返回值:执行成功返回指向函数的地址, 执行错误返回nullptr, 入参检查错误返回nullptr
 */
VOID *OsalDlsym(VOID *handle, const CHAR *funcName)
{
    return mmDlsym(handle, funcName);
}

/*
 * 描述:关闭OsalDlopen加载的动态库
 * 参数: handle--OsalDlopen 返回的指向动态链接库指针
 *       funcName--要求获取的函数的名称
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalDlclose(VOID *handle)
{
    return mmDlclose(handle);
}

/*
 * 描述:当OsalDlopen动态链接库操作函数执行失败时，OsalDlerror可以返回出错信息
 * 返回值:执行成功返回nullptr
 */
CHAR *OsalDlerror(void)
{
    return mmDlerror();
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
int32_t OsalGetOptLong(int32_t argc, CHAR * const * argv, const CHAR *opts, const OsalStructOption *longOpts,
    int32_t *longIndex)
{
    return mmGetOptLong(argc, argv, opts, longOpts, longIndex);
}

/*
 * 描述:获取当前操作系统版本信息
 * 参数:versionLength--存放操作系统信息的缓存长度
 *      versionInfo--由用户分配缓存, 缓存长度必须>=OSAL_MIN_OS_VERSION_SIZE
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetOsVersion(CHAR *versionInfo, int32_t versionLength)
{
    return mmGetOsVersion(versionInfo, versionLength);
}

/*
 * 描述:获取当前系统cpu的部分物理硬件信息
 * 参数:cpuInfo--包含需要获取信息的结构体, 函数内部分配, 需要调用LinuxCpuInfoFree释放
 *      count--读取到的物理cpu个数
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetCpuInfo(OsalCpuDesc **cpuInfo, int32_t *count)
{
    return mmGetCpuInfo(cpuInfo, count);
}

/*
 * 描述:释放OsalGetCpuInfo生成的动态内存
 * 参数:cpuInfo--LinuxGetCpuInfo获取到的信息的结构体指针
 *      count--LinuxGetCpuInfo获取到的物理cpu个数
 * 返回值:执行成功返回OSAL_EN_OK, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalCpuInfoFree(OsalCpuDesc *cpuInfo, int32_t count)
{
    return mmCpuInfoFree(cpuInfo, count);
}

/*
 * 描述:获取本地时间
 * 参数: sysTimePtr -- 指向OsalSystemTime 结构的指针
 * 返回值:执行成功返回OSAL_EN_OK, 执行错误返回OSAL_EN_ERROR, 入参检查错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetLocalTime(OsalSystemTime *sysTimePtr)
{
    return mmGetLocalTime(sysTimePtr);
}

/*
 * 描述:获取当前系统时间和时区信息, windows不支持时区获取
 * 参数:timeVal--当前系统时间, 不能为nullptr
        timeZone--当前系统设置的时区信息, 可以为nullptr, 表示不需要获取时区信息
 * 返回值:执行成功返回OSAL_EN_OK, 失败返回OSAL_EN_ERROR，入参错误返回OSAL_EN_INVALID_PARAM
 */
int32_t OsalGetTimeOfDay(OsalTimeval *timeVal, OsalTimezone *timeZone)
{
    return mmGetTimeOfDay(timeVal, timeZone);
}