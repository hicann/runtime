# aclrtNotifyBatchReset

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

批量复位Notify。

## 函数原型

```
aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notifies | 输入 | Notify数组。 |
| num | 输入 | Notify数组的长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

昇腾虚拟化实例场景不支持该操作。

