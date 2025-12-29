# aclprofCreateStamp

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建msproftx事件标记。后续调用[aclprofMark](aclprofMark.md)、[aclprofSetStampTraceMessage](aclprofSetStampTraceMessage.md)、[aclprofPush](aclprofPush.md)和[aclprofRangeStart](aclprofRangeStart.md)接口时需要以描述该事件的指针作为输入，表示记录该事件发生的时间跨度。

## 函数原型

```
void *aclprofCreateStamp()
```

## 返回值说明

-   返回void类型的指针，表示成功。
-   返回nullptr，表示失败。

## 约束说明

与[aclprofDestroyStamp](aclprofDestroyStamp.md)接口配对使用，需提前调用[aclprofStart](aclprofStart.md)接口。

