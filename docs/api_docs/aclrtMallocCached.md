# aclrtMallocCached

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Device上申请size大小的线性内存，通过\*devPtr返回已分配内存的指针，该接口在任何场景下申请的内存都是支持Cache缓存。

使用aclrtMallocCached接口申请的内存与使用[aclrtMalloc](aclrtMalloc.md)接口申请的内存是等价的，都支持Cache缓存，不需要用户处理CPU与NPU之间的Cache一致性。

## 函数原型

```
aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](aclrtMemMallocPolicy.md)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

