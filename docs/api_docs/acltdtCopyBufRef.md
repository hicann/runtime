# acltdtCopyBufRef

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

对共享Buffer数据区的引用拷贝，创建并返回一个新的Buffer管理结构指向相同的数据区。

## 函数原型

```
aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| buf | 输入 | 共享Buffer，须通过[acltdtAllocBuf](acltdtAllocBuf.md)或[acltdtCopyBufRef](acltdtCopyBufRef.md)接口申请获得。 |
| newBuf | 输出 | 返回一个新的共享Buffer，指向相同的数据区。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

