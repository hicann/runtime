# aclrtAppendBufChain

## 功能说明

将共享Buffer添加到Mbuf链表中。共享Buffer链最大支持128个共享Buffer。共享Buffer可通过[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请获得。

## 函数原型

```
aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| headBuf | 输入 | Mbuf链表中的第一个共享Buffer。 |
| buf | 输入 | 待添加的共享Buffer。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

