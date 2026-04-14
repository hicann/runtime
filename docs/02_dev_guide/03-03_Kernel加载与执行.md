# Kernel加载与执行

Kernel函数可以采用<<<\>\>\>方式进行任务下发，具有代码简洁，可读性好的优点。

以下是关键步骤的代码示例，不可以直接拷贝编译运行，仅供参考。

```
// Device code
Template<>
extern "C" __global__ __aicore__ void add_custom(GM_ADDR x, GM_ADDR y, GM_ADDR z)
{
    KernelAdd op;
    op.Init(x, y, z);
    op.Process();
}

int main()
{
    int N = ...;
    size_t size = N * sizeof(uint64);

    // Initialize
    aclrtSetDevice(0);

    // Create stream
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // Allocate vectors in host memory
    void *h_x, *h_y, *h_z;
    aclrtMallocHost(&h_x, size);
    aclrtMallocHost(&h_y, size);
    aclrtMallocHost(&h_z, size);

    // Initialize input vectors
    ...

    // Allocate vectors in device memory
    void *d_x, *d_y, *d_z;
    aclrtMalloc(&d_x, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&d_y, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&d_z, size, ACL_MEM_MALLOC_HUGE_FIRST);

    // Copy vectors from host memory to device memory
    aclrtMemcpy(d_x, size, h_x, size, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(d_y, size, h_y, size, ACL_MEMCPY_HOST_TO_DEVICE);

    // Invoke kernel
    uint32_t numBlocks = 48;
    add_custom<<<numBlocks, nullptr, stream>>>(d_x, d_y, d_z);
    ...
}
```

用户也可以使用Runtime提供的LaunchKernel接口（例如aclrtLaunchKernelWithHostArgs接口）进行kernel函数的下发。使用这种方式需先了解Binary和Function的概念：

-   Binary：是一个动态加载的代码容器单元，里面包含编译后的kernel代码、全局变量等。用户可以通过aclrtBinaryLoadFromFile或aclrtBinaryLoadFromData将编译好的算子二进制加载到NPU上，并获得对应的Binary句柄。
-   Function：是一个具体可执行的kernel函数，它定义在Binary内部，是主机代码可以调用并在NPU上执行的入口点。用户可以通过aclrtBinaryGetFunction获取kernel函数对应的Function句柄。

以下是使用LaunchKernel接口的关键代码示例，不可以直接拷贝编译运行，仅供参考。

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
    int N = ...;
    size_t size = N * sizeof(uint64);

    // Initialize
    aclrtSetDevice(0);

    // Create stream
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // Create binary from binary file
    aclrtBinHandle bin;
    aclrtBinaryLoadFromFile("add_custom.o", nullptr, &bin);

    // Get function handle from binary
    aclrtFuncHandle add_custom;
    aclrtBinaryGetFunction(bin, "add_custom", &add_custom);

    // Allocate vectors in host memory
    void *h_x, *h_y, *h_z;
    aclrtMallocHost(&h_x, size);
    aclrtMallocHost(&h_y, size);
    aclrtMallocHost(&h_z, size);

    // Initialize input vectors
    ...

    // Allocate vectors in device memory
    void *d_x, *d_y, *d_z;
    aclrtMalloc(&d_x, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&d_y, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&d_z, size, ACL_MEM_MALLOC_HUGE_FIRST);

    // Copy vectors from host memory to device memory
    aclrtMemcpy(d_x, size, h_x, size, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(d_y, size, h_y, size, ACL_MEMCPY_HOST_TO_DEVICE);

    // Invoke kernel
    uint32_t numBlocks = 48;
    void* args[] = {d_x, d_y, d_z};
    size_t argsSize = 3 * sizeof(void*);
    aclrtLaunchKernelWithHostArgs(add_custom, numBlocks, stream, nullptr, args, argsSize, nullptr, 0);
    ...
}
```

