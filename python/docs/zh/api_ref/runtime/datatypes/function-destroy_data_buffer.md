# 函数：destroy\_data\_buffer

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

销毁aclDataBuffer类型的数据。

此处仅销毁aclDataBuffer类型的数据，调用[acl.create\_data\_buffer](function-create_data_buffer.md)接口创建aclDataBuffer类型数据时传入的data的内存需由用户自行释放。

## 函数原型

- **C函数原型**

    ```c
    aclError aclDestroyDataBuffer(const aclDataBuffer *dataBuffer)
    ```

- **python函数**

    ```python
    ret = acl.destroy_data_buffer(data_buffer)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data_buffer | int，表示aclDataBuffer的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |
