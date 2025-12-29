# aclDataTypeSize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取aclDataType数据的大小，单位Byte。

## 函数原型

```
size_t aclDataTypeSize(aclDataType dataType)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataType | 输入 | 指定要获取大小的aclDataType数据。 |

## 返回值说明

返回aclDataType数据的大小，单位Byte。

