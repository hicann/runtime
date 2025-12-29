# acltdtCreateDataset

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建acltdtDataset类型的数据，对等一个Vector<tensor\>。

如需销毁acltdtDataset类型的数据，请参见[acltdtDestroyDataset](acltdtDestroyDataset.md)。

## 函数原型

```
acltdtDataset *acltdtCreateDataset()
```

## 参数说明

无

## 返回值说明

-   返回acltdtDataset类型的指针，表示成功。
-   返回nullptr，表示失败。

