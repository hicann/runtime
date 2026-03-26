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

int32_t main(int argc, char* argv[])
{
    if (argc < 2) {
        return -1;
    }
    const char* server_ip = argv[1];
    int32_t port = 8888;
    if (argc > 2) {
        port = atoi(argv[2]);
        if (port <= 0 || port > 65535) {
            ERROR_LOG("Client: invalid port number, using default port 8888");
            port = 8888;
        }
    }
    INFO_LOG("Client: connecting to server %s:%d", server_ip, port);

    // Initialize ACL and set device
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        ERROR_LOG("Client: create socket failed");
        return -1;
    }
    INFO_LOG("Client: create socket successfully, sockfd = %d", sockfd);

    struct sockaddr_in server_addr;
    CHECK_ERROR(aclrtMemset(&server_addr, sizeof(server_addr), 0, sizeof(server_addr)));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = inet_addr(server_ip);
    server_addr.sin_port = htons(port);

    // Send connection request to server
    char buffer[1] = {0};
    int send_len = sendto(sockfd, buffer, sizeof(buffer), 0, (struct sockaddr*)&server_addr, sizeof(server_addr));
    if (send_len < 0) {
        ERROR_LOG("Client: send connection message failed");
        close(sockfd);
        return -1;
    }
    INFO_LOG("Client: send connection message successfully");

    aclrtMemFabricHandle shareableHandle = {};
    aclrtDrvMemHandle handle = nullptr;
    socklen_t server_len = sizeof(server_addr);
    int recv_len = 
        recvfrom(sockfd, &shareableHandle, sizeof(shareableHandle), 0, (struct sockaddr*)&server_addr, &server_len);
    if (recv_len < 0) {
        close(sockfd);
        return -1;
    }

    // Import shareable handle from server
    CHECK_ERROR(aclrtMemImportFromShareableHandleV2(&shareableHandle, ACL_MEM_SHARE_HANDLE_TYPE_FABRIC, 
                ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT, &handle));
    INFO_LOG("Client: import shareable handle successfully");

    const size_t data_size = 1024 * sizeof(float);
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;
    prop.memAttr = ACL_HBM_MEM_NORMAL;

    size_t granularity = 0UL;
    CHECK_ERROR(aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity));
    void* virPtr = nullptr;
    CHECK_ERROR(aclrtReserveMemAddress(&virPtr, granularity, 0, nullptr, 0));
    INFO_LOG("Client: reserve virtual memory successfully");

    CHECK_ERROR(aclrtMapMem(virPtr, granularity, 0, handle, 0));
    INFO_LOG("Client: map virtual memory address to physical memory handle");

    aclrtMemAccessDesc accessDesc = {};
    accessDesc.flags = ACL_RT_MEM_ACCESS_FLAGS_READWRITE;
    accessDesc.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    accessDesc.location.id = deviceId;
    CHECK_ERROR(aclrtMemSetAccess(virPtr, granularity, &accessDesc, 1));
    INFO_LOG("Client: set memory access permissions successfully");

    // Unmap virtual memory from physical memory
    CHECK_ERROR(aclrtUnmapMem(virPtr));

    // Send completion flag to server
    int32_t flag = 1;
    send_len = sendto(sockfd, &flag, sizeof(flag), 0, (struct sockaddr*)&server_addr, sizeof(server_addr));
    if (send_len < 0) {
        ERROR_LOG("Client: send completion flag failed");
        close(sockfd);
        return -1;
    }

    // Release memory resources
    close(sockfd);
    CHECK_ERROR(aclrtReleaseMemAddress(virPtr));
    CHECK_ERROR(aclrtFreePhysical(handle));
    INFO_LOG("Client: released memory successfully");

    aclrtDestroyStreamForce(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}