# aclrtMemGetAllocationGranularity

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询内存申请粒度。

系统内部会根据用户指定的内存属性信息计算最小粒度或建议粒度，并以granularity参数返回粒度。此粒度可用作对齐、地址大小或地址映射的倍数。

## 函数原型

```
aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option, size_t *granularity)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| prop | 输入 | 物理内存属性信息。 |
| option | 输入 | 最小粒度或推荐粒度。 |
| granularity | 输出 | 内存申请粒度，单位为Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

