/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __IDE_CMD_TEST_H
#define __IDE_CMD_TEST_H

int IdeGetFilePath(IdeString filename, std::string &whiteFileName);
void IdeCmdUsage(const std::string msg);
void ProcessRes(const char *str, int req_type);
int IdeCmdCommonProcess(sock_handle_t handle, uint32_t dev_id, const char *command, enum cmd_class cmd_req);
int IdeCmdDetectProcess(sock_handle_t handle, uint32_t dev_id, const char *command);
int IdeCmdTimeProcess(const cmd_info_t &cmd_info);
int IdeCmdLogProcess(struct IdeSockHandle handle, uint32_t devId, const char *command);
int IdeHostCmdCommandProcess(sock_handle_t handle, uint32_t dev_id, const char *command);
int IdeCmdApiProcess(sock_handle_t handle, uint32_t dev_id, const char *command);
int IdeCreateSendFilePath(const std::string &rc_file_path, const std::string &des_file_path, std::string &p_value_buf);
int IdeCmdFileProcess(sock_handle_t handle, uint32_t dev_id, const char *src_file_path, IdeString des_file_path, enum cmd_class cmd_req);
int IdeCmdSendFileProcess(sock_handle_t handle, uint32_t dev_id, IdeString src_file_path, IdeString des_file_path);
int IdeCmdSyncProcess(sock_handle_t handle, uint32_t dev_id, IdeString src_file_path, IdeString des_file_path);
int IdeCmdGetType(int argc, IdeString argv[], cmd_info_t &cmd_info);
int IdeCmdGetFileProcess(sock_handle_t handle, uint32_t dev_id, IdeString local_path, IdeString host_path);
int IdeCmdGetdFileProcess(sock_handle_t handle, uint32_t dev_id, IdeString local_path, IdeString host_path);
int IdeCmdCheckValid(const cmd_info_t &cmd_info);
int RemoteHandle(const cmd_info_t &cmd_info);
int IdeCmdTestMain(int argc, IdeStringBuffer argv[]);
int ExtractExitCode(const IdeString str);
int IdeCmdGetFileCommonProcess(enum cmd_class type, struct IdeSockHandle handle,
    uint32_t devId, const std::string localPath, const std::string sourcePath);


#endif  //__IDE_CMD_TEST_H
