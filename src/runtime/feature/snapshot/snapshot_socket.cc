/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "snapshot_socket.hpp"
#include <arpa/inet.h>
#include <cerrno>
#include <fcntl.h>
#include <fstream>
#include <poll.h>
#include <pwd.h>
#include <sstream>
#include <sys/eventfd.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/un.h>
#include <unistd.h>
#include <vector>
#include "base.hpp"
#include "common/enum_log.hpp"
#include "error_message_manage.hpp"
#include "osal.hpp"
#include "securec.h"
namespace cce {
namespace runtime {
namespace {
constexpr uint32_t SNAPSHOT_MAGIC = 0x534E4150U;
constexpr uint32_t SNAPSHOT_VERSION = 1U;
constexpr int32_t IO_TIMEOUT_MS = 5000;
constexpr int32_t SNAPSHOT_LISTEN_BACKLOG = 8;
constexpr int32_t ACCEPT_RETRY_DELAY_MS = 100;
constexpr size_t PASSWD_BUFFER_SIZE = 16U * 1024U;
bool SetSocketTimeout(int32_t fd, int32_t receiveTimeoutMs, int32_t sendTimeoutMs)
{
    const struct timeval receiveTimeout = {
        static_cast<time_t>(receiveTimeoutMs / RT_MS_PER_S),
        static_cast<suseconds_t>((receiveTimeoutMs % RT_MS_PER_S) * RT_US_TO_MS)};
    const struct timeval sendTimeout = {
        static_cast<time_t>(sendTimeoutMs / RT_MS_PER_S),
        static_cast<suseconds_t>((sendTimeoutMs % RT_MS_PER_S) * RT_US_TO_MS)};
    if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &receiveTimeout, sizeof(receiveTimeout)) != 0) {
        RT_LOG(RT_LOG_ERROR, "Set snapshot receive timeout failed, errno=%d.", errno);
        return false;
    }
    if (setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, sizeof(sendTimeout)) != 0) {
        RT_LOG(RT_LOG_ERROR, "Set snapshot send timeout failed, errno=%d.", errno);
        return false;
    }
    return true;
}

bool WaitSocketReady(int32_t fd, short events, int32_t stopFd, int32_t timeoutMs)
{
    struct pollfd fds[2] = {{fd, events, 0}, {stopFd, POLLIN, 0}};
    int32_t ret;
    do {
        ret = poll(fds, 2U, timeoutMs);
    } while ((ret < 0) && (errno == EINTR));
    if (ret <= 0) {
        return false;
    }
    // A stop notification takes priority over socket readiness.
    if (fds[1].revents != 0) {
        return false;
    }
    return (fds[0].revents & (events | POLLHUP)) != 0;
}

bool SendSocket(int32_t fd, const void* data, int32_t length, int32_t stopFd = EN_ERROR)
{
    const auto* bytes = static_cast<const char*>(data);
    int32_t offset = 0;
    while (offset < length) {
        if ((stopFd >= 0) && !WaitSocketReady(fd, POLLOUT, stopFd, IO_TIMEOUT_MS)) {
            return false;
        }
        const mmSsize_t ret = mmSocketSend(fd, const_cast<char*>(bytes + offset), length - offset, MSG_NOSIGNAL);
        if ((ret < 0) && (errno == EINTR)) {
            continue;
        }
        if (ret <= 0) {
            return false;
        }
        offset += static_cast<int32_t>(ret);
    }
    return true;
}

bool ReceiveSocket(int32_t fd, void* data, int32_t length, int32_t stopFd = EN_ERROR)
{
    auto* bytes = static_cast<char*>(data);
    int32_t offset = 0;
    while (offset < length) {
        if ((stopFd >= 0) && !WaitSocketReady(fd, POLLIN, stopFd, IO_TIMEOUT_MS)) {
            return false;
        }
        const mmSsize_t ret = mmSocketRecv(fd, bytes + offset, length - offset, 0);
        if ((ret < 0) && (errno == EINTR)) {
            continue;
        }
        if (ret <= 0) {
            return false;
        }
        offset += static_cast<int32_t>(ret);
    }
    return true;
}

