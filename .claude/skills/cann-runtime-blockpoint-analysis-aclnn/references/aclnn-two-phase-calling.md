# aclnn 两段式调用范式与核心概念

## 两段式调用范式（GetWorkspaceSize → Execute）

CANN 的 aclnn 预置算子统一采用**两段式调用**（Two-Phase Invocation）范式。
所有 aclnn 算子（如 aclnnAdd、aclnnSin、aclnnMatmul 等）都遵循相同的调用模式：

> **命名规范：** aclnn 函数名中，`aclnn` 前缀后的算子名使用**首字母大写、其余小写**的风格。
> 例如：`aclnnMatmul`（不是 `aclnnMatMul`）、`aclnnAdd`、`aclnnSin`。
> 对应的 GetWorkspaceSize 函数同理：`aclnnMatmulGetWorkspaceSize`。
其中“aclxx”表示算子接口前缀，如aclnn；而“Xxx”表示对应的算子类型，如Add算子。
```
aclnnStatus aclxxXxxGetWorkspaceSize(const aclTensor *src, ..., aclTensor *out, ..., uint64_t *workspaceSize, aclOpExecutor **executor);

aclnnStatus aclxxXxx(void *workspace, uint64_t workspaceSize, aclOpExecutor *executor, aclrtStream stream);
```
两段式接口的作为分别为：
- 第一段接口aclxxXxxGetWorkspaceSize：该接口内部执行入参校验、在动态Shape场景下推导输出Shape、数据切块（Tiling）以及计算执行算子所需的workspace内存大小等任务。

- 第二段接口aclxxXxx：执行算子计算，接口内部涉及DFX（例如Dump、溢出检测等）、调用Runtime提供的LaunchKernel接口等。

