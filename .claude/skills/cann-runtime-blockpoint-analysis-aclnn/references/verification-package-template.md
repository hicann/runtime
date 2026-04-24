# 验证包文件模板

本文件为 Step 9 验证包生成提供各文件的模板。
模板中使用 `{算子名}` 和 `{算子名小写}` 作为占位符，生成时替换为实际算子名。

参考 `example/0_quickstart/0_hello_cann`（aclnnAdd 向量加法）的代码风格。

> **设计原则：** 验证包不仅验证 Runtime 调用流程能否走通，**同时进行精度验证**。
> 在 Host 侧根据算子数学公式计算 expected 值，与 Device 输出逐元素对比。

---

## 1. README.md 模板

```markdown
# {算子名} aclnn 预置算子验证包

## 概述

使用 aclnn 两段式调用方式验证 {算子名} 算子的 Runtime 调用流程。

运算公式：{写出算子的数学公式，如 out = self + alpha * other}

## 目录说明

{算子名小写}_verify/
├── CMakeLists.txt
├── main.cpp               Host 代码（aclnn 两段式调用，数据硬编码）
├── run.sh                 一键编译运行
└── README.md              本文件

## 前置条件

- Atlas A2 或 A3 系列 NPU 硬件
- CANN Toolkit 已安装（含 Runtime + 算子库）
- GCC >= 7.3, CMake >= 3.16

## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

    # ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
    source ${install_root}/cann/set_env.sh
    export ASCEND_INSTALL_PATH=${install_root}/cann

## 快速使用

    cd {算子名小写}_verify/
    bash run.sh
    ./build/main

## 正确性判定

程序输出 `Sample run successfully!` 且打印的计算结果与 expected 值一致即验证通过。

## 相关 API

| API | 说明 |
|-----|------|
| `aclInit` | 初始化 ACL |
| `aclrtSetDevice` | 设置设备 |
| `aclrtCreateStream` | 创建 Stream |
| `aclrtMalloc` | 分配 Device 内存 |
| `aclrtMemcpy` | 内存拷贝 |
| `aclCreateDataBuffer` | 创建 DataBuffer |
| `aclGetDataBufferAddr` | 获取 DataBuffer 中保存的内存地址 |
| `aclCreateTensor` | 创建 Tensor |
| `aclCreateScalar` | 创建 Scalar（如算子需要） |
| `{算子名}GetWorkspaceSize` | 获取算子所需 workspace 大小 |
| `{算子名}` | 执行算子运算 |
| `aclrtSynchronizeStream` | 同步 Stream |
| `aclDestroyTensor` | 销毁 Tensor |
| `aclDestroyScalar` | 销毁 Scalar |
| `aclDestroyDataBuffer` | 销毁 DataBuffer |
| `aclrtFree` | 释放 Device 内存 |
| `aclrtDestroyStream` | 销毁 Stream |
| `aclrtResetDeviceForce` | 重置设备 |
| `aclFinalize` | 释放 ACL 资源 |

## 预期输出

    {根据算子输入数据计算出的预期输出示例}
    Sample run successfully!
```

---

## 2. CMakeLists.txt 模板

对齐 `example/0_quickstart/0_hello_cann/CMakeLists.txt` 的风格：

```cmake
# CMake 最低版本要求
cmake_minimum_required(VERSION 3.16.0)

# 项目信息
project({算子名}_Sample)

# Include directories and libraries
include_directories(${ASCEND_CANN_PACKAGE_PATH}/include
                    ${ASCEND_CANN_PACKAGE_PATH}/aclnnop)
link_directories(${ASCEND_CANN_PACKAGE_PATH}/lib64)

add_executable(main main.cpp)

target_compile_options(main PRIVATE
    -O2 -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -Wall -Werror
)

target_link_libraries(main PRIVATE
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libascendcl.so
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libnnopbase.so
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libopapi.so
)
```

---

## 3. main.cpp 模板

对齐 `example/0_quickstart/0_hello_cann/main.cpp` 的代码结构和风格。

关键要求：
1. 输入数据硬编码为 `std::vector`（小规模，如 8 个元素），不使用外部数据文件
2. 使用 `CreateAclTensor` 模板函数封装 Tensor 创建
3. 使用 `DestroyTensorResources` 函数封装资源释放
4. 使用 `aclCreateDataBuffer` / `aclGetDataBufferAddr` 包装输出内存
5. 结果通过 `printf` 逐元素打印（含 expected 值对比）
6. 使用 `aclrtResetDeviceForce` 复位设备
7. **aclnn 函数命名规范**：`aclnn` 前缀后使用首字母大写、其余小写的风格。
   例如：`aclnnMatmul`（不是 `aclnnMatMul`）、`aclnnMatmulGetWorkspaceSize`（不是 `aclnnMatMulGetWorkspaceSize`）。
   头文件同理：`aclnnop/aclnn_matmul.h`（全小写下划线分隔）

```cpp
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "acl/acl.h"
#include "aclnnop/{算子头文件}.h"   // 替换为实际算子头文件，如 aclnn_add.h

#define CHECK_ERROR(ret)                                       \
    if ((ret) != ACL_SUCCESS) {                                \
        printf("Error at line %d, ret = %d\n", __LINE__, ret); \
        return -1;                                             \
    }

// 计算张量的元素总数
int64_t GetShapeSize(const std::vector<int64_t>& shape)
{
    int64_t shape_size = 1;
    for (auto i : shape) {
        shape_size *= i;
    }
    return shape_size;
}

// 创建 ACL Tensor 并分配设备内存
template <typename T>
int CreateAclTensor(
    const std::vector<T>& hostData, const std::vector<int64_t>& shape, void** deviceAddr, aclDataType dataType,
    aclTensor** tensor)
{
    auto size = GetShapeSize(shape) * sizeof(T);

    // 在设备上分配内存
    CHECK_ERROR(aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST));

    // 将数据从主机同步复制到设备
    CHECK_ERROR(aclrtMemcpy(*deviceAddr, size, hostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));

    // 计算 strides
    std::vector<int64_t> strides(shape.size(), 1);
    for (int64_t i = shape.size() - 2; i >= 0; i--) {
        strides[i] = shape[i + 1] * strides[i + 1];
    }

    // 创建 tensor
    *tensor = aclCreateTensor(
        shape.data(), shape.size(), dataType, strides.data(), 0, aclFormat::ACL_FORMAT_ND, shape.data(), shape.size(),
        *deviceAddr);
    if (*tensor == nullptr) {
        printf("Create tensor failed\n");
        return -1;
    }

    return 0;
}

int main()
{
    // ===== 1. 初始化 =====
    CHECK_ERROR(aclInit(NULL));
    printf("ACL init successfully\n");

    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));
    printf("Set device %d successfully\n", deviceId);

    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));
    printf("Create stream successfully\n");

    // ===== 2. 数据准备（根据算子调整） =====
    // 定义 shape 和硬编码输入数据
    // std::vector<int64_t> shape{8};
    // std::vector<float> selfHostData = {1.0f, 2.0f, ...};
    // std::vector<float> outHostData(8, 0.0f);

    // 打印输入数据
    // printf("Input: ...\n");

    // ===== 3. 创建 Tensor =====
    // void* selfDeviceAddr = nullptr;
    // aclTensor* self = nullptr;
    // CHECK_ERROR(CreateAclTensor(selfHostData, shape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));

    // 创建输出 Tensor
    // void* outDeviceAddr = nullptr;
    // aclTensor* out = nullptr;
    // CHECK_ERROR(CreateAclTensor(outHostData, shape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    // 使用 aclCreateDataBuffer 包装输出内存
    // aclDataBuffer* outDataBuffer = aclCreateDataBuffer(outDeviceAddr, outHostData.size() * sizeof(float));
    // void* outBufferAddr = aclGetDataBufferAddr(outDataBuffer);

    // 创建 Scalar（如算子需要）
    // float alphaValue = 1.0f;
    // aclScalar* alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);

    // ===== 4. aclnn 两段式调用 =====
    uint64_t workspaceSize = 0;
    aclOpExecutor* executor = nullptr;
    // CHECK_ERROR({算子名}GetWorkspaceSize(..., &workspaceSize, &executor));
    // printf("Get workspace size successfully, workspace size = %lu\n", workspaceSize);

    void* workspaceAddr = nullptr;
    if (workspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
        printf("Allocate workspace successfully\n");
    }

    // CHECK_ERROR({算子名}(workspaceAddr, workspaceSize, executor, stream));
    // printf("Launch {算子名} successfully\n");

    // ===== 5. 同步 =====
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    printf("Synchronize stream successfully\n");

    // ===== 6. 结果回传与打印 =====
    // auto size = GetShapeSize(shape);
    // std::vector<float> resultData(size, 0.0f);
    // CHECK_ERROR(aclrtMemcpy(
    //     resultData.data(), resultData.size() * sizeof(float), outBufferAddr, size * sizeof(float),
    //     ACL_MEMCPY_DEVICE_TO_HOST));

    // 逐元素打印结果（含 expected 对比）
    // printf("\nResult:\n");
    // for (int64_t i = 0; i < size; i++) {
    //     printf("  result[%ld] = %.1f (expected: %.1f)\n", i, resultData[i], expectedData[i]);
    // }

    // ===== 7. 资源释放 =====
    // DestroyTensorResources(...)  — 销毁所有 Tensor 和 Scalar
    // aclDestroyDataBuffer(outDataBuffer);
    // aclrtFree(各 deviceAddr);
    if (workspaceAddr != nullptr) aclrtFree(workspaceAddr);
    aclrtDestroyStream(stream);
    printf("Destroy stream successfully\n");

    aclrtResetDeviceForce(deviceId);
    printf("Reset device successfully\n");

    aclFinalize();
    printf("ACL finalize successfully\n");

    printf("\nSample run successfully!\n");
    return 0;
}
```

