# aclrtGetBufDataLen

## 功能说明

获取共享Buffer中有效数据的长度。

通过[aclrtSetBufDataLen](aclrtSetBufDataLen.md)接口设置共享Buffer中有效数据的长度后，可调用本接口获取有效数据的长度，否则，通过本接口获取到的长度为0。

## 函数原型

```
aclError aclrtGetBufDataLen(aclrtMbuf buf, size_t *len)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 共享Buffer，须通过[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请获得。 |
| len | 输出 | 有效数据的长度，单位为Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

