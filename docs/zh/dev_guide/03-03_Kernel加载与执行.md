# Kernel加载与执行

本章介绍如何加载并执行使用Ascend C开发的自定义Kernel。**只有在用户自己编写算子Kernel，或需要直接控制Kernel二进制加载、参数组装和任务下发时，才需要调用本章接口。**如果业务不编写算子，只是调用CANN已提供的算子能力，应优先调用aclnn算子接口，例如aclnnAdd等。aclnn接口会封装算子选择、参数处理、Kernel加载和执行流程，用户通常不需要直接调用LaunchKernel接口。

自定义Kernel主要有两种下发方式：

-   **混合编程方式**：在Host代码中直接使用`<<< >>>`语法下发Kernel。
-   **非混合编程方式**：先将Kernel编译成独立算子二进制，再通过aclrtBinaryLoadFromFile、aclrtBinaryGetFunction、aclrtLaunchKernelWithConfig等Runtime接口加载和下发。

## 两种方式的差异

| 对比项 | 混合编程：`<<< >>>` | 非混合编程：LaunchKernel接口 |
| --- | --- | --- |
| Kernel引用方式 | Host代码直接引用Kernel函数符号，例如`add_custom<<<...>>>(...)`。 | Host代码通过Kernel名称字符串获取aclrtFuncHandle，例如`aclrtBinaryGetFunction(bin, "add_custom", &func)`。 |
| 编译方式 | Kernel源码参与Host工程构建，通常通过Ascend C CMake能力生成可链接的Kernel库，并与Host可执行文件一起链接。 | Kernel源码单独编译为算子二进制文件，例如`*.o`或fatbin；Host程序单独编译，通过Runtime接口在运行时加载该二进制。 |
| 生成代码 | 构建系统会生成Host侧可调用的Kernel启动桩、注册信息和设备侧代码绑定关系，使`<<< >>>`语法能够直接下发任务。 | 不生成可直接调用的Kernel启动桩。Host侧只保存二进制路径、Kernel名称和Runtime句柄，需要手动加载Binary、获取Function并组装参数。 |
| 运行时加载 | Kernel二进制通常随Host程序或链接库注册，首次下发时由生成代码完成注册和加载。 | 用户显式调用aclrtBinaryLoadFromFile或aclrtBinaryLoadFromData加载Binary，并在结束时调用aclrtBinaryUnLoad卸载。 |
| 参数组织 | 以函数调用形式传参，代码简洁，可读性好。 | 可使用Device参数区、Host参数区、aclrtArgsHandle参数列表、placeholder等方式组织参数，控制粒度更细。 |
| 适用场景 | Kernel与Host程序一起开发、一起发布，Kernel集合在编译期已确定。 | Kernel二进制需要独立发布、动态选择、延迟加载，或需要使用Runtime参数组装、placeholder、任务属性配置等能力。 |

两种方式下，Kernel任务下发后相对于Host线程都是异步执行。Host线程如果需要等待Kernel执行完成，需要调用aclrtSynchronizeStream、aclrtSynchronizeDevice或使用Event等同步机制。

## 混合编程方式

混合编程方式中，Host代码可以直接调用Kernel函数并使用`<<< >>>`语法指定任务的block数量、动态共享内存参数和Stream。该方式代码最简洁，适合Kernel和Host程序绑定发布的场景。

编译时，Kernel源码会作为工程的一部分参与构建。例如样例中可使用Ascend C CMake能力将Kernel源码编译为静态库，再链接到Host可执行文件：

```
include(${ASCENDC_CMAKE_DIR}/ascendc.cmake)
ascendc_library(kernels STATIC kernel_print.cpp)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE kernels ${ASCEND_CANN_PACKAGE_PATH}/lib64/libacl_rt.so)
```

上述方式生成的Host侧代码可以直接调用Kernel启动函数，用户不需要显式调用aclrtBinaryLoadFromFile、aclrtBinaryGetFunction等接口。

关键代码示例如下，不可以直接拷贝编译运行，仅供参考。

```
// Device code
extern "C" __global__ __aicore__ void add_custom(GM_ADDR x, GM_ADDR y, GM_ADDR z)
{
    KernelAdd op;
    op.Init(x, y, z);
    op.Process();
}

int main()
{
    int64_t n = ...;
    size_t size = static_cast<size_t>(n) * sizeof(uint64_t);

    aclInit(nullptr);
    aclrtSetDevice(0);

    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    void *hX = nullptr;
    void *hY = nullptr;
    void *hZ = nullptr;
    aclrtMallocHost(&hX, size);
    aclrtMallocHost(&hY, size);
    aclrtMallocHost(&hZ, size);

    // 初始化输入数据。
    ...

    void *dX = nullptr;
    void *dY = nullptr;
    void *dZ = nullptr;
    aclrtMalloc(&dX, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&dY, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&dZ, size, ACL_MEM_MALLOC_HUGE_FIRST);

    aclrtMemcpy(dX, size, hX, size, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(dY, size, hY, size, ACL_MEMCPY_HOST_TO_DEVICE);

    uint32_t numBlocks = 48;
    add_custom<<<numBlocks, nullptr, stream>>>(dX, dY, dZ);
    aclrtSynchronizeStream(stream);

    aclrtMemcpy(hZ, size, dZ, size, ACL_MEMCPY_DEVICE_TO_HOST);
    ...
}
```

