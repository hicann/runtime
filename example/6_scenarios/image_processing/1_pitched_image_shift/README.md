# 1_pitched_image_shift

## 描述

本样例面向需要在单个 Device 上处理带行步长二维图像的开发者。程序构造一幅 8x8 `uint16_t` 图像，使用 24 Byte 的 Host pitch 和 32 Byte 的 Device pitch 完成二维同步搬运，由 Ascend C Kernel 按 Device pitch 执行横向 2 像素、纵向 1 像素的循环位移，再按不同 pitch 将结果搬回 Host。

程序逐像素验证全部 64 个输出，并检查二维 D2H 搬运没有覆盖 Host 每行的 `0xFFFF` padding。任一 Runtime 接口、结果不变量或清理操作失败时，程序输出 `ERROR` 并返回非零值；仅在全部检查和清理成功后输出最终成功日志。样例固定使用 Device 0。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。
2. 设置环境变量。
3. 执行以下命令编译并运行样例。

```bash
cd ${git_clone_path}/example/6_scenarios/image_processing/1_pitched_image_shift
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- Runtime 初始化与 Device 管理
    - `aclInit`：初始化 ACL Runtime。
    - `aclrtSetDevice`：选择 Device 0 执行图像位移。
    - `aclrtResetDevice`：释放 Device 0 上的 Runtime 资源。
    - `aclFinalize`：去初始化 ACL Runtime。
- Stream 与二维内存管理
    - `aclrtCreateStream`：创建 Kernel 执行使用的 Stream。
    - `aclrtMallocHost`：分配包含行 padding 的 Host 图像内存。
    - `aclrtMalloc`：分配采用独立 Device pitch 的图像内存。
    - `aclrtMemcpy2d`：在不同 Host 和 Device pitch 间同步搬运有效像素区域。
    - `aclrtSynchronizeStream`：等待位移 Kernel 完成后再同步回读图像。
    - `aclrtFree`：释放 Device 内存。
    - `aclrtFreeHost`：释放 Host 内存。
    - `aclrtDestroyStream`：销毁 Stream。
- Kernel 加载与执行
    - `aclrtBinaryLoadFromFile`：加载带步长图像位移 Kernel 二进制。
    - `aclrtBinaryGetFunction`：获取图像位移 Kernel 函数句柄。
    - `aclrtKernelArgsInit`：初始化 Kernel 参数句柄。
    - `aclrtKernelArgsAppend`：追加输入和输出图像的 Device 地址。
    - `aclrtKernelArgsFinalize`：完成 Kernel 参数构造。
    - `aclrtLaunchKernelWithConfig`：在 Stream 上启动图像位移 Kernel。
    - `aclrtBinaryUnLoad`：卸载 Kernel 二进制。

## 示例输出

```text
[INFO]  Start to run 1_pitched_image_shift sample.
[INFO]  Pitched shift verified: 64 pixels, Host pitch=24 bytes, Device pitch=32 bytes.
[INFO]  Run the 1_pitched_image_shift sample successfully.
```
