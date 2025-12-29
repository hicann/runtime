# aclrtCmoGetDescSize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前Device上的Cache内存描述符占用的内存大小。

## 函数原型

```
aclError aclrtCmoGetDescSize(size_t *size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| size | 输出 | Cache内存描述符大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

