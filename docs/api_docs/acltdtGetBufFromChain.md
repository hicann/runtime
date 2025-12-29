# acltdtGetBufFromChain

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

获取Mbuf链中第index个Mbuf。

## 函数原型

```
aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer，须通过[acltdtAllocBuf](acltdtAllocBuf.md)或[acltdtCopyBufRef](acltdtCopyBufRef.md)接口申请获得。 |
| index | 输入 | 共享Buffer链中的共享Buffer序号（从0开始计数）。 |
| buf | 输出 | 输出第index个共享Buffer。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

