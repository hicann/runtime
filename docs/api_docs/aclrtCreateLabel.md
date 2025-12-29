# aclrtCreateLabel

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建标签。每个进程最多创建65535个标签。

调用本接口创建标签后，再依次配合[aclrtCreateLabelList](aclrtCreateLabelList.md)接口（创建标签列表）、[aclrtSetLabel](aclrtSetLabel.md)接口（在Stream上设置标签）、[aclrtSwitchLabelByIndex](aclrtSwitchLabelByIndex.md)接口（跳转到指定Stream）使用，实现Stream之间的跳转。

## 函数原型

```
aclError aclrtCreateLabel(aclrtLabel *label)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| label | 输出 | 标签的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

