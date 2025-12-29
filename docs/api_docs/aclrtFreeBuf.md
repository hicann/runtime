# aclrtFreeBuf

## 功能说明

释放通过[aclrtAllocBuf](aclrtAllocBuf.md)接口申请的共享Buffer。

## 函数原型

```
aclError aclrtFreeBuf(aclrtMbuf buf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 待释放的共享Buffer。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