更多aclnn信息可以参阅[昇腾社区](https://www.hiascend.com/zh/document)

### 典型调用流程

```cpp
// === 第一段：获取 workspace 大小 ===
uint64_t workspaceSize = 0;
aclOpExecutor* executor = nullptr;
aclnnStatus ret = aclnn<Op>GetWorkspaceSize(
    inputTensor1, inputTensor2, ...,   // 输入 Tensor（const aclTensor*）
    outputTensor,                       // 输出 Tensor（aclTensor*）
    &workspaceSize,                     // [输出] 所需 workspace 字节数
    &executor);                         // [输出] 算子执行器

// === 分配 workspace（仅在 workspaceSize > 0 时需要）===
void* workspaceAddr = nullptr;
if (workspaceSize > 0) {
    aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST);
}

// === 第二段：执行计算 ===
ret = aclnn<Op>(workspaceAddr, workspaceSize, executor, stream);

// === 同步等待 ===
aclrtSynchronizeStream(stream);
```

### 为什么需要两段式？

1. **资源预分配**：第一段接口告知需要多少 Device 内存作为临时空间（workspace），
   避免执行期间动态分配内存
2. **参数校验前置**：第一段接口会校验所有输入参数的合法性（维度、数据类型等），
   在真正执行前就报告错误
3. **执行计划复用**：第一段生成的 executor 包含优化后的执行计划

## 核心概念

### workspace（工作空间）

- **定义**：算子执行过程中需要的 **Device 端临时内存**
- **由谁管理**：
  - 大小由第一段接口 `GetWorkspaceSize` 计算并返回
  - 内存由用户使用 `aclrtMalloc` 分配，执行完成后由用户释放
- **可能为 0**：部分算子不需要额外的 workspace，此时 `workspaceSize == 0`，
  无需分配，直接传 `nullptr`
- **生命周期**：workspace 内存在第二段接口调用期间被使用，
  `aclrtSynchronizeStream` 返回后即可安全释放

### executor（算子执行器，aclOpExecutor）

- **定义**：由第一段接口创建的**算子执行计划**对象
- **包含内容**：算子的计算流程、参数绑定、内部优化决策等
- **由谁管理**：
  - 由第一段接口 `GetWorkspaceSize` 创建并通过 `executor` 指针返回
  - 传递给第二段接口后由系统内部管理，**用户无需手动释放**
- **不可复用**：每次调用第一段接口生成的 executor 只能用于一次第二段调用

### aclnnStatus（返回状态码）

- aclnn 系列 API 的返回值类型为 `aclnnStatus`（而非 Runtime 的 `aclError`）
- 成功时返回 `0`（ACLNN_SUCCESS）
- 常见错误码：
  - `161001`（ACLNN_ERR_PARAM_NULLPTR）：参数为空指针
  - `161002`（ACLNN_ERR_PARAM_INVALID）：参数不合法

## aclnn 算子文档查找指引

aclnn 算子的 API 文档、示例代码和头文件**不在 Runtime 仓库中**，
而是分布在以下三个 ops 仓库中：

| 仓库 | 地址 | 算子类型 | 本地路径（clone 后） |
|------|------|---------|---------------------|
| ops-nn | https://gitcode.com/cann/ops-nn.git | 神经网络算子（卷积、池化、归一化等） | `reference/ops-nn/` |
| ops-transformer | https://gitcode.com/cann/ops-transformer.git | Transformer 相关算子（attention、layernorm 等） | `reference/ops-transformer/` |
| ops-math | https://gitcode.com/cann/ops-math.git | 数学运算算子（sin、cos、add、matmul 等） | `reference/ops-math/` |

### 如何查找特定算子的文档

以 `aclnnSin` 为例：

1. **确定所属仓库**：sin 是数学运算 → `ops-math`
2. **查找算子目录**：`reference/ops-math/math/sin/`
3. **目录结构**：
   ```
   math/sin/
   ├── docs/                          算子说明文档
   │   └── aclnnSin&aclnnInplaceSin.md   函数签名、参数说明、约束
   ├── op_api/                         头文件（供用户 include）
   │   └── aclnn_sin.h
   ├── op_host/op_api/                 内部实现头文件
   │   └── aclnn_sin.h
   ├── examples/                       示例代码
   │   └── test_aclnn_sin.cpp
   ├── tests/                          单元测试
   └── README.md
   ```
4. **关键文件**：
   - 函数签名和参数说明 → `docs/aclnn<Op>.md`
   - 头文件路径 → `op_api/aclnn_<op>.h`（编译时 include `aclnnop/aclnn_<op>.h`）
   - 示例代码 → `examples/test_aclnn_<op>.cpp`

### 头文件和链接库

使用 aclnn 算子时，编译需要：

| 头文件 | 用途 | 对应库文件 |
|--------|------|-----------|
| `acl/acl.h` | Runtime 基础 API | `libascendcl.so` |
| `aclnnop/aclnn_<op>.h` | 具体 aclnn 算子 API | `libopapi.so` + `libnnopbase.so` |

CMake 配置示例（来自 Runtime 仓库 `example/quickstart/CMakeLists.txt`）：

```cmake
include_directories(${ASCEND_CANN_PACKAGE_PATH}/include
                    ${ASCEND_CANN_PACKAGE_PATH}/aclnnop)
link_directories(${ASCEND_CANN_PACKAGE_PATH}/lib64)

target_link_libraries(main PRIVATE
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libascendcl.so
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libnnopbase.so
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libopapi.so
)
```

### Tensor/Scalar 创建 API

`aclCreateTensor` 和 `aclCreateScalar` 不属于 Runtime 仓库，
由 opbase 组件提供。其用法可从以下来源获取：

1. **Runtime quickstart 示例**：`example/quickstart/main.cpp` 中有完整调用示例
2. **ops 仓库示例**：各算子的 `examples/` 目录中有调用示例
3. **opbase 仓库**：正式 API 文档（如有）

`aclCreateTensor` 的参数顺序（从 quickstart 示例推断）：

```cpp
aclTensor* aclCreateTensor(
    const int64_t* viewDims,     // shape 数组
    uint64_t viewDimsNum,        // shape 维度数
    aclDataType dataType,        // 数据类型（ACL_FLOAT 等）
    const int64_t* stride,       // strides 数组
    int64_t offset,              // 偏移量（通常为 0）
    aclFormat format,            // 数据格式（ACL_FORMAT_ND 等）
    const int64_t* storageDims,  // 存储 shape（通常与 viewDims 相同）
    uint64_t storageDimsNum,     // 存储 shape 维度数
    void* tensorData             // Device 端数据地址
);
```
