# aclrtMemManagedGetAttrs

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询指定大小的UVM内存的策略属性值。

本接口操作的内存必须是通过[aclrtMemAllocManaged](aclrtMemAllocManaged.md)接口分配的。若查询的这段内存范围内的策略属性值不一致，则查询结果为无效值。

与[aclrtMemManagedGetAttr](aclrtMemManagedGetAttr.md)接口不同，本接口支持一次查询多个内存策略属性的值。

## 函数原型

```
aclError aclrtMemManagedGetAttrs(aclrtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, size_t size, void **data, size_t *dataSizes)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| attributes | 输入 | 待查询的属性数组。类型定义请参见[aclrtMemManagedRangeAttribute](aclrtMemManagedRangeAttribute.md)。 |
| numAttributes | 输入 | 待查询的属性数组大小。 |
| ptr | 输入 | 待查询属性的内存首地址，范围必须在UVM内存范围之内，即[0x90000000000ULL, 0x90000000000ULL+3T)。 |
| size | 输入 | 待查询属性的内存大小，单位Byte。取值范围为(0, 3T]。 |
| data | 输出 | 查询结果数组。 |
| dataSizes | 输入 | 存放查询结果数组的内存大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

