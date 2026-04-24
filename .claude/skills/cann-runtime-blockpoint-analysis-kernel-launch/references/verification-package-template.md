# 验证包文件模板（ASC 构建系统）

本文件为 Step 9 验证包生成提供各文件的模板。
模板中使用 `{算子名}` 和 `{算子名小写}` 作为占位符，生成时替换为实际算子名。

**构建系统：** `find_package(ASC)` + `.asc` 单文件（**禁止使用 `ascendc_library()`**）。

> **设计原则：** 验证包验证 Runtime 调用流程能否走通，**同时进行精度验证**。
> 在 Host 侧根据算子数学公式计算 expected 值，与 Device 输出逐元素对比。

---

## 1. README.md 模板

```markdown
# {算子名} Kernel Launch 验证包

## 概述

使用 <<<>>> 内核调用符方式验证 {算子名} 自定义 Kernel 的 Runtime 调用流程。

运算公式：{写出算子的数学公式，如 dst = srcA + alpha * srcB}

## 目录说明

{算子名小写}_verify/
├── CMakeLists.txt              find_package(ASC) 编译配置
├── {算子名小写}.asc              单文件：kernel + host main
├── run.sh                      一键编译脚本
└── README.md                   本文件

## 支持的产品型号

- Atlas A2 训练/推理系列产品（默认 --npu-arch=dav-2201）
- Atlas A3 训练/推理系列产品（需改 --npu-arch=dav-3510）

## 前置条件

- Atlas A2 或 A3 系列 NPU 硬件
- CANN Toolkit 已安装（含 ASC 编译器）
- GCC >= 7.3, CMake >= 3.16

## 环境变量设置

    # ${install_root} 替换为 CANN 安装根目录
    source ${install_root}/cann/set_env.sh
    export ASCEND_INSTALL_PATH=${install_root}/cann

注意：ASC 构建系统不需要 SOC_VERSION 和 ASCENDC_CMAKE_DIR 环境变量。

## 修改目标 NPU 架构

编辑 CMakeLists.txt，注释/取消注释对应的 --npu-arch 行。

## 快速使用

    bash run.sh
    ./build/main

## 预期输出

    {根据核函数实际逻辑计算出的预期输出示例}
    Sample run successfully with <<<>>> kernel call!
```

---

## 2. CMakeLists.txt 模板

```cmake
cmake_minimum_required(VERSION 3.16)
find_package(ASC REQUIRED)
project({算子名}_Verify LANGUAGES ASC CXX)

add_executable(main {算子名小写}.asc)

target_link_libraries(main PRIVATE
    m
    dl
)

# NPU architecture: adjust to your hardware
target_compile_options(main PRIVATE
    $<$<COMPILE_LANGUAGE:ASC>:--npu-arch=dav-2201>   # Atlas A2 / Ascend 910B（默认）
    # $<$<COMPILE_LANGUAGE:ASC>:--npu-arch=dav-3510> # Atlas A3 / Ascend 950
)
```

如需 tiling 等库，按需添加：
```cmake
target_link_libraries(main PRIVATE
    tiling_api
    register
    platform
    m
    dl
)
```

---

## 3. {算子名小写}.asc 模板

**⚠️ 核函数规则（强制）：**
- **必须使用真实核函数**：从 `reference/asc-devkit/` 完整复制算子的核函数代码，禁止简化为 element-wise copy
- 核函数属性与 `reference/` 原始代码保持一致（`__vector__`/`__cube__`/`__mix__(m,n)`）
- 如果 `reference/` 原始代码使用了 `extern "C"`，保留之
- **禁止** `__aicore__`（ASC 下无法推导类型，报 `auto type derivate failed`）
- `ReadFile`/`WriteFile` 替换为硬编码数据初始化 + `printf` 输出（唯一允许的修改）
- 如有辅助头文件（`data_utils.h`、`nd2nz_utils.h` 等），一并复制到验证包中

