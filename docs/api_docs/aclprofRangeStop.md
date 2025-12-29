# aclprofRangeStop

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

msproftx用于记录事件发生的时间跨度的结束时间。

调用此接口后，Profiling自动在Stamp指针中记录采集结束的时间戳。

## 函数原型

```
aclError aclprofRangeStop(uint32_t rangeId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| rangeId | 输出 | msproftx事件标记的唯一标识。用于在跨线程时区分。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   与[aclprofRangeStart](aclprofRangeStart.md)接口成对使用，表示时间跨度的开始和结束。
-   在[aclprofCreateStamp](aclprofCreateStamp.md)接口和[aclprofDestroyStamp](aclprofDestroyStamp.md)接口之间调用。
-   可以跨线程调用。

