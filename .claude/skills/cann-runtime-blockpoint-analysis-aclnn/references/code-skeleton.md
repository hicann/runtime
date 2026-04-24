# $0 代码骨架与步骤分解

## 目标任务

**使用 $0 完成计算任务**（具体输入输出由算子定义决定）
- 输入/输出：需根据 $0 的参数签名确定（从 docs/ 或 example/ 中查找）
- 调用方式：使用 CANN 内置算子 $0（预置算子库路径）
- 参考：如仓库中有 $0 对应示例则优先参考，否则以 `example/quickstart/`（aclnnAdd）为模板

**算子签名发现：**
在编写代码前，先在仓库中搜索 $0 的函数签名：
1. 搜索 `example/` 中是否有 $0 示例代码
2. 搜索 `docs/` 中是否有 $0 API 文档
3. 如仓库中找不到 $0 的签名信息，这本身就是一个断点——记录下来
4. 根据发现的签名信息（或参考 quickstart 的 aclnnAdd 模式）填充下方代码骨架

## 完整代码骨架

```cpp
#include <acl/acl.h>
#include [UNKNOWN: $0 的头文件路径，约定为 aclnnop/aclnn_<operator>.h]
// 其他必要的头文件 [需要从文档确认]

#define CHECK_ERROR(ret) \
    if ((ret) != ACL_SUCCESS) { \
        printf("Error at line %d, ret = %d\n", __LINE__, ret); \
        return -1; \
    }

int main() {
    // ==================== Step 1: 初始化 ====================
    // 1. aclInit — 初始化 ACL 运行时环境
    aclError ret = aclInit(nullptr);  // [需确认：参数是否为 nullptr？]

    // ==================== Step 2: Device/Stream ====================
    // 2. aclrtSetDevice — 设置当前使用的设备
    int32_t deviceId = 0;
    ret = aclrtSetDevice(deviceId);

    // 3. aclrtCreateStream — 创建 Stream
    aclrtStream stream = nullptr;
    ret = aclrtCreateStream(&stream);

    // ==================== Step 4-5: 内存管理 ====================
    // 4. 准备 Host 数据
    // [需根据 $0 的参数签名确定输入数据的维度、类型和数量]
    // [从 docs/ 或 example/ 中查找 $0 的函数签名]
    // 示例（需替换为实际参数）：
    //   - 输入 Tensor 数量和维度：[待确定]
    //   - 输出 Tensor 数量和维度：[待确定]
    //   - 数据类型：[待确定]
    //   - 标量参数（如有）：[待确定]

    // 5. 申请 Device 内存
    // [根据 $0 的输入输出 Tensor 数量和大小分配]
    // void *inputDevAddr, *outputDevAddr;
    // size_t size = [待确定] * sizeof([待确定]);
    // ret = aclrtMalloc(&inputDevAddr, size, [UNKNOWN: 内存分配策略参数]);
    // ret = aclrtMalloc(&outputDevAddr, size, [UNKNOWN: 内存分配策略参数]);

    // ==================== Step 6: 数据拷贝 ====================
    // 6. 将数据从 Host 拷贝到 Device
    // ret = aclrtMemcpy(inputDevAddr, size, hostData, size, [UNKNOWN: 拷贝方向枚举]);

    // ==================== Step 7: 创建 Tensor/Scalar ====================
    // 7a. 创建输入输出 Tensor
    // [Tensor 数量和维度取决于 $0 的参数签名]
    // std::vector<int64_t> shape{...};  // [待确定：维度]
    [UNKNOWN: aclCreateTensor 的完整调用方式]
    // 需要知道：shape, strides, dataType, format, offset 等参数

    // 7b. 创建 Scalar（如 $0 需要标量参数）
    // [如 $0 不需要标量参数，跳过此步骤]
    [UNKNOWN: aclCreateScalar 的完整调用方式]
    // 需要知道：标量值指针、数据类型

    // ==================== Step 8: $0 调用 ====================
    // 8a. 获取 workspace 大小
    uint64_t workspaceSize = 0;
    aclOpExecutor* executor = nullptr;
    [UNKNOWN: $0GetWorkspaceSize 的完整调用方式]
    // 需要知道：参数顺序、返回值含义

    // 8b. 分配 workspace
    void* workspaceAddr = nullptr;
    if (workspaceSize > 0) {
        ret = aclrtMalloc(&workspaceAddr, workspaceSize, [UNKNOWN: 内存分配策略]);
    }

    // 8c. 执行 $0
    [UNKNOWN: $0 的完整调用方式]
    // 需要知道：workspace, workspaceSize, executor, stream 的传递方式

    // ==================== Step 9: 同步 ====================
    // 9. 同步等待执行完成
    ret = aclrtSynchronizeStream(stream);

    // ==================== Step 10: 结果回传 ====================
    // 10. 将结果从 Device 拷贝回 Host
    // [根据输出 Tensor 大小分配 Host 缓冲区]
    // ret = aclrtMemcpy(resultData, size, outputDevAddr, size, [UNKNOWN: 拷贝方向枚举]);

    // ==================== Step 11-12: 验证与清理 ====================
    // 11. 验证结果
    // [根据 $0 的数学定义验证输出结果的正确性]

    // 12. 释放所有资源
    [UNKNOWN: aclDestroyTensor 的调用方式]
    // [如有 Scalar] [UNKNOWN: aclDestroyScalar 的调用方式]
    // aclrtFree(inputDevAddr);
    // aclrtFree(outputDevAddr);
    if (workspaceAddr) aclrtFree(workspaceAddr);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();

    return 0;
}
```

## 步骤分解与关注重点

| 步骤 | 代码行为 | 关注重点 | 断点风险 |
|------|---------|---------|---------|
| Step 1 | aclInit | 参数说明、头文件路径 | 低 |
| Step 2 | SetDevice + CreateStream | 三者关系、参数含义 | 低 |
| Step 3 | 理解 aclnn 范式 | 两段式调用、概念文档 | **高（衔接区）** |
| Step 4 | aclCreateTensor（+ Scalar 如需要） | 参数含义、strides 计算 | **高（衔接区）** |
| Step 5 | 框架代码 - 内存管理 | Malloc/Memcpy 参数 | 中 |
| Step 5 | 框架代码 - $0 调用 | GetWorkspaceSize + Execute | **高（衔接区）** |
| Step 6 | 错误处理 | 错误码枚举 | 中 |
| Step 7 | 编译构建 | 链接库、头文件路径 | 中（衔接区） |
| Step 8 | 运行验证 | 预期输出 | 低 |

## 核心衔接区域标记

以下 API 是 aclnn 算子库与 Runtime 的衔接重点，最容易出现断点：

1. **aclCreateTensor** — 需要知道 shape/strides/format/dataType 的传递方式
2. **aclCreateScalar** — 如 $0 需要标量参数，需要知道标量值的传递方式
3. **$0GetWorkspaceSize** — 需要理解 workspace + executor 概念
4. **$0** — 需要知道 workspace, workspaceSize, executor, stream 的传参方式
5. **aclDestroyTensor / aclDestroyScalar** — 资源释放
6. **头文件和链接库** — aclnnop/ 下 $0 对应头文件、libnnopbase.so、libopapi.so