```cpp
/**
 * {算子名} verification using ASC build system.
 * Single-file (.asc): REAL kernel + host in one file.
 * Kernel code copied from reference/asc-devkit/, ReadFile/WriteFile replaced with hardcoded data.
 */

#include "acl/acl.h"
#include "kernel_operator.h"
#include "data_utils.h"
// 按需添加其他头文件（如 tiling/tiling_api.h, kernel_tiling/kernel_tiling.h 等）

#include <cstdint>
#include <cstdio>
#include <cstring>
#include <vector>

// ==================== Kernel ====================
// 从 reference/asc-devkit/ 完整复制核函数代码
// 包括核函数类、辅助函数、tiling 生成函数等
// 保持原始的 __vector__/__cube__/__mix__(m,n) 属性标注

// ==================== Host ====================

#define CHECK_ERROR(ret)                                       \
    if ((ret) != ACL_SUCCESS) {                                \
        printf("Error at line %d, ret = %d\n", __LINE__, ret); \
        return -1;                                             \
    }

int main()
{
    const int32_t deviceId = 0;
    const uint32_t blockDim = /* 根据算子调整 */;
    aclrtStream stream = nullptr;

    // 硬编码非零输入数据（禁止全零，否则无法验证精度）
    // std::vector<...> srcHost = {1.0f, 2.0f, 3.0f, ...};
    // std::vector<...> dstHost(..., 0);

    CHECK_ERROR(aclInit(nullptr));
    printf("ACL init successfully\n");

    CHECK_ERROR(aclrtSetDevice(deviceId));
    printf("Set device %d successfully\n", deviceId);

    CHECK_ERROR(aclrtCreateStream(&stream));
    printf("Create stream successfully\n");

    // 分配设备内存
    uint8_t* srcDevice = nullptr;
    uint8_t* dstDevice = nullptr;
    // CHECK_ERROR(aclrtMalloc(...));

    // 拷贝输入数据到设备
    // CHECK_ERROR(aclrtMemcpy(..., ACL_MEMCPY_HOST_TO_DEVICE));

    // <<<>>> 直接调用（ASC 单文件模式，不需要包装函数）
    {算子名}Kernel<<<blockDim, nullptr, stream>>>(srcDevice, dstDevice);
    printf("Custom AscendC kernel <<<>>> call successfully\n");

    CHECK_ERROR(aclrtSynchronizeStream(stream));
    printf("Synchronize stream successfully\n");

    // 结果回传
    // CHECK_ERROR(aclrtMemcpy(..., ACL_MEMCPY_DEVICE_TO_HOST));

    // 逐元素打印结果（expected 必须与核函数实际逻辑一致）
    // printf("  result[%u] = %.1f (expected: %.1f)\n", i, dstHost[i], expected);

    // 释放资源
    // CHECK_ERROR(aclrtFree(srcDevice));
    // CHECK_ERROR(aclrtFree(dstDevice));

    CHECK_ERROR(aclrtDestroyStream(stream));
    printf("Destroy stream successfully\n");

    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    printf("Reset device successfully\n");

    CHECK_ERROR(aclFinalize());
    printf("ACL finalize successfully\n");

    printf("\nSample run successfully with <<<>>> kernel call!\n");
    return 0;
}
```

---

## 4. run.sh 模板

```bash
#!/bin/bash
set -e

if [ -z "${ASCEND_INSTALL_PATH}" ]; then
    echo "[ERROR]: ASCEND_INSTALL_PATH is not set. Please source \${install_root}/cann/set_env.sh first."
    exit 1
fi

if [ ! -f "${ASCEND_INSTALL_PATH}/bin/setenv.bash" ]; then
    echo "[ERROR]: ${ASCEND_INSTALL_PATH}/bin/setenv.bash does not exist."
    exit 1
fi

_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH
source "${_ASCEND_INSTALL_PATH}/bin/setenv.bash"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

BUILD_DIR="${SCRIPT_DIR}/build"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "Configuring CMake (ASC build system)..."
cmake ..

echo "Building..."
make -j"$(nproc)"

cd "${SCRIPT_DIR}"

echo "Build completed successfully!"
echo "Executable location: ${SCRIPT_DIR}/build/main"
echo "Run the sample: ./build/main"
```

---

## 注意事项

1. **ASC 构建系统** — 使用 `find_package(ASC)` + `.asc` 单文件，**禁止使用 `ascendc_library()`**
2. **真实核函数（强制）** — 必须从 `reference/asc-devkit/` 完整复制算子的核函数代码，**禁止简化为 element-wise copy 或其他简化逻辑**。核函数属性与原始代码一致（`__vector__`/`__cube__`/`__mix__(m,n)`），如原始代码有 `extern "C"` 则保留。**禁止 `__aicore__`**
3. **精度验证（强制）** — 验证包不仅验证 Runtime 调用流程，还必须在 Host 侧计算 expected 值并与 Device 输出逐元素对比。使用相对误差+绝对误差双重判定（float32: rtol=1e-3/atol=1e-3, half: rtol=1e-2/atol=1e-2, int: 精确匹配）。输出 `[PRECISION PASS]` 或 `[PRECISION FAIL]`
4. **数据初始化** — 将 `ReadFile` 替换为硬编码**非零**数据（递增序列、全 1、小随机整数等，**禁止全零**），`WriteFile` 替换为精度对比 + `printf` 输出。这是唯一允许对原始 .asc 代码做的修改
5. **辅助头文件** — 如算子依赖 `data_utils.h`、`nd2nz_utils.h` 等，必须从 `reference/` 一并复制到验证包中
6. **环境变量** — 仅需 `ASCEND_INSTALL_PATH`，不需要 `SOC_VERSION` 和 `ASCENDC_CMAKE_DIR`
7. **NPU 架构** — 在 CMakeLists.txt 中通过 `--npu-arch` 指定，不通过环境变量
8. **⚠️ Device 指针类型必须与核函数参数类型匹配** — ASC 编译器在 `<<<>>>` 调用时只做地址空间转换（添加 `__gm__`），**不做类型转换**。因此 Device 指针的 C++ 类型必须与核函数参数去掉 `__gm__` 后的类型一致：
   - 核函数参数为 `GM_ADDR`（即 `__gm__ uint8_t*`）→ Device 指针必须用 `uint8_t*`
   - 核函数参数为 `__gm__ float*` → Device 指针必须用 `float*`
   - **禁止** `float*` 传给 `GM_ADDR` 参数（报错 `cannot initialize '__gm__ uint8_t *' with 'float *'`）
   - **禁止** `reinterpret_cast<GM_ADDR>(floatPtr)`（报错 `reinterpret_cast from 'float *' to '__gm__ uint8_t *' is not allowed`）
