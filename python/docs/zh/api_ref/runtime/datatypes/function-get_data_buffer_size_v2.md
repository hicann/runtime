# 函数：get\_data\_buffer\_size\_v2

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

获取aclDataBuffer类型中数据的内存大小，单位Byte。

## 函数原型

- **C函数原型**

    ```c
    size_t aclGetDataBufferSizeV2(const aclDataBuffer *dataBuffer)
    ```

- **python函数**

    ```python
    size = acl.get_data_buffer_size_v2(data_buffer)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data_buffer | int，aclDataBuffer的指针地址。<br>需提前调用[acl.create_data_buffer](function-create_data_buffer.md)接口创建aclDataBuffer类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| size | int，aclDataBuffer类型中数据的内存大小。 |