---

## 4. run.sh 模板

对齐 `example/0_quickstart/0_hello_cann/run.sh` 的风格：

```bash
#!/bin/bash
set -e

# Load the CANN environment.
_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH
source "$_ASCEND_INSTALL_PATH/bin/setenv.bash"

# Enter the sample directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

# Configure the build directory.
BUILD_DIR="${SCRIPT_DIR}/build"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "Configuring CMake..."
cmake .. \
    -DASCEND_CANN_PACKAGE_PATH="${_ASCEND_INSTALL_PATH}"

echo "Building..."
make -j"$(nproc)"

cd "${SCRIPT_DIR}"

echo "Build completed successfully!"
echo "Executable location: ${SCRIPT_DIR}/build/main"
echo "Run the sample: ./build/main"
```

---

## 注意事项

1. **精度验证（强制）** — 验证包不仅验证 Runtime 调用流程（初始化 → Tensor 创建 → 两段式调用 → 同步 → 结果回传 → 资源释放），还必须在 Host 侧根据算子数学公式计算 expected 值，与 Device 输出逐元素打印对比，确认精度一致
2. **数据硬编码** — 输入数据直接以 `std::vector` 写在 `main.cpp` 中，不使用外部文件（`.bin`）或 Python 脚本生成数据
3. **结果目视确认** — 通过 `printf` 打印每个输出元素及其 expected 值，由用户目视确认
4. **expected 必须真实** — aclnn 调用的是真实算子，expected 值按算子数学语义 + 实际输入数据手动计算
5. **CMake 变量** — 使用 `ASCEND_CANN_PACKAGE_PATH`（通过 cmake -D 传入），而非 `ASCEND_INSTALL_PATH` 环境变量
6. **链接方式** — 直接链接 `.so` 全路径（`${ASCEND_CANN_PACKAGE_PATH}/lib64/libascendcl.so` 等），而非使用 `-lascendcl`
7. **禁止外部路径依赖** — `include_directories` 只包含 `${ASCEND_CANN_PACKAGE_PATH}/include` 和 `${ASCEND_CANN_PACKAGE_PATH}/aclnnop`，**禁止** `../`、`${CMAKE_CURRENT_SOURCE_DIR}/../..` 等相对路径
8. **aclnn 命名规范** — `aclnn` + 首字母大写其余小写（如 `aclnnMatmul` 不是 `aclnnMatMul`），头文件 `aclnnop/aclnn_{全小写}.h`。命名错误会直接导致编译失败
9. **与 Kernel Launch 验证包的区别** — 无需 ASC 编译器，无需 `.asc` 文件，使用标准 C++ 编译器和 CMake
