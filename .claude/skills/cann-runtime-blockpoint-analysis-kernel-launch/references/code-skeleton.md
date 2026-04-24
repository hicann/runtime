# $0 代码骨架与步骤分解

## 目标算子

**自定义核函数算子（$0）**（具体功能由用户提供的算子信息定义）
- 输入/输出：需根据用户提供的算子信息确定
- 调用方式：AscendC 自定义核函数 → `<<<>>>` 内核调用符语法（Kernel Launch 路径）
- 参考：`example/kernel/0_launch_kernel/` 和 `docs/02_dev_guide/Kernel加载与执行.md` 中的示例

**算子信息发现：**
在编写代码前，先在仓库中搜索 $0 的相关信息：
1. 搜索 `example/` 中是否有 $0 相关示例代码
2. 搜索 `docs/` 中是否有相关 API 文档
3. 如仓库中找不到 $0 相关信息，以用户提供的算子信息和 `example/kernel/` 中的通用示例为参考
4. 将仓库中发现的信息与用户提供的算子信息进行对比，确认哪些属于 Runtime 职责、哪些属于外源知识

## 完整代码骨架

```cpp
#include "acl/acl.h"
#include "kernel_operator.h"  // AscendC 核函数头文件 [外源知识]
// 其他必要的头文件 [需要从文档确认]

// ==================== 核函数定义（外源知识，由 ASC 编译器处理）====================
// 核函数由用户提供的算子信息定义
// 使用 ASC 构建系统（find_package(ASC) + .asc 单文件）
// 核函数属性：__vector__（简化/vector kernel）、__cube__（cube kernel）、__mix__(m,n)（mix kernel）
// 禁止使用 extern "C" 和 __aicore__
// __global__ __vector__ void $0_custom(GM_ADDR ...);

int main() {
    // ==================== Step 1: 初始化 ====================
    // 1. aclInit — 初始化 ACL 运行时环境
    aclInit(nullptr);  // [需确认：参数是否为 nullptr？]

    // ==================== Step 2: Device + Stream ====================
    // 2. aclrtSetDevice — 设置当前使用的设备
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);  // [需确认：deviceId 从何获取？]

    // 3. aclrtCreateStream — 创建 Stream
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);  // [需确认：参数含义]

    // ==================== Step 4-5: 内存管理 ====================
    // 4. 申请 Host 内存
    // [根据用户提供的 $0 输入/输出信息确定数据类型、维度和大小]
    // size_t inputSize = [用户提供: 输入数据大小];
    // size_t outputSize = [用户提供: 输出数据大小];
    uint8_t *hostInput;
    aclrtMallocHost((void **)&hostInput, inputSize);
    // 初始化输入数据（如从文件读取）...

    // 5. 申请 Device 内存
    uint8_t *devInput;
    uint8_t *devOutput;
    aclrtMalloc((void **)&devInput, inputSize, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc((void **)&devOutput, outputSize, ACL_MEM_MALLOC_HUGE_FIRST);

    // ==================== Step 6: 数据拷贝 ====================
    // 6. 将输入数据从 Host 拷贝到 Device
    aclrtMemcpy(devInput, inputSize, hostInput, inputSize, ACL_MEMCPY_HOST_TO_DEVICE);

    // ==================== Step 7: <<<>>> 内核调用符 ====================
    // 7. 使用内核调用符语法调用核函数
    uint32_t blockDim = 1;  // [需确认：blockDim 的含义和计算方式]
    $0_custom<<<blockDim, nullptr, stream>>>(devInput, devOutput);
    // <<<blockDim, l2ctrl, stream>>>(args...)
    // blockDim: 核函数并行执行的 block 数量
    // l2ctrl: L2 缓存控制参数（通常为 nullptr）
    // stream: 执行流
    // args: 核函数参数（Device 指针等）

    // ==================== Step 8: 同步 ====================
    // 8. 同步等待执行完成
    aclrtSynchronizeStream(stream);

    // ==================== Step 9: 结果回传 ====================
    // 9. 将结果从 Device 拷贝回 Host
    uint8_t *hostOutput;
    aclrtMallocHost((void **)&hostOutput, outputSize);
    aclrtMemcpy(hostOutput, outputSize, devOutput, outputSize, ACL_MEMCPY_DEVICE_TO_HOST);

    // ==================== Step 10: 验证结果 ====================
    // 10. 验证结果
    // [根据 $0 的数学定义验证输出结果的正确性]

    // ==================== Step 11: 资源释放 ====================
    // 11. 释放所有资源
    aclrtFree(devInput);
    aclrtFree(devOutput);
    aclrtFreeHost(hostInput);
    aclrtFreeHost(hostOutput);
    aclrtDestroyStream(stream);
    aclrtResetDevice(deviceId);
    aclFinalize();

    return 0;
}
```

## 步骤分解与关注重点

| 步骤 | 代码行为 | 关注重点 | 断点风险 |
|------|---------|---------|---------|
| Step 1 | aclInit | 参数说明、头文件路径 | 低 |
| Step 2 | SetDevice + CreateStream | 两者关系、参数含义、是否需要显式 CreateContext | 中 |
| Step 3 | 核函数编写 | AscendC 编程范式（外源知识） | 视算子复杂度 |
| Step 4 | 核函数编译 | ASC 编译器、CMake 配置（外源知识） | 中 |
| Step 5 | 框架代码 - 内存管理 | MallocHost/Malloc/Memcpy 参数 | 中 |
| Step 5 | 框架代码 - <<<>>> 调用 | 内核调用符语法、blockDim/l2ctrl/stream 参数含义 | **高（核心区域）** |
| Step 6 | 错误处理 | 错误码枚举 | 中 |
| Step 7 | 编译构建 | ASC CMake 配置、链接库 | 中 |
| Step 8 | 运行验证 | 预期输出 | 低 |
| Step 9 | 验证包生成 | 完整可编译代码、一键脚本、精度验证 | — |

## 核心区域标记

以下是 `<<<>>>` 内核调用符路径的核心关注点，最容易出现断点：

1. **`<<<>>>` 语法文档** — 内核调用符的完整语法说明（blockDim、l2ctrl、stream 三个参数的含义）
2. **blockDim 参数** — 如何确定并行 block 数量
3. **核函数参数传递** — Device 指针如何传入核函数
4. **ASC 编译器配置** — `.asc` 文件编译、`find_package(ASC REQUIRED)` 等 CMake 集成
5. **`--npu-arch` 参数** — 如何确定目标硬件架构
