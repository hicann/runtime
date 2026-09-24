# 函数：set\_kernel\_args

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

动态Shape场景下，设置算子Tiling参数、执行并发数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopSetKernelArgs(aclopKernelDesc *kernelDesc,
    const char *kernelId,
    uint32_t blockDim,
    const void *args,
    uint32_t argSize)
    ```

- **python函数**

    ```python
    ret = acl.op.set_kernel_args(kernel_desc, kernel_id, block_dim, args, arg_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| kernel_desc | int，Kernel描述缓存，aclopKernelDesc类型的指针地址。 |
| kernel_id | str，算子执行时要指定的Kernel ID，与调用acl.op.create.kernel时传递的kernel_id一致。 |
| block_dim | int，Kernel执行的并发数。 |
| args | int，Tiling参数，需要通过numpy数组tobytes方法获取bytes对象，然后使用`acl.utils.bytes_to_ptr()`接口获取Tiling参数指针地址。 |
| arg_size | int，Tiling参数内存大小，单位为Byte，为`numpy.tobytes()`转换得到bytes的对象长度，可用len函数获取。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
