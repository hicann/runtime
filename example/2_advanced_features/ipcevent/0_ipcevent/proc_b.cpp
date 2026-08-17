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
 * This sample demonstrates IPC event for task synchronization across two processes.
 * Process B (consumer) imports the IPC event handle, waits for the event,
 * then records the event to notify the producer.
 */

#include <cstdio>
#include <cstring>
#include <unistd.h>
#include "acl/acl.h"
#include "utils.h"

#define EVENT_HANDLE_FILE "./event_handle.bin"
#define DONE_FILE "./consumer_done.flag"

int32_t main()
{
    CHECK_ERROR(aclInit(nullptr));

    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));

    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));

    // 1. 等待生产者创建事件句柄文件
    INFO_LOG("Process B: waiting for event handle file...");
    int timeout = 30;
    while (access(EVENT_HANDLE_FILE, F_OK) != 0 && timeout-- > 0) {
        sleep(1);
    }
    if (timeout <= 0) {
        ERROR_LOG("Timeout waiting for %s", EVENT_HANDLE_FILE);
        return -1;
    }

    // 2. 二进制读取事件句柄
    aclrtIpcEventHandle handle;
    FILE* fp = fopen(EVENT_HANDLE_FILE, "rb");
    if (!fp) {
        ERROR_LOG("Failed to open %s", EVENT_HANDLE_FILE);
        return -1;
    }
    fread(&handle, sizeof(handle), 1, fp);
    fclose(fp);
    INFO_LOG("Process B: read event handle");

    // 3. 打开IPC事件
    aclrtEvent ipcEvent = nullptr;
    CHECK_ERROR(aclrtIpcOpenEventHandle(handle, &ipcEvent));
    INFO_LOG("Process B: IPC event opened");

    // 4. 在流中等待该事件（等待生产者记录的事件）
    CHECK_ERROR(aclrtStreamWaitEvent(stream, ipcEvent));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    INFO_LOG("Process B: event received, stream synchronized");

    // 5. 模拟消费者自身的工作
    INFO_LOG("Process B: doing some work...");
    usleep(2000000); // 2秒

    // 6. 记录事件，通知生产者
    CHECK_ERROR(aclrtRecordEvent(ipcEvent, stream));
    CHECK_ERROR(aclrtSynchronizeEvent(ipcEvent));
    INFO_LOG("Process B: event recorded");

    // 7. 查询事件状态（应为已完成）
    aclrtEventRecordedStatus status;
    CHECK_ERROR(aclrtQueryEventStatus(ipcEvent, &status));
    INFO_LOG("Process B: event status = %d (1=completed)", status);
    if (status != ACL_EVENT_RECORDED_STATUS_COMPLETE) {
        ERROR_LOG("Event status error");
        return -1;
    }

    // 8. 创建完成标志文件，通知生产者
    fp = fopen(DONE_FILE, "w");
    if (fp) {
        fprintf(fp, "done");
        fclose(fp);
    }
    INFO_LOG("Process B: completion flag created");

    // 9. 清理资源
    CHECK_ERROR(aclrtDestroyEvent(ipcEvent));
    aclrtDestroyStream(stream);
    aclrtResetDevice(deviceId);
    aclFinalize();

    INFO_LOG("Process B: cleanup completed");
    return 0;
}