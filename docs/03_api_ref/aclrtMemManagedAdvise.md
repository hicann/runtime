# aclrtMemManagedAdvise

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

管理统一虚拟内存（Unified Virtual Memory, UVM）的策略属性，既支持设置策略属性，也支持取消设置。

本接口操作的内存必须是通过[aclrtMemAllocManaged](aclrtMemAllocManaged.md)接口申请的内存，设置的策略属性值可使用[aclrtMemManagedGetAttr](aclrtMemManagedGetAttr.md)和[aclrtMemManagedGetAttrs](aclrtMemManagedGetAttrs.md)接口查询。

## 函数原型

```
aclError aclrtMemManagedAdvise(const void *const ptr, uint64_t size, aclrtMemManagedAdviseType advise, aclrtMemManagedLocation location)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 待设置属性的内存地址，地址范围必须在UVM内存范围之内，即[0x90000000000ULL, 0x90000000000ULL+3T)。 |
| size | 输入 | 内存大小，单位Byte，要求2MB对齐。取值范围为(0, 3T]。 |
| advise | 输入 | 内存策略属性。<br>类型定义请参见[aclrtMemManagedAdviseType](aclrtMemManagedAdviseType.md)。 |
| location | 输入 | 物理内存的位置信息，location参数包含id和type两个成员。<br>类型定义请参见[aclrtMemManagedLocation](aclrtMemManagedLocation.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。
