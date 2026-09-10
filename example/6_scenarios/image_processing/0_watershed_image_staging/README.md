# 0_watershed_image_staging

## 描述

本样例面向在单个 Device 上为分水岭图像处理准备输入的应用，将三帧带行步长的 8-bit 灰度图异步上传到 Device 并回读，在后续图像算法执行前确认 Runtime 数据通路可用。

样例查询 Runtime 与驱动版本、当前 Device、Device 总内存及 Stream flag，并将这些信息用于确认资源和执行环境。程序逐像素校验三帧回读图像，校验有效区域校验和及 Host 行填充未被覆盖；任一核心 API、数据、配置或清理不变量不满足时输出 `ERROR` 并返回非零。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | :---: |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Ascend 950PR/Ascend 950DT | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/6_scenarios/image_processing/0_watershed_image_staging
```

2. 设置环境变量。

`${install_root}` 为 CANN 软件包安装根目录，`set_env.sh` 加载 CANN 运行环境，`set_sample_env.sh` 设置样例编译所需的 `SOC_VERSION` 和 `ASCENDC_CMAKE_DIR`。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. 执行以下命令编译并运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化与 Device 管理
    - 调用 `aclInit` 接口完成 ACL 初始化。
    - 调用 `aclrtSetDevice` 接口指定单个运算 Device。
    - 调用 `aclrtGetDevice` 接口确认当前 Device 与选择结果一致。
    - 调用 `aclrtGetDeviceInfo` 接口查询 Device 总内存并确认图像缓冲区可分配。
    - 调用 `aclrtResetDevice` 接口释放当前进程使用的 Device 资源。
    - 调用 `aclFinalize` 接口完成 ACL 去初始化。
- 版本与 Stream 配置
    - 调用 `aclsysGetVersionNum` 接口查询 Runtime 和驱动软件包版本；查询失败时记录告警并继续执行。
    - 调用 `aclrtCreateStreamWithConfig` 接口创建快速同步 Stream。
    - 调用 `aclrtStreamGetFlags` 接口确认创建 Stream 时设置的 flag。
    - 调用 `aclrtSynchronizeStream` 接口等待二维内存复制任务完成，并在释放资源前确认 Stream 空闲。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
- 图像内存与二维传输
    - 调用 `aclrtMallocHost` 接口为输入和输出图像分配锁页 Host 内存。
    - 调用 `aclrtMalloc` 接口分配带行步长的 Device 图像缓冲区。
    - 调用 `aclrtMemcpy2dAsync` 接口按有效宽度异步上传和回读图像。
    - 调用 `aclrtFree` 接口释放 Device 图像缓冲区。
    - 调用 `aclrtFreeHost` 接口释放输入和输出 Host 图像缓冲区。

## 示例输出

```text
[INFO]  Start to run 0_watershed_image_staging sample.
[INFO]  Environment verified: runtime=90200000, driver=250505000, Device=0, global memory=65787658240 bytes, Stream flag=0x2.
[INFO]  Image 0 staging verified: 262144 pixels, checksum=32759100.
[INFO]  Image 1 staging verified: 262144 pixels, checksum=32764400.
[INFO]  Image 2 staging verified: 262144 pixels, checksum=32769700.
[INFO]  Run the 0_watershed_image_staging sample successfully.
```

版本号和 Device 总内存取决于实际运行环境。版本查询失败时，对应版本号显示为 `-1`。
