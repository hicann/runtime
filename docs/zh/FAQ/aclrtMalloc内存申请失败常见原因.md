# aclrtMalloc内存申请失败常见原因

## 问题现象描述

**现象1：调用aclrtMalloc接口申请Device内存时返回内存申请失败错误码**

调用 aclrtMalloc 接口申请 Device 内存时返回错误码 207001（ACL_ERROR_RT_MEMORY_ALLOCATION），表示内存申请失败。

报错日志示例如下：
```
aclrtMalloc failed, ret = 207001, size=10485760
[ERROR] RUNTIME: Failed to allocate device memory, device_id=0, size=10485760
```

## 可能原因

1. **Device 内存不足或申请大小不合理**：设备内存已被大量占用、申请大小超过设备内存总容量、并发申请超过系统资源上限，剩余容量不足以满足申请需求。
2. **内存分配策略配置不当**：强制使用大页策略（如 ACL_MEM_MALLOC_HUGE_ONLY）但大页内存不足。

## 处理步骤

### 原因1：Device 内存不足或申请大小不合理

**解决方法**：
- 检查内存容量：使用 npu-smi 工具查看设备内存使用情况
- 释放已分配内存：调用 aclrtFree 释放不再使用的内存
- 减少申请大小：优化业务逻辑，减少一次性申请的内存量
- 检查 size 参数：确认申请大小合理，不超过设备内存总容量
- 预分配并复用：初始化阶段预分配固定内存池，业务中复用

命令示例：
```bash
# 查看设备内存使用情况
npu-smi info -t memory

# 输出示例：
# Device ID: 0
# HBM Total: 32GB
# HBM Used: 28GB
# HBM Free: 4GB
```

代码示例：
```c
// 检查内存使用情况后合理申请
void* devPtr = nullptr;
size_t size = 1024 * 1024;  // 1MB

// 先释放不再使用的内存
if (oldDevPtr != nullptr) {
    aclrtFree(oldDevPtr);
    oldDevPtr = nullptr;
}

// 再申请新内存
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
```

### 原因2：内存分配策略配置不当

**解决方法**：
- 理解策略含义：
  - ACL_MEM_MALLOC_HUGE_FIRST：优先大页，不足时退回普通页（推荐）
  - ACL_MEM_MALLOC_HUGE_ONLY：仅大页，不足时报错
  - ACL_MEM_MALLOC_NORMAL_ONLY：仅普通页
- 选择合适策略：根据实际内存容量和性能需求选择
- 调整策略为 HUGE_FIRST：避免强制大页导致的申请失败

策略选择建议：
```c
// 推荐策略：大页优先，不足时退回普通页
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);

// 不推荐策略：仅大页，大页不足时会失败
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);  // 可能失败

// 普通页策略：适合小块内存或内存紧张场景
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
```

## 相关 issue

- [Issue #476: aclrtMallocPhysical申请大页内存限制](https://gitcode.com/cann/runtime/issues/476)