bool IsMemoryOp(rtSnapshotOp op) { return (op == rtSnapshotOp::BACKUP) || (op == rtSnapshotOp::RESTORE); }

bool GetTargetUid(int32_t pid, uid_t& uid)
{
    std::ifstream status("/proc/" + std::to_string(pid) + "/status");
    if (!status.is_open()) {
        RT_LOG(RT_LOG_ERROR, "Read snapshot target status failed, errno=%d.", errno);
        return false;
    }
    std::string line;
    while (std::getline(status, line)) {
        if (line.compare(0U, 4U, "Uid:") == 0) {
            uid_t realUid = 0;
            std::istringstream fields(line.substr(4U));
            if (fields >> realUid >> uid) {
                return true;
            }
            break;
        }
    }
    RT_LOG(RT_LOG_ERROR, "Read snapshot target effective UID failed.");
    return false;
}

bool GetHome(uid_t uid, std::string& home)
{
    struct passwd entry = {};
    struct passwd* found = nullptr;
    std::vector<char> buffer(PASSWD_BUFFER_SIZE);
    const int32_t ret = getpwuid_r(uid, &entry, buffer.data(), buffer.size(), &found);
    if ((ret != 0) || (found == nullptr) || (entry.pw_dir == nullptr) || (entry.pw_dir[0] != '/')) {
        RT_LOG(RT_LOG_ERROR, "Get snapshot home directory failed, ret=%d.", ret);
        return false;
    }
    home = entry.pw_dir;
    return true;
}

bool CheckDirectory(int32_t fd, uid_t uid)
{
    struct stat info = {};
    if (fstat(fd, &info) != 0) {
        RT_LOG(RT_LOG_ERROR, "Get snapshot directory information failed, errno=%d.", errno);
        return false;
    }
    if (!S_ISDIR(info.st_mode) || (info.st_uid != uid) || ((info.st_mode & 0777U) != 0700U)) {
        RT_LOG(RT_LOG_ERROR, "Invalid snapshot directory ownership or permissions.");
        return false;
    }
    return true;
}

