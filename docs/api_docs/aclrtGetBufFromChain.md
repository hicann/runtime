# aclrtGetBufFromChain

## 功能说明

从Mbuf链表中获取第index个共享Buffer。

## 函数原型

```
aclError aclrtGetBufFromChain(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| headBuf | 输入 | Mbuf链表中的第一个共享Buffer。 |
| index | 输入 | Mbuf链表中的索引（从0开始计数）。 |
| buf | 输出 | 输出第index个共享Buffer。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

