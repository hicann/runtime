# acltdtGetTensorTypeFromItem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

收到dataItem数据之后，从数据描述里首先check这个数据是个正常数据，还是一个end数据，还是一个异常数据。

## 函数原型

```
acltdtTensorType acltdtGetTensorTypeFromItem(const acltdtDataItem *dataItem)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](acltdtCreateDataItem.md)接口创建acltdtDataItem类型的数据。 |

## 返回值说明

请参见[acltdtTensorType](acltdtTensorType.md)。

