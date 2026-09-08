# 4_launch_blocking

## 描述

本样例展示如何使用 Kernel Launch Blocking 控制 Kernel Launch 的同步或异步行为，包括进程级默认策略、流级策略和临时非阻塞区间。

- 环境变量控制：分别以 `ASCEND_RT_LAUNCH_BLOCKING=0` 和 `ASCEND_RT_LAUNCH_BLOCKING=1` 启动进程，验证异步模式和同步模式。
- 流级三态控制：通过 `aclrtSetStreamAttribute` 设置 `ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV`、`ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING` 和 `ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING`，验证流属性对环境变量的继承或覆盖。
- 临时非阻塞区间：在同步模式下嵌套调用 `aclrtNonBlockingLaunchBegin` 和 `aclrtNonBlockingLaunchEnd`，区间内的 Kernel Launch 保持异步。

样例通过 Notify 延迟释放目标流，并执行一个输出可校验的 Ascend C Kernel。样例根据 Kernel Launch 返回后的流状态和计算结果判断控制策略是否生效，执行耗时仅用于观察。`run.sh` 会构建一次样例，并为不同环境变量配置分别启动新进程。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/4_launch_blocking
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh
```

3. 执行以下命令构建并运行全部场景。

```bash
bash run.sh
```

环境变量在 Runtime 初始化时读取，因此不能在同一进程内切换。不要在执行 `run.sh` 前固定导出 `ASCEND_RT_LAUNCH_BLOCKING`，脚本会为每个场景单独设置该变量。

## 场景说明

| 场景 | 环境变量 | 预期行为 |
| --- | --- | --- |
| `env-control` | `0` | Kernel Launch 异步返回，显式同步后结果正确 |
| `env-control` | `1` | Kernel Launch 等待流完成后返回，结果正确 |
| `stream-mode` | `0` 和 `1` | `CTRL_BY_ENV` 跟随环境变量，`NON_BLOCKING` 强制异步，`BLOCKING` 强制同步 |
| `non-blocking-section` | `1` | 嵌套区间内保持异步，内层 `End` 不同步，最外层 `End` 恢复同步策略并等待流完成 |

## 控制规则及注意事项

Kernel Launch 是否阻塞按以下优先级决定：

1. 流处于 `aclrtNonBlockingLaunchBegin` 和 `aclrtNonBlockingLaunchEnd` 标记的非阻塞区间时，Kernel Launch 保持异步。
2. 流属性为 `ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING` 或 `ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING` 时，流属性覆盖环境变量。
3. 流属性为 `ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV` 时，执行策略由 `ASCEND_RT_LAUNCH_BLOCKING` 决定。

使用时请注意：

- `ASCEND_RT_LAUNCH_BLOCKING` 在 Runtime 初始化时读取，修改后需要重新启动进程才能生效。
- `aclrtNonBlockingLaunchBegin` 和 `aclrtNonBlockingLaunchEnd` 必须在同一条 Stream 上配对调用，`flag` 是保留参数，必须传入 `0`。
- 非阻塞区间支持嵌套。内层 `End` 只减少嵌套层数；最外层 `End` 退出非阻塞区间，并在恢复后的策略要求同步时等待流完成。
- 接口参数 `stream` 为 `nullptr` 时表示当前 Context 的默认流。
- 模型流、绑定流、Capture 阶段的流及部分特殊流不支持流级 Launch Blocking 控制。
- 本样例演示普通 Stream 上的 `aclrtLaunchKernel`。异步内存复制和 Event 等接口不会因为该功能自动变为同步调用。

## CANN RUNTIME API

在该 Sample 中，涉及的关键功能点及其关键接口如下：

- 初始化与 Device 管理
  - `aclInit` / `aclFinalize`
  - `aclrtSetDevice` / `aclrtResetDevice`
- Stream 与 Launch Blocking 控制
  - `aclrtCreateStream` / `aclrtDestroyStream`
  - `aclrtSetStreamAttribute` / `aclrtGetStreamAttribute`
  - `aclrtNonBlockingLaunchBegin` / `aclrtNonBlockingLaunchEnd`
  - `aclrtStreamQuery` / `aclrtSynchronizeStreamWithTimeout`
- Kernel 加载与执行
  - `aclrtBinaryLoadFromFile` / `aclrtBinaryGetFunction` / `aclrtBinaryUnLoad`
  - `aclrtLaunchKernel`
- Notify 控制
  - `aclrtCreateNotify` / `aclrtWaitAndResetNotify`
  - `aclrtRecordNotify` / `aclrtDestroyNotify`
- 内存管理与数据传输
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy` / `aclrtMemset`

## 示例输出

```text
========== ASCEND_RT_LAUNCH_BLOCKING=0, scenario=env-control ==========
[ENV] ASCEND_RT_LAUNCH_BLOCKING=0
[STATUS] environment control: NOT_READY
[PASS] environment control
[SUCCESS] env-control
...
========== ASCEND_RT_LAUNCH_BLOCKING=1, scenario=non-blocking-section ==========
[STATUS] inside nested section: NOT_READY
[STATUS] after inner end: NOT_READY
[STATUS] after outer end: COMPLETE
[PASS] nested non-blocking section
[STATUS] blocking restored after outer end: COMPLETE
[SUCCESS] non-blocking-section
All launch blocking scenarios passed.
```
