# aclrtAllocatorUnregister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

用户销毁Allocator前，需调用本接口取消注册用户提供的Allocator以及Allocator对应的回调函数。

待取消注册的Stream不存在，或多次调用本接口取消注册，本接口内部不做任何操作，返回成功。

## 函数原型

```
aclError aclrtAllocatorUnregister(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 该Allocator对应的stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

