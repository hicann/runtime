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
#endif

/*
 * 描述:写数据到一个资源文件中
 * 参数: fd--指向打开文件的资源描述符
 *       buf--需要写入的数据
 *       bufLen--需要写入的数据长度
 * 返回值:执行成功返回写入的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmWrite(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < MMPA_ZERO) || (buf == NULL)) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t ret = write(fd, buf, (size_t)bufLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:从资源文件中读取数据
 * 参数: fd--指向打开文件的资源描述符
 *       buf--存放读取的数据，由用户分配缓存
 *       bufLen--需要读取的数据大小
 * 返回值:执行成功返回读取的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < MMPA_ZERO) || (buf == NULL)) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t ret = read(fd, buf, (size_t)bufLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:获取文件状态
 * 参数: path--需要获取的文件路径名
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:获取文件状态(文件size大于2G使用)
 * 参数: path--需要获取的文件路径名
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmStat64Get(const CHAR *path, mmStat64_t *buffer)
{
    if ((path == NULL) || (buffer == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = stat64(path, buffer);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取文件状态
 * 参数: fd--需要获取的文件描述符
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFStatGet(INT32 fd, mmStat_t *buffer)
{
    if (buffer == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = fstat(fd, buffer);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:创建一个目录
 * 参数: pathName -- 需要创建的目录路径名, 比如 CHAR dirName[256]="/home/test";
 *       mode -- 新目录的权限
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMkdir(const CHAR *pathName, mmMode_t mode)
{
    if (pathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = mkdir(pathName, mode);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数: pathName -- 文件路径名
 * 参数: mode -- 权限
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmAccess2(const CHAR *pathName, INT32 mode)
{
    if (pathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = access(pathName, mode);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数: pathName -- 文件路径名
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmAccess(const CHAR *pathName)
{
    return mmAccess2(pathName, F_OK);
}

/*
 * 描述:删除目录下所有文件及目录, 包括子目录
 * 参数: pathName -- 目录名全路径
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRmdir(const CHAR *pathName)
{
    INT32 ret;
    DIR *childDir = NULL;

    if (pathName == NULL) {
        return EN_INVALID_PARAM;
    }
    DIR *dir = opendir(pathName);
    if (dir == NULL) {
        return EN_INVALID_PARAM;
    }

    const struct dirent *entry = NULL;
    size_t bufSize = strlen(pathName) + (size_t)(PATH_SIZE + 2); // make sure the length is large enough
    while ((entry = readdir(dir)) != NULL) {
        if ((strcmp(".", entry->d_name) == MMPA_ZERO) || (strcmp("..", entry->d_name) == MMPA_ZERO)) {
            continue;
        }
        CHAR *buf = (CHAR *)malloc(bufSize);
        if (buf == NULL) {
            break;
        }
        ret = memset_s(buf, bufSize, 0, bufSize);
        if (ret == EN_ERROR) {
            free(buf);
            buf = NULL;
            break;
        }
        ret = snprintf_s(buf, bufSize, bufSize - 1U, "%s/%s", pathName, entry->d_name);
        if (ret == EN_ERROR) {
            free(buf);
            buf = NULL;
            break;
        }

        childDir = opendir(buf);
        if (childDir != NULL) {
            (VOID)closedir(childDir);
            (VOID)mmRmdir(buf);
            free(buf);
            buf = NULL;
            continue;
        } else {
            ret = unlink(buf);
            if (ret == EN_OK) {
                free(buf);
                continue;
            }
        }
        free(buf);
        buf = NULL;
    }
    (VOID)closedir(dir);

    ret = rmdir(pathName);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:对设备的I/O通道进行管理
 * 参数: fd--指向设备驱动文件的文件资源描述符
 *       ioctlCode--ioctl的操作码
 *       bufPtr--指向数据的缓存, 里面包含的输入输出buf缓存由用户分配
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmIoctl(mmProcess fd, INT32 ioctlCode, mmIoctlBuf *bufPtr)
{
    if ((fd < MMPA_ZERO) || (bufPtr == NULL) || (bufPtr->inbuf == NULL)) {
        return EN_INVALID_PARAM;
    }
    UINT32 request = (UINT32)ioctlCode;
    INT32 ret = ioctl(fd, request, bufPtr->inbuf);
    if (ret < EN_OK) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:打开文件或者设备驱动,linux侧暂不支持
 * 参数: 文件路径名fileName, 打开的权限access, 是否新创建标志位fileFlag
 * 返回值:执行成功返回对应打开的文件描述符，执行错误返回EN_ERROR, 入参检查错误返回EN_ERROR
 */
mmProcess mmOpenFile(const CHAR *fileName, UINT32 accessFlag, mmCreateFlag fileFlag)
{
    return EN_ERROR;
}

