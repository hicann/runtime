# aclrtBinaryGetFunctionCount 示例

本示例演示如何使用 `aclrtBinaryGetFunctionCount` 接口查询算子二进制文件中包含的核函数数量，并基于该数量完成后续的核函数获取、信息查询、任务下发和结果验证的完整流程。

示例将 `add_custom`、`sub_custom` 和 `mul_custom` 三个 AscendC 核函数编译到同一个独立算子二进制文件中，然后按以下步骤执行：

1. **查询核函数数量**：调用 `aclrtBinaryGetFunctionCount` 获取二进制中的核函数总数。
2. **按名称获取核函数句柄**：已知核函数名称，调用 `aclrtBinaryGetFunction` 逐个获取对应的核函数句柄。
3. **查询核函数信息**：调用 `aclrtGetFunctionName` 获取核函数名称，调用 `aclrtGetFunctionAddr` 获取核函数在 Device 上的代码地址。
4. **准备输入数据**：分配 Host 和 Device 内存，将 FP16 格式的输入数据拷贝到 Device。
5. **下发执行并验证**：调用 `aclrtLaunchKernelWithHostArgs` 分别下发三个核函数，同步等待执行完成后将结果拷贝回 Host 并校验。

## 目录

```text
3_binary_get_function_count/
├── CMakeLists.txt
├── kernel/
│   └── custom.cpp
├── main.cpp
├── README.md
├── README_en.md
└── run.sh
```

三个 Device Kernel 位于 `kernel/custom.cpp`。

## 环境准备

Runtime 默认安装在 `/home/developer/Ascend/cann`。运行前需要同时具备 AscendC 编译工具；仅安装 Runtime 包时可能不存在 `ascendc.cmake`。

在 Runtime 仓库中可以执行：

```bash
source /home/developer/Ascend/cann/set_env.sh
source /mnt/workspace/runtime/example/set_sample_env.sh
```

也可以手工设置：

```bash
export ASCEND_HOME_PATH=/home/developer/Ascend/cann
export SOC_VERSION=Ascend910B1
```

`SOC_VERSION` 需要替换为实际设备型号。

## 编译运行

```bash
cd /mnt/workspace/runtime/example/2_advanced_features/kernel/3_binary_get_function_count
bash run.sh
```

成功时可看到类似输出：

```text
[STEP 1] Querying the number of kernel functions in the binary
[INFO] aclrtBinaryGetFunctionCount returned 3 functions
[STEP 2] Getting function handles by name
[STEP 3] Querying function names and addresses
[INFO] function[0]: name=add_custom, handle=..., aic=..., aiv=...
[INFO] function[1]: name=sub_custom, handle=..., aic=..., aiv=...
[INFO] function[2]: name=mul_custom, handle=..., aic=..., aiv=...
[STEP 4] Preparing input data
[STEP 5] Launching kernels and verifying results
[INFO] add_custom result verified
[INFO] sub_custom result verified
[INFO] mul_custom result verified
[SUCCESS] aclrtBinaryGetFunctionCount sample passed
```

## 关键接口说明

- `aclrtBinaryLoadFromFile`：从文件加载并解析算子二进制文件，输出 binHandle。
- `aclrtBinaryGetFunctionCount`：获取算子二进制中核函数句柄的总数。
- `aclrtBinaryGetFunction`：根据核函数名称获取对应的核函数句柄。
- `aclrtGetFunctionName`：根据核函数句柄获取核函数名称。
- `aclrtGetFunctionAddr`：根据核函数句柄获取 Device 侧算子起始地址。
- `aclrtLaunchKernelWithHostArgs`：下发 Kernel 计算任务，Host 侧参数在调用时自动拷贝到 Device。
- `aclrtBinaryUnLoad`：卸载算子二进制文件，释放相关资源。
