# Runtime Core Resource Control

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:23:52.759Z pushedAt=2026-11-16T03:07:10.143Z nl=2 -->

To improve the utilization and isolation of device core resources, Runtime supports controlling the core resources of a device. Currently, it supports configuring core resource limits at the device and the stream granularities. Core resources include the number of AI Cores or Cube Cores and the number of Vector Cores.

Whether **numBlocks** (used to specify the number of cores on which the operator's kernel function will be executed) is explicitly specified by the user determines the API to be called for runtime core resource control, as follows:

- **Scenario without numBlocks** (for example, calling the aclnn operator API): To apply the stream-granular core resource limit, call the **aclrtUseStreamResInCurrentThread** API to bind it to the current thread, and call the **aclrtGetResInCurrentThread** API to obtain the core resources available to the current thread.

    The priority of the core resource limit obtained through the **aclrtGetResInCurrentThread** API is as follows: stream-granular core resource limit \> device-granular core resource limit \> default core resource limit of the AI processor hardware. For example, if a device contains 32 Vector Cores in total, the device-granular core resource limit allows 16 Vector Cores, while the stream-granular core resource limit can be 20 Vector Cores, the aclnn operator runs with 20 Vector Cores during execution.

- **Scenario requiring numBlocks** (for example, executing operators through LaunchKernel): You can call the **aclrtGetDeviceResLimit** and **aclrtGetStreamResLimit** APIs to obtain the core resource limits at different granularities before setting **numBlocks**.

## Device-Granular Core Resource Limit

The following code example shows the key steps. It is for reference only and cannot be directly copied, compiled, or run.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
For the complete sample code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/2_advanced_features/kernel/1_launch_kernel_with_reslimit).
<!-- end id1 -->

```c
......
int32_t deviceId = 0;
uint32_t numBlocks = 8;
uint32_t coreDim = 0;

// Specify a compute device.
aclrtSetDevice(deviceId);

// Set the core resource limit.
aclrtSetDeviceResLimit(deviceId, ACL_RT_DEV_RES_CUBE_CORE, numBlocks);

// Dispatch the operator execution task.
// Take the aclnnAdd operator as an example:
// aclnnAddGetWorkspaceSize implicitly calls aclrtGetResInCurrentThread to query core resources for tiling.
// aclnnAdd()
......

// Obtain the core resource limit.
aclrtGetDeviceResLimit(deviceId, ACL_RT_DEV_RES_CUBE_CORE, &coreDim);
```

## Stream-Granular Core Resource Limit

The following code example shows the key steps. It is for reference only and cannot be directly copied, compiled, or run.

```c
#include "acl/acl.h"
......
int32_t deviceId = 0;
uint32_t numBlocks = 8;

// Specify the device for computation.
aclrtSetDevice(deviceId);

// Explicitly create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

// Set the number of Cube Cores and Vector Cores at the stream granularity.
aclrtSetStreamResLimit(stream, ACL_RT_DEV_RES_CUBE_CORE, numBlocks);
aclrtSetStreamResLimit(stream, ACL_RT_DEV_RES_VECTOR_CORE, numBlocks * 2);

// Bind to the current thread.
aclrtUseStreamResInCurrentThread(stream);

// In the operator task, call aclrtGetResInCurrentThread to query the resource limit of the current thread, and then specify the number of resources for running the operator.
// Take the aclnnAdd operator as an example:
// aclnnAddGetWorkspaceSize implicitly calls aclrtGetResInCurrentThread to query the core resources for tiling.
// aclnnAdd()
......

aclrtUnuseStreamResInCurrentThread(stream);
aclrtResetStreamResLimit(stream);

// Destroy resources.
aclrtDestroyStream(stream);
aclrtResetDevice(deviceId);
```
