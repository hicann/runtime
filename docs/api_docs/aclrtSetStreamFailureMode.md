# aclrtSetStreamFailureMode

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

当一个Stream上下发了多个任务时，可通过本接口指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。

## 函数原型

```
aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 待操作Stream。 |
| mode | 输入 | 当一个Stream上下发了多个任务时，可通过本参数指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。<br>取值范围如下：<br><br>  - ACL_CONTINUE_ON_FAILURE：默认值，某个任务失败后，继续执行下一个任务；<br>  - ACL_STOP_ON_FAILURE：某个任务失败后，停止执行后续任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   针对指定Stream只能调用一次本接口设置任务调度模式。
-   当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。该约束适用于以下产品型号：

    Atlas A3 训练系列产品/Atlas A3 推理系列产品

    Atlas A2 训练系列产品/Atlas A2 推理系列产品

