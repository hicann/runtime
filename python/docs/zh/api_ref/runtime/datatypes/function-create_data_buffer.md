# 函数：create\_data\_buffer

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

创建aclDataBuffer类型的数据，该数据类型用于描述内存地址、大小等内存信息。

如需销毁aclDataBuffer类型的数据，请参见[函数：destroy\_data\_buffer](function-destroy_data_buffer.md)。

## 函数原型

- **C函数原型**

    ```c
    aclDataBuffer *aclCreateDataBuffer(void *data, size_t size)
    ```

- **python函数**

    ```python
    output = acl.create_data_buffer(data, size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data | int，表示存储aclDataBuffer数据的指针地址。“data”参数支持传入0，表示创建一个空的数据类型，此时“size”参数值必须设置为0。<br>该内存需由用户自行管理，调用[acl.rt.malloc](../memory/function-malloc.md)接口/[acl.rt.free](../memory/function-free.md)接口申请/释放内存，或调用[acl.rt.malloc_host](../memory/function-malloc_host.md)接口/[acl.rt.free_host](../memory/function-free_host.md)接口申请/释放内存。 |
| size | int，内存大小。如果用户需要使用空Tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| output | int，输出aclDataBuffer的指针地址。 |
