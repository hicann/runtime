# acltdtGetSliceInfoFromItem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

用于输出Tensor分片信息。

**使用场景：**OutfeedEnqueueOpV2算子由于其功能要求需申请Device上的大块内存存放数据，在Device内存不足时，可能会导致内存申请失败，进而导致某些算子无法正常执行，该场景下，用户可以调用本接口获取Tensor分片信息（分片数量、分片索引），再根据分片信息拼接算子的Tensor数据。

## 函数原型

```
aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。acltdtDataItem用于标识一个业务上的Tensor。<br>需提前调用[acltdtCreateDataItem](acltdtCreateDataItem.md)接口创建acltdtDataItem类型的数据。 |
| sliceNum | 输出 | 单个Tensor被切片的数量。 |
| sliceId | 输出 | 被切片Tensor的数据段索引。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

