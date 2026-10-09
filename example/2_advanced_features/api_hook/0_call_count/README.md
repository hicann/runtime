# 0_call_count

## 描述

工具开发者可以在单 Device 应用中临时统计 Runtime 接口的调用次数，同时保留接口原有行为。本样例对 Device 0 的一次查询安装 API Hook，验证计数为 1、返回的 Device ID 为 0；恢复原函数后再次查询，验证 Device ID 仍为 0 且计数不再增加。

样例在主线程串行完成安装、调用和恢复，不启动业务工作线程。请独立运行，避免与其他 API Hook 工具或 Profiling 同时使用；发现已有 Hook 时会报错退出。复用到多线程应用时，应先暂停相关接口的调用，待在途调用结束后再安装或恢复 Hook。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A2系列产品 | √ |
| Atlas A3系列产品 | √ |
| Ascend 950PR/Ascend 950DT | √ |

需使用提供上述 API Hook 接口的 CANN 版本，且 Runtime 构建需启用 API Hook。缺少接口或功能未启用时，构建或运行失败。

## 编译运行

环境准备和运行步骤请参见 [样例使用指导](../../../README.md)。样例使用逻辑 Device 0。

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化与去初始化：`aclInit` 进行初始化配置，`aclFinalize` 实现去初始化。
- Device 管理与结果校验：`aclrtSetDevice` 绑定 Device，`aclrtGetDevice` 查询当前 Device ID，`aclrtResetDeviceForce` 释放 Device 资源。
- API Hook 调用观测：`aclrtApiInjectionGetFunc` 读取并校验原始与当前函数指针，`aclrtApiInjectionSetFunc` 安装计数 Hook 并恢复原函数。

## 示例输出

成功时，Hook 内的一次调用使计数变为 1；恢复后的查询应保持计数为 1。失败时程序以非零退出码结束，不输出成功标记。

```text
[INFO]  Hook installed for aclrtGetDevice
[INFO]  Hooked call: device=0, hook count=1
[INFO]  Original function restored
[INFO]  Restored call: device=0, hook count=1
[INFO]  Run the call_count sample successfully.
```
