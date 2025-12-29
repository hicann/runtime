# aclprofPush

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

msproftx用于记录事件发生的时间跨度的开始时间。

调用此接口后，Profiling自动在Stamp指针中记录开始的时间戳，将Event type设置为Push/Pop。

## 函数原型

```
aclError aclprofPush(void *stamp)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](aclprofCreateStamp.md)接口的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   与[aclprofPop](aclprofPop.md)接口成对使用，表示时间跨度的开始和结束。
-   在[aclprofCreateStamp](aclprofCreateStamp.md)接口和[aclprofDestroyStamp](aclprofDestroyStamp.md)接口之间调用。
-   不能跨线程调用，若需要跨线程可使用[aclprofRangeStart](aclprofRangeStart.md)/[aclprofRangeStop](aclprofRangeStop.md)接口。

