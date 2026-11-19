# Multi-Device Programming

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:21:21.354Z pushedAt=2026-11-16T02:57:20.432Z nl=2 -->

## Overview

Multi-device programming enables users to leverage the combined performance, memory, and other resources of multiple Neural-Network Processing Units (NPUs) to achieve performance levels beyond those of a single NPU. Typically, each physical NPU is abstracted as a device in the Runtime programming UI, and task dispatch requires the support of the context within the device. Therefore, multi-device programming requires managing multiple devices and their corresponding contexts.

Some common multi-NPU programming methods include:

- A single host thread drives multiple NPUs.
- Multiple host threads, each thread driving its own NPU.
- Multiple single-threaded host processes, each process driving its own NPU.
- Multiple host processes, each process containing multiple threads, with each thread driving its own NPU.

<br>
<br>

## Multi-Device Selection

In a scenario where one host is paired with multiple devices, the user can call the **aclrtGetDeviceCount** API in the host-side application to obtain the number of devices paired with the current host. The devices are arranged in the order of 0, 1, 2, ...

The following is a code example for obtaining device information. It cannot be directly copied, compiled, and run, and is for reference only.

```c
// Obtain the number of devices and their corresponding attribute information.
uint32_t deviceCount;
aclrtGetDeviceCount(&deviceCount);
uint32_t deviceId;
for (deviceId = 0; deviceId < deviceCount; ++deviceId) {
    // Query device attribute information as needed.
    aclrtDevAttr attr = ACL_DEV_ATTR_VECTOR_CORE_NUM;
    int64_t value;
    aclrtGetDeviceInfo(deviceId, attr, &value);
}
```

At this point, you can switch devices at any time by calling the **aclrtSetDevice** API at **thread granularity** (without affecting other threads). After a device is specified, subsequent operations such as memory allocation and kernel execution are all performed on that device, and streams and events are also associated with the currently specified device. You can release resources by calling the **aclrtResetDevice** API, but it is more recommended to use the **aclrtResetDeviceForce** API to clean up resources on the device at once, including the default context, the default stream, and all streams created under the default context. If tasks under the default context or default stream have not been completed, the system waits for the tasks to complete before releasing resources. In a user program, if the **aclrtResetDevice** API is used, ensure that the number of calls to **aclrtSetDevice** and **aclrtResetDevice** appears in pairs.

The API call process for multi-device selection is shown in the following figure.

<img src="figures/sync_wait_multi_devices.png" width="60%">

The following is a code example for multi-device selection. It cannot be directly copied, compiled, and run, and is for reference only.

```c
// Specify Device 0 as the compute device and use the default context of Device 0 as the default context of the current thread.
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
// Execute task 1.
......

// Specify Device 1 as the compute device and use the default context of Device 1 as the default context of the current thread.
aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
// Execute task 2.
......

// Reset Device 1 to release compute resources. The default context of the thread is released.
// To continue running tasks, explicitly specify the device and context.
aclrtResetDeviceForce(1);

// Reset Device 0 to release compute resources.
aclrtResetDeviceForce(0);
```

<br>
<br>

## Stream and Event Behavior

Dispatching an operator on a stream that does not belong to the current device will fail. The sample code is as follows.

```c
aclrtSetDevice(0);                 // Specify Device 0 as the compute device.
aclrtStream s0;
aclrtCreateStream(&s0);            // Create Stream s0 on Device 0.
myKernel<<<8, nullptr, s0>>>();    // Dispatch the operator on Device 0 through Stream s0.

aclrtSetDevice(1);                 // Specify Device 1 as the compute device.
aclrtStream s1;
aclrtCreateStream(&s1);            // Create Stream s1 on Device 1.
myKernel<<<8, nullptr, s1>>>();    // Dispatch the operator on Device 1 through Stream s1.

// The operator fails to be dispatched.
myKernel<<<8, nullptr, s0>>>();    // Dispatch the operator on Device 1 through Stream s0.
```

- When the device to which a stream belongs differs from the device currently being operated, calling **aclrtMemcpyAsync** on this stream will fail.
- When an event and a stream are associated with different devices, calling **aclrtRecordEvent** will fail.
- When an event and a stream are associated with different devices, calling **aclrtStreamWaitEvent** will fail.
- When the device to which an event belongs differs from the device currently being operated, calling **aclrtSynchronizeEvent** and **aclrtQueryEvent** will succeed.

<br>
<br>

## Data Exchange Across Devices

In this section, "data exchange across devices" refers to the ability of devices within a single process to access each other's memory based on the hardware networking topology (for example, a topology interconnected through PCIe or HCCS). You can call the **aclrtDeviceCanAccessPeer** API to query whether data exchange is supported between two devices. If it is supported, call the **aclrtDeviceEnablePeerAccess** API separately for each access direction to enable data exchange from one device to the other. For example, call the **aclrtDeviceEnablePeerAccess** API once to enable data exchange from Device 0 to Device 1, and call it again to enable data exchange from Device 1 to Device 0. To disable data exchange between devices, call the **aclrtDeviceDisablePeerAccess** API. For communication between two processes, see [Inter-Process Communication](07_inter_process_communication.md).

The following is a code example of memory copy across devices. It cannot be directly copied, compiled, and run, and is for reference only.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
For the complete sample code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/1_basic_features/device/2_device_P2P).
<!-- end id1 -->

```c
aclInit(NULL); // Perform initialization.
int32_t canAccessPeer = 0;
aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1);      // Query whether data exchange is supported between Device 0 and Device 1.
if (canAccessPeer == 1) {
    aclrtSetDevice(0);                           // Perform the operation on Device 0.
    uint32_t reserveFlag = 0U;
    aclrtDeviceEnablePeerAccess(1, reserveFlag); // Enable data exchange from the current device (Device 0) to the specified device (Device 1).
    void *dev0Mem = nullptr;
    aclrtMalloc(&dev0Mem, 10, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
    aclrtSetDevice(1);                           // Perform the operation on Device 1.
    aclrtDeviceEnablePeerAccess(0, reserveFlag); // Enable data exchange from the current device (Device 1) to the specified device (Device 0).
    void *dev1Mem = nullptr;
    aclrtMalloc(&dev1Mem, 10, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
    aclrtMemcpy(dev1Mem, 10, dev0Mem, 10, ACL_MEMCPY_DEVICE_TO_DEVICE); // Copy the memory data on Device 0 to Device 1.
    aclrtDeviceDisablePeerAccess(0);             // Disable data exchange from the current device (Device 1) to the specified device (Device 0).
    aclrtFree(dev1Mem);
    aclrtResetDevice(1);                         // Release the resources of Device 1.
        aclrtSetDevice(0);                           // Switch to Device 0 for operations.
        aclrtDeviceDisablePeerAccess(1);             // Disable data exchange from the current device (Device 0) to the specified device (Device 1).
    aclrtFree(dev0Mem);
    aclrtResetDeviceForce(0);                    // For operations on Device 0, call aclrtResetDeviceForce to release the resources of Device 0.
    printf("P2P copy success\n");
} else {
    printf("current device doesn't support p2p feature\n");
}
aclFinalize(); // Perform deinitialization.
```
