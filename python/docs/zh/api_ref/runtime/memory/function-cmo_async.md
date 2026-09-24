# 函数：cmo\_async

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

实现Device上的Cache内存操作。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.cmo_async(src, size, cmo_type, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| src | int，待操作的Device内存的地址。 |
| size | int，待操作的Device内存大小，单位Byte。 |
| cmoType | int，Cache内存操作类型。参考[aclrtCmoType](../datatypes/aclrtCmoType.md)<br>当前仅支持ACL_RT_CMO_TYPE_PREFETCH（内存预取）。 |
| stream | int，指定stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
