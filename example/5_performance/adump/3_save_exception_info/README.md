# 3_save_exception_info

## 描述

本用例展示了在算子执行场景下，如何组合使用 `acldumpGetExceptionInfoPath` 与 `acldumpSaveExceptionInfo` 两个接口，将自定义的 tensor 数据主动落盘到 Adump 工具的 Exception Dump 路径下。

场景说明：部分组件或框架在算子异常时存在落盘自定义数据的诉求。本样例通过 `acl.json` 中的 `dump_scene=aic_err_brief_dump` 使能 Exception Dump，先跑通一个正常的 aclnnAdd 算子，随后：

1. 调用 `acldumpGetExceptionInfoPath` 查询 Exception Dump 的落盘根路径（带 deviceId）；
2. 构造 `acldumpTensorInfo`（复用算子的 device 地址、shape、dataType），调用 `acldumpSaveExceptionInfo` 将 tensor 数据落盘到该路径下，`userTag` 保存进 Dump 文件 proto 头的 OpAttr 中。

> 说明：`fileName` 为相对路径（不能为空、不能包含 `..`），最终落盘位置限定在 Exception Dump 根路径之内；为避免重复运行时覆盖已有文件，落盘文件名会在 `fileName` 基础上自动追加 `.custom.{timestamp}` 后缀（`timestamp` 为毫秒级时间戳），例如传入 `save_exception_info`，实际文件名形如 `save_exception_info.custom.20260721153012345`。调用前需确保已使能 Exception Dump，否则接口返回失败。
>
> 说明：本接口直接以 `tensorAddr` 作为 Device 上的数据地址读取数据，因此样例中 `addrType` 传入 `ACL_DUMP_ADDR_RAW`、`placement` 传入 `ACL_DUMP_PLACEMENT_DEVICE`。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装详情以及运行详情请见example目录下的[README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用aclInit接口初始化AscendCL配置（通过acl.json使能Exception Dump）。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Exception Dump
    - 调用acldumpGetExceptionInfoPath接口查询Exception Dump的落盘根路径。
    - 调用acldumpSaveExceptionInfo接口将自定义tensor数据落盘到Exception Dump路径下，userTag写入proto头OpAttr。
- Device管理
    - 调用aclrtSetDevice/aclrtResetDeviceForce接口管理Device。
- Stream管理
    - 调用aclrtCreateStream/aclrtSynchronizeStream/aclrtDestroyStream接口管理Stream。
- 内存管理
    - 调用aclrtMalloc/aclrtFree接口申请、释放Device内存。
- 数据传输
    - 调用aclrtMemcpy接口实现数据传输。

## 本示例新增覆盖

- `acldumpGetExceptionInfoPath`：查询 Exception Dump 落盘根路径。
- `acldumpSaveExceptionInfo`：将自定义 tensor 数据主动落盘到 Exception Dump 路径根路径下，并通过 userTag 保存附加维测信息。

## 示例输出

```text
[INFO]  acldumpGetExceptionInfoPath success, exception dump path is: .../extra-info/data-dump/0/
[INFO]  acldumpSaveExceptionInfo success, data has been saved under exception dump path: .../extra-info/data-dump/0/
[INFO]  result[0] is: 1.000000
...
[INFO]  Run the save_exception_info sample successfully.
```

## 已知issue

   暂无
