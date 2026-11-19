# Cross-Process Snapshot

This document describes the internal implementation of cross-process Snapshot. For interface parameters, return values, product support scope, and usage examples, see [Snapshot Management Interface Reference](../../../api_ref/21_snapshot_management.md). In this document, A indicates the control process and B indicates the target process.

## Invocation Methods

The four existing interfaces keep their original signatures. `pid` indicates the target process PID and must be a positive number:

```c
aclrtSnapShotProcessLock(pid, NULL);
aclrtSnapShotProcessBackup(pid, args);
aclrtSnapShotProcessRestore(pid, args);
aclrtSnapShotProcessUnlock(pid, NULL);
```

When `pid == the current PID`, the call uses the local RT entry. For other PIDs, the call requests the target process `ApiImplSnapshot` to perform the operation through a local Unix Socket. The control process does not need to create a Device or Context. It does not initialize its own Runtime for remote requests or error code conversion. The target Runtime must already be initialized, and the current implementation and the chip must support snapshots.

Two query interfaces are added:

```c
aclError aclrtSnapshotProcessGetState(int pid, aclrtProcessState *state);
aclError aclrtSnapshotProcessGetRestoreThreadId(int pid, int *tid);
```

Output parameters are written only on success. The global state manager provides the state. The thread ID returns the Linux TID that performs the snapshot operation. A local query goes through the Runtime initialization and error handling of the RT entry. When the chip does not support snapshots, the query returns not supported. When the chip supports snapshots but the service has not published a TID, failed to start, or has stopped, the TID query returns an internal runtime error and records error information.

## Implementation and Call Chain

```text
ACL four operations / two queries
  ├─ Current process: RT C entry → ApiSnapshot → ApiImplSnapshot
  └─ Other processes: SnapshotSocketCall
       → SnapshotSocketRequest → connect → SO_PEERCRED validation → send one request
       → SnapshotService service thread of B
       → SnapshotService::DispatchSnapshotRequest → SnapshotRequestHandler → ApiImplSnapshot
       → Snapshot business methods / GlobalStateManager / Driver processing
       → Return the internal RT error code and the query value
       → SnapshotSocketCall of A returns the internal error code → The ACL entry converts it to the external error code
```

`feature/snapshot/snapshot_socket.cc` centrally implements the client, common send and receive, the service thread, and command dispatch. `feature/snapshot/snapshot_socket.hpp` declares the protocol and service objects. This implementation is compiled into the common library. A can initiate remote requests without loading the target chip implementation library or initializing its own Runtime. The service calls the shared business flow in `ApiImplSnapshot` through the `SnapshotRequestHandler` defined by the feature. It does not depend on methods in the API directory. The original `ApiImplSnapshot` implementation is moved entirely into feature/snapshot and directly holds the service and the callback table. Runtime starts and stops the service through the existing `ApiSnapshot` interface. The feature also implements the state and TID queries. The transport returns internal RT error codes, and the ACL entry converts them uniformly. Error mapping does not initialize the Runtime of the control process. The common library and the corresponding UT source lists for the general and cmodel builds register this file. v200/v201 reuse the common library. tiny and arch5162 follow the existing tailoring approach that does not support Snapshot and do not compile the real Socket implementation. The Socket stub is merged into the existing `api_impl_snapshot_stub.cc`. It is registered only once together with the Snapshot factory stub. It returns not supported for cross-process calls and provides lifecycle stubs that do not create threads or Sockets. tiny compiles the merged stub into the common library, and arch5162 compiles it into the single library.

`ApiImplSnapshot` directly holds `SnapshotService` and `SnapshotCallbackManager`. At the end of the `Init()` success path, Runtime calls `StartSnapshotService(GetChipType())` on the existing Snapshot API object. The Snapshot feature checks the chip capability and then starts the service. `mmCreateTask()` returns directly after it succeeds. It does not wait for the service thread to be scheduled or for the TID to be ready. The service thread records its own Linux TID first and then enters the request processing loop. Therefore, the TID is published before a remote query is executed. A local query may find that the thread has not published the TID. In this case, the query returns the existing service-unavailable error. On failure, the output parameters are not modified. After Runtime initialization returns, Keeper publishes `BOOT_DONE`. If service startup fails, the system records a warning. Runtime can still complete initialization, and local interfaces remain available. The corresponding remote service and TID query are unavailable.

