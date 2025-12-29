# acltdtGetDimsFromItem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

得到正常tensor数据的数据Shape。

## 函数原型

```
aclError acltdtGetDimsFromItem(const acltdtDataItem *dataItem, int64_t *dims, size_t dimNum)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](acltdtCreateDataItem.md)接口创建acltdtDataItem类型的数据。 |
| dims | 输入&输出 | 维度信息数组。 |
| dimNum | 输入 | 维度个数。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

