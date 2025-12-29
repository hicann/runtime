# aclrtSwitchStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据条件在Stream之间跳转。异步接口。

跳转成功后，只执行所跳转的Stream上的任务，当前Stream上的任务停止执行。

## 函数原型

```
aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| leftValue | 输入 | 左值数据的Device内存地址。 |
| cond | 输入 | 左值数据与右值数据的比较条件。 |
| rightValue | 输入 | 右值数据的Device内存地址。 |
| dataType | 输入 | 左值数据、右值数据的数据类型。 |
| trueStream | 输入 | 根据cond处指定的条件，条件成立时，则执行trueStream上的任务。 |
| falseStream | 输入 | 根据cond处指定的条件，条件不成立时，则执行falseStream上的任务。 |
| stream | 输入 | 执行跳转任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

