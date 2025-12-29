# aclUpdateDataBuffer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

更新aclDataBuffer中数据的内存及大小。

更新aclDataBuffer后，之前aclDataBuffer中存放数据的内存如果不使用，需及时释放，否则可能会导致内存泄漏。

## 函数原型

```
aclError aclUpdateDataBuffer(aclDataBuffer *dataBuffer, void *data, size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataBuffer | 输入 | aclDataBuffer类型的指针。<br>需提前调用[aclCreateDataBuffer](aclCreateDataBuffer.md)接口创建aclDataBuffer类型的数据。<br>该内存需由用户自行管理，调用[aclrtMalloc](aclrtMalloc.md)接口/[aclrtFree](aclrtFree.md)接口申请/释放内存，或调用[aclrtMallocHost](aclrtMallocHost.md)接口/[aclrtFreeHost](aclrtFreeHost.md)接口申请/释放内存。 |
| data | 输入 | 存放数据内存地址的指针。 |
| size | 输入 | 内存大小，单位Byte。<br>如果用户需要使用空tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

