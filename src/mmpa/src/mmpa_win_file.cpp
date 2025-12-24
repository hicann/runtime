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

/*
 * 描述:打开或者创建一个文件
 * 参数:pathName--需要打开或者创建的文件路径名，由用户确保绝对路径
 *       flags--打开或者创建的文件标志位, 默认 user和group的权限
 * 返回值:执行成功返回对应打开的文件描述符, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmOpen(const CHAR *pathName, INT32 flags)
{
    if (pathName == nullptr) {
        return EN_INVALID_PARAM;
    }
    UINT32 tmpFlag = static_cast<UINT32>(flags);

    if ((tmpFlag & (_O_TRUNC | _O_WRONLY | _O_RDWR | _O_CREAT | _O_BINARY)) == MMPA_ZERO && flags != _O_RDONLY) {
        return EN_INVALID_PARAM;
    }

    INT32 fd = _open(pathName, flags, _S_IREAD | _S_IWRITE); // mode默认为 _S_IREAD | _S_IWRITE
    if (fd < MMPA_ZERO) {
        return EN_ERROR;
    }
    return fd;
}

/*
 * 描述:打开或者创建一个文件
 * 参数:pathName--需要打开或者创建的文件路径名，由用户确保绝对路径
 *       flags--打开或者创建的文件标志位
 *       mode -- 打开或者创建的权限
 * 返回值:执行成功返回对应打开的文件描述符, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmOpen2(const CHAR *pathName, INT32 flags, MODE mode)
{
    if (pathName == nullptr) {
        return EN_INVALID_PARAM;
    }
    UINT32 tmpFlag = static_cast<UINT32>(flags);
    UINT32 tmpMode = static_cast<UINT32>(mode);

    if ((tmpFlag & (_O_TRUNC | _O_WRONLY | _O_RDWR | _O_CREAT | _O_BINARY)) == MMPA_ZERO && flags != _O_RDONLY) {
        return EN_INVALID_PARAM;
    }
    if (((tmpMode & _S_IREAD) == MMPA_ZERO) && ((tmpMode & _S_IWRITE) == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 winFd = _open(pathName, flags, mode);
    if (winFd < MMPA_ZERO) {
        return EN_ERROR;
    }
    return winFd;
}

/*
 * 描述:关闭打开的文件
 * 参数:fd--指向打开文件的资源描述符
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM， 错误原因存于mmGetErrorCode中
 */
