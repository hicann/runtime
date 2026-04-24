# 核函数定义与 <<<>>> 内核调用符语法

> 来源：AscendC 官方文档（华为昇腾 CANN 商用版 8.5.0）
> 职责归属：AscendC（asc-devkit），非 Runtime 仓库

## 一、核函数定义

### 1. 核函数修饰符

核函数是直接在 NPU 芯片上执行的函数，使用 `__global__` 和 `__aicore__` 修饰：

```cpp
extern "C" __global__ __aicore__ void kernel_name(__gm__ uint8_t* param1, ...)
{
    // 核函数体
}
```

- `__global__`：标识该函数为核函数（Device 侧入口）
- `__aicore__`：标识该函数在 AI Core 上执行
- 两者**必须同时使用**

### 2. 参数规则

核函数的参数**只能是以下两种类型**：

| 参数类型 | 说明 | 示例 |
|---------|------|------|
| 指针类型 | 必须使用 `__gm__` 修饰，指向 Global Memory | `__gm__ uint8_t* x` |
| 值类型 | C/C++ 基本数据类型（非指针、非引用） | `float alpha`, `uint32_t n` |

**`__gm__` 限定符：**
- 表示指针指向 Global Memory（设备全局内存）
- 可使用宏 `GM_ADDR` 替代 `__gm__ uint8_t*`
- 核函数中，所有设备侧指针参数都必须加 `__gm__` 修饰

**返回值：** 核函数的返回类型**必须为 `void`**。

### 3. 模板核函数

核函数支持模板参数：

```cpp
template <typename T>
__global__ __aicore__ void kernel_name(__gm__ T* x, __gm__ T* y, uint32_t n)
{
    // ...
}
```

调用时需显式指定模板参数：
```cpp
kernel_name<half><<<blockDim, nullptr, stream>>>(x, y, n);
```

## 二、<<<>>> 内核调用符语法

### 1. 基本语法

```cpp
kernel_name<<<blockDim, l2ctrl, stream>>>(参数列表);
```

`<<<>>>` 是 AscendC 扩展的内核调用符，用于从 Host 侧发起核函数的执行。

### 2. 三个控制参数

| 参数 | 类型 | 含义 | 取值范围 |
|------|------|------|---------|
| `blockDim` | `uint32_t` | 核函数使用的核数（并行度） | [1, 65535] |
| `l2ctrl` | `void*` | 保留参数（L2 缓存控制） | **固定传 `nullptr`** |
| `stream` | `aclrtStream` | 执行流（任务队列） | 由 `aclrtCreateStream` 创建 |

**参数详细说明：**

- **blockDim**：规定了核函数将使用多少个 AI Core 并行执行。取值范围 1~65535。
  实际使用时应根据硬件核数和算子并行策略确定。

- **l2ctrl**：当前版本为**保留参数**，必须传 `nullptr`。未来可能用于 L2 缓存策略控制。

- **stream**：指定核函数在哪个 Stream 上执行。Stream 由 Runtime API `aclrtCreateStream(&stream)` 创建，
  核函数的执行是**异步**的——`<<<>>>` 调用立即返回，核函数在 Device 侧异步执行。
  需要通过 `aclrtSynchronizeStream(stream)` 等待执行完成。

### 3. 完整调用示例

```cpp
#include "acl/acl.h"

// 核函数声明
extern "C" __global__ __aicore__ void vector_add(
    __gm__ half* x, __gm__ half* y, __gm__ half* z, uint32_t n);

int main() {
    // ... 初始化、内存分配 ...

    aclrtStream stream;
    aclrtCreateStream(&stream);

    // 使用 8 个核并行执行
    uint32_t blockDim = 8;
    vector_add<<<blockDim, nullptr, stream>>>(d_x, d_y, d_z, elementCount);

    // 等待执行完成
    aclrtSynchronizeStream(stream);

    // ... 拷回结果、清理资源 ...
}
```

### 4. 异步执行特性

- `<<<>>>` 调用是**异步**的：调用后 Host 立即返回，不等待 Device 执行完成
- 必须调用 `aclrtSynchronizeStream(stream)` 或 `aclrtSynchronizeDevice()` 来同步
- 同一 Stream 上的多个核函数按提交顺序执行（FIFO）
- 不同 Stream 上的核函数可以并行执行

## 三、核函数属性与构建系统兼容性

| 属性 | 用途 | 构建系统要求 |
|------|------|-------------|
| `__aicore__` | 通用 AI Core 核函数 | `ascendc_library()` 或 ASC 构建系统均可 |
| `__cube__` | Cube 核函数（矩阵乘法等） | **仅 ASC 构建系统**（`.asc` + `find_package(ASC)`） |
| `__mix__(m, n)` | 混合核函数（AIC + AIV） | **仅 ASC 构建系统**（`.asc` + `find_package(ASC)`） |

`ascendc_library()` 是 legacy CMake 宏，只支持 `__aicore__`。
验证包统一使用 `__aicore__` 属性。

## 四、断点分析中的职责归属

| 知识点 | 职责归属 |
|--------|---------|
| `<<<>>>` **语法定义**（三个控制参数的含义和取值） | AscendC（asc-devkit） |
| `<<<>>>` **使用示例**（在 Runtime 上下文中如何调用） | Runtime 仓库 |
| 核函数编写规范（`__global__`、`__aicore__`、`__gm__`） | AscendC（asc-devkit） |
| 核函数属性（`__aicore__`、`__cube__`、`__mix__`）及构建系统要求 | AscendC（asc-devkit） |
| `aclrtCreateStream`、`aclrtSynchronizeStream` 等 | Runtime 仓库 |
| 核函数编译流程（ASC 编译器、CMake 集成） | AscendC（asc-devkit） |

**在断点分析中：**
- `<<<>>>` 语法定义相关的文档缺失 → 记录为**外源知识缺失**（不计入 Runtime 整改项）
- `<<<>>>` 在 Runtime 示例中的使用缺失 → 记录为 **Runtime 缺陷**
- `__cube__`/`__mix__` 与 `ascendc_library()` 不兼容 → 记录为**外源知识缺失**
