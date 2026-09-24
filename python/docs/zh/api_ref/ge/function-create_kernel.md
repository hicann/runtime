# 函数：create\_kernel

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

动态Shape场景下，将算子注册到系统内部，运行算子时使用。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopCreateKernel(const char *opType,
    const char *kernelId,
    const char *kernelName,
    void *binData,
    int binSize,
    aclopEngineType enginetype,
    aclDataDeallocator deallocator)
    ```

- **python函数**

    ```python
    ret = acl.op.create_kernel(op_type, kernel_id, kernel_name, bin_data, bin_size, enginetype, deallocator)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | str，算子类型。 |
| kernel_id | str，算子执行时要指定的Kernel ID。 |
| kernel_name | str，算子Kernel名称，和算子二进制文件中的kernelName保持一致。 |
| bin_data | int，算子Kernel文件的内存地址。 |
| bin_size | int，算子Kernel文件的内存大小，单位为Byte。 |
| enginetype | int，表示算子执行引擎，该参数只有acl.op.update.params接口的“compile_flag”参数值为“ACL_COMPILE_SYS”时有效。<br> 0：ACL_ENGINE_SYS，不关心具体执行引擎时填写。<br> 1：ACL_ENGINE_AICORE，将算子编译成AI Core算子。<br> 2：ACL_ENGINE_VECTOR，将算子编译成Vector Core算子。 |
| deallocator | int，指定是否自动释放bin_data内存。<br> 0：不自动释放，数据由调用者自行编写代码进行释放。<br> 1：自动释放，内部会设置回调函数释放bin_data内存。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
