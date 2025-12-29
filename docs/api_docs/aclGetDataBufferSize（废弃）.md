# aclGetDataBufferSize（废弃）

**须知：此接口后续版本会废弃，请使用[aclGetDataBufferSizeV2](aclGetDataBufferSizeV2.md)接口。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取aclDataBuffer类型中数据的内存大小，单位Byte。

## 函数原型

```
uint32 aclGetDataBufferSize(const aclDataBuffer *dataBuffer)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataBuffer | 输入 | aclDataBuffer类型的指针。<br>需提前调用[aclCreateDataBuffer](aclCreateDataBuffer.md)接口创建aclDataBuffer类型的数据。 |

## 返回值说明

aclDataBuffer类型中数据的内存大小。

