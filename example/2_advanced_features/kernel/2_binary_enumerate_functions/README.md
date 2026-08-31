# aclrtBinaryEnumerateFunctions 示例

本示例将 `add_custom`、`sub_custom` 和 `mul_custom` 编译到同一个独立算子二进制，通过
`aclrtBinaryEnumerateFunctions` 获取模块中的 Kernel 函数句柄，再使用
`aclrtGetFunctionName` 查询函数名，依次执行三个 Kernel 并打印首个输出元素。

`aclrtBinaryLoadFromFile` 完成 Host 侧文件加载和解析；首次调用
`aclrtBinaryEnumerateFunctions` 时，Runtime 将关联的算子二进制拷贝到当前
Context 对应的 Device。样例输入为 `x=1.0`、`y=2.0`，三个 Kernel 的结果分别为
`3.0`、`-1.0` 和 `2.0`。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 目录

```text
2_binary_enumerate_functions/
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

Runtime 默认安装在 `/home/developer/Ascend/cann`。运行前需要同时具备
AscendC 编译工具；仅安装 Runtime 包时可能不存在 `ascendc.cmake`。

`run.sh` 会自动探测 CANN 环境：优先使用已设置的 `ASCEND_INSTALL_PATH` /
`ASCEND_HOME_PATH`，否则通过 `example/common/resolve_cann_env.sh` 在常见安装
路径中查找并 source `set_env.sh`。

`SOC_VERSION` 和 `ASCENDC_CMAKE_DIR` 未设置时，`run.sh` 会 source
`example/set_sample_env.sh` 自动探测（SOC_VERSION 通过设备查询获得），无需手工指定。

也可以预先手工设置：

```bash
export ASCEND_INSTALL_PATH=/home/developer/Ascend/cann
export SOC_VERSION=Ascend910B1
```

## 编译运行

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/2_binary_enumerate_functions
bash run.sh
```

成功时可看到类似输出：

```text
[INFO] Enumerating functions in the Kernel binary.
[INFO] aclrtBinaryEnumerateFunctions succeeded.
[INFO] function[0]: name=add_custom, handle=...
[INFO] function[1]: name=mul_custom, handle=...
[INFO] function[2]: name=sub_custom, handle=...
[INFO] add_custom result: 3.0
[INFO] mul_custom result: 2.0
[INFO] sub_custom result: -1.0
```
