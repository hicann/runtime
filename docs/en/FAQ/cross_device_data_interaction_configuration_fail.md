# Cross-Device P2P Data Interaction Configuration Failure

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:55:58.392Z pushedAt=2026-10-22T07:58:00.797Z -->

## Symptoms

**Symptom 1: Failure in cross-device memory copy**

In a multi-device scenario, when you attempt cross-device P2P data interaction, the memory copy fails.

Example of the error code:

```cpp
aclInit(NULL);
aclrtSetDevice(0);
void *dev0Mem = nullptr;
aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

aclrtSetDevice(1);
void *dev1Mem = nullptr;
aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

// Attempting cross-device memory copy fails.
aclrtMemcpy(dev1Mem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_DEVICE);  // ✗ Failure
```

**Symptom 2: An error is reported when the aclrtDeviceEnablePeerAccess API is called**

An error is reported when the `aclrtDeviceEnablePeerAccess` API is called, indicating that P2P access is not supported between the devices.

## Possible Causes

1. **The P2P access capability between devices is not checked**: Not all device combinations support P2P data interaction. You need to query the capability using the `aclrtDeviceCanAccessPeer` API first.
2. **The P2P access permission is not enabled**: Even if P2P is supported between devices, you must explicitly call the `aclrtDeviceEnablePeerAccess` API to enable the access permission.
3. **The P2P optimization flag is not used for memory allocation**: When performing cross-device memory copy, use the `ACL_MEM_MALLOC_HUGE_FIRST_P2P` flag to allocate memory for better performance.
4. **Hardware networking restrictions**: Devices must be in an interconnected networking topology such as PCIe to support P2P access.

## Handling

**Solution 1: Check the P2P access capability between devices and enable the access permission**

Configure P2P data interaction by following the correct process.

```cpp
aclInit(NULL);

// 1. Check whether the P2P access is supported between Device 0 and Device 1.
int32_t canAccessPeer = 0;
aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1);  // Query whether Device 0 can access Device 1.

if (canAccessPeer == 1) {
    // 2. Enable the P2P access from Device 0 to Device 1.
    aclrtSetDevice(0);
    uint32_t reserveFlag = 0U;
    aclrtDeviceEnablePeerAccess(1, reserveFlag);  // Enable access from Device 0 to Device 1.

    void *dev0Mem = nullptr;
    aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

    // 3. Enable the P2P access from Device 1 to Device 0.
    aclrtSetDevice(1);
    aclrtDeviceEnablePeerAccess(0, reserveFlag);  // Enable access from Device 1 to Device 0.

    void *dev1Mem = nullptr;
    aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

    // 4. Perform cross-device memory copy.
    aclrtMemcpy(dev1Mem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_DEVICE);  // ✓ Success

    // 5. Disable the P2P access and release resources.
    aclrtDeviceDisablePeerAccess(0);  // Disable access from Device 1 to Device 0.
    aclrtFree(dev1Mem);
    aclrtResetDevice(1);

    aclrtSetDevice(0);
    aclrtDeviceDisablePeerAccess(1);  // Disable access from Device 0 to Device 1.
    aclrtFree(dev0Mem);
    aclrtResetDeviceForce(0);
} else {
    printf("Device 0 and Device 1 don't support P2P feature\n");
}

aclFinalize();
```

**Solution 2: Use host memory as an intermediary**

If P2P access is not supported between devices or P2P configuration fails, you can use host memory as an intermediary.

```cpp
aclrtSetDevice(0);
void *dev0Mem = nullptr;
aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

// Allocate host memory as an intermediary.
void *hostMem = nullptr;
aclrtMallocHost(&hostMem, 1024);

// Device 0 → Host
aclrtMemcpy(hostMem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_HOST);

aclrtSetDevice(1);
void *dev1Mem = nullptr;
aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

// Host → Device 1
aclrtMemcpy(dev1Mem, 1024, hostMem, 1024, ACL_MEMCPY_HOST_TO_DEVICE);

aclrtFreeHost(hostMem);
aclrtFree(dev1Mem);
aclrtResetDevice(1);

aclrtSetDevice(0);
aclrtFree(dev0Mem);
aclrtResetDeviceForce(0);
```

**Solution 3: Check the hardware networking topology**

Check the hardware connection status between devices.

```cpp
uint32_t deviceCount;
aclrtGetDeviceCount(&deviceCount);

// Check the P2P capability of all device combinations.
for (uint32_t i = 0; i < deviceCount; ++i) {
    for (uint32_t j = 0; j < deviceCount; ++j) {
        if (i != j) {
            int32_t canAccessPeer = 0;
            aclrtDeviceCanAccessPeer(&canAccessPeer, i, j);
            printf("Device %d can access Device %d: %s\n",
                   i, j, canAccessPeer ? "Yes" : "No");
        }
    }
}
```

**Solution 4: Complete example code**

Example of the complete P2P data interaction process:

```cpp
#include <stdio.h>
#include "acl/acl.h"

int main() {
    aclInit(NULL);

    int32_t canAccessPeer = 0;
    aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1);

    if (canAccessPeer == 1) {
        // Perform the operation on Device 0.
        aclrtSetDevice(0);
        uint32_t reserveFlag = 0U;
        aclrtDeviceEnablePeerAccess(1, reserveFlag);

        void *dev0Mem = nullptr;
        aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

        // Perform the operation on Device 1.
        aclrtSetDevice(1);
        aclrtDeviceEnablePeerAccess(0, reserveFlag);

        void *dev1Mem = nullptr;
        aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

        // Perform cross-device memory copy.
        aclrtMemcpy(dev1Mem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_DEVICE);

        // Clean up resources.
        aclrtDeviceDisablePeerAccess(0);
        aclrtFree(dev1Mem);
        aclrtResetDevice(1);

        aclrtSetDevice(0);
        aclrtDeviceDisablePeerAccess(1);
        aclrtFree(dev0Mem);
        aclrtResetDeviceForce(0);

        printf("P2P copy success\n");
    } else {
        printf("Current device doesn't support P2P feature\n");
    }

    aclFinalize();
    return 0;
}
```

## Related Issues

None