INT32 mmClose(INT32 fd)
{
    if (fd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 result = _close(fd);
    if (result != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:写数据到一个资源文件中
 * 参数:fd--指向打开文件的资源描述符
 *       buf--需要写入的数据
 *       bufLen--需要写入的数据长度
 * 返回值:执行成功返回写入的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmWrite(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if (fd < MMPA_ZERO || buf == nullptr || bufLen == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t result = _write(fd, buf, bufLen);
    if (result < MMPA_ZERO) {
        return EN_ERROR;
    }
    return result;
}

/*
 * 描述:从资源文件中读取数据
 * 参数:fd--指向打开文件的资源描述符
 *       buf--存放读取的数据，由用户分配缓存
 *       bufLen--需要读取的数据大小
 * 返回值:执行成功返回读取的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if (fd < MMPA_ZERO || buf == nullptr || bufLen == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t result = _read(fd, buf, bufLen);
    if (result < MMPA_ZERO) {
        return EN_ERROR;
    }
    return result;
}

/*
 * 描述:创建一个目录
 * 参数:pathName -- 需要创建的目录路径名, 比如 CHAR dirName[256]="/home/test";
 *       mode -- 新目录的权限
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMkdir(const CHAR *pathName, mmMode_t mode)
{
    if (pathName == nullptr) {
        return EN_INVALID_PARAM;
    }

    BOOL ret = CreateDirectory((LPCSTR)pathName, nullptr);
    if (!ret) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取文件状态
 * 参数:path--需要获取的文件路径名
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmStatGet(const CHAR *path, mmStat_t *buffer)
{
    if (path == nullptr || buffer == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = stat(path, buffer);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取文件状态(文件size大于2G使用)
 * 参数:path--需要获取的文件路径名
 *       buffer--获取到的状态 由用户分配缓存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmStat64Get(const CHAR *path, mmStat64_t *buffer)
{
    if (path == nullptr || buffer == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = _stat64(path, buffer);
    if (ret == EN_ERROR) {
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
    if (buffer == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = _fstat(fd, reinterpret_cast<struct _stat64i32 *>(buffer));
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数:pathName -- 文件路径名
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmAccess(const CHAR *pathName)
{
    if (pathName == nullptr) {
        return EN_INVALID_PARAM;
    }
    DWORD ret = GetFileAttributes((LPCSTR)pathName);
    if (ret == INVALID_FILE_ATTRIBUTES) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:判断文件或者目录是否存在
 * 参数:pathName -- 文件路径名
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmAccess2(const CHAR *pathName, INT32 mode)
{
    return mmAccess(pathName);
}

/*
 * 描述:删除目录下所有文件及目录, 包括子目录
 * 参数:pathName -- 目录名全路径
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRmdir(const CHAR *pathName)
{
    DWORD dRet;
    if (pathName == nullptr) {
        return EN_INVALID_PARAM;
    }
    CHAR szCurPath[MAX_PATH] = {0};
    INT32 ret = _snprintf_s(szCurPath, MAX_PATH - 1, "%hs\\*.*", pathName);
    if (ret < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    WIN32_FIND_DATA FindFileData;
    SecureZeroMemory(&FindFileData, sizeof(WIN32_FIND_DATAA));
    HANDLE hFile = FindFirstFile((LPCSTR)szCurPath, &FindFileData);
    BOOL FOUND = FALSE;
    do {
        FOUND = FindNextFile(hFile, &FindFileData);
        if (strcmp(reinterpret_cast<CHAR *>(FindFileData.cFileName), ".") == MMPA_ZERO ||
            strcmp(reinterpret_cast<CHAR *>(FindFileData.cFileName), "..") == MMPA_ZERO) {
            continue;
        }
        CHAR buf[MAX_PATH];
        ret = _snprintf_s(buf, MAX_PATH - 1, "%s\\%s", pathName, FindFileData.cFileName);
        if (ret < MMPA_ZERO) {
            (void)FindClose(hFile);
            return EN_INVALID_PARAM;
        }
        dRet = GetFileAttributes(buf); // whether dir or file,
        if (dRet == FILE_ATTRIBUTE_DIRECTORY) {
            dRet = mmRmdir(buf);
            if (dRet != EN_OK) {
                (void)FindClose(hFile);
                return EN_ERROR;
            }
        } else {
            if (!DeleteFile(buf)) {
                (void)FindClose(hFile);
                return EN_ERROR;
            }
        }
    } while (FOUND);
    (void)FindClose(hFile);

    BOOL bRet = RemoveDirectory((LPCSTR)pathName);
    if (!bRet) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:对设备的I/O通道进行管理
 * 参数:fd--指向设备驱动文件的文件资源描述符
 *       ioctlCode--ioctl的操作码
 *       bufPtr--指向数据的缓存, 里面包含的输入输出buf缓存由用户分配
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmIoctl(mmProcess fd, INT32 ioctlCode, mmIoctlBuf *bufPtr)
{
    if ((fd < MMPA_ZERO) || bufPtr == nullptr || bufPtr->inbuf == nullptr || bufPtr->outbuf == nullptr) {
        return EN_INVALID_PARAM;
    }
    DWORD bytesReturned = 0;
    DWORD result = DeviceIoControl(fd, static_cast<DWORD>(ioctlCode), static_cast<LPVOID>(bufPtr->inbuf),
                                   static_cast<DWORD>(bufPtr->inbufLen), static_cast<LPVOID>(bufPtr->outbuf),
                                   static_cast<DWORD>(bufPtr->outbufLen), &bytesReturned, bufPtr->oa);
    if (result == MMPA_ZERO) {
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:打开文件或者设备驱动
 * 参数:文件路径名fileName, 打开的权限access, 是否新创建标志位fileFlag
 * 返回值:执行成功返回对应打开的文件描述符，执行错误返回EN_ERROR, 入参检查错误返回EN_ERROR
 */
mmProcess mmOpenFile(const CHAR *fileName, UINT32 accessFlag, mmCreateFlag fileFlag)
{
    if (fileName == nullptr) {
        return (mmProcess)EN_ERROR;
    }

    if ((accessFlag & (GENERIC_READ | GENERIC_WRITE)) == MMPA_ZERO) {
        return (mmProcess)EN_ERROR;
    }
    DWORD dwCreationDisposition;
    if (fileFlag.createFlag == OPEN_ALWAYS) {
        dwCreationDisposition = OPEN_ALWAYS; // if no file , create file
    } else {
        dwCreationDisposition = OPEN_EXISTING; // if no file , return false
    }
    DWORD dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL;
    if (fileFlag.oaFlag != MMPA_ZERO) {
        dwFlagsAndAttributes |= FILE_FLAG_OVERLAPPED;
    }

    mmProcess fd = CreateFile((LPCSTR)fileName, accessFlag,
        FILE_SHARE_READ | FILE_SHARE_WRITE, // 默认文件对于多进程都是共享读写的
        nullptr, (DWORD)dwCreationDisposition, dwFlagsAndAttributes, nullptr);
    if (fd == INVALID_HANDLE_VALUE) {
        return (mmProcess)EN_ERROR;
    }
    return fd;
}

/*
 * 描述:关闭打开的文件或者设备驱动
 * 参数:打开的文件描述符fileId
 * 返回值:执行成功返回EN_OK，执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCloseFile(mmProcess fileId)
{
    if (fileId < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    BOOL result = CloseHandle(fileId);
    if (!result) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:往打开的文件或者设备驱动写内容
 * 参数:打开的文件描述符fileId，buffer为用户分配缓存，len为buffer对应长度
 * 返回值:执行成功返回写入的字节数，执行错误返回EN_ERROR，入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmWriteFile(mmProcess fileId, VOID *buffer, INT32 len)
{
    DWORD dwWritten = MMPA_ZERO;
    if ((fileId < MMPA_ZERO) || (buffer == nullptr) || len < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = WriteFile(fileId, buffer, len, &dwWritten, nullptr);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return (INT32)dwWritten;
}

/*
 * 描述:往打开的文件或者设备驱动读取内容
 * 参数:打开的文件描述符fileId，buffer为用户分配缓存，len为buffer对应长度
 * 返回值:执行成功返回实际读取的长度，执行错误返回EN_ERROR，入参检查错误返回EN_INVALID_PARAM
 */
mmSsize_t mmReadFile(mmProcess fileId, VOID *buffer, INT32 len)
{
    DWORD dwRead = MMPA_ZERO;
    if ((fileId < MMPA_ZERO) || (buffer == nullptr) || len == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    mmSsize_t ret = ReadFile(fileId, buffer, len, &dwRead, nullptr);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return (INT32)dwRead;
}

/*
 * 描述:将参数path所指的相对路径转换成绝对路径, 接口待废弃, 请使用mmRealPath
 * 参数:path--原始路径相对路径
         realPath--规范化后的绝对路径, 由用户分配内存, 长度必须要>= MMPA_MAX_PATH
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetRealPath(CHAR *path, CHAR *realPath)
{
    if (realPath == nullptr || path == nullptr) {
        return EN_INVALID_PARAM;
    }

    if (_fullpath(realPath, path, MMPA_MAX_PATH) == nullptr) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:将参数path所指的相对路径转换成绝对路径
 * 参数:path--原始路径相对路径
         realPath--规范化后的绝对路径, 由用户分配内存
         realPathLen--realPath缓存的长度, 长度必须要>= MMPA_MAX_PATH
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    if (realPath == nullptr || path == nullptr || realPathLen < MMPA_MAX_PATH) {
        return EN_INVALID_PARAM;
    }

    if (_fullpath(realPath, path, MMPA_MAX_PATH) == nullptr) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * mmScandir接口内部使用，查找有效的子目录或文件
 */
BOOL LocalFindFile(WIN32_FIND_DATA *findData)
{
    BOOL findFlag = FALSE;
    if (!(findData->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)) {
        findFlag = TRUE;
    } else if (findData->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
        if (findData->cFileName[0] == '.' && (findData->cFileName[1] == MMPA_ZERO || findData->cFileName[1] == '.')) {
            return findFlag;
        }
        findFlag = TRUE;
    }
    return findFlag;
}

/*
 * 描述:扫描目录,最多支持扫描MMPA_MAX_SCANDIR_COUNT个数目录
 * 参数:path--目录路径
        filterFunc--用户指定的过滤回调函数
        sort--用户指定的排序回调函数
        entryList--扫描到的目录结构指针, 用户不需要分配缓存, 内部分配, 需要调用mmScandirFree释放
 * 返回值:执行成功返回扫描到的子目录数量, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    if (path == nullptr) {
        return EN_INVALID_PARAM;
    }

    CHAR findPath[_MAX_PATH] = {0};
    WIN32_FIND_DATA findData;
    mmDirent **nameList = nullptr;
    mmDirent *newList = nullptr;
    size_t pos = 0;

    BOOL value = PathCanonicalize(findPath, path);
    if (!value) {
        return EN_INVALID_PARAM;
    }
    // 保证有6个字节的空余
    if (strlen(findPath) >= (_MAX_PATH - strlen("\\*.*") - 1)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = strcat_s(findPath, _MAX_PATH, "\\*.*");
    if (ret != MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    HANDLE fh = FindFirstFile(findPath, &findData);
    if (fh == INVALID_HANDLE_VALUE) {
        *entryList = nameList;
        return pos;
    }
    // 支持扫描最多1024个目录
    nameList = reinterpret_cast<mmDirent **>(malloc(MMPA_MAX_SCANDIR_COUNT * sizeof(mmDirent *)));
    if (nameList == nullptr) {
        FindClose(fh);
        return EN_ERROR;
    }
    SecureZeroMemory(nameList, MMPA_MAX_SCANDIR_COUNT * sizeof(mmDirent *));
    do {
        if (LocalFindFile(&findData)) {
            mmDirent tmpDir;
            (void)memcpy_s(tmpDir.d_name, sizeof(tmpDir.d_name), findData.cFileName, MAX_PATH);
            if (filterFunc != nullptr && filterFunc(&tmpDir) == 0) {
                continue;
            }
            newList = reinterpret_cast<mmDirent *>(malloc(sizeof(mmDirent)));
            if (newList == nullptr) {
                break;
            }
            SecureZeroMemory(newList, sizeof(mmDirent));
            newList->d_type = (findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY);
            (void)memcpy_s(newList->d_name, sizeof(newList->d_name), findData.cFileName, MAX_PATH);
            nameList[pos++] = newList;
        }
    } while (FindNextFile(fh, &findData) && pos < MMPA_MAX_SCANDIR_COUNT);
    FindClose(fh);

    if (sort != nullptr && nameList != nullptr) {
        qsort(nameList, pos, sizeof(mmDirent *), (_CoreCrtNonSecureSearchSortCompareFunction)sort);
    }
    *entryList = nameList;
    return pos;
}

/*
 * 描述:扫描目录,最多支持扫描MMPA_MAX_SCANDIR_COUNT个数目录
 * 参数:path--目录路径
        filterFunc--用户指定的过滤回调函数
        sort--用户指定的排序回调函数
        entryList--扫描到的目录结构指针, 用户不需要分配缓存, 内部分配, 需要调用mmScandirFree2释放
 * 返回值:执行成功返回扫描到的子目录和文件数量, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmScandir2(const CHAR *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    if (path == nullptr) {
        return EN_INVALID_PARAM;
    }

    CHAR findPath[_MAX_PATH] = {0};
    WIN32_FIND_DATA findData;
    mmDirent2 **nameList = nullptr;
    mmDirent2 *newList = nullptr;
    size_t pos = 0;

    BOOL value = PathCanonicalize(findPath, path);
    if (!value) {
        return EN_INVALID_PARAM;
    }
    // 保证有6个字节的空余
    if (strlen(findPath) >= (_MAX_PATH - strlen("\\*.*") - 1)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = strcat_s(findPath, _MAX_PATH - 1, "\\*.*");
    if (ret != MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    HANDLE fh = FindFirstFile(findPath, &findData);
    if (fh == INVALID_HANDLE_VALUE) {
        *entryList = nameList;
        return pos;
    }
    // 支持扫描最多1024个目录
    nameList = reinterpret_cast<mmDirent2 **>(malloc(MMPA_MAX_SCANDIR_COUNT * sizeof(mmDirent2 *)));
    if (nameList == nullptr) {
        FindClose(fh);
        return EN_ERROR;
    }
    SecureZeroMemory(nameList, MMPA_MAX_SCANDIR_COUNT * sizeof(mmDirent2 *));
    do {
        if (LocalFindFile(&findData)) {
            mmDirent2 tmpDir;
            tmpDir.d_type = findData.dwFileAttributes;
            (void)memcpy_s(tmpDir.d_name, sizeof(tmpDir.d_name), findData.cFileName, MAX_PATH);
            if (filterFunc != nullptr && filterFunc(&tmpDir) == 0) {
                continue;
            }
            newList = reinterpret_cast<mmDirent2 *>(malloc(sizeof(mmDirent2)));
            if (newList == nullptr) {
                break;
            }
            SecureZeroMemory(newList, sizeof(mmDirent2));
            newList->d_type = findData.dwFileAttributes;
            (void)memcpy_s(newList->d_name, sizeof(newList->d_name), findData.cFileName, MAX_PATH);
            nameList[pos++] = newList;
        }
    } while (FindNextFile(fh, &findData) && pos < MMPA_MAX_SCANDIR_COUNT);
    FindClose(fh);

    if (sort != nullptr && nameList != nullptr) {
        qsort(nameList, pos, sizeof(mmDirent2 *), (_CoreCrtNonSecureSearchSortCompareFunction)sort);
    }
    *entryList = nameList;
    return pos;
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:entryList--mmScandir扫描到的目录结构指针
 *      count--扫描到的子目录数量
 * 返回值:无
 */
void mmScandirFree(mmDirent **entryList, INT32 count)
{
    if (entryList == nullptr || count < MMPA_ZERO || count > MMPA_MAX_SCANDIR_COUNT) {
        return;
    }
    INT32 i;
    for (i = 0; i < count; i++) {
        if (entryList[i] != nullptr) {
            free(entryList[i]);
            entryList[i] = nullptr;
        }
    }
    free(entryList);
    entryList = nullptr;
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:entryList--mmScandir2扫描到的目录结构指针
 *      count--扫描到的子目录数量
 * 返回值:无
 */
void mmScandirFree2(mmDirent2 **entryList, INT32 count)
{
    if (entryList == nullptr || count < MMPA_ZERO || count > MMPA_MAX_SCANDIR_COUNT) {
        return;
    }
    INT32 i;
    for (i = 0; i < count; i++) {
        if (entryList[i] != nullptr) {
            free(entryList[i]);
            entryList[i] = nullptr;
        }
    }
    free(entryList);
    entryList = nullptr;
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
    LONG  pos = _lseek(fd, offset, seekFlag); // 出错返回-1L
    if (pos == -1L) {
        return EN_ERROR;
    }
    return pos;
}

/*
 * 描述:参数fd指定的文件大小改为参数length指定的大小
 * 参数:文件描述符fd
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFtruncate(mmProcess fd, UINT32 length)
{
    if (fd == nullptr) {
        return EN_INVALID_PARAM;
    }

    DWORD ret = SetFilePointer(fd, length, nullptr, FILE_BEGIN);
    if (ret == INVALID_SET_FILE_POINTER) {
        return EN_ERROR;
    }
    BOOL result = SetEndOfFile(fd);
    if (!result) {
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:复制一个文件的描述符
 * 参数:oldFd -- 需要复制的fd
 *      newFd -- 新的生成的fd
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmDup2(INT32 oldFd, INT32 newFd)
{
    if (oldFd <= MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    return _dup2(oldFd, newFd);
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
    return _dup(fd);
}

/*
 * 描述:返回指定文件流的文件描述符
 * 参数:stream--FILE类型文件流
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFileno(FILE *stream)
{
    if (stream == nullptr) {
        return EN_INVALID_PARAM;
    }

    return _fileno(stream);
}

/*
 * 描述:删除一个文件
 * 参数:filename--文件路径
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmUnlink(const CHAR *filename)
{
    if (filename == nullptr) {
        return EN_INVALID_PARAM;
    }

    return _unlink(filename);
}

/*
 * 描述:修改文件读写权限，目前仅支持读写权限修改
 * 参数:filename--文件路径
        mode--需要修改的权限
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmChmod(const CHAR *filename, INT32 mode)
{
    if (filename == nullptr) {
        return EN_INVALID_PARAM;
    }

    return _chmod(filename, mode);
}

/*
 * 描述:将对应文件描述符在内存中的内容写入磁盘
 * 参数:fd--文件句柄
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFsync(mmProcess fd)
{
    if (fd == INVALID_HANDLE_VALUE) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = FlushFileBuffers(fd);
    if (ret == MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:将对应文件描述符在内存中的内容写入磁盘
 * 参数:fd--文件描述符
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmFsync2(INT32 fd)
{
    HANDLE handle = (mmProcess)_get_osfhandle(fd);
    INT32 ret = FlushFileBuffers(handle);
    if (ret == MMPA_ZERO) {
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
    if (path == nullptr) {
        return EN_INVALID_PARAM;
    }

    return _chdir(path);
}

/*
 * 描述:获取当前工作目录路径
 * 参数:buffer--由用户分配用来存放工作目录路径的缓存
 *      maxLen--缓存长度
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetCwd(CHAR *buffer, INT32 maxLen)
{
    if (buffer == nullptr || maxLen <= MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    CHAR *ptr = _getcwd(buffer, maxLen);
    if (ptr != nullptr) {
        return EN_OK;
    } else {
        return EN_ERROR;
    }
}

/*
 * 描述:内部使用，去除行尾反斜杠符及斜杠符
 * 参数:profilePath--路径，会修改profilePath的值
 * 返回值:执行成功返回指向去除行尾后的源指针字符串
 */
static LPTSTR LocalDeleteBlackslash(LPTSTR profilePath)
{
    DWORD pathLength = strlen(profilePath);
    INT32 i = 0;
    for (i = pathLength - 1; i > 0; i--) {
        if (profilePath[i] == TEXT('\\') || profilePath[i] == TEXT('/')) {
            profilePath[i] = (TCHAR)0;
        } else {
            break;
        }
    }
    return profilePath;
}

/*
 * 描述:截取目录, windows路径格式为 d:\\usr\\bin\\test, 截取后为 d:\\usr\\bin
 * 参数:path--路径，函数内部会修改path的值
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回nullptr
 */
CHAR *mmDirName(CHAR *path)
{
    if (path == nullptr) {
        return nullptr;
    }

    CHAR dirName[MAX_PATH] = {};
    CHAR drive[MAX_PATH] = {};
    INT32 pathLength = strlen(path);

    // 去除行尾反斜杠符及斜杠符
    LocalDeleteBlackslash(path);
    // 获取目录后在获取盘符
    _splitpath(path, nullptr, dirName, nullptr, nullptr);
    _splitpath(path, drive, nullptr, nullptr, nullptr);

    // 将目录拼接到盘符下
    INT32 ret = strcat_s(drive, MAX_PATH, dirName);
    if (ret != MMPA_ZERO) {
        return nullptr;
    }
    // 将包含结束符的获取的路径赋值给path
    ret = memcpy_s(path, pathLength, drive, strlen(drive) + 1);
    if (ret != MMPA_ZERO) {
        return nullptr;
    }
    // 去除行尾反斜杠符及斜杠符
    LocalDeleteBlackslash(path);
    return path;
}

/*
 * 描述:截取目录后面的部分, 比如d:\\usr\\bin\\test, 截取后为test
 * 参数:path--路径，函数内部会修改path的值(行尾有\\会去掉)
 * 返回值:执行成功返回指向截取到的目录部分指针，执行失败返回nullptr
 */
CHAR *mmBaseName(CHAR *path)
{
    if (path == nullptr) {
        return nullptr;
    }
    // 去除行尾反斜杠符及斜杠符
    LocalDeleteBlackslash(path);
    CHAR fileName[MAX_PATH] = {};
    CHAR *tmp = path;
    INT32 i = 0;
    _splitpath(path, nullptr, nullptr, fileName, nullptr);
    INT32 fileNameLength = strlen(fileName);
    if (fileNameLength == MMPA_ZERO) {
        return path;
    }
    INT32 pathLength = strlen(path);
    // 防止有目录与文件名有重名部分,逆序匹配
    tmp += pathLength - fileNameLength;
    for (i = 0; i < pathLength - fileNameLength; i++) {
        if (strncmp(tmp, fileName, fileNameLength) == MMPA_ZERO) {
            return tmp;
        } else {
            tmp--;
        }
    }

    return path;
}

/*
 * 描述:获取当前指定路径下文件大小
 * 参数:fileName--文件路径名
 *      length--获取到的文件大小
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetFileSize(const CHAR *fileName, ULONGLONG *length)
{
    if (fileName == nullptr || length == nullptr) {
        return EN_INVALID_PARAM;
    }

    HANDLE hFile = CreateFile((LPCSTR)fileName, GENERIC_READ,
        FILE_SHARE_READ | FILE_SHARE_WRITE, // 默认文件对于多进程都是共享读写的
        nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
    if (hFile == INVALID_HANDLE_VALUE) {
        return EN_ERROR;
    }

    BOOL ret = GetFileSizeEx(hFile, (PLARGE_INTEGER)length);
    (void)CloseHandle(hFile);
    if (!ret) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:判断是否是目录
 * 参数:fileName -- 文件路径名
 * 返回值:执行成功返回EN_OK(是目录), 执行错误返回EN_ERROR(不是目录), 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == nullptr) {
        return EN_INVALID_PARAM;
    }
    DWORD ret = GetFileAttributes((LPCSTR)fileName);
    if (ret != FILE_ATTRIBUTE_DIRECTORY) {
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
    if (name == NULL) {
        return (mmFileHandle)EN_INVALID_PARAM;
    }
    mmFileHandle handle = CreateFile(name,
                                     oflag,
                                     FILE_SHARE_READ | FILE_SHARE_WRITE,
                                     NULL,
                                     OPEN_ALWAYS,
                                     FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
                                     NULL);
    if (handle == INVALID_HANDLE_VALUE) {
        return (mmFileHandle)EN_ERROR;
    }
    return handle;
}

/*
 * 描述:删除mmShmOpen创建的文件
 * 参数:name--文件路径
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmShmUnlink(const CHAR *name)
{
    if (name == nullptr) {
        return EN_INVALID_PARAM;
    }

    return _unlink(name);
}

/*
 * 描述： 将一个文件或者其它对象映射进内存
 * 参数： fd--有效的文件句柄
 *        size--映射区的长度
 *        offeet--被映射对象内容的起点
 *        extra--(出参)CreateFileMapping()返回的文件映像对象句柄，此参数linux不使用，windows为mmMumMap入参，释放资源
 *        prot--期望的内存保护标志，不能与文件的打开模式冲突，此参数linux使用，windows不使用
 *        flags--指定映射对象的类型，映射选项和映射页是否可以共享，此参数linux使用，windows不使用
 * 返回值：成功执行时，返回被映射区的指针；失败返回nullptr
 */
VOID *mmMmap(mmFd_t fd, mmSize_t size, mmOfft_t offset, mmFd_t *extra, INT32 prot, INT32 flags)
{
    if ((size == 0) || (extra == nullptr)) {
        return nullptr;
    }
    // The ">> 32" is a high-order DWORD of the file offset where the view begins
    *extra = CreateFileMapping(fd, nullptr, PAGE_READWRITE,
                               (DWORD) ((UINT64) size >> 32ULL),
                               (DWORD) (size & 0xffffffff),
                               nullptr);
    if (*extra == nullptr) {
        return nullptr;
    }

    // The ">> 32" is a high-order DWORD of the file offset where the view begins
    VOID *data = MapViewOfFile(*extra,
                               FILE_MAP_ALL_ACCESS,
                               (DWORD) ((UINT64) offset >> 32ULL),
                               (DWORD) (offset & 0xffffffff),
                               size);
    if (data == nullptr) {
        CloseHandle(*extra);
    }

    return data;
}

/*
 * 描述：取消已映射内存的地址
 * 参数： data--需要取消映射的内存地址
 *        size--欲取消的内存大小
 *        extra--CreateFileMapping()返回的文件映像对象句柄，此参数linux不使用，windows为释放资源参数
 * 返回值：执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMunMap(VOID *data, mmSize_t size, mmFd_t *extra)
{
    if ((data == nullptr) || (extra == nullptr)) {
        return EN_INVALID_PARAM;
    }
    if (UnmapViewOfFile(data) == 0) {
        (void)CloseHandle(*extra);
        return EN_ERROR;
    }

    if (CloseHandle(*extra) == 0) {
        return EN_ERROR;
    }
    return EN_OK;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

