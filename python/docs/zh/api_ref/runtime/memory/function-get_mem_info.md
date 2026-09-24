# 函数：get\_mem\_info

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

获取指定属性的应用可用内存的空闲大小和总大小，不包括系统预留内存大小。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)
    ```

- **python函数**

    ```python
    free, total, ret = acl.rt.get_mem_info(attr)
    ```

## 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| attr | 输入 | int，需要查询的内存的属性值，具体请参见[aclrtMemAttr](../datatypes/aclrtMemAttr.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| free | int，对应属性的内存的空闲大小，单位Byte。 |
| total | int，对应属性的内存的总大小，单位Byte。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 调用本接口前必须先指定用于计算的Device（例如调用acl.rt.set\_device接口指定用于计算的Device），因此本接口中不体现Device ID。
- 请根据实际硬件支持的情况选择相应的内存属性；否则，通过本接口获取的空闲大小和总大小都将为0。如果硬件不支持HBM内存，在查询HBM内存信息时，接口将自动转换为查询DDR内存信息，例如，查询ACL\_HBM\_MEM时，接口实际会查询ACL\_DDR\_MEM。
