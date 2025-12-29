# aclrtFreePhysical

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

释放通过[aclrtMallocPhysical](aclrtMallocPhysical.md)接口申请的物理内存。

## 函数原型

```
aclError aclrtFreePhysical(aclrtDrvMemHandle handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 待释放的物理内存信息handle。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   若该物理内存与虚拟内存存在映射关系，则释放物理内存前，需调用[aclrtUnmapMem](aclrtUnmapMem.md)接口取消该物理内存与虚拟内存的映射。

