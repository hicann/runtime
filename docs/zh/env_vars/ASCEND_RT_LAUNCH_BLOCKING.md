# ASCEND\_RT\_LAUNCH\_BLOCKING

## 功能描述

控制Kernel Launch和模型执行任务采用同步模式或异步模式，可用于算子调试场景。

取值为：

- 0：关闭。接口采用异步模式，完成任务下发后返回，不等待任务执行完成。
- 1：开启。以下接口采用同步模式，任务执行完成后返回：
    - aclrtLaunchKernel
    - aclrtLaunchKernelV2
    - aclrtLaunchKernelWithConfig
    - aclrtLaunchKernelWithHostArgs
    - aclrtLaunchKernelWithArgsArray
    - aclrtLaunchSIMTKernelWithArgsArray
    - aclrtLaunchSIMTKernelWithHostArgs
    - aclmdlRIExecuteAsync
- 其他值：与配置为0时相同。

>**须知：**
>
>- 该环境变量默认关闭。未配置或配置为空时，与配置为0时相同。
>- 开启后，较早版本的算子可能未适配本功能。如果算子中已下发的任务依赖尚未下发的任务，接口同步等待会导致后续任务无法继续下发，可能发生死锁。
>- 上述场景可在存在依赖关系的任务下发前调用[aclrtNonBlockingLaunchBegin](../api_ref/06_stream_management.md#aclrtNonBlockingLaunchBegin)，任务下发完成后调用[aclrtNonBlockingLaunchEnd](../api_ref/06_stream_management.md#aclrtNonBlockingLaunchEnd)；也可调用[aclrtSetStreamAttribute](../api_ref/06_stream_management.md#aclrtSetStreamAttribute)，将stmAttrType设置为ACL_STREAM_LAUNCH_BLOCKING_MODE，并将launchBlockingMode设置为ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING。
>- 对于调用aclrtCreateStreamWithConfig接口，将flag设置为ACL_STREAM_PERSISTENT、ACL_STREAM_CPU_SCHEDULE或ACL_STREAM_DEVICE_USE_ONLY创建的Stream，本功能不生效。

## 配置示例

```bash
export ASCEND_RT_LAUNCH_BLOCKING=1
```

## 使用约束

- 该环境变量不支持动态修改。调用任意Runtime接口前需完成配置，Runtime初始化后修改不生效。
- 开启该环境变量可能会影响业务性能，建议仅在算子调试场景下使用。

<!-- npu="950,A3,910b" id1 -->
## 支持的型号

<!-- npu="950" id2 -->
Ascend 950PR/Ascend 950DT
<!-- end id2 -->

<!-- npu="A3" id3 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id3 -->

<!-- npu="910b" id4 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id4 -->
<!-- end id1 -->
