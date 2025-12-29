# aclrtMemGetAllocationPropertiesFromHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据物理内存信息的handle查询其内存属性信息。

## 函数原型

```
aclError aclrtMemGetAllocationPropertiesFromHandle(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 存放物理内存信息的handle。<br>查询通过aclrtMallocPhysical接口申请的物理内存属性信息。 |
| prop | 输出 | 物理内存属性信息。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

