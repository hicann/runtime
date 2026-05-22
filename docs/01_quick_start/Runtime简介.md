# CANN Runtime简介

CANN Runtime是CANN软件栈中负责驱动硬件执行与管理AI计算任务的核心组件，它通过提供统一的API，使得上层应用、AI框架、加速库能够高效利用AI处理器的硬件计算资源。
<br>
<br>

## 典型应用示例

下面以一个向量加法算子（VectorAdd，实现 `result = x + alpha * y` 的计算）伪码，展示使用CANN Runtime进行算子调用的完整流程。该示例真实可运行代码请见[hello_cann样例](../../example/0_quickstart/0_hello_cann/main.cpp)


```c
#include "acl/acl.h"

int main() {
    // 1. 初始化Runtime
    aclInit(nullptr);
  
    // 2. 设置计算设备
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);  // 创建默认Context和默认Stream
  
    // 3. 创建Stream
    aclrtStream stream;
    aclrtCreateStream(&stream);
  
    // 4. 申请设备内存
    size_t bufferSize = 8 * sizeof(float);  // 8个float元素
    float *xDevice, *yDevice, *resultDevice;
    aclrtMalloc(&xDevice, bufferSize, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&yDevice, bufferSize, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&resultDevice, bufferSize, ACL_MEM_MALLOC_HUGE_FIRST);
  
    // 5. 准备主机数据并拷贝到设备
    float xHost[8] = {1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f};
    float yHost[8] = {0.5f, 1.0f, 1.5f, 2.0f, 2.5f, 3.0f, 3.5f, 4.0f};
    float alpha = 1.0f;
  
    aclrtMemcpy(xDevice, bufferSize, xHost, bufferSize, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(yDevice, bufferSize, yHost, bufferSize, ACL_MEMCPY_HOST_TO_DEVICE);
  
    // 6. 调用aclnnAdd(...)下发计算任务
  
    // 7. 同步等待计算完成
    aclrtSynchronizeStream(stream);
  
    // 8. 将结果拷贝回主机
    float resultHost[8];
    aclrtMemcpy(resultHost, bufferSize, resultDevice, bufferSize, ACL_MEMCPY_DEVICE_TO_HOST);
  
    // 9. 释放资源
    aclrtFree(xDevice);
    aclrtFree(yDevice);
    aclrtFree(resultDevice);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
  
    return 0;
}
```

### 代码解析

上述调用示例展示了Runtime编程的核心步骤，每个步骤对应Runtime的不同能力模块：


| 步骤 | 操作                     | Runtime能力        | 说明                                  |
| ---- | ------------------------ | ------------------ | ------------------------------------- |
| 1    | `aclInit`                | **运行时全局管理** | 初始化Runtime运行时环境，加载配置     |
| 2    | `aclrtSetDevice`         | **Device管理**     | 指定计算设备，创建默认Context和Stream |
| 3    | `aclrtCreateStream`      | **Stream管理**     | 创建任务执行队列，用于异步任务下发    |
| 4    | `aclrtMalloc`            | **Memory管理**     | 在设备上申请内存，存储计算数据        |
| 5    | `aclrtMemcpy`            | **Memory管理**     | 主机与设备间的数据传输                |
| 6    | 调用`aclnnAdd`算子函数    | **Kernel管理**     | aclnnAdd函数会使用Runtime的Kernel管理功能，下发算子执行任务到Stream          |
| 7    | `aclrtSynchronizeStream` | **Stream管理**     | 同步等待Stream上任务完成              |
| 8    | `aclrtMemcpy`            | **Memory管理**     | 将计算结果从设备拷贝回主机            |
| 9    | 资源释放                 | **资源管理**       | 释放内存、Stream、Device资源          |

<br>

### 核心编程模式

Runtime采用**主机-设备异步并行**的编程模式：

1. **主机与设备分离**：主机（CPU）负责任务编排和下发，设备（NPU）负责计算执行，各自拥有独立内存空间。
2. **异步任务下发**：主机调用算子接口后立即返回，不等待设备执行完成。任务下发到Stream队列后，设备异步执行。
3. **显式同步**：当主机需要获取计算结果时，调用同步接口阻塞等待设备任务完成。

这种模式有效隐藏了主机处理时间和数据传输延迟，实现主机与设备的并行工作，提升整体吞吐量。

<br>
<br>

## Runtime功能架构

从上述示例可以看出，Runtime围绕计算任务的执行生命周期，提供以下核心功能模块：


| 功能模块           | 核心能力                             | 关键接口                                       |
| ------------------ | ------------------------------------ | ---------------------------------------------- |
| **运行时全局管理** | 初始化/去初始化、进程级配置、DFX功能 | `aclInit`、`aclFinalize`                       |
| **Device管理**     | 设备设置、复位、查询、配置           | `aclrtSetDevice`、`aclrtResetDevice`           |
| **Context管理**    | 上下文创建、销毁、切换               | `aclrtCreateContext`、`aclrtSetCurrentContext` |
| **Stream管理**     | Stream创建、销毁、同步、属性配置     | `aclrtCreateStream`、`aclrtSynchronizeStream`  |
| **Memory管理**     | 设备内存、主机内存申请/释放/拷贝     | `aclrtMalloc`、`aclrtMemcpy`                   |
| **Kernel管理**     | 算子加载、注册、执行                 | `<<< >>>` 语法、`aclrtLaunchKernel`        |
| **Event管理**      | Stream间同步、时间戳记录             | `aclrtCreateEvent`、`aclrtRecordEvent`         |
<br>

此外Runtime还提供一系列特性（如ACL Graph），Runtime功能架构如下图所示：

![](figures/逻辑架构图.png)

<br>
<br>

## 深入了解

本章介绍了Runtime的基本概念和算子调用的典型流程。要深入理解Runtime编程，建议继续阅读：

- [Runtime编程模型](Runtime编程模型.md)：主机-设备架构、异步执行机制、Stream与Task关系
