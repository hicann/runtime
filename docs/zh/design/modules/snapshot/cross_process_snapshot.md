# 跨进程 Snapshot

本文说明跨进程 Snapshot 的内部实现。接口参数、返回值、产品支持范围和调用示例参见[快照管理接口参考](../../../api_ref/21_snapshot_management.md)。下文 A 表示控制进程，B 表示目标进程。

## 调用方式

四个现有接口保留原签名，`pid` 表示目标进程 PID，必须为正数：

```c
aclrtSnapShotProcessLock(pid, NULL);
aclrtSnapShotProcessBackup(pid, args);
aclrtSnapShotProcessRestore(pid, args);
aclrtSnapShotProcessUnlock(pid, NULL);
```

`pid == 当前 PID` 走本地 RT 入口；其他 PID 通过本机 Unix Socket 请求目标进程的 `ApiImplSnapshot` 执行操作。控制进程不需要创建 Device 或 Context，也不会因远程请求或错误码转换而初始化自身 Runtime。目标 Runtime 必须已经初始化，且当前实现和芯片支持快照。

新增两个查询接口：

```c
aclError aclrtSnapshotProcessGetState(int pid, aclrtProcessState *state);
aclError aclrtSnapshotProcessGetRestoreThreadId(int pid, int *tid);
```

成功时才写出参。状态由全局状态管理器提供；线程 ID 返回执行快照操作的 Linux TID。本地查询经过 RT 入口的 Runtime 初始化与错误处理；芯片不支持时返回不支持，芯片已支持但服务尚未发布 TID、启动失败或已停止时，TID 查询返回内部运行错误并记录错误信息。

## 实现与调用链

```text
ACL 四操作/两个查询
  ├─ 本进程：RT C 入口 → ApiSnapshot → ApiImplSnapshot
  └─ 其他进程：SnapshotSocketCall
       → SnapshotSocketRequest → connect → SO_PEERCRED 校验 → 发送一条请求
       → B 的 SnapshotService 服务线程
       → SnapshotService::DispatchSnapshotRequest → SnapshotRequestHandler → ApiImplSnapshot
       → Snapshot 业务方法 / GlobalStateManager / Driver 处理
       → 返回内部 RT 错误码和查询值
       → A 的 SnapshotSocketCall 返回内部错误码 → ACL 入口转换为对外错误码
```

`feature/snapshot/snapshot_socket.cc` 集中实现客户端、公共收发、服务线程和命令分发，`feature/snapshot/snapshot_socket.hpp` 声明协议及服务对象。该实现编入公共库，A 无须加载目标芯片实现库或初始化自己的 Runtime 即可发起远程请求。服务通过 feature 定义的 `SnapshotRequestHandler` 调用 `ApiImplSnapshot` 中的共享业务流程，不依赖 API 目录的方法。原有 `ApiImplSnapshot` 实现整体放入 feature/snapshot，直接持有服务和回调表。Runtime 通过已有 `ApiSnapshot` 接口启动、停止服务。状态和 TID 查询同样由 feature 实现。传输返回内部 RT 错误码，由 ACL 入口统一转换，不为错误映射初始化控制进程的 Runtime。通用和 cmodel 的公共库及对应 UT 源列表登记该文件，v200/v201 复用公共库。tiny 和 arch5162 沿用 Snapshot 不支持的裁剪方式，不编入真实 Socket 实现；Socket 桩合并在已有 `api_impl_snapshot_stub.cc` 中，与 Snapshot 工厂桩一起只登记一次，为跨进程调用返回不支持，并提供不创建线程或 Socket 的生命周期桩。tiny 将合并桩编入公共库，arch5162 将其编入单库。

`ApiImplSnapshot` 直接持有 `SnapshotService` 和 `SnapshotCallbackManager`；Runtime 在 `Init()` 成功路径末尾调用已有 Snapshot API 对象的 `StartSnapshotService(GetChipType())`。Snapshot 功能检查芯片能力后启动服务；`mmCreateTask()` 成功后直接返回，不等待服务线程调度或 TID 就绪。服务线程先记录自身 Linux TID，再进入请求处理循环，因此远程查询被执行前 TID 已发布。本地查询可能遇到线程尚未发布 TID，此时返回现有服务不可用错误，失败时不修改出参。Runtime 初始化返回后，Keeper 才发布 `BOOT_DONE`。服务启动失败记录警告，Runtime 仍可完成初始化，本地接口保持可用，对应远程服务和 TID 查询不可用。

