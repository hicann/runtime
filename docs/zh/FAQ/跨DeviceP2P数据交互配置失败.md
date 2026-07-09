# 跨Device P2P数据交互配置失败

## 问题现象描述

**现象1：跨Device内存复制失败**

在多Device场景下，尝试进行跨Device的P2P数据交互时，内存复制失败。

错误代码示例：
```cpp
aclInit(NULL);
aclrtSetDevice(0);
void *dev0Mem = nullptr;
aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

aclrtSetDevice(1);
void *dev1Mem = nullptr;
aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

// 尝试跨Device内存复制失败
aclrtMemcpy(dev1Mem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_DEVICE);  // ✗ 失败
```

**现象2：调用aclrtDeviceEnablePeerAccess接口报错**

调用`aclrtDeviceEnablePeerAccess`接口时报错，提示Device间不支持P2P访问。

## 可能原因

1. **未检查Device间的P2P访问能力**：并非所有Device组合都支持P2P数据交互，需要先使用`aclrtDeviceCanAccessPeer`接口查询。
2. **未正确开启P2P访问权限**：即使Device间支持P2P，也需要显式调用`aclrtDeviceEnablePeerAccess`接口开启访问权限。
3. **内存分配未使用P2P优化标志**：跨Device内存复制时，应使用`ACL_MEM_MALLOC_HUGE_FIRST_P2P`标志分配内存以获得更好的性能。
4. **硬件组网限制**：Device之间需要处于PCIe等互联的组网拓扑下才能支持P2P访问。

## 处理步骤

**方案一：检查Device间P2P访问能力并开启访问权限**

按照正确的流程配置P2P数据交互：

```cpp
aclInit(NULL);

// 1. 检查Device 0和Device 1之间是否支持P2P
int32_t canAccessPeer = 0;
aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1);  // 查询Device 0能否访问Device 1

if (canAccessPeer == 1) {
    // 2. 开启Device 0到Device 1的P2P访问
    aclrtSetDevice(0);
    uint32_t reserveFlag = 0U;
    aclrtDeviceEnablePeerAccess(1, reserveFlag);  // 开启Device 0→Device 1的访问

    void *dev0Mem = nullptr;
    aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

    // 3. 开启Device 1到Device 0的P2P访问
    aclrtSetDevice(1);
    aclrtDeviceEnablePeerAccess(0, reserveFlag);  // 开启Device 1→Device 0的访问

    void *dev1Mem = nullptr;
    aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

    // 4. 执行跨Device内存复制
    aclrtMemcpy(dev1Mem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_DEVICE);  // ✓ 成功

    // 5. 关闭P2P访问并释放资源
    aclrtDeviceDisablePeerAccess(0);  // 关闭Device 1→Device 0的访问
    aclrtFree(dev1Mem);
    aclrtResetDevice(1);

    aclrtSetDevice(0);
    aclrtDeviceDisablePeerAccess(1);  // 关闭Device 0→Device 1的访问
    aclrtFree(dev0Mem);
    aclrtResetDeviceForce(0);
} else {
    printf("Device 0 and Device 1 don't support P2P feature\n");
}

aclFinalize();
```

**方案二：使用Host内存作为中转**

如果Device间不支持P2P或P2P配置失败，可以使用Host内存作为中转：

```cpp
aclrtSetDevice(0);
void *dev0Mem = nullptr;
aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST);

// 分配Host内存作为中转
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

**方案三：检查硬件组网拓扑**

确认Device间的硬件连接状态：

```cpp
uint32_t deviceCount;
aclrtGetDeviceCount(&deviceCount);

// 检查所有Device组合的P2P能力
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

**方案四：完整示例代码**

完整的P2P数据交互流程示例：

```cpp
#include <stdio.h>
#include "acl/acl.h"

int main() {
    aclInit(NULL);

    int32_t canAccessPeer = 0;
    aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1);

    if (canAccessPeer == 1) {
        // Device 0操作
        aclrtSetDevice(0);
        uint32_t reserveFlag = 0U;
        aclrtDeviceEnablePeerAccess(1, reserveFlag);

        void *dev0Mem = nullptr;
        aclrtMalloc(&dev0Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

        // Device 1操作
        aclrtSetDevice(1);
        aclrtDeviceEnablePeerAccess(0, reserveFlag);

        void *dev1Mem = nullptr;
        aclrtMalloc(&dev1Mem, 1024, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

        // 跨Device内存复制
        aclrtMemcpy(dev1Mem, 1024, dev0Mem, 1024, ACL_MEMCPY_DEVICE_TO_DEVICE);

        // 清理资源
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

## 相关 issue

暂无相关Issue。