/*
 * 描述:关闭打开的文件或者设备驱动
 * 参数: 打开的文件描述符fileId
 * 返回值:执行成功返回EN_OK，执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCloseFile(mmProcess fileId)
{
    if (fileId < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = close(fileId);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:往打开的文件或者设备驱动写内容
 * 参数:打开的文件描述符fileId，buffer为用户分配缓存，len为buffer对应长度
 * 返回值:执行成功返回EN_OK，执行错误返回EN_ERROR，入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmWriteFile(mmProcess fileId, VOID *buffer, INT32 len)
{
    if ((fileId < MMPA_ZERO) || (buffer == NULL) || (len < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 writeLen = (UINT32)len;
    mmSsize_t ret = write(fileId, buffer, writeLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:往打开的文件或者设备驱动读取内容
 * 参数: 打开的文件描述符fileId，buffer为用户分配缓存，len为buffer对应长度
 * 返回值:执行成功返回实际读取的长度，执行错误返回EN_ERROR，入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmReadFile(mmProcess fileId, VOID *buffer, INT32 len)
{
    if ((fileId < MMPA_ZERO) || (buffer == NULL) || (len < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 readLen = (UINT32)len;

    mmSsize_t ret = read(fileId, buffer, readLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:将参数path所指的相对路径转换成绝对路径, 接口待废弃, 请使用mmRealPath
 * 参数: path--原始路径相对路径
 *       realPath--规范化后的绝对路径, 由用户分配内存, 长度必须要>= MMPA_MAX_PATH
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetRealPath(CHAR *path, CHAR *realPath)
{
    INT32 ret = EN_OK;
    if ((realPath == NULL) || (path == NULL)) {
        return EN_INVALID_PARAM;
    }
    const CHAR *pRet = realpath(path, realPath);
    if (pRet == NULL) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:将参数path所指的相对路径转换成绝对路径
 * 参数: path--原始路径相对路径
 *       realPath--规范化后的绝对路径, 由用户分配内存
 *       realPathLen--realPath缓存的长度, 长度必须要>= MMPA_MAX_PATH
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    INT32 ret = EN_OK;
    if ((realPath == NULL) || (path == NULL) || (realPathLen < MMPA_MAX_PATH)) {
        return EN_INVALID_PARAM;
    }
    const CHAR *ptr = realpath(path, realPath);
    if (ptr == NULL) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:扫描目录
 * 参数:path--目录路径
 *      filterFunc--用户指定的过滤回调函数
 *      sort--用户指定的排序回调函数
 *      entryList--扫描到的目录结构指针, 用户不需要分配缓存, 内部分配, 需要调用mmScandirFree释放
 * 返回值:执行成功返回扫描到的子目录数量, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < MMPA_ZERO) {
        return EN_ERROR;
    }
    return count;
}

/*
 * 描述:扫描目录
 * 参数:path--目录路径
 *      filterFunc--用户指定的过滤回调函数
 *      sort--用户指定的排序回调函数
 *      entryList--扫描到的目录结构指针, 用户不需要分配缓存, 内部分配, 需要调用mmScandirFree2释放
 * 返回值:执行成功返回扫描到的子目录和文件数量, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmScandir2(const CHAR *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < MMPA_ZERO) {
        return EN_ERROR;
    }
    return count;
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:entryList--mmScandir扫描到的目录结构指针
 *      count--扫描到的子目录数量
 * 返回值:无
 */
VOID mmScandirFree(mmDirent **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }
    INT32 j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:entryList--mmScandir2扫描到的目录结构指针
 *      count--扫描到的子目录数量
 * 返回值:无
 */
VOID mmScandirFree2(mmDirent2 **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }
    INT32 j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
}

/*
 * 描述:控制文件的读写位置
 * 参数:fd打开的文件描述符, 参数offset 为根据参数seekFlag来移动读写位置的位移数
 * 返回值:执行成功返回返回目前的读写位置, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
LONG mmLseek(INT32 fd, INT64 offset, INT32 seekFlag)
{
    if (fd <= MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    off_t pos = lseek(fd, (LONG)offset, seekFlag);
    return (LONG)pos;
}

/*
 * 描述:参数fd指定的文件大小改为参数length指定的大小
 * 参数:文件描述符fd
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFtruncate(mmProcess fd, UINT32 length)
{
    if (fd <= MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    return ftruncate(fd, (off_t)(ULONG)length);
}

/*
 * 描述:复制一个文件的描述符
 * 参数:oldFd -- 需要复制的fd
 *      newFd -- 新的生成的fd
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmDup2(INT32 oldFd, INT32 newFd)
{
    if ((oldFd <= MMPA_ZERO) || (newFd < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = dup2(oldFd, newFd);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * @brief Creates a second file descriptor for an open file
 * @param [in] fd, an open file handle
 * @returns a new file descripto, failed return EN_ERROR
 */
