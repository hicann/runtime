# aclrtAllocatorSetObjToDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

使用用户提供的Allocator场景下，向Allocator描述信息中设置Allocator对象。

## 函数原型

```
aclError aclrtAllocatorSetObjToDesc(aclrtAllocatorDesc allocatorDesc,  aclrtAllocator allocator)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](aclrtAllocatorCreateDesc.md)接口设置Allocator描述信息。 |
| allocator | 输入 | 用户提供的Allocator对象指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败。

