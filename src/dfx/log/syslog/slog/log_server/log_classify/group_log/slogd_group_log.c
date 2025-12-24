/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_group_log.h"
#include "slogd_syslog.h"
#include "slogd_buffer.h"
#include "log_to_file.h"
#include "log_level_parse.h"
#include "slogd_dev_mgr.h"
#include "slogd_recv_core.h"

#ifdef GROUP_LOG

STATIC GroupInfo *g_groupInfoListHead = NULL;
STATIC GroupInfo *g_groupInfoListTail = NULL;

STATIC uint32_t g_writeGroupFilePrintNum = 0;

STATIC bool SlogdGroupLogCheckLogType(const LogInfo *info)
{
    return LogConfGroupGetSwitch() && (info->type == DEBUG_LOG) && (info->aosType == 0);
}

/**
* @brief GetGroupByModuleId: get groupinfo by moduleId
* @param [in]moduleId: module id
* @return: groupinfo ptr
*/
GroupInfo *GetGroupInfoById(const int groupId)
{
    GroupInfo *groupInfo = g_groupInfoListHead;
    while (groupInfo != NULL) {
        if (groupInfo->groupId == groupId) {
            return groupInfo;
        }
        groupInfo = groupInfo->next;
    }
    return NULL;
}

/**
* @brief GetGroupInfoByName: get groupinfo by name
* @param [in]name: group name
* @param [in]size: len of name
* @return: groupinfo ptr
*/
STATIC GroupInfo *GetGroupInfoByName(const char *name, size_t size)
{
    (void)size;
    ONE_ACT_WARN_LOG(name == NULL, return NULL, "[input] name is null.");
    GroupInfo *groupInfo = g_groupInfoListHead;
    while (groupInfo != NULL) {
        if (strcmp(name, (char*)(groupInfo->groupName)) == 0) {
            return groupInfo;
        }
        groupInfo = groupInfo->next;
    }
    return NULL;
}

