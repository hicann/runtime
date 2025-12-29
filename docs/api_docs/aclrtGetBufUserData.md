# aclrtGetBufUserData

## 功能说明

获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

## 函数原型

```
aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 共享Buffer，须通过[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请获得。 |
| dataPtr | 输出 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

