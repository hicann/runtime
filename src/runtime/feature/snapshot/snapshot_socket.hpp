/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SNAPSHOT_SOCKET_HPP
#define CCE_RUNTIME_SNAPSHOT_SOCKET_HPP
#include <atomic>
#include <cstdint>
#include <string>
#include "base.h"
#include "rts_snapshot.h"
#include "mmpa/mmpa_api.h"
namespace cce {
namespace runtime {
// API-independent execution contract shared by the transport and the feature implementation.
class SnapshotRequestHandler {
public:
    virtual ~SnapshotRequestHandler() = default;
    virtual rtError_t SnapShotProcessGetState(rtProcessState* state) = 0;
    virtual rtError_t SnapShotProcessGetRestoreThreadId(int32_t* tid) = 0;
    virtual rtError_t SnapShotProcessLock() = 0;
    virtual rtError_t SnapShotProcessUnlock() = 0;
    virtual rtError_t SnapShotProcessBackup(const rtSnapShotBackupArgs* args) = 0;
    virtual rtError_t SnapShotProcessRestore(const rtSnapShotRestoreArgs* args) = 0;
};
enum class rtSnapshotOp : uint32_t {
    LOCK = 1U,
    BACKUP = 2U,
    RESTORE = 3U,
    UNLOCK = 4U,
    GET_STATE = 5U,
    GET_RESTORE_THREAD_ID = 6U,
};

// All integer fields are encoded in network byte order. No process pointers cross the socket.
struct SnapshotRequestHeader {
    uint32_t magic;
    uint32_t version;
    uint32_t op;
    uint32_t argsSize;
};

struct SnapshotMemoryArgs {
    uint32_t flags;
    char reserved[60];
};

struct SnapshotResponse {
    uint32_t magic;
    uint32_t version;
    uint32_t result;
    uint32_t value;
};

// One request per connection. Returns internal RT codes; the API boundary converts them.
rtError_t SnapshotSocketCall(int32_t pid, rtSnapshotOp op, const SnapshotMemoryArgs* args, uint32_t& value);

class SnapshotService {
public:
    SnapshotService() = default;
    ~SnapshotService();
    SnapshotService(const SnapshotService&) = delete;
    SnapshotService& operator=(const SnapshotService&) = delete;
    rtError_t StartSnapshotService(SnapshotRequestHandler* handler);
    void StopSnapshotService();
    int32_t GetSnapshotThreadId() const;

private:
    static void* ThreadMain(void* arg);
    void Run();
    void HandleConnection(int32_t fd);
    rtError_t DispatchSnapshotRequest(rtSnapshotOp op, const SnapshotMemoryArgs* args, uint32_t& value);
    void CloseResources();
    // The feature owner keeps the handler alive until this service has joined.
    SnapshotRequestHandler* handler_ = nullptr;
    mmThread thread_{};
    bool started_ = false;
    // Identifies the creator so a fork child cannot join its thread or remove its endpoint.
    std::atomic<int32_t> ownerPid_{0};
    int32_t listenFd_ = EN_ERROR;
    // eventfd used to wake poll when Stop requests service shutdown.
    int32_t stopFd_ = EN_ERROR;
    // Private directory handle used by unlinkat to remove the socket endpoint.
    int32_t directoryFd_ = EN_ERROR;
    // Set only after bind succeeds; cleanup must not remove a conflicting endpoint.
    bool socketBound_ = false;
    std::string socketName_;
    std::atomic<int32_t> threadId_{0};
    // Prevents new requests from executing after Stop; stopFd_ wakes a blocked poll.
    std::atomic<bool> stopping_{false};
};
} // namespace runtime
} // namespace cce
#endif
