# 函数：update\_data\_buffer

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
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

更新aclDataBuffer中数据的内存及大小。

更新aclDataBuffer后，之前aclDataBuffer中存放数据的内存如果不使用，需及时释放，否则可能会导致内存泄漏。

## 函数原型

- **C函数原型**

    ```c
    aclError aclUpdateDataBuffer(aclDataBuffer *dataBuffer, void *data, size_t size)
    ```

- **python函数**

    ```python
    ret = acl.update_data_buffer(data_buffer, data, size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data_buffer | int，aclDataBuffer类型的指针地址。<br>需提前调用[acl.create_data_buffer](function-create_data_buffer.md)接口创建aclDataBuffer类型的数据。<br>该内存需由用户自行管理，调用[acl.rt.malloc](../memory/function-malloc.md)接口/[acl.rt.free](../memory/function-free.md)接口申请/释放内存，或调用[acl.rt.malloc_host](../memory/function-malloc_host.md)接口/[acl.rt.free_host](../memory/function-free_host.md)接口申请/释放内存。 |
| data | int，存放数据内存地址的指针地址。 |
| size | int，内存大小，单位Byte。如需使用空Tensor，在申请内存时，内存大小最小为1Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |
