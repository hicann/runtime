# aclCreateDataBuffer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建aclDataBuffer类型的数据，该数据类型用于描述内存地址、大小等内存信息。

如需销毁aclDataBuffer类型的数据，请参见[aclDestroyDataBuffer](aclDestroyDataBuffer.md)。

## 函数原型

```
aclDataBuffer *aclCreateDataBuffer(void *data, size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| data | 输入 | 存放数据内存地址的指针。data参数支持传入nullptr，表示创建一个空的数据类型，此时size参数值必须设置为0。<br>该内存需由用户自行管理，调用[aclrtMalloc](aclrtMalloc.md)接口/[aclrtFree](aclrtFree.md)接口申请/释放内存，或调用[aclrtMallocHost](aclrtMallocHost.md)接口/[aclrtFreeHost](aclrtFreeHost.md)接口申请/释放内存。 |
| size | 输入 | 内存大小，单位Byte。<br>如果用户需要使用空tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。 |

## 返回值说明

返回aclDataBuffer类型的指针。

