# 17_configured_allocation

## 描述

本样例面向需要按应用模块管理传输缓冲区的数据暂存场景，在单 Device 上为 1024 个确定的 32 位整数完成 Host → 配置分配的 Device 缓冲区 → 支持 Cache 缓存的 Device 缓冲区 → Host 的往返传输。Host 和暂存 Device 内存使用应用模块 ID 33 进行配置分配，便于维测时定位应用内存。

样例根据查询到的内存位置选择复制方向，并在传输前确认两个 Device 缓冲区均为普通 Device 内存。带同步的释放操作等待异步任务完成后回收输入和缓存缓冲区，回传数据逐元素校验；只有数据校验及全部清理均成功才输出成功标记。当前版本不需要用户处理 CPU 与 NPU 之间的 Cache 一致性。

## 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Atlas A2系列产品 | √ |
| Atlas A3系列产品 | √ |
| Ascend 950PR/Ascend 950DT | √ |

## 编译运行

参见 [样例使用指导](../../../README.md#运行样例)，切换到本样例目录后执行 `bash run.sh`。需要安装包含下列接口的 CANN 软件包；本样例使用 Device 0。

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于传输的 Device。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前 Device，回收资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建异步传输 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待清理前的剩余任务完成。
    - 调用 `aclrtDestroyStreamForce` 接口强制销毁 Stream。
- 内存配置分配
    - 调用 `aclrtMallocHostWithCfg` 接口申请带应用模块 ID 配置的锁页 Host 内存。
    - 调用 `aclrtMallocWithCfg` 接口申请带应用模块 ID 配置的 Device 暂存内存，使用普通页分配策略。
    - 调用 `aclrtMallocCached` 接口申请支持 Cache 缓存的 Device 中转内存。
- 内存识别与数据传输
    - 调用 `aclrtCheckMemType` 接口检查两个 Device 地址是否均匹配 `ACL_RT_MEM_TYPE_DEV`；返回的匹配结果为 1 才继续传输。
    - 调用 `aclrtPointerGetAttributes` 接口查询内存位置、Device ID 和页表大小，根据内存位置选择复制方向，并拒绝其他 Device 的内存。
    - 调用 `aclrtMemcpyAsync` 接口完成 Host 到 Device、Device 到 Device 及 Device 到 Host 的异步传输。
- 同步释放
    - 调用 `aclrtFreeHostWithDevSync` 接口等待上传完成并释放输入 Host 内存，以及在清理时释放输出 Host 内存。
    - 调用 `aclrtFreeWithDevSync` 接口等待回传完成并释放缓存 Device 内存，以及在清理时释放配置分配的 Device 内存。

## 示例输出

运行成功后会输出内存类型检查、按内存属性选择的传输方向、同步释放以及 1024 个元素的校验结果。页表大小随运行环境变化。

```text
Configuring CMake...
...
Building...
...
[INFO]  Configured Host and staging buffers: 4096 bytes, application module ID 33
[INFO]  Verified both Device buffers match ACL_RT_MEM_TYPE_DEV
[INFO]  Selected Host -> Device from pointer attributes (source page ..., destination page ...)
[INFO]  Released Host input after implicit Device synchronization
[INFO]  Selected Device -> Device from pointer attributes (source page ..., destination page ...)
[INFO]  Selected Device -> Host from pointer attributes (source page ..., destination page ...)
[INFO]  Released cached Device buffer after implicit Device synchronization
[INFO]  Verified 1024 elements after Host -> configured Device -> cached Device -> Host
[INFO]  [SUCCESS] Configured allocation sample completed successfully
```