The Runtime destructor entry stops the service by calling `StopSnapshotService()` on the existing Snapshot API object. `Runtime::PrepareProcessExitNoThrow()` also stops the service before it sets the Runtime exit state and reclaims devices. This call covers the process exit preparation path. Keeper is responsible only for Runtime initialization and destruction. It does not manage the Snapshot service and does not expose Snapshot lifecycle interfaces in `RuntimeIntf`. The stop flow sets `stopping_`, wakes up the listening or receive wait through eventfd, waits for started operations to complete, joins the thread, and then cleans up Socket resources. The callback manager is a member of `ApiImplSnapshot` and stays alive until the service stops. The member declaration order also ensures that service members are destroyed before the callback manager. Device Reset does not stop the service.

The service creates one resident thread and processes requests serially by connection. A query is queued after the operation in progress. It reflects the process state when the query is executed. It does not provide task progress or a completion credential for a request. `threadId_`, `stopping_`, and `ownerPid_` keep atomic types for the shared TID, the stop state, and the creator identity.

The implementation targets Linux Runtime builds. Common Socket send and receive, connection, listening, thread creation and reclaim, and PID/TID queries use the `mm*` interfaces of MMPA. Identity validation, stop notification, directory access, and connection acceptance with the CLOEXEC flag use system interfaces such as `SO_PEERCRED`, `eventfd`, `open/openat/fstatat`, and `accept4`.

## Parameters and Protocol

One connection processes only one request and one response. All integers are encoded in network byte order.

| Structure | Field | Bytes |
| --- | --- | --- |
| Request header SnapshotRequestHeader | magic, version, op, argsSize, all uint32_t | 16 |
| Optional parameter body | uint32_t flags, char reserved[60] | 64 |
| Response | magic, version, result, value, all uint32_t | 16 |

The magic value is `0x534E4150`, and the version is 1. Both ends strictly check that the versions are equal. The current implementation does not promise compatibility with unknown higher versions. The operation enumeration is `rtSnapshotOp`. The commands are Lock=1, Backup=2, Restore=3, Unlock=4, GetState=5, and GetRestoreThreadId=6. UT verifies the protocol and the size, field offset, and complete parameter pass-through of ACL/RT parameters.

For remote Backup/Restore, `args == NULL` corresponds to argsSize=0 and passes empty parameters to impl. Non-empty parameters correspond to argsSize=64, pass flags and reserved completely, and are copied into the RT parameter structure during dispatch. flags accepts only 0 or 1. Other commands accept only argsSize=0. After the ACL public entry validates the PID and parameters, the internal client encodes and sends the request. The server independently validates the protocol and parameters received on the external connection. impl and the transport return `RT_ERROR_*` internally. The response encodes the result as a network-order uint32_t, and the client decodes it as `rtError_t`. `CallRemoteSnapshot` in ACL converts it to the external error code at the public entry boundary. The conversion does not depend on caller Runtime initialization.

SendSocket/ReceiveSocket send and receive complete messages in a loop. They handle short reads, short writes, and EINTR. The connected Socket uses blocking mode. The client sets SO_SNDTIMEO=5 seconds when it sends a request and sets SO_RCVTIMEO=0 when it receives the result. It does not set a fixed timeout for the operation result. The server keeps a 5-second single send/receive timeout for protocol messages. These protocol timeouts do not limit the total execution time of Backup/Restore. The service thread uses WaitSocketReady to wait for both the Socket and the stop eventfd. A stop notification can wake it when it is idle or waiting for half a packet. The client uses a blocking connect and returns an error directly on failure. When accept on the server encounters FD or memory resource exhaustion, the server waits 100 milliseconds and retries. A stop notification can wake it during the wait. `SNAPSHOT_LISTEN_BACKLOG=8` represents the listen backlog. It does not mean that 8 operations run in parallel. Each request is at most 80 bytes and uses a fixed-size receive buffer. Invalid versions, commands, or lengths and truncated requests do not perform operations. After the client receives the complete response and validates magic/version, it processes the return value. It does not need to wait for the connection to close.

