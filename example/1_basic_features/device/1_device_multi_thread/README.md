# 1_device_multi_thread

## 描述
本样例展示多线程场景下的 Device 管理流程。主线程指定 Device 并设置 Device 资源限制，工作线程查询 Device 数量、运行模式、资源限制等信息后下发核函数任务，最后释放 Device、Stream 和内存资源。

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
cd ${git_clone_path}/example/1_basic_features/device/1_device_multi_thread
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
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtGetSocName` 接口查询当前运行环境的昇腾 AI 处理器版本。
    - 调用 `aclrtGetDeviceCount` 接口获取可用 Device 数量。
    - 调用 `aclrtQueryDeviceStatus` 接口查询 Device 状态。
    - 调用 `aclrtGetRunMode` 接口获取当前运行模式。
    - 调用 `aclrtGetDeviceUtilizationRate` 接口查询 Device 上 Cube、Vector、AI CPU 等模块的利用率。
    - 调用 `aclrtDeviceGetStreamPriorityRange` 接口查询硬件支持的 Stream 优先级范围。
    - 调用 `aclrtGetDeviceInfo` 接口获取指定 Device 的属性信息。
    - 调用 `aclrtSetDeviceResLimit` 接口设置当前进程的 Device 资源限制。
    - 调用 `aclrtGetDeviceResLimit` 接口获取当前进程的 Device 资源限制。
    - 调用 `aclrtResetDeviceResLimit` 接口重置当前进程的 Device 资源限制。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上的任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
- 内存管理
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtMallocHost` 接口申请 Host 上的内存。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
    - 调用 `aclrtFreeHost` 接口释放 Host 上的内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口通过内存复制的方式实现数据传输。

## 示例输出

```text
[INFO]  Start to run device_multi_thread sample.
[INFO]  Current Ascend chipset platform is: Ascend910_9362.
[INFO]  Get device count success. deviceCount: 2.
[INFO]  Query device status success. deviceStatus: 0.
[INFO]  RunMode is ACL_HOST.
[INFO]  Get device resLimit success. VECTOR_CORE 1.
[INFO]  The results (first 10 elements) of the kernel function:
[INFO]  Result: hostDst[0]: 0.000000 Expected value: 0.000000
[INFO]  Result: hostDst[1]: 2.000000 Expected value: 2.000000
...
[INFO]  Result: hostDst[9]: 18.000000 Expected value: 18.000000
[INFO]  Run the device_multi_thread sample successfully.
```
