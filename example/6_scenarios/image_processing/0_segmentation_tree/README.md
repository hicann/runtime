# 0_segmentation_tree

## 描述

本样例面向需要在单个 Device 上生成层级图像分割标签的开发者。程序构造一幅确定性的 8x8 灰度图，先查询 Device 可用内存并用结果完成任务容量准入，再由 Ascend C Kernel 根据灰度区间生成四类细粒度标签，并将相邻的两类细粒度标签合并为一类粗粒度标签，形成可直接验证的两级分割树。

程序逐像素验证细粒度标签、粗粒度标签和 `coarse = fine / 2` 的层级关系，同时验证四类细粒度标签各有 16 个像素、两类粗粒度标签各有 32 个像素。任一 Runtime 接口、结果不变量或清理操作失败时，程序输出 `ERROR` 并返回非零值；仅在全部检查和清理成功后输出最终成功日志。样例固定使用 Device 0。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。
2. 设置环境变量。
3. 执行以下命令编译并运行样例。

```bash
cd ${git_clone_path}/example/6_scenarios/image_processing/0_segmentation_tree
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- Runtime 初始化与 Device 管理
    - `aclInit`：初始化 ACL Runtime。
    - `aclrtSetDevice`：选择 Device 0 执行图像分割。
    - `aclrtResetDevice`：释放 Device 0 上的 Runtime 资源。
    - `aclFinalize`：去初始化 ACL Runtime。
- Stream 与内存管理
    - `aclrtGetMemInfo`：查询 HBM 空闲和总容量，并在容量满足图像与标签缓冲区需求时才允许任务继续。
    - `aclrtCreateStream`：创建异步传输和 Kernel 执行使用的 Stream。
    - `aclrtMallocHost`：分配图像和两级标签的 Host 内存。
    - `aclrtMalloc`：分配图像和两级标签的 Device 内存。
    - `aclrtMemcpyAsync`：异步传输图像和两级标签。
    - `aclrtSynchronizeStream`：等待传输和分割 Kernel 完成。
    - `aclrtFree`：释放 Device 内存。
    - `aclrtFreeHost`：释放 Host 内存。
    - `aclrtDestroyStream`：销毁 Stream。
- Kernel 加载与执行
    - `aclrtBinaryLoadFromFile`：加载分割树 Kernel 二进制。
    - `aclrtBinaryGetFunction`：获取分割树 Kernel 函数句柄。
    - `aclrtKernelArgsInit`：初始化 Kernel 参数句柄。
    - `aclrtKernelArgsAppend`：追加图像、细粒度标签和粗粒度标签地址。
    - `aclrtKernelArgsFinalize`：完成 Kernel 参数构造。
    - `aclrtLaunchKernelWithConfig`：在 Stream 上启动分割树 Kernel。
    - `aclrtBinaryUnLoad`：卸载 Kernel 二进制。

## 示例输出

```text
[INFO]  Start to run 0_segmentation_tree sample.
[INFO]  Memory admission passed: required=192 bytes, free=... bytes.
[INFO]  Segmentation verified: fine counts=[16,16,16,16], coarse counts=[32,32].
[INFO]  Run the 0_segmentation_tree sample successfully.
```
