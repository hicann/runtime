# aclrtCreateBinary

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建aclrtBinary类型的数据，该数据类型用于描述算子二进制信息。此处的算子为使用Ascend C语言开发的自定义算子。

如需销毁aclrtBinary类型的数据，请参见[aclrtDestroyBinary](aclrtDestroyBinary.md)。

## 函数原型

```
aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| data | 输入 | 存放算子二进制文件（*.o文件）数据的内存地址指针。<br>应用运行在Host时，此处需申请Host上的内存；应用运行在Device时，此处需申请Device上的内存。内存申请接口请参见[内存管理](内存管理.md)。 |
| dataLen | 输入 | 内存大小，单位Byte。 |

## 返回值说明

返回aclrtBinary类型的指针。