Runtime 自身的析构入口通过已有 Snapshot API 对象调用 `StopSnapshotService()` 停止服务；`Runtime::PrepareProcessExitNoThrow()` 也在设置 Runtime 退出状态和回收设备前停止服务，覆盖进程退出准备路径。Keeper 只负责 Runtime 的初始化和销毁，不管理 Snapshot 服务，也不在 `RuntimeIntf` 中暴露 Snapshot 生命周期接口。停止流程设置 `stopping_`、通过 eventfd 唤醒监听或收包等待、等待已开始的操作完成、join 线程，再清理 Socket 资源。回调管理器是 `ApiImplSnapshot` 成员，在服务停止前保持存活；成员声明顺序也保证服务成员先于回调管理器析构。Device Reset 不停止服务。

服务创建一个常驻线程，按连接串行处理请求；查询排在正在执行的操作之后，反映查询被执行时的进程状态，不提供任务进度或某次请求的完成凭据。`threadId_`、`stopping_` 和 `ownerPid_` 保留原子类型，分别用于共享 TID、停止状态和创建者身份。

实现面向 Linux Runtime 构建。通用 Socket 收发、连接、监听、线程创建与回收、PID/TID 查询使用 MMPA 的 `mm*` 接口。身份校验、停止通知、目录访问和带 CLOEXEC 标志的连接接收分别使用 `SO_PEERCRED`、`eventfd`、`open/openat/fstatat` 和 `accept4` 等系统接口。

## 参数与协议

一条连接只处理一条请求和一个响应，所有整数按网络字节序编码。

| 结构 | 字段 | 字节数 |
| --- | --- | --- |
| 请求头 SnapshotRequestHeader | magic、version、op、argsSize，均为 uint32_t | 16 |
| 可选参数体 | uint32_t flags、char reserved[60] | 64 |
| 响应 | magic、version、result、value，均为 uint32_t | 16 |

magic 为 `0x534E4150`，版本为 1，双端严格检查版本相等；当前不承诺未知高版本兼容。操作枚举为 `rtSnapshotOp`，命令依次为 Lock=1、Backup=2、Restore=3、Unlock=4、GetState=5、GetRestoreThreadId=6。协议及 ACL/RT 参数的尺寸、字段偏移和完整参数透传由 UT 校验。

远程 Backup/Restore 的 `args == NULL` 对应 argsSize=0，向 impl 传入空参数；非空参数对应 argsSize=64，完整传递 flags 和 reserved，并在分发时复制为 RT 参数结构体。flags 只接受 0/1。其他命令只接受 argsSize=0。ACL 公开入口校验 PID 和参数后，由内部客户端编码并发送请求；服务端独立校验外部连接收到的协议和参数。impl 与传输内部返回 `RT_ERROR_*`，响应将结果编码为网络序 uint32_t，客户端解码为 `rtError_t`，由 ACL 的 `CallRemoteSnapshot` 在公开入口边界转换成对外错误码，转换不依赖调用方 Runtime 初始化。

SendSocket/ReceiveSocket 循环收发完整报文，处理短读、短写和 EINTR。连接 Socket 为阻塞模式：客户端发送请求设置 SO_SNDTIMEO=5 秒，接收结果设置 SO_RCVTIMEO=0，不设固定操作结果超时；服务端收发协议报文保留 5 秒的单次收发超时。这些协议超时不限制 Backup/Restore 的总执行时间。服务线程通过 WaitSocketReady 同时等待 Socket 和停止 eventfd，空闲或等待半包时可被停止通知唤醒。客户端使用阻塞式 connect，失败直接返回错误。服务端 accept 遇到 FD 或内存资源耗尽时，等待 100 毫秒再重试，等待期间可被停止通知唤醒。监听 backlog 由 `SNAPSHOT_LISTEN_BACKLOG=8` 表示，不代表并行执行 8 个操作。每个请求最多 80 字节，使用固定大小的接收缓冲区。非法版本、命令或长度及截断请求不执行操作。客户端收到完整响应并校验 magic/version 后处理返回值，无需等待连接关闭。

