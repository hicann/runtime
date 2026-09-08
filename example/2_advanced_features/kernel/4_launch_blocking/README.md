# 4_launch_blocking

## 描述

本样例展示 Kernel Launch Blocking 功能的三类控制方式。样例通过 Notify 延迟释放目标流，并执行一个输出可校验的 Ascend C Kernel，检查 Kernel Launch 返回后的流状态和计算结果。

- 环境变量控制：分别以 `ASCEND_RT_LAUNCH_BLOCKING=0` 和 `ASCEND_RT_LAUNCH_BLOCKING=1` 启动进程，验证异步模式和同步模式。
- 流级三态控制：通过 `aclrtSetStreamAttribute` 设置 `DEFAULT`、`ASYNC` 和 `SYNC`，验证流属性对环境变量的继承或覆盖。
- 异步执行范围：在同步模式下嵌套调用 `aclrtNonBlockingLaunchBegin` 和 `aclrtNonBlockingLaunchEnd`。两个接口之间 Kernel 保持异步模式，内层 `End` 不执行同步等待，最外层 `End` 同步流并恢复后续 Kernel 的同步模式。

`run.sh` 会构建一次样例，并为不同环境变量配置分别启动新进程。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件 | √ |
| Ascend 950PR/Ascend 950DT | √ |

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
| `non-blocking-section` | `1` | 嵌套范围内保持异步模式，最外层 `End` 同步，结束后恢复同步模式 |

## CANN Runtime API

- `aclrtSetStreamAttribute`、`aclrtGetStreamAttribute`：设置和查询 `ACL_STREAM_LAUNCH_BLOCKING_MODE` 流属性。
- `aclrtNonBlockingLaunchBegin`、`aclrtNonBlockingLaunchEnd`：标记指定流上相关接口异步执行的起始点和结束点。
- `aclrtLaunchKernel`：下发自定义 Kernel。
- `aclrtCreateNotify`、`aclrtWaitAndResetNotify`、`aclrtRecordNotify`：构造可控的流等待关系。
- `aclrtStreamQuery`：检查 Kernel Launch 或异步执行范围相关接口返回后的流状态。
- `aclrtSynchronizeStreamWithTimeout`：等待异步 Kernel 执行完成。

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

样例以 Notify 构造确定性的等待关系，并以流状态和输出结果作为通过条件，日志中的耗时仅用于观察。
