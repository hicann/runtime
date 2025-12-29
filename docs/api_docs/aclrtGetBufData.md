# aclrtGetBufData

## 功能说明

获取共享Buffer的数据区指针和数据区长度，用户可以使用此指针填入数据。

接口调用顺序：调用[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请到共享Buffer后，因此需由用户调用[aclrtGetBufData](aclrtGetBufData.md)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用[aclrtSetBufDataLen](aclrtSetBufDataLen.md)接口设置共享Buffer中有效数据的长度，且长度必须小于[aclrtGetBufData](aclrtGetBufData.md)获取到的size大小。

## 函数原型

```
aclError aclrtGetBufData(const aclrtMbuf buf, void **dataPtr, size_t *size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 共享Buffer，须通过[acltdtAllocBuf](acltdtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请获得。 |
| dataPtr | 输出 | 数据区指针（Device侧地址）。 |
| size | 输出 | 数据区的长度，单位为Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

