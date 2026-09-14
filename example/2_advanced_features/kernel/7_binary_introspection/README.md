# 7_binary_introspection

## 描述

本样例面向需要在加载后检查自定义 Kernel 元数据的单 Device 应用。样例从 Host 内存创建并加载一个包含具名 Device 全局变量的 Ascend C Kernel 二进制，验证 Binary 与 Function 的关联关系、函数参数布局、AI Core/Vector Core 代码段大小、动态 UB 大小和二进制 Device 地址，并通过写入后读回的方式校验全局变量地址有效。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/7_binary_introspection
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. 编译并运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化与去初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定加载二进制的 Device。
    - 调用 `aclrtResetDeviceForce` 接口复位 Device 并回收相关资源。
- Binary 生命周期
    - 调用 `aclrtCreateBinary` 接口使用 Host 内存中的二进制数据创建描述对象。
    - 调用 `aclrtBinaryLoad` 接口解析二进制并加载到当前 Context 对应的 Device。
    - 调用 `aclrtBinaryUnLoad` 接口在同一 Context 中卸载二进制。
    - 调用 `aclrtDestroyBinary` 接口销毁 Binary 描述对象；原始 Host 内存仍由应用管理。
- Binary 元数据
    - 调用 `aclrtBinaryGetDevAddress` 接口获取已加载二进制的 Device 地址和大小。
    - 调用 `aclrtBinaryGetGlobal` 接口按名称获取 Device 全局变量地址和大小。
- Function 元数据
    - 调用 `aclrtBinaryGetFunction` 接口按名称获取 Kernel 函数句柄。
    - 调用 `aclrtFunctionGetBinary` 接口从函数句柄反查所属 Binary。
    - 调用 `aclrtFunctionGetParamCount` 接口查询 Kernel 参数数量。
    - 调用 `aclrtFunctionGetParamInfo` 接口逐项查询参数偏移和大小。
    - 调用 `aclrtGetFunctionSize` 接口查询 AI Core 和 Vector Core 代码段大小。
    - 调用 `aclrtFunctionGetAvailDynUbufPerBlock` 接口查询每个 Block 的可用动态 UB；本样例使用非 SIMT Kernel，预期返回 0。
- 全局变量验证
    - 调用 `aclrtMemcpy` 接口向全局变量写入探测值并读回校验。

## 示例输出

```text
[INFO]  Start to run the 7_binary_introspection sample.
[INFO]  Loaded ... binary bytes from Host memory.
[INFO]  Parameter[0]: offset=0, size=8.
[INFO]  Parameter[1]: offset=8, size=8.
[INFO]  Parameter[2]: offset=16, size=4.
[INFO]  Function code size: aic=... bytes, aiv=... bytes; dynamic UB=0 bytes.
[INFO]  Binary Device image: address=..., size=... bytes.
[INFO]  Verified Device global g_binary_metadata_value: size=... bytes, value=0x13572468.
[INFO]  Run the 7_binary_introspection sample successfully.
```
