## 2_model_dump_config

## 描述
本用例展示了如何使用 `aclmdlInitDump`、`aclmdlSetDump`、`acldumpGetPath` 和 `aclmdlFinalizeDump` 这组模型级 Dump 配置接口，在单算子 API 场景下按配置文件启用 Dump，并查询当前生效的 Dump 输出路径。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
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
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclmdlInitDump接口初始化Dump配置。
    - 调用aclmdlSetDump接口加载Dump配置文件。
    - 调用acldumpGetPath接口查询当前Dump输出路径。
    - 调用aclmdlFinalizeDump接口结束本次Dump配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream接口阻塞等待Stream上任务的完成。
    - 调用aclrtDestroyStream接口销毁Stream。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。

## 说明

- 本示例将模型级 Dump 配置接口用于单算子 API 场景，便于补充 `adump` 目录中的配置式 Dump 用法。
- 配置文件 `acl.json` 采用单算子 Dump 场景推荐的 `dump_op_switch: on` 配置。

## 示例输出

```text
[INFO]  Configured model dump path is: ...
[INFO]  result[0] is: 1.000000
[INFO]  result[1] is: 2.000000
[INFO]  result[2] is: 3.000000
[INFO]  result[3] is: 5.000000
[INFO]  result[4] is: 6.000000
[INFO]  result[5] is: 7.000000
[INFO]  result[6] is: 10.000000
[INFO]  result[7] is: 11.000000
[INFO]  Run the model dump config sample successfully.
```

## 已知issue

   暂无
