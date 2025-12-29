# acltdtGetDataItem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取acltdtDataset中的第n个acltdtDataItem。

## 函数原型

```
acltdtDataItem *acltdtGetDataItem(const acltdtDataset *dataset, size_t index)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataset | 输入 | acltdtDataset类型的指针。<br>需提前调用[acltdtCreateDataset](acltdtCreateDataset.md)接口创建acltdtDataset类型的数据，再调用[acltdtAddDataItem](acltdtAddDataItem.md)接口添加acltdtDataItem。 |
| index | 输入 | 表明获取的是第几个acltdtDataItem。 |

## 返回值说明

-   获取成功，返回acltdtDataItem的地址。
-   获取失败返回空地址。

