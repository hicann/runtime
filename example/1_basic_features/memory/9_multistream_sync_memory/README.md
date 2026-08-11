# 9_multistream_sync_memory

## 描述
本样例会触发两个线程，一个线程A等待指定内存中的数据满足一定条件后解除阻塞，一个线程B向指定内存中写入数据，在线程B写入满足条件的数据之前线程A将持续阻塞。

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
cd ${git_clone_path}/example/1_basic_features/memory/9_multistream_sync_memory
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
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口可以阻塞等待 Stream 上任务的完成。
    - 调用 `aclrtDestroyStreamForce` 接口强制销毁 Stream，丢弃所有任务。
- 内存管理
    - 调用 `aclrtValueWait` 接口等待指定内存中的数据满足一定条件后解除阻塞。
    - 调用 `aclrtValueWrite` 接口向指定内存中写数据。
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口通过内存复制的方式实现数据传输。

## 示例输出

```text
[INFO]  Allocate memory on the device successfully
[INFO]  Create Stream A successfully
[INFO]  Create Stream B successfully
[INFO]  Stream A: wait for data at virtual memory = 0x... to meet the condition
[INFO]  Start writing to file/flag.txt
[INFO]  Flag value after the writing thread starts: 123
[INFO]  Stream B: write data at virtual memory = 0x...
[INFO]  Stream B: the data in the specified memory has met the condition, all tasks are complete
[INFO]  Stream A: the data in the specified memory has met the condition, all tasks are complete
[INFO]  Flag value read by the waiting thread: 123
```

