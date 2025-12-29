# acltdtCreateDataItem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建acltdtDataItem类型的数据，代表一个业务上的Tensor。

如需销毁acltdtDataItem类型的数据，请参见[acltdtDestroyDataItem](acltdtDestroyDataItem.md)。

## 函数原型

```
acltdtDataItem *acltdtCreateDataItem(acltdtTensorType tdtType,
const int64_t *dims,
size_t dimNum,
aclDataType dataType,
void *data,
size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| tdtType | 输入 | tensor类型。 |
| dims | 输入 | tensor的Shape。 |
| dimNum | 输入 | tensor的Shape中的维度个数。 |
| dataType | 输入 | 正常数据里的数据类型。 |
| data | 输入 | 数据地址指针。 |
| size | 输入 | 数据长度。 |

## 返回值说明

-   返回acltdtDataItem类型的指针，表示成功。
-   返回nullptr，表示失败。

