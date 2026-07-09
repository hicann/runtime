# 运行时核资源控制

为了提高Device核资源的使用率以及隔离性，Runtime支持控制Device的核资源。当前支持配置Device粒度、Stream粒度的核资源限制，核资源包括AI Core或Cube Core数量、Vector Core数量。

是否由用户显式指定numBlocks（用于指定算子的核函数将会在几个核上执行），调用运行时核资源控制的接口会有所不同，如下所示：

-   **无numBlocks场景**（例如调用aclnn算子接口）：Stream粒度的核资源限制需要调用aclrtUseStreamResInCurrentThread接口绑定到当前线程使用，并调用aclrtGetResInCurrentThread接口获取当前线程可使用的核资源。

    通过aclrtGetResInCurrentThread接口获取核资源限制的优先级为：Stream粒度的核资源限制 \> Device粒度的核资源限制 \> AI处理器硬件的默认核资源限制。例如，Device总共包含32个Vector Core，Device粒度限制使用16个Vector Core，而Stream粒度的核资源限制可以为20个Vector Core，则aclnn算子执行时以20个Vector Core运行。

-   **需numBlocks场景**（例如LaunchKernel方式执行算子）：用户可调用aclrtGetDeviceResLimit接口、aclrtGetStreamResLimit接口获取不同粒度的核资源限制后再配置numBlocks。

## Device粒度的核资源限制

以下是关键步骤的代码示例，不可以直接拷贝编译运行，仅供参考。完整样例代码，请参见[Link](https://gitcode.com/cann/runtime/tree/master/example/2_advanced_features/kernel/1_launch_kernel_with_reslimit)。

```
......
int32_t deviceId = 0;
uint32_t numBlocks = 8;
uint32_t coreDim = 0;

// 指定计算设备
aclrtSetDevice(deviceId);

// 设置核资源限制
aclrtSetDeviceResLimit(deviceId, ACL_RT_DEV_RES_CUBE_CORE, numBlocks);

// 下发算子执行任务
// 以aclnnAdd算子为例：
// aclnnAddGetWorkspaceSize中会隐式调用aclrtGetResInCurrentThread查询核资源进行tiling
// aclnnAdd()
......

// 获取核资源限制
aclrtGetDeviceResLimit(deviceId, ACL_RT_DEV_RES_CUBE_CORE, &coreDim);
```

## Stream粒度的核资源限制

以下是关键步骤的代码示例，不可以直接拷贝编译运行，仅供参考。

```
#include "acl/acl.h"
......
int32_t deviceId = 0;
uint32_t numBlocks = 8;

// 指定运算的Device
aclrtSetDevice(deviceId);

// 显式创建一个Stream
aclrtStream stream;
aclrtCreateStream(&stream);

// 设置Stream粒度的Cube Core、Vector Core的数量
aclrtSetStreamResLimit(stream, ACL_RT_DEV_RES_CUBE_CORE, numBlocks);
aclrtSetStreamResLimit(stream, ACL_RT_DEV_RES_VECTOR_CORE, numBlocks * 2);

// 绑定到当前线程
aclrtUseStreamResInCurrentThread(stream);

// 算子的任务中需要调用aclrtGetResInCurrentThread查询当前线程的资源限制，然后指定运行算子的资源数量
// 以aclnnAdd算子为例：
// aclnnAddGetWorkspaceSize中会隐式调用aclrtGetResInCurrentThread查询核资源进行tiling
// aclnnAdd()
......

aclrtUnuseStreamResInCurrentThread(stream);
aclrtResetStreamResLimit(stream);

// 资源销毁
aclrtDestroyStream(stream);
aclrtResetDevice(deviceId);
```


