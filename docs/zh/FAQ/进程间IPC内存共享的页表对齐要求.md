# 进程间IPC内存共享的页表对齐要求

## 问题现象描述

**现象1：调用IPC接口报错提示页表未对齐**

在使用Runtime IPC接口进行进程间内存共享时，调用`aclrtIpcMemGetExportKey`或`aclrtIpcMemImportByKey`接口时报错，提示共享内存页表未对齐。

错误代码示例：
```cpp
// 进程A：分配内存并导出IPC key
void *ptrA = nullptr;
aclrtSetDevice(0);
aclrtMalloc(&ptrA, 1024);  // 分配1024字节内存

char key[65];
aclrtIpcMemGetExportKey(ptrA, 1024, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
// ✗ 可能失败：内存未页表对齐
```

## 可能原因

1. **内存分配未对齐**：通过`aclrtMalloc`接口分配设备内存时，出于性能考虑，可能会从更大的底层内存块中切分出来，导致分配的内存地址未页表对齐。
2. **页表对齐安全检查**：IPC接口会检查共享内存是否页表对齐，若未对齐，API将拦截并报错，以防止跨进程多映射内存导致的信息泄露风险。
3. **不同内存类型页表大小不同**：普通页内存的页表大小为4K，大页内存的页表大小支持2M或1G。

## 处理步骤

**方案一：使用aclrtMalloc接口的内存分配规则**

按照内存分配规则申请内存，确保内存页表对齐：

```cpp
// 正确示例：使用合适的内存分配标志
void *ptrA = nullptr;
aclrtSetDevice(0);

// 对于小内存（小于2M），使用普通页内存分配
aclrtMalloc(&ptrA, 4096, ACL_MEM_MALLOC_HUGE_FIRST);  // ✓ 分配4K对齐的内存

char key[65];
aclrtIpcMemGetExportKey(ptrA, 4096, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);  // ✓ 成功
```

**方案二：分配大页内存以确保对齐**

对于需要大页内存的场景，使用大页内存分配标志：

```cpp
// 正确示例：分配大页内存（2M或1G对齐）
void *ptrA = nullptr;
aclrtSetDevice(0);

// 分配2M大页内存
size_t largePageSize = 2 * 1024 * 1024;  // 2MB
aclrtMalloc(&ptrA, largePageSize, ACL_MEM_MALLOC_HUGE_ONLY);  // ✓ 强制使用大页内存

char key[65];
aclrtIpcMemGetExportKey(ptrA, largePageSize, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
```

**方案三：使用VMM接口实现进程间共享**

如果无法保证内存对齐，可以使用VMM（Virtual Memory Management）接口，它提供更灵活的内存管理和共享功能：

```cpp
// 进程A：使用VMM接口
const size_t dataSize = 1024 * sizeof(float);
aclrtPhysicalMemProp prop = {};
prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
prop.location.id = 0;
prop.memAttr = ACL_HBM_MEM_NORMAL;

// 查询内存申请粒度
size_t granularity = 0UL;
aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);

// 基于内存申请粒度申请物理内存（自动对齐）
size_t alignedSize = ((dataSize + granularity - 1U) / granularity) * granularity;
aclrtDrvMemHandle handle = nullptr;
aclrtMallocPhysical(&handle, alignedSize, &prop, 0);

// 预留虚拟内存
void *virPtr;
aclrtReserveMemAddress(&virPtr, alignedSize, 0, nullptr, 0);

// 将虚拟内存映射到物理内存
aclrtMapMem(virPtr, alignedSize, 0, handle, 0);

// 导出共享handle
uint64_t shareableHandle = 0ULL;
aclrtMemExportToShareableHandle(handle, ACL_MEM_HANDLE_TYPE_NONE,
                                ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION, &shareableHandle);
```

**方案四：检查内存对齐状态**

在导出IPC key前，可以先检查内存对齐状态：

```cpp
void *ptrA = nullptr;
aclrtSetDevice(0);
aclrtMalloc(&ptrA, size, ACL_MEM_MALLOC_HUGE_FIRST);

// 检查内存地址是否对齐（示例：4K对齐）
if ((uintptr_t)ptrA % 4096 != 0) {
    // 内存未对齐，需要调整分配策略或使用VMM接口
    printf("Warning: Memory not page-aligned, consider using VMM interface\n");
    aclrtFree(ptrA);
    // 切换到VMM方案或调整分配大小
} else {
    char key[65];
    aclrtIpcMemGetExportKey(ptrA, size, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
}
```

## 相关 issue

- [Issue #148: Stream有序内存分配IPC内存池共享](https://gitcode.com/cann/runtime/issues/148)