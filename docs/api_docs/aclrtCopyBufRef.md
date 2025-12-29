# aclrtCopyBufRef

## 功能说明

对共享Buffer数据区的引用拷贝，创建并返回一个新的Mbuf管理结构指向相同的数据区。

## 函数原型

```
aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 共享Buffer。<br>共享Buffer可通过[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请获得。 |
| newBuf | 输出 | 返回一个新的共享Buffer，指向相同的数据区。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

