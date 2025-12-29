# aclrtMemRetainAllocationHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据虚拟内存地址获取物理内存信息的handle。

若多次调用本接口，则需相应地调用相同次数的aclrtFreePhysical来释放物理内存handle。

## 函数原型

```
aclError aclrtMemRetainAllocationHandle(void* virPtr, aclrtDrvMemHandle *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输入 | “已分配的虚拟内存地址的指针”的指针。<br>必须与[aclrtMapMem](aclrtMapMem.md)接口的virPtr地址相同。 |
| handle | 输出 | 存放物理内存信息的handle。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

