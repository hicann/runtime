# aclrtGetBufChainNum

## 功能说明

从Mbuf链表中获取共享Buffer的个数。

## 函数原型

```
aclError aclrtGetBufChainNum(aclrtMbuf headBuf, uint32_t *num)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| headBuf | 输入 | Mbuf链表中的第一个共享Buffer。 |
| num | 输出 | 共享Buffer的个数。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

