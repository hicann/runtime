# aclrtSwitchLabelByIndex

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据标签索引跳转到相应的标签位置，执行该标签所在Stream上的任务，同时当前Stream上的任务停止执行。异步接口。

## 函数原型

```
aclError aclrtSwitchLabelByIndex(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 标签索引。<br>存放目标标签索引值的Device内存地址，索引值的数据类型uint32，长度4字节，索引值从0开始。<br>当目标标签索引大于labelList数组的最大索引值时，跳转到最大标签。 |
| maxValue | 输入 | 标签列表中的标签个数。 |
| labelList | 输入 | 标签列表。<br>通过[aclrtCreateLabelList](aclrtCreateLabelList.md)接口创建的标签列表作为此处的输入。 |
| stream | 输入 | 执行跳转任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