## 非混合编程方式

非混合编程方式中，Kernel设备侧代码先被编译成独立算子二进制。Host程序运行时显式加载该二进制，获取Kernel函数句柄，组装参数后调用LaunchKernel接口下发任务。

编译时，Kernel源码和Host程序可以分开构建。例如样例中可使用ascendc_fatbin_library生成算子二进制文件，再由Host程序在运行时加载：

```
include(${ASCENDC_CMAKE_DIR}/ascendc.cmake)
ascendc_fatbin_library(ascendc_kernels_simple add_custom.cpp)

add_executable(ascendc_kernels_bbit main.cpp)
target_link_libraries(ascendc_kernels_bbit PRIVATE ${ASCEND_CANN_PACKAGE_PATH}/lib64/libacl_rt.so)
```

生成的算子二进制文件会在运行时通过路径加载，例如`./out/fatbin/ascendc_kernels_simple/ascendc_kernels_simple.o`。这种方式下，Host代码不直接引用Kernel函数符号，而是通过Binary和Function句柄操作Kernel。

相关概念如下：

-   **Binary**：动态加载的代码容器单元，包含编译后的Kernel代码、全局变量等。用户通过aclrtBinaryLoadFromFile或aclrtBinaryLoadFromData加载算子二进制，并获得Binary句柄。
-   **Function**：Binary内部的具体可执行Kernel入口。用户通过aclrtBinaryGetFunction或aclrtBinaryGetFunctionByEntry获取Function句柄。
-   **参数列表**：LaunchKernel接口需要获取Kernel参数。参数可放在Device内存、Host内存或aclrtArgsHandle参数列表中，也可以使用placeholder让Runtime在Launch时完成小块参数数据的搬运。

以下是使用LaunchKernel接口的关键代码示例，不可以直接拷贝编译运行，仅供参考。

```
// Device code，编译为独立算子二进制文件。
extern "C" __global__ __aicore__ void add_custom(GM_ADDR x, GM_ADDR y, GM_ADDR z)
{
    KernelAdd op;
    op.Init(x, y, z);
    op.Process();
}

int main()
{
    int64_t n = ...;
    size_t size = static_cast<size_t>(n) * sizeof(uint64_t);

    aclInit(nullptr);
    aclrtSetDevice(0);

    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    // 加载算子二进制，并获取Kernel函数句柄。
    aclrtBinHandle bin = nullptr;
    aclrtBinaryLoadFromFile("add_custom.o", nullptr, &bin);

    aclrtFuncHandle func = nullptr;
    aclrtBinaryGetFunction(bin, "add_custom", &func);

    void *hX = nullptr;
    void *hY = nullptr;
    void *hZ = nullptr;
    aclrtMallocHost(&hX, size);
    aclrtMallocHost(&hY, size);
    aclrtMallocHost(&hZ, size);

    // 初始化输入数据。
    ...

    void *dX = nullptr;
    void *dY = nullptr;
    void *dZ = nullptr;
    aclrtMalloc(&dX, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&dY, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&dZ, size, ACL_MEM_MALLOC_HUGE_FIRST);

    aclrtMemcpy(dX, size, hX, size, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(dY, size, hY, size, ACL_MEMCPY_HOST_TO_DEVICE);

    uint32_t numBlocks = 48;
    void *args[] = {dX, dY, dZ};
    size_t argsSize = sizeof(args);
    aclrtLaunchKernelWithHostArgs(func, numBlocks, stream, nullptr, args, argsSize, nullptr, 0);
    aclrtSynchronizeStream(stream);

    aclrtMemcpy(hZ, size, dZ, size, ACL_MEMCPY_DEVICE_TO_HOST);

    aclrtBinaryUnLoad(bin);
    ...
}
```

LaunchKernel接口族的选择建议如下：

| 接口 | 参数来源 | 适用场景 |
| --- | --- | --- |
| aclrtLaunchKernel | Device内存中的完整参数区 | 参数已经在Device侧组装完成，不需要Launch配置。 |
| aclrtLaunchKernelV2 | Device内存中的完整参数区 | 需要额外指定Launch配置。 |
| aclrtLaunchKernelWithConfig | aclrtArgsHandle参数列表 | 希望由Runtime管理参数布局，或需要使用placeholder、参数更新等能力。 |
| aclrtLaunchKernelWithHostArgs | Host内存中的完整参数区 | 参数在Host侧连续组织，Launch时由Runtime处理。 |
| aclrtLaunchKernelWithArgsArray | Host侧参数数组 | 每个数组元素指向一个参数数据，便于按参数数组形式组织调用。 |

完整样例可参考[0_launch_kernel](../../../example/2_advanced_features/kernel/0_launch_kernel/README.md)，该样例展示了Binary加载、Function获取、aclrtArgsHandle参数组装、placeholder参数和aclrtLaunchKernelWithConfig下发流程。
