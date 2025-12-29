# acltdtSetBufDataLen

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

设置共享Buffer中有效数据的长度。

接口调用顺序：调用[acltdtAllocBuf](acltdtAllocBuf.md)或[acltdtCopyBufRef](acltdtCopyBufRef.md)接口申请到共享Buffer后，因此需由用户调用[acltdtGetBufData](acltdtGetBufData.md)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用acltdtSetBufDataLen接口设置共享Buffer中有效数据的长度，且长度必须小于[acltdtGetBufData](acltdtGetBufData.md)获取到的size大小。

## 函数原型

```
aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 共享Buffer指针，须通过[acltdtAllocBuf](acltdtAllocBuf.md)或[acltdtCopyBufRef](acltdtCopyBufRef.md)接口申请获得。 |
| len | 输入 | 有效数据的长度，单位为Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

