# aclrtKernelArgsGetMemSize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取Kernel Launch时参数列表所需内存的实际大小。

## 函数原型

```
aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| funcHandle | 输入 | 核函数句柄。 |
| userArgsSize | 输入 | 在内存中存放参数列表数据所需的大小，单位为Byte。<br>每个参数数据的内存大小都需要8字节对齐，这里的userArgsSize是这些对齐后的参数数据内存大小相加的总和。 |
| actualArgsSize | 输出 | Kernel Launch时参数列表所需内存的实际大小，单位为Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

