# aclrtAllocBuf

## 功能说明

申请指定大小的共享Buffer。

## 函数原型

```
aclError aclrtAllocBuf(aclrtMbuf *buf, size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输出 | 申请到的共享Buffer。 |
| size | 输入 | 用于指定数据区的内存大小，单位Byte，不能超过4G。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