/**
* @brief InitGroupWriteLimit: Init group write limit
* @param [in]logList: the log list pointer
* @param [in]type: type of the log list
* @param [in]currSize: current total size of the log list
* @return: success or failed
*/
STATIC LogStatus InitGroupWriteLimit(StSubLogFileList *logList, int32_t type, uint32_t currSize)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "[input] log group file list is null.");
    const GeneralGroupInfo *info = LogConfGroupGetInfo();
    ONE_ACT_ERR_LOG(info == NULL, return LOG_FAILURE, "group info is null, load group info failed.");
    const uint32_t baseBytes = 1024U;
    uint32_t typeSize = (uint32_t)info->maxSize * baseBytes;
    if (WriteFileLimitInit(&logList->limit, type, typeSize, currSize) != LOG_SUCCESS) {
        SELF_LOG_ERROR("create group write file limit param list failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
* @brief InitGroupLogList: Init logList for group
* @param [in]group: group info pointer
* @param [in]groupLogPath: group log path
* @param [in]size: group log path len
* @return: success or failed
*/
STATIC LogStatus InitGroupLogList(StSubLogFileList *list, GroupInfo *group, const char *groupLogPath, uint32_t pathLen)
{
    ONE_ACT_WARN_LOG((pathLen <= 0) || (pathLen >= MAX_FILEPATH_LEN), return LOG_FAILURE, "[input] size is invalid.");
    int32_t err = snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s_", group->groupName);
    ONE_ACT_ERR_LOG(err == -1, return LOG_FAILURE, "get group name header failed, result=%d, strerr=%s.",
                    err, strerror(ToolGetErrorCode()));
    list->totalMaxFileSize = group->totalMaxFileSize;
    list->maxFileSize = (uint32_t)group->fileSize;
    (void)ToolMutexInit(&list->lock);
    uint32_t ret = LogAgentInitMaxFileNumHelper(list, groupLogPath, MAX_FILEPATH_LEN);
    ONE_ACT_ERR_LOG(ret != OK, return LOG_FAILURE, "init max group log filename list failed, result=%d.", ret);
    LogStatus status = InitGroupWriteLimit(list, (int32_t)DEBUG_LOG,  list->totalMaxFileSize + list->maxFileSize);
    ONE_ACT_ERR_LOG(status != LOG_SUCCESS, return status, "create group write limit failed, result=%d.", status);

    return LOG_SUCCESS;
}

/**
* @brief GetGroupFileList: get current log file for group
* @param [in]group: the group info pointer
* @return: void
*/
STATIC void GetGroupFileList(StSubLogFileList *list)
{
    (void)LogAgentGetFileListForModule(list, list->filePath);
}

static bool SlogdGroupLogBufCheck(void *srcAttr, void *dstAttr)
{
    return srcAttr == dstAttr;
}

/**
* @brief GroupResourceInit: Init group resource
* @param [in]group: the group info pointer
* @param [in]groupLogPath: the log path of group
* @param [in]len: the len of log path
* @return: SYS_OK or SYS_ERROR
*/
STATIC LogStatus GroupResourceInit(GroupInfo *group, char *groupLogPath, uint32_t len)
{
    SlogdBufAttr attr = { group, SlogdGroupLogBufCheck };
    LogStatus ret = SlogdBufferInit(GROUP_LOG_TYPE, group->bufSize, 0, &attr);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init buf for group failed.");
    StSubLogFileList *list = &(group->fileList);
    int32_t err = InitGroupLogList(list, group, groupLogPath, len);
    TWO_ACT_WARN_LOG(err != OK, (SlogdBufferExit(GROUP_LOG_TYPE, NULL)), return LOG_FAILURE,
        "Malloc data for node failed, strerr=%s", strerror(ToolGetErrorCode()));
    return LOG_SUCCESS;
}

STATIC GroupInfo *MallocNewGroup(const GroupInfo *groupInfo, const char *groupLogPath, unsigned int pathLen)
{
    ONE_ACT_WARN_LOG(groupInfo == NULL, return NULL, "[input] groupInfo is null.");
    ONE_ACT_WARN_LOG(groupLogPath == NULL, return NULL, "[input] groupLogPath is null.");
    ONE_ACT_WARN_LOG((groupInfo->bufSize) <= 0, return NULL, "[input] bufSize of group is invalid.");
    ONE_ACT_WARN_LOG(pathLen >= MAX_FILEPATH_LEN, return NULL, "[input] log dir is too long.");
    GroupInfo *newGroup = GetGroupInfoByName(groupInfo->groupName, strlen(groupInfo->groupName));
    ONE_ACT_WARN_LOG(newGroup != NULL, return NULL, "[input] Duplicate group Name is not support.");
    newGroup = GetGroupInfoById(groupInfo->groupId);
    ONE_ACT_WARN_LOG(newGroup != NULL, return NULL, "[input] Duplicate group Id is not support.");

    newGroup = (GroupInfo *)LogMalloc(sizeof(GroupInfo));
    ONE_ACT_WARN_LOG(newGroup == NULL, return NULL, "alloc a new group failed. strerr=%s.", \
                     strerror(ToolGetErrorCode()));
    int32_t err = memcpy_s(newGroup, sizeof(GroupInfo), groupInfo, sizeof(GroupInfo));
    TWO_ACT_WARN_LOG(err != 0, XFREE(newGroup), return NULL, "Copy group info failed. strerr=%s", \
                     strerror(ToolGetErrorCode()));
    newGroup->next = NULL;

    return newGroup;
}

/**
* @brief AddNewGroup: add a new group
* @param [in]groupInfo: the group info to add
* @param [in]groupLogPath: the group log root dir
* @param [in]pathLen: the group log root dir path length
* @return: success or failed
*/
STATIC LogStatus AddNewGroup(GroupInfo *groupInfo, char *groupLogPath, unsigned int pathLen)
{
    GroupInfo *newGroup = MallocNewGroup(groupInfo, groupLogPath, pathLen);
    ONE_ACT_NO_LOG(newGroup == NULL, return LOG_FAILURE);

    int32_t err = GroupResourceInit(newGroup, groupLogPath, (uint32_t)strlen(groupLogPath));
    TWO_ACT_WARN_LOG(err != 0, XFREE(newGroup), return LOG_FAILURE, "Init group resource failed.");

    StSubLogFileList *list = &(newGroup->fileList);
    GetGroupFileList(list);
    SELF_LOG_INFO("Success add group. Group Id = [%d].", newGroup->groupId);
    if (g_groupInfoListTail == NULL) {
        g_groupInfoListTail = newGroup;
        g_groupInfoListHead = newGroup;
    } else {
        g_groupInfoListTail->next = newGroup;
        g_groupInfoListTail = newGroup;
    }
    return LOG_SUCCESS;
}

/**
* @brief AddDeviceNewGroup: add a new group
* @param [in]groupInfo: the group info to add
* @param [in]groupLogPath: the group log root dir
* @param [in]pathLen: the group log root dir path length
* @return: success or failed
*/
STATIC LogStatus AddDeviceNewGroup(GroupInfo *groupInfo, char *groupLogPath, unsigned int pathLen)
{
    GroupInfo *newGroup = MallocNewGroup(groupInfo, groupLogPath, pathLen);
    ONE_ACT_NO_LOG(newGroup == NULL, return LOG_FAILURE);

    size_t len = sizeof(StSubLogFileList) * (size_t)MAX_DEV_NUM;
    // multi devices and os init
    newGroup->deviceLogList = (StSubLogFileList *)LogMalloc(len);
    if (newGroup->deviceLogList == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        XFREE(newGroup);
        return LOG_FAILURE;
    }

    newGroup->deviceNum = MAX_DEV_NUM;
    for (uint32_t idx = 0; idx < newGroup->deviceNum; idx++) {
        char deviceLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
        int32_t err = snprintf_s(deviceLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%u", groupLogPath,
                                 FILE_SEPARATOR, DEVICE_HEAD, GetHostDeviceID(idx));
        ONE_ACT_ERR_LOG(err == -1, goto fail_init_group_node, \
                        "get device log dir path failed, device_id=%u, result=%d, strerr=%s.",
                        idx, err, strerror(ToolGetErrorCode()));
        StSubLogFileList *list = &(newGroup->deviceLogList[idx]);
        err = InitGroupLogList(list, groupInfo, deviceLogPath, LogStrlen(deviceLogPath));
        ONE_ACT_ERR_LOG(err != 0, goto fail_init_group_node, "Init group resource failed.");
        GetGroupFileList(list);
    }
    SELF_LOG_INFO("Success add group. Group Id = [%d].", newGroup->groupId);
    if (g_groupInfoListTail == NULL) {
        g_groupInfoListTail = newGroup;
        g_groupInfoListHead = newGroup;
    } else {
        g_groupInfoListTail->next = newGroup;
        g_groupInfoListTail = newGroup;
    }
    return LOG_SUCCESS;
fail_init_group_node:
    XFREE(newGroup->deviceLogList);
    XFREE(newGroup);
    return LOG_FAILURE;
}

STATIC LogStatus LoadGroupInfo(void)
{
    LogStatus ret = LOG_SUCCESS;
    const GeneralGroupInfo *info = LogConfGroupGetInfo();
    ONE_ACT_ERR_LOG(info == NULL, return LOG_FAILURE, "groupinfo is null, load group info failed.");

    const UnitGroupInfo *groupInfo = info->map;
    char groupLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
    int32_t err = snprintf_s(groupLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s",
                             info->agentFileDir, DEBUG_DIR_NAME);
    ONE_ACT_ERR_LOG(err == -1, return LOG_FAILURE, "get group log dir path failed, result=%d, strerr=%s.",
                    err, strerror(ToolGetErrorCode()));
    GroupInfo group;
    const int32_t baseBytes = 1024;
    for (int32_t i = 0; i < GROUP_MAP_SIZE; ++i) {
        if (groupInfo->isInit == 1) {
            err = memset_s(&group, sizeof(GroupInfo), 0, sizeof(GroupInfo));
            TWO_ACT_ERR_LOG(err != EOK, groupInfo++, continue, "Memset group info failed.");
            group.groupId = groupInfo->id;
            group.totalMaxFileSize = groupInfo->totalMaxFileSize * (uint32_t)baseBytes;
            group.fileSize = groupInfo->fileSize * baseBytes;
            group.bufSize = (uint32_t)info->bufSize * (uint32_t)baseBytes;
            err = memcpy_s(group.groupName, GROUP_NAME_MAX_LEN, groupInfo->name, GROUP_NAME_MAX_LEN);
            TWO_ACT_ERR_LOG(err != EOK, groupInfo++, continue, "Memcpy group name failed.");
            if (strcmp(group.groupName, "device-0") == 0) {
                ret = AddDeviceNewGroup(&group, groupLogPath, (unsigned int)strlen(groupLogPath));
            } else {
                ret = AddNewGroup(&group, groupLogPath, (unsigned int)strlen(groupLogPath));
            }
            NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "Add now group failed. Group Id is %d, Group Name is %s",
                           group.groupId, group.groupName);
        }
        groupInfo++;
    }

    return LOG_SUCCESS;
}

/**
* @brief : delete all groups
* @param [in]void
* @return: void
*/
STATIC void DeleteAllGroup(void)
{
    SlogdBufferExit(GROUP_LOG_TYPE, NULL);
    GroupInfo *group = g_groupInfoListHead;
    while (group != NULL) {
        GroupInfo *tmp = group;
        for (uint32_t idx = 0; idx < tmp->deviceNum; idx++) {
            WriteFileLimitUnInit(&tmp->deviceLogList[idx].limit);
        }
        WriteFileLimitUnInit(&tmp->fileList.limit);
        group = group->next;
        XFREE(tmp->deviceLogList);
        XFREE(tmp);
    }
    g_groupInfoListHead = NULL;
    g_groupInfoListTail = NULL;
    return;
}

/**
* @brief GetGroupListHead: get group list head
* @param [in]void
* @return: GroupInfo pointer
*/
GroupInfo *GetGroupListHead(void)
{
    return g_groupInfoListHead;
}

/**
 * @brief       : write log from slogd_group buffer to file [GROUP*]
 * @param[in]   : handle        group log buffer handle
 * @param[in]   : type          log type
 * @param[in]   : fileList      target file list
 */
STATIC void SlogdWriteDeviceGroupLog(void *handle, LogType type, StSubLogFileList *fileList)
{
    ONE_ACT_ERR_LOG((handle == NULL) || (fileList == NULL), return, "input args is null, write buffer log failed.");
    uint32_t bufSize = SlogdBufferGetBufSize(GROUP_LOG_TYPE);
    char *data = (char *)LogMalloc((size_t)bufSize + 1U);
    if (data == NULL) {
        SELF_LOG_ERROR("malloc failed, write buffer log failed.");
        SlogdBufferReset(handle);
        return;
    }
    int32_t dataLen = SlogdBufferRead(handle, data, bufSize);
    if (dataLen == 0) {
        XFREE(data);
        return;
    }
    if ((dataLen < 0) || ((uint32_t)dataLen > bufSize)) {
        XFREE(data);
        SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
        return;
    }
    uint32_t ret = LogAgentWriteDeviceOsLog((int32_t)type, fileList, data, LogStrlen(data));
    if (ret != OK) {
        SELF_LOG_ERROR_N(&g_writeGroupFilePrintNum, GENERAL_PRINT_NUM,
                         "write device group log failed, result=%u, strerr=%s, print once every %u times.",
                         ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
    }
    XFREE(data);
}

STATIC int32_t SlogdGroupLogWrite(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    ONE_ACT_ERR_LOG((msg == NULL) || (info == NULL),
                    return LOG_FAILURE, "flush syslog to buffer failed, input msg is null.");
    const ModuleInfo* moduleInfo = GetModuleInfoById(info->moduleId);
    ONE_ACT_WARN_LOG(moduleInfo == NULL, return LOG_FAILURE, "invalid module, moduleId=%d", info->moduleId);

    GroupInfo *group = GetGroupInfoById(moduleInfo->groupId);
    ONE_ACT_WARN_LOG(group == NULL, return LOG_FAILURE, "module[%d] belong to no group. Log loss...", info->moduleId);

    void *handle = SlogdBufferHandleOpen(GROUP_LOG_TYPE, (void *)group, LOG_BUFFER_WRITE_MODE, 0);
    if (handle == NULL) {
        SELF_LOG_ERROR("get group log[%s] buffer handle failed.", group->groupName);
        return LOG_FAILURE;
    }
    if (SlogdBufferCheckFull(handle, msgLen)) {
        (void)ToolMutexLock(&group->fileList.lock);
        SlogdWriteDeviceGroupLog(handle, info->type, &(group->fileList));
        (void)ToolMutexUnLock(&group->fileList.lock);
    }
    LogStatus ret = SlogdBufferWrite(handle, msg, msgLen);
    SlogdBufferHandleClose(&handle);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "write log to buffer failed, ret = %d.", ret);
    return LOG_SUCCESS;
}

STATIC int32_t SlogdGroupLogFlush(void *buffer, uint32_t bufferLen, bool flushFlag)
{
    (void)buffer;
    (void)bufferLen;
    (void)flushFlag;
    GroupInfo *group = GetGroupListHead();
    while (group != NULL) {
        // firmware log data is null, skip it
        if (strcmp(group->groupName, "device-0") == 0) {
            group = group->next;
            continue;
        }
        void *handle = SlogdBufferHandleOpen(GROUP_LOG_TYPE, (void *)group, LOG_BUFFER_WRITE_MODE, 0);
        if (handle == NULL) {
            SELF_LOG_ERROR("get group log[%s] buffer handle failed.", group->groupName);
            group = group->next;
            continue;
        }
        if (SlogdBufferCheckEmpty(handle)) {
            SlogdBufferHandleClose(&handle);
            group = group->next;
            continue;
        }
        (void)ToolMutexLock(&group->fileList.lock);
        SlogdWriteDeviceGroupLog(handle, DEBUG_LOG, &(group->fileList));
        (void)ToolMutexUnLock(&group->fileList.lock);
        SlogdBufferHandleClose(&handle);
        group = group->next;
    }
    return LOG_SUCCESS;
}

static int32_t SlogdGrouplogRegister(void)
{
    int32_t ret = 0;
    LogDistributeNode distributeNode = {GROUP_LOG_PRIORITY, SlogdGroupLogCheckLogType, SlogdGroupLogWrite};
    ret = SlogdDistributeRegister(&distributeNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "group log register distribute node failed, ret=%d.", ret);

    LogFlushNode flushNode = {COMMON_THREAD_TYPE, GROUP_LOG_PRIORITY, SlogdGroupLogFlush, NULL};
    ret = SlogdFlushRegister(&flushNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "group log register flush node failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

LogStatus SlogdGroupLogInit(void)
{
    LogStatus err = LoadGroupInfo();
    ONE_ACT_ERR_LOG(err != LOG_SUCCESS, return LOG_FAILURE, "Create group list failed.");

    int32_t ret = SlogdGrouplogRegister();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdGroupLogExit(void)
{
    DeleteAllGroup();
}

#else

LogStatus SlogdGroupLogInit(void)
{
    return LOG_SUCCESS;
}

void SlogdGroupLogExit(void)
{
    return;
}

#endif