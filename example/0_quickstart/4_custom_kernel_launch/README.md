# 4_custom_kernel_launch

## 描述

本样例提供一个最小可运行示例，演示如何使用 `<<<>>>` 内核调用符下发自定义 AscendC Kernel，完成 8 元素向量加法。运行成功后，结果应与 [0_hello_cann](../0_hello_cann/README.md) 中的向量加法结果一致。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/0_quickstart/4_custom_kernel_launch
```

2.设置环境变量。
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3.执行以下命令运行样例。
```bash
bash run.sh
```
## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 与 Stream 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtMemcpy` 接口完成 Host/Device 数据传输。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
- Kernel 调用
    - 使用 `<<<>>>` 内核调用符下发自定义 AscendC Kernel。

## 示例输出

样例会打印输入向量、`<<<>>>` 调用成功信息以及最终结果。典型输出如下：

```text
[INFO]  ACL init successfully
[INFO]  Set device 0 successfully
[INFO]  Create stream successfully
[INFO]  Allocate device buffers successfully
[INFO]  Copy input vectors to device successfully
Input vectors:
  self:   [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
  other:  [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  alpha:  1.0
[INFO]  Custom AscendC kernel <<<>>> call successfully
[INFO]  Synchronize stream successfully

Vector addition result:
  result[0] = 1.5 (expected: 1.5)
  result[1] = 3.0 (expected: 3.0)
  result[2] = 4.5 (expected: 4.5)
  result[3] = 6.0 (expected: 6.0)
  result[4] = 7.5 (expected: 7.5)
  result[5] = 9.0 (expected: 9.0)
  result[6] = 10.5 (expected: 10.5)
  result[7] = 12.0 (expected: 12.0)

[INFO]  Sample run successfully with <<<>>> kernel call!
```

如果输出结果与预期一致，说明 CANN 自定义 Kernel 的 `<<<>>>` 调用路径工作正常。

## 相关样例

- [0_hello_cann](../0_hello_cann/README.md)：使用 `aclnnAdd` 完成相同的向量加法。
