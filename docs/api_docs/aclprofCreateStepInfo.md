# aclprofCreateStepInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建aclprofStepInfo对象，用于描述迭代信息。

## 约束说明

-   使用aclprofDestroyStepInfo接口销毁aclprofStepInfo类型的数据，如不销毁会导致内存未被释放。
-   与[aclprofDestroyStepInfo](aclprofDestroyStepInfo.md)接口配对使用，先调用aclprofCreateStepInfo接口再调用aclprofDestroyStepInfo接口。

## 函数原型

```
aclprofStepInfo* aclprofCreateStepInfo()
```

## 返回值

-   返回aclprofStepInfo类型的指针，表示成功。
-   返回nullptr，表示失败。

>![](public_sys-resources/icon-note.gif) **说明：** 
>同一个aclprofStepInfo对象、同一个tag只能设置一次，否则Profiling解析会出错。