int32_t OpenDirectory(uid_t uid, bool create, std::string& path)
{
    std::string home;
    if (!GetHome(uid, home)) {
        return EN_ERROR;
    }
    const int32_t homeFd = open(home.c_str(), O_RDONLY | O_DIRECTORY | O_CLOEXEC);
    if (homeFd < 0) {
        RT_LOG(RT_LOG_ERROR, "Open snapshot home directory failed, errno=%d.", errno);
        return EN_ERROR;
    }
    const ScopeGuard homeGuard([homeFd] { (void)mmClose(homeFd); });
    if (create && (mkdirat(homeFd, ".cann_snapshot", 0700U) != 0) && (errno != EEXIST)) {
        RT_LOG(RT_LOG_ERROR, "Create snapshot directory failed, errno=%d.", errno);
        return EN_ERROR;
    }
    const int32_t fd = openat(homeFd, ".cann_snapshot", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
    if (fd < 0) {
        RT_LOG(RT_LOG_ERROR, "Open snapshot directory failed, errno=%d.", errno);
        return EN_ERROR;
    }
    if (!CheckDirectory(fd, uid)) {
        (void)mmClose(fd);
        return EN_ERROR;
    }
    path = home + "/.cann_snapshot/";
    return fd;
}

bool MakeAddress(const std::string& path, struct sockaddr_un& address)
{
    if (path.size() >= sizeof(address.sun_path)) {
        RT_LOG(
            RT_LOG_ERROR, "Snapshot socket path is too long, length=%zu, capacity=%zu.", path.size(),
            sizeof(address.sun_path));
        return false;
    }
    address.sun_family = AF_UNIX;
    return memcpy_s(address.sun_path, sizeof(address.sun_path), path.c_str(), path.size() + 1U) == EOK;
}

bool CheckServerCredentials(int32_t fd, int32_t pid, uid_t uid)
{
    struct ucred peer = {};
    socklen_t length = sizeof(peer);
    if ((getsockopt(fd, SOL_SOCKET, SO_PEERCRED, &peer, &length) != 0) || (peer.pid != pid) || (peer.uid != uid)) {
        RT_LOG(RT_LOG_ERROR, "Snapshot server credentials do not match the target process.");
        return false;
    }
    return true;
}

bool CheckClientCredentials(int32_t fd, struct ucred& peer)
{
    socklen_t length = sizeof(peer);
    if ((getsockopt(fd, SOL_SOCKET, SO_PEERCRED, &peer, &length) != 0) ||
        ((peer.uid != geteuid()) && (peer.uid != 0U))) {
        return false;
    }
    return true;
}

rtError_t SnapshotSocketRequest(int32_t pid, rtSnapshotOp op, const SnapshotMemoryArgs* args, uint32_t& value)
{
    uid_t uid = 0;
    if (!GetTargetUid(pid, uid)) {
        return RT_ERROR_OS_HANDLE;
    }
    std::string directory;
    const int32_t dirFd = OpenDirectory(uid, false, directory);
    if (dirFd < 0) {
        return RT_ERROR_OS_HANDLE;
    }
    const ScopeGuard directoryGuard([dirFd] { (void)mmClose(dirFd); });
    const std::string name = std::to_string(pid) + ".sock";
    struct stat node = {};
    if (fstatat(dirFd, name.c_str(), &node, AT_SYMLINK_NOFOLLOW) != 0) {
        RT_LOG(RT_LOG_ERROR, "Get snapshot socket information failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    if (!S_ISSOCK(node.st_mode) || (node.st_uid != uid) || ((node.st_mode & 0777U) != 0600U)) {
        RT_LOG(RT_LOG_ERROR, "Invalid snapshot socket type, ownership or permissions.");
        return RT_ERROR_OS_HANDLE;
    }
    struct sockaddr_un address = {};
    if (!MakeAddress(directory + name, address)) {
        return RT_ERROR_INVALID_VALUE;
    }
    const int32_t fd = mmSocket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    if (fd < 0) {
        RT_LOG(RT_LOG_ERROR, "Create snapshot client socket failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    const ScopeGuard socketGuard([fd] { (void)mmCloseSocket(fd); });
    if (!SetSocketTimeout(fd, 0, IO_TIMEOUT_MS)) {
        return RT_ERROR_OS_HANDLE;
    }
    if (mmConnect(fd, reinterpret_cast<mmSockAddr*>(&address), sizeof(address)) != EN_OK) {
        RT_LOG(RT_LOG_ERROR, "Connect snapshot socket failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    if (!CheckServerCredentials(fd, pid, uid)) {
        return RT_ERROR_OS_HANDLE;
    }
    SnapshotRequestHeader request = {
        htonl(SNAPSHOT_MAGIC), htonl(SNAPSHOT_VERSION), htonl(static_cast<uint32_t>(op)),
        htonl(args == nullptr ? 0U : static_cast<uint32_t>(sizeof(*args)))};
    if (!SendSocket(fd, &request, sizeof(request))) {
        RT_LOG(RT_LOG_ERROR, "Send snapshot request failed, op=%u.", static_cast<uint32_t>(op));
        return RT_ERROR_OS_HANDLE;
    }
    if (args != nullptr) {
        SnapshotMemoryArgs encoded = *args;
        encoded.flags = htonl(encoded.flags);
        if (!SendSocket(fd, &encoded, sizeof(encoded))) {
            RT_LOG(RT_LOG_ERROR, "Send snapshot arguments failed, op=%u.", static_cast<uint32_t>(op));
            return RT_ERROR_OS_HANDLE;
        }
    }
    SnapshotResponse response = {};
    if (!ReceiveSocket(fd, &response, sizeof(response)) || (ntohl(response.magic) != SNAPSHOT_MAGIC) ||
        (ntohl(response.version) != SNAPSHOT_VERSION)) {
        RT_LOG(RT_LOG_ERROR, "Receive snapshot response failed, op=%u.", static_cast<uint32_t>(op));
        return RT_ERROR_OS_HANDLE;
    }
    const rtError_t result = static_cast<rtError_t>(ntohl(response.result));
    if (result == 0) {
        value = ntohl(response.value);
    }
    return result;
}

} // namespace

rtError_t SnapshotSocketCall(int32_t pid, rtSnapshotOp op, const SnapshotMemoryArgs* args, uint32_t& value)
{
    return SnapshotSocketRequest(pid, op, args, value);
}

SnapshotService::~SnapshotService()
{
    // Join the service thread before releasing its socket resources.
    StopSnapshotService();
}

rtError_t SnapshotService::StartSnapshotService(SnapshotRequestHandler* handler)
{
    if (started_) {
        RT_LOG(RT_LOG_ERROR, "Snapshot service already started.");
        return RT_ERROR_OS_HANDLE;
    }
    NULL_PTR_RETURN_MSG(handler, RT_ERROR_INVALID_VALUE);
    handler_ = handler;
    ownerPid_ = mmGetPid();
    stopping_.store(false);
    ScopeGuard cleanup([this] { CloseResources(); });
    std::string directory;
    directoryFd_ = OpenDirectory(geteuid(), true, directory);
    if (directoryFd_ < 0) {
        return RT_ERROR_OS_HANDLE;
    }
    socketName_ = std::to_string(ownerPid_) + ".sock";
    struct sockaddr_un address = {};
    if (!MakeAddress(directory + socketName_, address)) {
        return RT_ERROR_OS_HANDLE;
    }
    listenFd_ = mmSocket(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
    if (listenFd_ < 0) {
        RT_LOG(RT_LOG_ERROR, "Create snapshot listener failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    stopFd_ = eventfd(0U, EFD_NONBLOCK | EFD_CLOEXEC);
    if (stopFd_ < 0) {
        RT_LOG(RT_LOG_ERROR, "Create snapshot stop notification failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    // Remove the previous socket file before binding, as other local socket services do.
    struct stat node = {};
    if (fstatat(directoryFd_, socketName_.c_str(), &node, AT_SYMLINK_NOFOLLOW) == 0) {
        RT_LOG(
            RT_LOG_WARNING, "Snapshot socket path already exists, remove before binding, path=%s.", address.sun_path);
        if ((unlinkat(directoryFd_, socketName_.c_str(), 0) != 0) && (errno != ENOENT)) {
            RT_LOG(RT_LOG_WARNING, "Remove snapshot socket failed, path=%s, errno=%d.", address.sun_path, errno);
        }
    }
    if (mmBind(listenFd_, reinterpret_cast<mmSockAddr*>(&address), sizeof(address)) != EN_OK) {
        RT_LOG(RT_LOG_ERROR, "Bind snapshot socket failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    socketBound_ = true;
    if (fchmodat(directoryFd_, socketName_.c_str(), 0600U, 0) != 0) {
        RT_LOG(RT_LOG_ERROR, "Set snapshot socket permissions failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    if (mmListen(listenFd_, SNAPSHOT_LISTEN_BACKLOG) != EN_OK) {
        RT_LOG(RT_LOG_ERROR, "Listen on snapshot socket failed, errno=%d.", errno);
        return RT_ERROR_OS_HANDLE;
    }
    mmUserBlock_t threadArgs = {&SnapshotService::ThreadMain, this};
    const int32_t ret = mmCreateTask(&thread_, &threadArgs);
    if (ret != EN_OK) {
        RT_LOG(RT_LOG_ERROR, "Create snapshot service thread failed, ret=%d.", ret);
        return RT_ERROR_OS_HANDLE;
    }
    started_ = true;
    cleanup.ReleaseGuard();
    RT_LOG(RT_LOG_INFO, "Snapshot service started.");
    return RT_ERROR_NONE;
}

int32_t SnapshotService::GetSnapshotThreadId() const
{
    return ((ownerPid_ == mmGetPid()) && !stopping_.load()) ? threadId_.load() : 0;
}

void SnapshotService::StopSnapshotService()
{
    if (ownerPid_ != mmGetPid()) {
        // fork inherits descriptors, not this thread. Do not join it or remove the parent's socket.
        CloseResources();
        started_ = false;
        threadId_.store(0);
        return;
    }
    stopping_.store(true);
    if (started_) {
        const uint64_t wake = 1U;
        ssize_t wakeResult;
        do {
            wakeResult = write(stopFd_, &wake, sizeof(wake));
        } while ((wakeResult < 0) && (errno == EINTR));
        if (wakeResult < 0) {
            RT_LOG(RT_LOG_WARNING, "Notify snapshot service stop failed, errno=%d.", errno);
        }
        const int32_t ret = mmJoinTask(&thread_);
        if (ret != EN_OK) {
            RT_LOG(RT_LOG_WARNING, "Join snapshot service thread failed, ret=%d.", ret);
        }
        started_ = false;
        RT_LOG(RT_LOG_INFO, "Snapshot service stopped.");
    }
    threadId_.store(0);
    CloseResources();
}

void SnapshotService::CloseResources()
{
    if ((ownerPid_ == mmGetPid()) && (directoryFd_ >= 0) && socketBound_) {
        if ((unlinkat(directoryFd_, socketName_.c_str(), 0) != 0) && (errno != ENOENT)) {
            RT_LOG(RT_LOG_WARNING, "Remove snapshot socket failed, errno=%d.", errno);
        }
    }
    socketBound_ = false;
    if (listenFd_ >= 0) {
        (void)mmCloseSocket(listenFd_);
        listenFd_ = EN_ERROR;
    }
    if (stopFd_ >= 0) {
        (void)mmClose(stopFd_);
        stopFd_ = EN_ERROR;
    }
    if (directoryFd_ >= 0) {
        (void)mmClose(directoryFd_);
        directoryFd_ = EN_ERROR;
    }
}

void* SnapshotService::ThreadMain(void* arg)
{
    auto* service = static_cast<SnapshotService*>(arg);
    (void)mmSetCurrentThreadName("RT_SNAPSHOT");
    service->threadId_.store(mmGetTid());
    service->Run();
    return nullptr;
}

void SnapshotService::Run()
{
    while (!stopping_.load()) {
        if (!WaitSocketReady(listenFd_, POLLIN, stopFd_, -1)) {
            continue;
        }
        const int32_t connection = accept4(listenFd_, nullptr, nullptr, SOCK_CLOEXEC);
        if (connection < 0) {
            const int32_t acceptError = errno;
            if ((acceptError != EINTR) && (acceptError != EAGAIN) && (acceptError != EWOULDBLOCK)) {
                RT_LOG(RT_LOG_WARNING, "Accept snapshot connection failed, errno=%d.", acceptError);
            }
            if ((acceptError == EMFILE) || (acceptError == ENFILE) || (acceptError == ENOBUFS) ||
                (acceptError == ENOMEM)) {
                // Wait only for stop or the retry delay; the listener stays readable while resources are exhausted.
                (void)WaitSocketReady(EN_ERROR, 0, stopFd_, ACCEPT_RETRY_DELAY_MS);
            }
            continue;
        }
        const ScopeGuard connectionGuard([connection] { (void)mmCloseSocket(connection); });
        if (SetSocketTimeout(connection, IO_TIMEOUT_MS, IO_TIMEOUT_MS)) {
            HandleConnection(connection);
        }
    }
}

void SnapshotService::HandleConnection(int32_t fd)
{
    struct ucred peer = {};
    if (!CheckClientCredentials(fd, peer)) {
        RT_LOG(RT_LOG_WARNING, "Reject snapshot client credentials.");
        return;
    }
    SnapshotRequestHeader request = {};
    if (!ReceiveSocket(fd, &request, sizeof(request), stopFd_)) {
        if (!stopping_.load()) {
            RT_LOG(RT_LOG_WARNING, "Read snapshot request failed.");
        }
        return;
    }
    const uint32_t opValue = ntohl(request.op);
    const auto op = static_cast<rtSnapshotOp>(opValue);
    const uint32_t argsSize = ntohl(request.argsSize);
    if ((ntohl(request.magic) != SNAPSHOT_MAGIC) || (ntohl(request.version) != SNAPSHOT_VERSION) ||
        (opValue < static_cast<uint32_t>(rtSnapshotOp::LOCK)) ||
        (opValue > static_cast<uint32_t>(rtSnapshotOp::GET_RESTORE_THREAD_ID)) ||
        ((argsSize != 0U) && ((argsSize != sizeof(SnapshotMemoryArgs)) || !IsMemoryOp(op)))) {
        RT_LOG(
            RT_LOG_WARNING, "Invalid snapshot request, magic=%#x, version=%u, op=%u, argsSize=%u.",
            ntohl(request.magic), ntohl(request.version), opValue, argsSize);
        return;
    }
    SnapshotMemoryArgs args = {};
    if (argsSize != 0U) {
        if (!ReceiveSocket(fd, &args, sizeof(args), stopFd_)) {
            if (!stopping_.load()) {
                RT_LOG(RT_LOG_WARNING, "Read snapshot arguments failed, op=%u.", opValue);
            }
            return;
        }
        args.flags = ntohl(args.flags);
        if (args.flags > 1U) {
            RT_LOG(RT_LOG_WARNING, "Invalid snapshot flags, flags=%u.", args.flags);
            return;
        }
    }
    if (stopping_.load()) {
        return;
    }
    // A disconnected client does not cancel an RT operation that has already started.
    uint32_t value = 0U;
    const int32_t result = DispatchSnapshotRequest(op, argsSize == 0U ? nullptr : &args, value);
    RT_LOG(
        RT_LOG_DEBUG, "Snapshot request finished, op=" RT_ENUM_LOG_FORMAT("%u") ", result=%d.",
        RT_ENUM_LOG_VALUE(opValue, SnapshotOpToString(opValue)), result);
    const SnapshotResponse response = {
        htonl(SNAPSHOT_MAGIC), htonl(SNAPSHOT_VERSION), htonl(static_cast<uint32_t>(result)), htonl(value)};
    if (!SendSocket(fd, &response, sizeof(response), stopFd_) && !stopping_.load()) {
        RT_LOG(RT_LOG_WARNING, "Send snapshot response failed, op=%u.", opValue);
    }
}
rtError_t SnapshotService::DispatchSnapshotRequest(rtSnapshotOp op, const SnapshotMemoryArgs* args, uint32_t& value)
{
    switch (op) {
        case rtSnapshotOp::LOCK:
            return handler_->SnapShotProcessLock();
        case rtSnapshotOp::UNLOCK:
            return handler_->SnapShotProcessUnlock();
        case rtSnapshotOp::BACKUP: {
            if (args == nullptr) {
                return handler_->SnapShotProcessBackup(nullptr);
            }
            rtSnapShotBackupArgs localArgs = {};
            if (memcpy_s(&localArgs, sizeof(localArgs), args, sizeof(*args)) != EOK) {
                return RT_ERROR_SEC_HANDLE;
            }
            return handler_->SnapShotProcessBackup(&localArgs);
        }
        case rtSnapshotOp::RESTORE: {
            if (args == nullptr) {
                return handler_->SnapShotProcessRestore(nullptr);
            }
            rtSnapShotRestoreArgs localArgs = {};
            if (memcpy_s(&localArgs, sizeof(localArgs), args, sizeof(*args)) != EOK) {
                return RT_ERROR_SEC_HANDLE;
            }
            return handler_->SnapShotProcessRestore(&localArgs);
        }
        case rtSnapshotOp::GET_STATE: {
            rtProcessState state = RT_PROCESS_STATE_RUNNING;
            const rtError_t ret = handler_->SnapShotProcessGetState(&state);
            if (ret == RT_ERROR_NONE) {
                value = static_cast<uint32_t>(state);
            }
            return ret;
        }
        case rtSnapshotOp::GET_RESTORE_THREAD_ID: {
            int32_t tid = 0;
            const rtError_t ret = handler_->SnapShotProcessGetRestoreThreadId(&tid);
            if (ret == RT_ERROR_NONE) {
                value = static_cast<uint32_t>(tid);
            }
            return ret;
        }
        default:
            return RT_ERROR_INVALID_VALUE;
    }
}

} // namespace runtime
} // namespace cce