客户端读取完整响应后关闭本端连接并返回，因此成功 Backup 返回后不保留控制连接。接口同步等待，不引入异步任务或任务 ID；目标一直不返回且连接保持时，调用线程会持续等待，可由应用工作线程发起调用。客户端断开或通信失败而收不到响应只表示结果未知，不表示 B 已取消操作，不能自动重发。已开始的操作继续执行并提交实际状态。

## 身份和路径

B 使用 `getpwuid_r(geteuid())` 查找系统账号配置的家目录，在 `<home>/.cann_snapshot/<pid>.sock` 监听。家目录和 `.cann_snapshot` 路径允许为符号链接，检查实际打开目录的属主和权限。私有目录权限为 0700，Socket 节点为 0600。A 根据 `/proc/<pid>/status` 的有效 UID 查找 B 的家目录；root 控制普通用户进程时同样使用 B 的家目录。

建联后双方检查内核提供的 `SO_PEERCRED`。B 允许自身有效 UID 或 UID=0；A 校验服务端 UID 和目标 PID。报文不传递可伪造的身份字段。实际打开的目录必须为对应用户所有、类型和权限正确。本进程成功绑定后，退出或后续初始化失败时按绑定路径清理 Socket 文件。fork 子进程不删除父进程的 Socket 文件。

首版支持相同 PID、user、mount 路径视图下的本机调用，不处理跨 namespace 的编号映射，不提供 TCP。无有效/可写家目录、Socket 路径过长、已有不合规目录等情况明确报错。

fork 子进程继承 FD 和内存，但不继承服务线程。继承对象检测创建者 PID，拒绝返回父进程 TID；清理子进程继承的 FD 时不 join 父线程、不删除父进程 Socket。fork 后直接复用父 Runtime 不在支持范围内。

## 并发和失败

远程请求由单个服务线程按连接串行执行；本地与远程操作均进入 `ApiImplSnapshot`，通过状态管理锁检查和更新状态。调用方负责协调本地调用与远程控制，避免并发操作同一目标进程；回调遵守“不在回调中调用 Runtime API”的约束。

Lock 先执行 LOCK_PRE 回调，再由 `GlobalStateManager::Locked()` 加锁校验并切换状态。服务按请求处理控制命令，不同控制方交替请求时均检查目标进程的当前状态。

| 状态 | 值 | 含义 |
| --- | --- | --- |
| RUNNING | 0 | 允许 Lock |
| LOCKED | 1 | 已锁定，允许 Backup/Unlock；Restore 成功后回到此状态 |
| BACKED_UP | 2 | 已备份，允许 Restore，保留原 Unlock 语义 |
| FAILED | 3 | Backup/Restore 执行失败，禁止继续操作 |

在 `ApiImplSnapshot` 中通过初始状态检查后，Backup/Restore 的 PRE 回调、资源 helper（包括其前置检查）或 POST 回调任一步失败，均由 impl 使用 `COND_PROC_RETURN_ERROR` 设置 FAILED 并返回原错误码，普通四操作拒绝继续。RT 入口的非法参数、芯片能力检查以及 impl 初始状态检查失败，在执行流程开始前返回。服务端的非法协议报文同样在分发前拒绝，不执行 Snapshot 操作。

OpMemoryRestore 使用对应 Device 的控制流执行恢复。回调在服务线程同步执行，使用服务线程自身的 TLS，并遵守“不在回调中调用 Runtime API”的契约。

## CRIU

外部编排工具按以下顺序调用：Lock → Backup 成功 → CRIU dump；CRIU restore 恢复 Host 和线程后 → 重新建联 Restore → Unlock。CRIU 负责 Host 进程和线程的备份恢复，Runtime 通过 Snapshot 接口完成 NPU 资源的备份恢复。
