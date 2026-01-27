/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "string.h"
#ifndef _APPMON_LIB_H_
#define _APPMON_LIB_H_

#ifdef __cplusplus
extern "C" {
#endif /*__cplusplus*/

#define APPMON_SERVER_PATH  "/usr/appmond/appmon.socket"

typedef struct client_info_s{
    /**
     *  内部维护信息。主要包括注册信息、进程间通信配置等。不对用户开放。
     */
    void *info;
} client_info_t;

/** 应用程序客户端初始化
 *
 *  应用程序初始化，完成资源申请及进程间通信接口初始化
 *
 *  @param[in] serv_addr 服务端地址
 *  @param[out] clnt 初始化后的客户端
 *
 *  @return ::0  执行成功  < 0 启动失败  >  server已经存在
 *  @return ::errno 执行失败,可用perror解析
 *
 *  @attention  无
 */

int appmon_client_init(client_info_t *clnt, const char *serv_addr)
{
    return 0;
}

/* * 应用程序客户端退出
 *
 *  应用程序客户端退出，同时初始化时申请的资源被释放，app monitor不再对该app进行监控
 *
 *  @param[in] clnt 初始化过的客户端信息结构体指针
 *  @param[out] 无
 *
 *  @return :: 无
 *
 *  @attention  无
 */
void appmon_client_exit(client_info_t *clnt)
{
    return;
}

/* * 应用程序注册
 *
 *  应用程序注册，app monitor开始对该app进行监控
 *
 *  @param[in] clnt                 初始化过的客户端信息结构体指针
 *  @param[in] timeout              心跳超时时间，单位: 毫秒
 *  @param[in] timeout_action       心跳超时后，执行的脚本的绝对路径字符串\n
                                    脚本调用时会加上pid作为参数，如: timeout_action pid
 *  @param[out] 无
 *
 *  @return ::0  执行成功
 *  @return ::errno 执行失败,可用perror解析
 *
 *  @attention  脚本路径字符串长度不能超过255个字符
 */
int appmon_client_register(client_info_t *clnt, unsigned long timeout, const char *timeout_action)
{
    return 0;
}

/** 应用程序注销
 *
 *  应用程序注销，app monitor不再对该app进行监控
 *
 *  @param[in] clnt     初始化过的客户端信息结构体指针
 *  @param[in] reason   注销原因字符串，用于日志记录，最多记录127个字符，可以为空
 *  @param[out] 无
 *
 *  @return ::0  执行成功
 *  @return ::errno 执行失败,可用perror解析
 *
 *  @attention  无
 */
int appmon_client_deregister(client_info_t *clnt, const char *reason)
{
    return 0;
}

/* * 应用程序客户端心跳发送函数
 *
 *  应用程序客户端心跳发送函数，用于维持与app monitor间的心跳
 *
 *  @param[in] clnt 初始化过的客户端信息结构体指针
 *  @param[out] 无
 *
 *  @return ::0  执行成功
 *  @return ::errno 执行失败,可用perror解析
 *
 *  @attention  无
 */
int appmon_client_heartbeat(client_info_t *clnt)
{
    return 0;
}

/* * 应用程序主动宣称死亡
 *
 *  应用程序主动宣称死亡，触发app monitor立即执行timeout_action脚本
 *
 *  @param[in] clnt     	初始化过的客户端信息结构体指针
 *  @param[in] last_words	临终遗言，用于日志记录，最多记录127个字符，可以为空
 *  @param[out] 无
 *
 *  @return ::0  执行成功
 *  @return ::errno 执行失败,可用perror解析
 *
 *  @attention  无
 */
int appmon_client_declare_death(client_info_t *clnt, const char *last_words)
{
    return 0;
}

#ifdef __cplusplus
}
#endif /*__cplusplus*/
#endif
