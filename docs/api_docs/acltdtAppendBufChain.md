# acltdtAppendBufChain

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

将某个共享Buffer内存添加到共享Buffer链表中。共享Buffer链最大支持128个共享Buffer。共享Buffer可通过[acltdtAllocBuf](acltdtAllocBuf.md)或[acltdtCopyBufRef](acltdtCopyBufRef.md)接口申请获得。

## 函数原型

```
aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。 |
| buf | 输入 | 待添加的共享Buffer。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

