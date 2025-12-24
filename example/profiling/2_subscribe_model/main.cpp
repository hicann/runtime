/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <vector>
#include <unistd.h>
#include <string>
#include <pthread.h>
#include "securec.h"
#include "utils.h"
#include "acl/acl.h"
#include "acl/acl_prof.h"

namespace {
// 自定义函数，实现从用户内存中读取订阅数据的函数
void getModelInfo(void *data, uint32_t len)
{
    uint32_t opNumber = 0;
    uint32_t dataLen = 0;
    // 读取算子信息个数
    aclprofGetOpNum(data, len, &opNumber);
    // 遍历用户内存的算子信息
    for (uint32_t i = 0; i < opNumber; i++) {
        // 获取算子的模型id
        uint32_t modelId = aclprofGetModelId(data, len, i);
        // 获取算子的类型名称长度
        size_t opTypeLen = 0;
        aclprofGetOpTypeLen(data, len, i, &opTypeLen);
        // 获取算子的类型名称
        char opType[opTypeLen];
        aclprofGetOpType(data, len, i, opType, opTypeLen);
        // 获取算子的详细名称长度
        size_t opNameLen = 0;
        aclprofGetOpNameLen(data, len, i, &opNameLen);
        // 获取算子的详细名称
        char opName[opNameLen];
        aclprofGetOpName(data, len, i, opName, opNameLen);
        // 获取算子的执行开始时间
        uint64_t opStart = aclprofGetOpStart(data, len, i);
        // 获取算子的执行结束时间
        uint64_t opEnd = aclprofGetOpEnd(data, len, i);
        uint64_t opDuration = aclprofGetOpDuration(data, len, i);
    }
}

// 自定义函数，实现从管道中读取数据到用户内存的函数
void *profDataRead(void *fd)
{
    // 设置每次从管道中读取的算子信息个数
    uint64_t N = 10;
    // 获取单位算子信息的大小（Byte）
    uint64_t bufferSize = 0;
    aclprofGetOpDescSize(&bufferSize);
    // 计算存储算子信息的内存的大小，并且申请内存
    uint64_t readbufLen = bufferSize * N;
    char *readbuf = new char[readbufLen];
    // 从管道中读取数据到申请的内存中，读取到的实际数据大小dataLen可能小于bufferSize * N，如果管道中没有数据，默认会阻塞直到读取到数据为止
    ssize_t dataLen = read(*(int*)fd, readbuf, readbufLen);
    // 读取数据到readbuf成功
    while (dataLen > 0) {
        if (dataLen == static_cast<ssize_t>(5) && strncmp(readbuf, "Stop", 4) == 0) { // 检查是否读取到Stop字符，读取长度为5，字符长度为4
            break;
        }
        // 调用实现的函数解析内存中的数据
        getModelInfo(readbuf, static_cast<uint32_t>(dataLen));
        if (dataLen > static_cast<ssize_t>(readbufLen)) {
            dataLen = static_cast<ssize_t>(readbufLen);
        }
        memset_s(readbuf, readbufLen, 0, readbufLen);
        dataLen = read(*(int*)fd, readbuf, readbufLen);
    }
    delete []readbuf;
}
}

int main(int argc, char *argv[])
{
    // 初始化
    uint32_t deviceIdList[1] = {0};  // 根据实际环境的DeviceID配置
    aclrtStream stream = nullptr;
    // 申请运行时资源
    aclInit(nullptr);
    aclrtSetDevice(deviceIdList[0]);
    aclrtCreateStream(&stream);
    // profiling初始化
    // 创建管道（UNIX操作系统下需要引用C++标准库头文件unistd.h），用于读取以及写入模型订阅的数据
    int subFd[2];
    // 读管道指针指向subFd[0]，写管道指针指向subFd[1]
    CHECK_ERROR(pipe(subFd));
    // 进行profiling配置
    // 创建配置结构体
    // 创建模型订阅的配置并且进行模型订阅
    aclprofSubscribeConfig *config = aclprofCreateSubscribeConfig(1, ACL_AICORE_NONE, &subFd[1]);
    // 模型订阅需要传入模型的modelId
    uint32_t fake_modelId = 1;
    aclprofModelSubscribe(fake_modelId, config);

    // 模型加载，加载成功后，返回标识模型的modelId
    // 创建aclmdlDataset类型的数据，用于描述模型的输入数据input、输出数据output

    // 启动线程读取管道数据并解析
    pthread_t subTid = 0;
    CHECK_ERROR(pthread_create(&subTid, nullptr, profDataRead, &subFd[0]));

    // 手动写入消息避免read阻塞
    INFO_LOG("Running ...... \n");
    if (write(subFd[1], "Hello", static_cast<size_t>(6)) != static_cast<size_t>(6)) { // 写入长度为6
        ERROR_LOG("Write Hello error");
    }
    (void)sleep(static_cast<uint8_t>(3));   // 3秒
    INFO_LOG("Try to Stop ...... \n");
    if (write(subFd[1], "Stop", static_cast<size_t>(5)) != static_cast<size_t>(5)) { // 写入长度为5
        ERROR_LOG("Write Stop error");
    }
    // 执行模型 ret = aclmdlExecute(modelId, input, output);
    // 处理模型推理结果
    // 释放描述模型输入/输出信息、内存等资源，卸载模型

    // 取消订阅，释放订阅相关资源
    aclprofModelUnSubscribe(fake_modelId);
    CHECK_ERROR(pthread_join(subTid, nullptr));
    INFO_LOG("Stopped ...... \n");
    // 关闭读管道指针
    CHECK_ERROR(close(subFd[0]));
    // 释放config指针
    aclprofDestroySubscribeConfig(config);

    // 释放运行时资源
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(deviceIdList[0]);
    aclFinalize();
    return 0;
}