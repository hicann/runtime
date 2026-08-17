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
 * Process A (producer) creates an IPC event, exports the handle, records the event,
 * then waits for process B to record the event.
 */

#include <cstdio>
#include <cstring>
#include <unistd.h>
#include <sys/stat.h>
#include "acl/acl.h"
#include "utils.h"

#define EVENT_HANDLE_FILE "./event_handle.bin"
#define DONE_FILE "./consumer_done.flag"

int main()
{
    CHECK_ERROR(aclInit(nullptr));

    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));

    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));

    // 1. 创建支持IPC的事件
    aclrtEvent ipcEvent = nullptr;
    CHECK_ERROR(aclrtCreateEventExWithFlag(&ipcEvent, ACL_EVENT_IPC));
    INFO_LOG("Process A: IPC event created");

    // 2. 记录事件（模拟生产者自身任务完成）
    CHECK_ERROR(aclrtRecordEvent(ipcEvent, stream));
    CHECK_ERROR(aclrtSynchronizeEvent(ipcEvent));
    INFO_LOG("Process A: event recorded and synchronized");

    // 3. 查询事件状态（应为已完成）
    aclrtEventRecordedStatus status;
    CHECK_ERROR(aclrtQueryEventStatus(ipcEvent, &status));
    if (status != ACL_EVENT_RECORDED_STATUS_COMPLETE) {
        ERROR_LOG("Event status error: expected 1, got %d", status);
        return -1;
    }
    INFO_LOG("Process A: event status = %d (1=completed)", status);

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
    INFO_LOG("Process A: IPC event handle written to %s", EVENT_HANDLE_FILE);

    // 5. 等待消费者完成（等待标志文件出现）
    INFO_LOG("Process A: waiting for consumer to finish...");
    int timeout = 30;
    while (access(DONE_FILE, F_OK) != 0 && timeout-- > 0) {
        sleep(1);
    }
    if (timeout <= 0) {
        ERROR_LOG("Timeout waiting for consumer");
        return -1;
    }
    INFO_LOG("Process A: consumer finished");

    // 6. 清理资源
    CHECK_ERROR(aclrtDestroyEvent(ipcEvent));
    aclrtDestroyStream(stream);
    aclrtResetDevice(deviceId);
    aclFinalize();

    // 删除临时文件
    remove(EVENT_HANDLE_FILE);
    remove(DONE_FILE);

    INFO_LOG("Process A: cleanup completed");
    return 0;
}