The client closes its connection and returns after it reads the complete response. Therefore, no control connection is retained after a successful Backup returns. The interface waits synchronously and does not introduce asynchronous tasks or task IDs. If the target never returns and the connection stays open, the calling thread keeps waiting. The application work thread can initiate the call. If the client disconnects or communication fails and no response arrives, it means only that the result is unknown. It does not mean that B canceled the operation, and automatic resending is not allowed. A started operation continues to execute and commits its actual state.

## Identity and Paths

B uses `getpwuid_r(geteuid())` to look up the home directory configured for the system account and listens on `<home>/.cann_snapshot/<pid>.sock`. The home directory and the `.cann_snapshot` path may be symbolic links. B checks the owner and permissions of the directory that is actually opened. The private directory permission is 0700, and the Socket node permission is 0600. A looks up the home directory of B using the effective UID from `/proc/<pid>/status`. When root controls a normal user process, A also uses the home directory of B.

After the connection is established, both ends check the `SO_PEERCRED` provided by the kernel. B allows its own effective UID or UID=0. A validates the server UID and the target PID. Messages do not carry forgeable identity fields. The directory that is actually opened must be owned by the corresponding user and have the correct type and permissions. If an existing endpoint conflicts, startup fails and the existing file is not deleted. After the current process binds successfully, it cleans up the Socket file by bind path on exit or on later initialization failure. A forked child process does not delete the Socket file of the parent process.

The first version supports local calls in the same PID, user, and mount path view. It does not handle number mapping across namespaces and does not provide TCP. It reports explicit errors for a missing or non-writable home directory, an overlong Socket path, an existing non-compliant directory, and similar conditions.

A forked child process inherits FDs and memory but does not inherit the service thread. Inherited objects check the creator PID and refuse to return the parent process TID. When the child process cleans up inherited FDs, it does not join the parent thread and does not delete the parent process Socket. Reusing the parent Runtime directly after fork is out of the supported scope.

## Concurrency and Failures

A single service thread executes remote requests serially by connection. Both local and remote operations enter `ApiImplSnapshot` and use the state management lock to check and update the state. The caller coordinates local calls and remote control to avoid concurrent operations on the same target process. Callbacks follow the constraint of not calling Runtime APIs inside a callback.

Lock first runs the LOCK_PRE callback. Then `GlobalStateManager::Locked()` performs the lock validation and switches the state. The service processes control commands by request. When different controllers send requests in turn, each request checks the current state of the target process.

| State | Value | Meaning |
| --- | --- | --- |
| RUNNING | 0 | Allow Lock |
| LOCKED | 1 | Locked. Allow Backup/Unlock. Return to this state after a successful Restore |
| BACKED_UP | 2 | Backed up. Allow Restore. Keep the original Unlock semantics |
| FAILED | 3 | Backup/Restore failed. Further operations are prohibited |

After the initial state check passes in `ApiImplSnapshot`, if any step of the Backup/Restore PRE callback, the resource helper (including its prerequisite check), or the POST callback fails, impl uses `COND_PROC_RETURN_ERROR` to set FAILED and returns the original error code. The normal four operations are then rejected. Invalid parameters at the RT entry, chip capability checks, and impl initial state check failures return before the execution flow starts. The server also rejects invalid protocol messages before dispatch and does not perform Snapshot operations.

OpMemoryRestore performs restoration using the control flow of the corresponding Device. Callbacks run synchronously in the service thread and use the TLS of the service thread itself. They follow the contract of not calling Runtime APIs inside a callback.

## CRIU

The external orchestration tool calls in the following order: Lock → successful Backup → CRIU dump; after CRIU restore restores the Host and threads → reconnect and Restore → Unlock. CRIU handles the backup and restoration of the Host process and threads. Runtime completes the backup and restoration of NPU resources through the Snapshot interfaces.