INT32 mmDup(INT32 fd)
{
    if (fd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    return dup(fd);
}

/*
 * 描述:返回指定文件流的文件描述符
 * 参数:stream--FILE类型文件流
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFileno(FILE *stream)
{
    if (stream == NULL) {
        return EN_INVALID_PARAM;
    }

    return fileno(stream);
}

/*
 * 描述:删除一个文件
 * 参数:filename--文件路径
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmUnlink(const CHAR *filename)
{
    if (filename == NULL) {
        return EN_INVALID_PARAM;
    }

    return unlink(filename);
}

/*
 * 描述:修改文件读写权限，目前仅支持读写权限修改
 * 参数:filename--文件路径
 *      mode--需要修改的权限
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmChmod(const CHAR *filename, INT32 mode)
{
    if (filename == NULL) {
        return EN_INVALID_PARAM;
    }

    return chmod(filename, (UINT32)mode);
}

/*
 * 描述:将对应文件描述符在内存中的内容写入磁盘
 * 参数:fd--文件句柄
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFsync(mmProcess fd)
{
    if (fd == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = fsync(fd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:将对应文件描述符在内存中的内容写入磁盘
 * 参数:fd--文件句柄
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFsync2(INT32 fd)
{
    if (fd == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = fsync(fd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:改变当前工作目录
 * 参数:path--需要切换到的工作目录
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmChdir(const CHAR *path)
{
    if (path == NULL) {
        return EN_INVALID_PARAM;
    }

    return chdir(path);
}

/*
 * 描述:获取当前工作目录路径
 * 参数:buffer--由用户分配用来存放工作目录路径的缓存
 *      maxLen--缓存长度
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
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

/*
 * 描述:截取目录, 比如/usr/bin/test, 截取后为 /usr/bin
 * 参数:path--路径，函数内部会修改path的值
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回NULL
 */
CHAR *mmDirName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    return dirname(path);
}

/*
 * 描述:截取目录后面的部分, 比如/usr/bin/test, 截取后为 test
 * 参数:path--路径，函数内部会修改path的值(行尾有\\会去掉)
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回NULL
 */
CHAR *mmBaseName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    return basename(path);
}

/*
 * 描述:获取当前指定路径下文件大小
 * 参数:fileName--文件路径名
 *      length--获取到的文件大小
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetFileSize(const CHAR *fileName, ULONGLONG *length)
{
    if ((fileName == NULL) || (length == NULL)) {
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (VOID)memset_s(&fileStat, sizeof(fileStat), 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    INT32 ret = lstat(fileName, &fileStat);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    *length = (ULONGLONG)fileStat.st_size;
    return EN_OK;
}

/*
 * 描述:判断是否是目录
 * 参数: fileName -- 文件路径名
 * 返回值:执行成功返回EN_OK(是目录), 执行错误返回EN_ERROR(不是目录), 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == NULL) {
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (VOID)memset_s(&fileStat, sizeof(fileStat), 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    INT32 ret = lstat(fileName, &fileStat);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    if (S_ISDIR(fileStat.st_mode) == 0) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述：创建或者打开共享内存文件
 * 参数：name- 要打开或者创建的共享内存文件名，linux：打开的文件都是位于/dev/shm目录的，因此name不能带路径；windows：需要带路径
 *       oflag：打开的文件操作属性
 *       mode：共享模式
 * 返回值：成功返回创建或者打开的文件句柄，执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmFileHandle mmShmOpen(const CHAR *name, INT32 oflag, mmMode_t mode)
{
    (VOID)name;
    (VOID)oflag;
    (VOID)mode;
    return EN_ERROR;
}

/*
 * 描述:删除mmShmOpen创建的文件
 * 参数:name--文件路径
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmShmUnlink(const CHAR *name)
{
    (VOID)name;
    return EN_ERROR;
}

/*
 * 描述： 将一个文件或者其它对象映射进内存(系统决定映射区的起始地址)
 * 参数： fd--有效的文件句柄
 *        size--映射区的长度
 *        offeet--被映射对象内容的起点
 *        extra--(出参)CreateFileMapping()返回的文件映像对象句柄，此参数linux不使用，windows为mmMumMap入参，释放资源
 *        prot--期望的内存保护标志，不能与文件的打开模式冲突，此参数linux使用，windows不使用
 *        flags--指定映射对象的类型，映射选项和映射页是否可以共享，此参数linux使用，windows不使用
 * 返回值：成功执行时，返回被映射区的指针；失败返回NULL
 */
VOID *mmMmap(mmFd_t fd, mmSize_t size, mmOfft_t offset, mmFd_t *extra, INT32 prot, INT32 flags)
{
    if (size == 0) {
        return NULL;
    }
    VOID *data = mmap(NULL, size, prot, flags, fd, offset);
    if (data == MAP_FAILED) {
        return NULL;
    }
    return data;
}

/*
 * 描述：取消已映射内存的地址(系统决定映射区的起始地址)
 * 参数： data--需要取消映射的内存地址
 *        size--欲取消的内存大小
 *        extra--CreateFileMapping()返回的文件映像对象句柄，此参数linux不使用，windows为释放资源参数
 * 返回值：执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMunMap(VOID *data, mmSize_t size, mmFd_t *extra)
{
    if ((data == NULL) || (size == 0)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = munmap(data, size);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

