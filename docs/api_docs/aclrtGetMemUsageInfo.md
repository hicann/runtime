# aclrtGetMemUsageInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询组件的内存使用信息，包括组件名称、当前内存大小和峰值内存大小等信息。

## 函数原型

```
aclError aclrtGetMemUsageInfo(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| memUsageInfo | 输入&输出 | 内存使用信息数组。类型定义请参见[aclrtMemUsageInfo](aclrtMemUsageInfo.md)。<br>该参数作为输入时，由用户传入aclrtMemUsageInfo结构体指针，其内存大小需确保足以存放inputNum个组件的内存使用信息。<br>该参数作为输出时，可以获取组件名称、当前内存大小和峰值内存大小等信息。memUsageInfo数组中的元素按照当前内存占用量从大到小排序。 |
| inputNum | 输入 | 指定需查询的组件数量。<br>如果实际组件数量少于inputNum，则按实际组件数量查询。 |
| outputNum | 输出 | 实际查询到的组件数量。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

