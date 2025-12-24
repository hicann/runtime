/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_file_utils.h"
#include <cctype>
#include "log_print.h"
#include "file_dump_os_type.h"
#include "log_process_util.h"
namespace Adx {

constexpr char OS_SPLIT_CHAR                 = '/';
const std::string OS_SPLIT_STR               = "/";
constexpr uint32_t DEFAULT_PATH_MODE         = 0700;
#define MAX_RECURSION_DEPTH 6

/**
 * @brief       : copy file and rename
 * @param [in]  : src    source file
 * @param [in]  : des    new file
 * @return      : zero  success; others  failed
 */
IdeErrorT LogFileUtils::CopyFileAndRename(const std::string &src, const std::string &des)
{
    if (src.empty() || des.empty()) {
        return IDE_DAEMON_INVALID_PATH_ERROR;
    }

    std::string cmdCopyStr = "cp " + src + " " + des;
    int32_t ret = AdxCreateProcess(cmdCopyStr.c_str());
    ONE_ACT_ERR_LOG(ret != SYS_OK, return IDE_DAEMON_UNKNOW_ERROR, "AdxCreateProcess failed, %s", cmdCopyStr.c_str());
    return IDE_DAEMON_NONE_ERROR;
}

std::string LogFileUtils::ReplaceAll(std::string &base, const std::string &src, const std::string &dst)
{
    size_t pos = 0;
    std::string targetStr = dst;
    while ((pos = base.find(src, pos)) != std::string::npos) {
        base.replace(pos, src.size(), targetStr);
        pos += targetStr.size();
    }
    return base;
}

/**
 * @brief       : sort dirent by alphabet order
 * @param [in]  : a    dirent a
 * @param [in]  : b    dirent b
 * @return      : 0    a=b
 *                >0   a>b
 *                <0   a<b
 */
static int32_t AlphaSort(const mmDirent **a, const mmDirent **b)
{
    // if first arg is null, return 'a' is greater than 'b'
    ONE_ACT_ERR_LOG(a == nullptr, return 1, "Invalid ptr parameter");
    ONE_ACT_ERR_LOG(*a == nullptr, return 1, "Invalid ptr parameter");
    // if second arg is null, return 'a' is less than 'b'
    ONE_ACT_ERR_LOG(b == nullptr, return -1, "Invalid ptr parameter");
    ONE_ACT_ERR_LOG(*b == nullptr, return -1, "Invalid ptr parameter");
    // sort by char
    return strcmp((*a)->d_name, (*b)->d_name);
}

/**
 * @brief       : get dir file list, if is subdir, recursivly get sub dir file list
 * @param [in]  : path               file path
 * @param [in]  : list               dir file list
 * @param [in]  : fileter            file filter method
 * @param [in]  : fileNamePrefix     prefix of target file
 * @param [in]  : recursiveDepth     recursive depth
 * @return      : EOK  SUCCESS; other  FAILED
 */
bool LogFileUtils::GetDirFileList(const std::string &path, std::vector<std::string> &list, const FileFilterFn fileter,
    const std::string &fileNamePrefix, int32_t recursiveDepth)
{
    mmDirent **fileList = nullptr;
    int32_t foundNum = mmScandir(path.c_str(), &fileList, fileter, AlphaSort);
    ONE_ACT_ERR_LOG(foundNum < 0, return false,
        "Scandir %s failed, errno=%s", path.c_str(), strerror(ToolGetErrorCode()));
    ONE_ACT_ERR_LOG(fileList == nullptr, return false, "Scandir failed, get null file list");

    for (int32_t i = 0; i < foundNum; i++) {
        if (fileList[i] == nullptr) {
            continue;
        }
        std::string filename = fileList[i]->d_name;
        if (filename == "." || filename == "..") {
            continue;
        }
        unsigned char isFolder = 0x4;
        unsigned char isFile = 0x8;
        // if is sub dir, recursivly get sub dir file list
        if (fileList[i]->d_type == isFolder) {
            if (recursiveDepth > 0) {
                std::string subFilePath = path + OS_SPLIT_STR + fileList[i]->d_name + OS_SPLIT_STR;
                GetDirFileList(subFilePath, list, nullptr, fileNamePrefix, recursiveDepth - 1);
            }
        } else if (fileList[i]->d_type == isFile &&
            (fileNamePrefix.empty() || Adx::LogFileUtils::StartsWith(filename, fileNamePrefix)) &&
            !Adx::LogFileUtils::EndsWith(filename, "tmp")) {
            list.push_back(path + fileList[i]->d_name); // input base path ends with slash
        }
    }
    mmScandirFree(fileList, foundNum);
    return true;
}

bool LogFileUtils::StartsWith(const std::string &s, const std::string &sub)
{
    return s.find(sub) == 0;
}

bool LogFileUtils::EndsWith(const std::string &s, const std::string &sub)
{
    return s.rfind(sub) == (s.length()-sub.length());
}

/**
 * @brief       : jugde the file_path is realpath
 * @param [in]  : file_path        file path
 * @param [out] : resolved_path    return path
 * @return      : SYS_OK  succ; SYS_ERROR  failed
 */
int32_t LogFileUtils::FilePathIsReal(const std::string &filePath, std::string &resultPath)
{
    if (filePath.empty()) {
        return SYS_ERROR;
    }

    char resolvedPath[MMPA_MAX_PATH] = {0};

    int32_t ret = mmRealPath(filePath.c_str(), resolvedPath, MMPA_MAX_PATH);
    if (ret != EN_OK) {
        return SYS_ERROR;
    }
    resultPath = resolvedPath;
    return SYS_OK;
}

/**
 * @brief       : jugde the file path with filename is realpath
 * @param [in]  : file_path       file path
 * @param [in]  : resolved_path   return path
 * @param [in]  : path_len        the max length of resolved_path buffer
 * @return      : SYS_OK  succ; SYS_ERROR  failed
 */
int32_t LogFileUtils::FileNameIsReal(const std::string &file, std::string &resultPath)
{
    int32_t ret = 0;
    if (file.empty()) {
        return SYS_ERROR;
    }

    size_t pos = file.find_last_of(OS_SPLIT_CHAR);
    if (pos != std::string::npos) {
        std::string path = file.substr(0, pos + 1);
        ret = FilePathIsReal(path, resultPath);
        if (ret != SYS_OK) {
            SELF_LOG_ERROR("path %s is not exist", file.c_str());
            return SYS_ERROR;
        }
    }
    resultPath = file;
    return SYS_OK;
}

/**
 * @brief       : Get the name part of the path
 * @param [in]  : path   file path
 * @param [out] : dir    the name part of path
 * @return      : IDE_DAEMON_NONE_ERROR            Dump start Success
 *                IDE_DAEMON_INVALID_PATH_ERROR    Invalid path
 */
IdeErrorT LogFileUtils::GetFileName(const std::string &path, std::string &name)
{
    size_t pos = path.find_last_of(OS_SPLIT_CHAR);
    if (pos != std::string::npos) {
        name = path.substr(pos + 1);
        if (name.empty()) {
            return IDE_DAEMON_INVALID_PATH_ERROR;
        }
        return IDE_DAEMON_NONE_ERROR;
    }
    name = path;
    return IDE_DAEMON_NONE_ERROR;
}

/**
 * @brief       : Check if the path is a directory
 * @param [in]  : path    file path
 * @return      : true    the path is a directory
 *                false   the path is not a directory
 */
bool LogFileUtils::IsDirectory(const std::string &path)
{
    if (path.empty()) {
        SELF_LOG_ERROR("invalid parameter");
        return false;
    }

    int32_t ret = mmIsDir(path.c_str());
    if (ret != EN_OK) {
        return false;
    }

    return true;
}

/**
 * @brief       : Create dir
 * @param [in]  : path     file path
 * @return      : IDE_DAEMON_NONE_ERROR           Exist or Mkdir success
 *                IDE_DAEMON_INVALID_PATH_ERROR   Invalid path
 *                IDE_DAEMON_MKDIR_ERROR          Mkdir failed
 */
IdeErrorT LogFileUtils::CreateDir(const std::string &path)
{
    std::string curr = path;
    IdeErrorT ret = IDE_DAEMON_UNKNOW_ERROR;

    if (curr.empty()) {
        SELF_LOG_ERROR("create dir input empty");
        return IDE_DAEMON_INVALID_PATH_ERROR;
    }

    if (IsFileExist(curr)) {
        return IDE_DAEMON_NONE_ERROR;
    } else {
        std::string dir = GetFileDir(curr);
        ONE_ACT_ERR_LOG(dir.empty(), return ret, "Get file dir failed, ret: %d", ret);

        ret = CreateDir(dir);
        ONE_ACT_ERR_LOG(ret != IDE_DAEMON_NONE_ERROR, return ret, "Create dir failed, ret: %d", ret);
    }

    if (!IsFileExist(path)) {
        if (mmMkdir(path.c_str(), (mmMode_t)DEFAULT_PATH_MODE) != EN_OK && errno != EEXIST) {
            SELF_LOG_ERROR("mkdir %s failed, errorstr: %s", path.c_str(), strerror(ToolGetErrorCode()));
            return IDE_DAEMON_MKDIR_ERROR;
        }
    }

    return IDE_DAEMON_NONE_ERROR;
}

/**
 * @brief       : Get the path part of the path
 * @param [in]  : path  file path
 * @param [out] : dir   the path part of path
 * @return      : IDE_DAEMON_NONE_ERROR           Dump start Success
 *                IDE_DAEMON_INVALID_PATH_ERROR   Invalid path
 */
std::string LogFileUtils::GetFileDir(const std::string &path)
{
    std::string dir;
    size_t pos = path.find_last_of(OS_SPLIT_CHAR);
    if (pos != std::string::npos) {
        dir = path.substr(0, pos);
        if (dir.empty()) {
            dir += OS_SPLIT_STR;
        }
        return dir;
    }

    return dir;
}

/**
 * @brief       : Check file is readable
 * @param [in]  : path     file path
 * @return      : true     can be read
 *                false    can't be read
 */
bool LogFileUtils::IsAccessible(const std::string &path)
{
    if (path.empty()) {
        return false;
    }

    if (mmAccess2(path.c_str(), R_OK) != EN_OK) {
        SELF_LOG_WARN("check path: %s does not have read permission!", path.c_str());
        return false;
    }

    return true;
}

/**
 * @brief       : Check directory is exist
 * @param [in]  : path    file path
 * @return      : true    directory exists
 *                false   directory not exist
 */
bool LogFileUtils::IsDirExist(const std::string &path)
{
    if (path.empty()) {
        return false;
    }

    if (mmAccess2(path.c_str(), R_OK | W_OK | X_OK) != EN_OK) {
        SELF_LOG_WARN("check path: %s does not have rwx permission!", path.c_str());
        return false;
    }

    return IsDirectory(path);
}

/**
 * @brief       : Check file is exist
 * @param [in]  : path     file path
 * @return      : true     file exists
 *                false    file not exist
 */
bool LogFileUtils::IsFileExist(const std::string &path)
{
    if (path.empty()) {
        return false;
    }

    if (::mmAccess(path.c_str()) == EN_OK) {
        return true;
    }

    return false;
}
int32_t LogFileUtils::RemoveDir(std::string &dirName, int32_t depth)
{
    if (depth > MAX_RECURSION_DEPTH) {
        SELF_LOG_ERROR("dir levels is greater than %d", MAX_RECURSION_DEPTH);
        return SYS_ERROR;
    }
    DIR *dir = nullptr;
    struct dirent *entry;
    struct stat statBuf;
    if ((dir = opendir(dirName.c_str())) == nullptr) {
        SELF_LOG_ERROR("open dir %s failed, strerr: %s", dirName.c_str(), strerror(errno));
        return SYS_ERROR;
    }
    int32_t ret = SYS_OK;

    std::string path;
    while ((entry = readdir(dir)) != nullptr) {
        if ((strcmp(entry->d_name, ".") == 0) || (strcmp(entry->d_name, "..") == 0)) {
            continue;
        }
        path = dirName + OS_SPLIT_STR + entry->d_name;

        if (lstat(path.c_str(), &statBuf) == -1) {
            SELF_LOG_ERROR("get %s stat failed, strerr: %s", dirName.c_str(), strerror(errno));
            break;
        }

        if (S_ISDIR(statBuf.st_mode)) {
            ret = RemoveDir(path, depth + 1);
        } else {
            if (remove(path.c_str()) == -1) {
                SELF_LOG_ERROR("remove %s failed, strerr: %s", dirName.c_str(), strerror(errno));
                ret = SYS_ERROR;
            }
        }
    }
    closedir(dir);
    if (rmdir(dirName.c_str()) == -1) {
        SELF_LOG_ERROR("rmdir %s failed, strerr: %s", dirName.c_str(), strerror(errno));
        return SYS_ERROR;
    }

    return ret;
}

}
