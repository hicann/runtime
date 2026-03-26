# 跨Device的数据交互

本节中的“跨Device的数据交互”是指一个进程内、根据硬件组网（例如处于PCIe或者HCCS互联的组网拓扑下）、Device之间能够访问彼此的内存。可以使用aclrtDeviceCanAccessPeer接口查询两个Device之间是否支持数据交互，若支持，再根据访问方向，分别调用aclrtDeviceEnablePeerAccess接口开启一个Device到另一个Device的数据交互功能，例如，调用一次aclrtDeviceEnablePeerAccess接口开启Device 0到Device 1的数据交互，再调用一次aclrtDeviceEnablePeerAccess接口开启Device 1到Device 0的数据交互。若需关闭Device之间的数据交互，可调用aclrtDeviceDisablePeerAccess接口。对于两个进程之间的通信请参见[进程间通信](进程间通信.md)。

以下是跨Device内存复制的代码示例，不可以直接拷贝编译运行，仅供参考。完整样例代码请参见[Link](https://gitcode.com/cann/runtime/tree/master/example/1_basic_features/device/2_device_P2P)。

```
aclInit(NULL); // 初始化
int32_t canAccessPeer = 0;
aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1);      // 查询Device 0和Device 1之间是否支持数据交互
if (canAccessPeer == 1) {
	aclrtSetDevice(0);                           // Device 0下的操作
	uint32_t reserveFlag = 0U;
	aclrtDeviceEnablePeerAccess(1, reserveFlag); // 开启当前Device(Device 0)到指定Device(Device 1）的数据交互
	void *dev0Mem = nullptr;
	aclrtMalloc(&dev0Mem, 10, ACL_MEM_MALLOC_HUGE_FIRST_P2P);  
	aclrtSetDevice(1);                           // Device 1下的操作
	aclrtDeviceEnablePeerAccess(0, reserveFlag); // 开启当前Device(Device 1)到指定Device(Device 0）的数据交互
	void *dev1Mem = nullptr;
	aclrtMalloc(&dev1Mem, 10, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
	aclrtMemcpy(dev1Mem, 10, dev0Mem, 10, ACL_MEMCPY_DEVICE_TO_DEVICE); // 将Device 0上的内存数据复制到Device 1上
	aclrtDeviceDisablePeerAccess(0);             // 关闭当前Device（Device 1）到指定Device（Device 0）的数据交互
	aclrtFree(dev1Mem);
	aclrtResetDevice(1);                         // 释放Device 1的资源
        aclrtSetDevice(0);                           // 切换到Device 0上进行操作
        aclrtDeviceDisablePeerAccess(1);             // 关闭当前Device（Device 0）到指定Device（Device 1）的数据交互
	aclrtFree(dev0Mem);
	aclrtResetDeviceForce(0);                    // Device 0下的操作，调用aclrtResetDevice接口释放Device 0的资源
	printf("P2P copy success\n");
} else {
	printf("current device doesn't support p2p feature\n");
}
aclFinalize(); // 去初始化
```


