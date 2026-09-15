# 3_device_identity_mapping

## 描述

本样例面向容器、虚拟化和调度系统识别 Device 的场景，枚举用户可见 Device，查询 UUID，并验证用户设备 ID 与逻辑设备 ID、物理设备 ID 之间的双向映射一致性。对于 PCIe 互连设备，样例还会通过 PCI Bus ID 反查用户设备 ID 并校验 round-trip；非 PCIe 互连形态返回 `ACL_ERROR_RT_FEATURE_NOT_SUPPORT` 时，样例会明确记录并跳过 PCI 发现，其他错误仍判定为失败。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装详情以及通用运行步骤请见 example 目录下的 [README](../../../README.md)。

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 枚举
    - 调用 `aclrtGetDeviceCount` 接口获取用户可见 Device 数量。
- Device 唯一标识查询
    - 版本要求：CANN 9.2.0-beta.2 及以上版本，并配套 Ascend HDK 25.5.5 及以上版本。
    - 调用 `aclrtDeviceGetUuid` 接口获取 Device 的 UUID。
    - 调用 `aclrtDeviceGetPCIBusId` 接口获取 Device 的 PCI Bus ID；非 PCIe 互连形态返回特性不支持时明确跳过 PCI 发现。
    - 调用 `aclrtDeviceGetByPCIBusId` 接口通过 PCI Bus ID 反查用户设备 ID，并校验与原 ID 一致。
- Device ID 映射
    - 调用 `aclrtGetLogicDevIdByUserDevId` 接口将用户设备 ID 映射为逻辑设备 ID。
    - 调用 `aclrtGetUserDevIdByLogicDevId` 接口将逻辑设备 ID 反向映射为用户设备 ID。
    - 调用 `aclrtGetPhyDevIdByUserDevId` 接口将用户设备 ID 映射为物理设备 ID。
    - 调用 `aclrtGetUserDevIdByPhyDevId` 接口将物理设备 ID 反向映射为用户设备 ID。

## 示例输出

```text
[INFO]  Start to run device_identity_mapping sample.
[INFO]  Device ID mapping: user=0, logic=..., physical=...
[INFO]  UUID: ...
[WARN]  Skip PCI discovery for user Device 0: the current interconnect is not PCIe.
[INFO]  Device ID mapping: user=1, logic=..., physical=...
[INFO]  UUID: ...
[WARN]  Skip PCI discovery for user Device 1: the current interconnect is not PCIe.
[INFO]  Enumerated 2 user-visible Device(s); PCI discovery skipped for 2 Device(s).
[INFO]  Run the device_identity_mapping sample successfully.
```
