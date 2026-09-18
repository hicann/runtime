# 4_capability_based_aggregation

## 描述

本样例面向需要在启动阶段适配不同硬件配置的数据统计业务。程序选择一个物理 Device，完成物理设备 ID 到用户可见设备 ID再到物理设备 ID 的往返校验，查询 Vector Core 数量并据此确定并行度，然后查询 Device 与 Host 之间对有符号 32 位原子加的支持能力。支持时，Kernel 通过映射 Host 内存直接原子汇总 8 类业务计数；不支持时，Kernel 在 Device 上生成分块结果，由 Host 完成最终汇总。两条路径都会将 1024 条记录的统计结果与 CPU 参考结果逐项比较。

`aclrtGetLogicDevIdByPhyDevId` 和 `aclrtGetPhyDevIdByLogicDevId` 接口名称中的逻辑设备 ID 参数实际表示用户设备 ID，本样例按接口文档中的实际语义使用。

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
cd ${git_clone_path}/example/1_basic_features/device/4_capability_based_aggregation
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3. 编译并运行样例。省略参数时使用用户设备 ID 0 对应的物理设备；也可以显式传入当前进程可见的物理设备 ID。

```bash
bash run.sh [physical_device_id]
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 选择与规格查询
    - 调用 `aclrtGetDeviceCount` 接口获取当前进程可见的 Device 数量。
    - 调用 `aclrtGetLogicDevIdByPhyDevId` 接口将物理设备 ID 映射为用户设备 ID。
    - 调用 `aclrtGetPhyDevIdByLogicDevId` 接口将用户设备 ID 反向映射为物理设备 ID，并校验往返结果。
    - 调用 `aclrtSetDevice` 接口指定用于计算的 Device。
    - 调用 `aclGetDeviceCapability` 接口查询 Vector Core 数量并确定 Kernel 并行度。
    - 调用 `aclrtDeviceGetHostAtomicCapabilities` 接口查询 Device 与 Host 之间的原子加能力，并选择直接原子汇总或分块汇总路径。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前 Device，回收 Device 上的资源。
- 内存与计算
    - 调用 `aclrtMalloc` 接口申请 Device 输入和分块结果内存。
    - 原子能力满足要求时，调用 `aclrtMallocHost`、`aclrtHostRegisterV2` 和 `aclrtHostGetDevicePointer` 接口准备映射 Host 输出内存。
    - 调用 `aclrtMemcpy` 接口传输输入或将分块结果复制回 Host。
    - 调用 `aclrtCreateStream` 和 `aclrtSynchronizeStream` 接口下发并等待 Kernel 计算。

## 示例输出

以下为 Host/Device 原子能力不满足有符号 32 位原子加要求时的输出，硬件规格、设备 ID 和能力掩码会随环境变化：

```text
[INFO]: Current compile soc version is ...
...
[INFO]  Start to run capability_based_aggregation sample.
[INFO]  ID round-trip: physical=... -> legacy logic (user)=0 -> physical=...
[INFO]  Vector Cores=..., aggregation blocks=8
[INFO]  Host/Device DMA_ADD capabilities=0x0, required int32 mask=0x21
[INFO]  Selected path: Device partials + Host sum
[INFO]  Category 0: actual=-15, expected=-15
...
[INFO]  Category 7: actual=-120, expected=-120
[INFO]  Verified 8 categories across 1024 records.
[INFO]  Run the capability_based_aggregation sample successfully.
```
