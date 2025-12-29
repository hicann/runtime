# acltdtAddDataItem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

向acltdtDataset中增加acltdtDataItem。

## 函数原型

```
aclError acltdtAddDataItem(acltdtDataset *dataset, acltdtDataItem *dataItem)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataset | 输出 | 待增加acltdtDataItem的acltdtDataset地址指针。<br>需提前调用[acltdtCreateDataset](acltdtCreateDataset.md)接口创建acltdtDataset类型的数据。 |
| dataItem | 输入 | 待增加的acltdtDataItem地址指针。<br>需提前调用[acltdtCreateDataItem](acltdtCreateDataItem.md)接口创建acltdtDataItem类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

