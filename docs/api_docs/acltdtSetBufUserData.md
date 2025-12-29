# acltdtSetBufUserData

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

设置共享Buffer的私有数据区数据，从用户内存拷贝到共享内存的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

## 函数原型

```
aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输出 | 共享Buffer指针。 |
| dataPtr | 输入 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

