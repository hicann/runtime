# acltdtGetDatasetName

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取标识acltdtDataset（对等一个Vector<tensor\>）的描述符。

## 函数原型

```
const char *acltdtGetDatasetName(const acltdtDataset *dataset)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataset | 输入 | acltdtDataset类型的指针。<br>需提前调用[acltdtCreateDataset](acltdtCreateDataset.md)接口创建acltdtDataset类型的数据。 |

## 返回值说明

标识acltdtDataset（对等一个Vector<tensor\>）的描述符的指针。

