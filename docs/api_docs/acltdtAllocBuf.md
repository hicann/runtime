# acltdtAllocBuf

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

申请共享Buffer内存。

使用acltdtAllocBuf接口申请内存后，数据区的长度为size参数的大小，在用户还未填入有效数据前，该内存的有效数据长度初始值为0，可在用户向内存中填入有效数据后，再通过[acltdtSetBufDataLen](acltdtSetBufDataLen.md)接口设置有效数据长度。

使用acltdtAllocBuf接口申请的内存，需要通过[acltdtFreeBuf](acltdtFreeBuf.md)接口释放内存。

## 函数原型

```
aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| size | 输入 | 用于指定数据区的内存大小，单位Byte，不能超过4G。 |
| type | 输入 | 共享Buffer内存类型，支持设置如下枚举值。<br>typedef enum {<br>   ACL_TDT_NORMAL_MEM = 0,<br>   ACL_TDT_DVPP_MEM<br>} acltdtAllocBufType; |
| buf | 输出 | 申请成功，输出共享Buffer。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

