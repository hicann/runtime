# aclrtBinaryLoad

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

解析、加载算子二进制文件，输出指向算子二进制的binHandle，同时将算子二进制文件数据拷贝至当前Context对应的Device上。此处的算子为使用Ascend C语言开发的自定义算子。

## 函数原型

```
aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binary | 输入 | 算子二进制信息。<br>此处需先调用[aclrtCreateBinary](aclrtCreateBinary.md)接口，获取aclrtBinary类型数据的指针。 |
| binHandle | 输出 | 指向二进制的handle。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

