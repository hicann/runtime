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
 * This sample demonstrates cross-server memory sharing
 * using two independent processes (i.e., Server and Client) on different devices.
 */

#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>
#include "write_do.h"

int32_t main(int argc, char* argv[])
{
    int32_t port = 8888;
    if (argc > 1) {
        port = atoi(argv[1]);
        if (port <= 0 || port > 65535) {
            ERROR_LOG("Server: invalid port number, using default port 8888");
            port = 8888;
        }
    }

    // Initialize ACL and set device
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    const size_t dataSize = 1024 * sizeof(float);
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;
    prop.memAttr = ACL_HBM_MEM_NORMAL;

    size_t granularity = 0UL;
    CHECK_ERROR(aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity));
    INFO_LOG(
        "Server: get memory allocation granularity successfully, granularity = %d", static_cast<int32_t>(granularity));

    // Start allocating physical memory based on memory allocation granularity
    size_t alignedSize = ((dataSize + granularity - 1U) / granularity) * granularity;
    aclrtDrvMemHandle handle = nullptr;
    CHECK_ERROR(aclrtMallocPhysical(&handle, alignedSize, &prop, 0));
    INFO_LOG("Server: allocate physical memory successfully");

    // Reserve virtual memory
    void* virPtr;
    CHECK_ERROR(aclrtReserveMemAddress(&virPtr, granularity, 0, nullptr, 0));
    INFO_LOG("Server: reserve virtual memory successfully");

    CHECK_ERROR(aclrtMapMem(virPtr, granularity, 0, handle, 0));
    INFO_LOG("Server: map virtual memory address to physical memory handle");

    aclrtMemAccessDesc accessDesc = {};
    accessDesc.flags = ACL_RT_MEM_ACCESS_FLAGS_READWRITE;
    accessDesc.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    accessDesc.location.id = deviceId;
    CHECK_ERROR(aclrtMemSetAccess(virPtr, granularity, &accessDesc, 1));
    INFO_LOG("Server: set memory access permissions successfully");

    constexpr uint32_t blockDim = 1;
    int writeValue = 123;
    WriteDo(blockDim, stream, (int*)virPtr, writeValue);
    aclrtSynchronizeStream(stream);
    INFO_LOG("Source data: %d", writeValue);

    // Export a shareable handle
    aclrtMemFabricHandle shareableHandle = {};
    aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_FABRIC;
    CHECK_ERROR(aclrtMemExportToShareableHandleV2(handle, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION, 
                shareType, &shareableHandle));
    INFO_LOG("Server: export shareable handle successfully");

    // Transfer the shareable handle to client by UDP
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        ERROR_LOG("Server: create socket failed");
        return -1;
    }
    INFO_LOG("Server: create socket successfully, sockfd = %d", sockfd);

    struct sockaddr_in server_addr, client_addr;
    CHECK_ERROR(aclrtMemset(&server_addr, sizeof(server_addr), 0, sizeof(server_addr)));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(port);

    if (bind(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        ERROR_LOG("Server: bind failed");
        close(sockfd);
        return -1;
    }
    INFO_LOG("Server: bind successfully on port %d", port);

    INFO_LOG("Server: listening on port %d", port);

    char buffer[1];
    socklen_t client_len = sizeof(client_addr);
    int recv_len = recvfrom(sockfd, buffer, sizeof(buffer), 0, (struct sockaddr*)&client_addr, &client_len);
    if (recv_len < 0) {
        ERROR_LOG("Server: receive connection failed");
        close(sockfd);
        return -1;
    }
    INFO_LOG("Server: receive client socket successfully.");

    int send_len =
        sendto(sockfd, &shareableHandle, sizeof(shareableHandle), 0, (struct sockaddr*)&client_addr, client_len);
    if (send_len < 0) {
        ERROR_LOG("Server: send shareable handle failed");
        close(sockfd);
        return -1;
    }
    INFO_LOG("Server: send ipc message successfully, size = %d", send_len);

    // Read the completion flag from client
    int32_t flag = 0;
    recv_len = recvfrom(sockfd, &flag, sizeof(flag), 0, (struct sockaddr*)&client_addr, &client_len);
    if (recv_len < 0) {
        ERROR_LOG("Server: receive completion flag failed");
        close(sockfd);
        return -1;
    }
    INFO_LOG("Server: receive ipc message successfully, flag = %d", flag);
    close(sockfd);
    INFO_LOG("Server: ipc close successfully");

     // Release memory resources
    CHECK_ERROR(aclrtUnmapMem(virPtr));
    CHECK_ERROR(aclrtReleaseMemAddress(virPtr));
    CHECK_ERROR(aclrtFreePhysical(handle));
    INFO_LOG("Server: released memory successfully");

    aclrtDestroyStreamForce(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}