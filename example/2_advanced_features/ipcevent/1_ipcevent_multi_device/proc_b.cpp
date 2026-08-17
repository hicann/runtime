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
 * Consumer process (runs on a specified device): imports the IPC event handle,
 * waits for the event, records the event, then signals completion.
 */

#include <cstdio>
#include <cstring>
#include <unistd.h>
#include <cstdlib>
#include <sys/stat.h>
#include "acl/acl.h"
#include "utils.h"

#define EVENT_HANDLE_FILE "./event_handle.bin"

int main(int argc, char* argv[])
{
    if (argc != 3) {
        ERROR_LOG("Usage: %s <device_id> <consumer_id>", argv[0]);
        return -1;
    }
    int32_t deviceId = atoi(argv[1]);
    int consumerId = atoi(argv[2]);

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));

    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));

    // 1. 等待生产者创建事件句柄文件
    INFO_LOG("Consumer %d (device %d): waiting for event handle file...", consumerId, deviceId);
    int timeout = 30;
    while (access(EVENT_HANDLE_FILE, F_OK) != 0 && timeout-- > 0) {
        sleep(1);
    }
    if (timeout <= 0) {
        ERROR_LOG("Consumer %d: timeout waiting for %s", consumerId, EVENT_HANDLE_FILE);
        return -1;
    }

    // 2. 二进制读取事件句柄
    aclrtIpcEventHandle handle;
    FILE* fp = fopen(EVENT_HANDLE_FILE, "rb");
    if (!fp) {
        ERROR_LOG("Consumer %d: failed to open %s", consumerId, EVENT_HANDLE_FILE);
        return -1;
    }
    fread(&handle, sizeof(handle), 1, fp);
    fclose(fp);
    INFO_LOG("Consumer %d: read event handle", consumerId);

    // 3. 打开IPC事件
    aclrtEvent ipcEvent = nullptr;
    CHECK_ERROR(aclrtIpcOpenEventHandle(handle, &ipcEvent));
    INFO_LOG("Consumer %d: IPC event opened on device %d", consumerId, deviceId);

    // 4. 在流中等待该事件（等待生产者记录的事件）
    CHECK_ERROR(aclrtStreamWaitEvent(stream, ipcEvent));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    INFO_LOG("Consumer %d: event received, stream synchronized", consumerId);

    // 5. 模拟消费者自身的工作
    INFO_LOG("Consumer %d: doing some work...", consumerId);
    usleep(1000000); // 1秒

    // 6. 记录事件，通知其他等待者（这里主要是为了演示，实际已无等待者）
    CHECK_ERROR(aclrtRecordEvent(ipcEvent, stream));
    CHECK_ERROR(aclrtSynchronizeEvent(ipcEvent));

    // 7. 查询事件状态（应为已完成）
    aclrtEventRecordedStatus status;
    CHECK_ERROR(aclrtQueryEventStatus(ipcEvent, &status));
    INFO_LOG("Consumer %d: event status = %d (1=completed)", consumerId, status);
    if (status != ACL_EVENT_RECORDED_STATUS_COMPLETE) {
        ERROR_LOG("Consumer %d: event status error", consumerId);
        return -1;
    }

    // 8. 创建完成标志文件，通知生产者
    char flagFile[64];
    snprintf(flagFile, sizeof(flagFile), "./consumer_%d.done", consumerId);
    fp = fopen(flagFile, "w");
    if (fp) {
        fprintf(fp, "done");
        fclose(fp);
    }
    INFO_LOG("Consumer %d: completion flag created", consumerId);

    // 9. 清理资源
    CHECK_ERROR(aclrtDestroyEvent(ipcEvent));
    aclrtDestroyStream(stream);
    aclrtResetDevice(deviceId);
    aclFinalize();

    INFO_LOG("Consumer %d (device %d) finished successfully.", consumerId, deviceId);
    return 0;
}