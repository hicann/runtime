/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * Producer process (Device 0): creates an IPC event, exports handle to file,
 * then waits for all consumer processes to finish.
 */

#include <cstdio>
#include <cstring>
#include <unistd.h>
#include <cstdlib>
#include <sys/stat.h>
#include "acl/acl.h"
#include "utils.h"

#define EVENT_HANDLE_FILE "./event_handle.bin"
#define MAX_CONSUMER_NUM 8

// 等待所有消费者完成（通过检查每个消费者创建的完成标志文件）
int WaitForConsumers(int expectedCount)
{
    char flagFile[64];
    int completed = 0;
    int timeoutSec = 30;
    int elapsed = 0;

    while (completed < expectedCount && elapsed < timeoutSec) {
        completed = 0;
        for (int i = 1; i <= expectedCount; ++i) {
            snprintf(flagFile, sizeof(flagFile), "./consumer_%d.done", i);
            if (access(flagFile, F_OK) == 0) {
                completed++;
            }
        }
        if (completed < expectedCount) {
            sleep(1);
            elapsed++;
        }
    }
    if (completed == expectedCount) {
        INFO_LOG("All %d consumers have finished.", expectedCount);
        return 0;
    } else {
        ERROR_LOG("Timeout waiting for consumers. Only %d of %d finished.", completed, expectedCount);
        return -1;
    }
}

int main(int argc, char* argv[])
{
    if (argc != 2) {
        ERROR_LOG("Usage: %s <number_of_consumers>", argv[0]);
        return -1;
    }
    int consumerNum = atoi(argv[1]);
    if (consumerNum <= 0 || consumerNum > MAX_CONSUMER_NUM) {
        ERROR_LOG("Invalid consumer number (1~%d)", MAX_CONSUMER_NUM);
        return -1;
    }

    CHECK_ERROR(aclInit(nullptr));

    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));

    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));

    // 1. 创建支持IPC的事件
    aclrtEvent ipcEvent = nullptr;
    CHECK_ERROR(aclrtCreateEventExWithFlag(&ipcEvent, ACL_EVENT_IPC));
    INFO_LOG("Producer: IPC event created on device %d", deviceId);

    // 2. 记录事件（模拟生产者自身任务完成）
    CHECK_ERROR(aclrtRecordEvent(ipcEvent, stream));
    CHECK_ERROR(aclrtSynchronizeEvent(ipcEvent));

    // 3. 查询事件状态（应为已完成）
    aclrtEventRecordedStatus status;
    CHECK_ERROR(aclrtQueryEventStatus(ipcEvent, &status));
    if (status != ACL_EVENT_RECORDED_STATUS_COMPLETE) {
        ERROR_LOG("Event status error: expected 1, got %d", status);
        return -1;
    }
    INFO_LOG("Producer: event status = %d (1=completed)", status);

    // 4. 导出IPC事件句柄（二进制写入文件）
    aclrtIpcEventHandle handle;
    CHECK_ERROR(aclrtIpcGetEventHandle(ipcEvent, &handle));
    FILE* fp = fopen(EVENT_HANDLE_FILE, "wb");
    if (!fp) {
        ERROR_LOG("Failed to create %s", EVENT_HANDLE_FILE);
        return -1;
    }
    fwrite(&handle, sizeof(handle), 1, fp);
    fclose(fp);
    INFO_LOG("Producer: IPC event handle written to %s", EVENT_HANDLE_FILE);

    // 5. 等待所有消费者完成
    INFO_LOG("Producer: waiting for %d consumer(s) to finish...", consumerNum);
    if (WaitForConsumers(consumerNum) != 0) {
        return -1;
    }

    // 6. 清理资源
    CHECK_ERROR(aclrtDestroyEvent(ipcEvent));
    aclrtDestroyStream(stream);
    aclrtResetDevice(deviceId);
    aclFinalize();

    // 删除临时文件
    remove(EVENT_HANDLE_FILE);
    for (int i = 1; i <= consumerNum; ++i) {
        char flagFile[64];
        snprintf(flagFile, sizeof(flagFile), "./consumer_%d.done", i);
        remove(flagFile);
    }

    INFO_LOG("Producer: finished successfully.");
    return 0;
}