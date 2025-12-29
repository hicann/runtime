# aclrtCtxGetFloatOverflowAddr

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

饱和模式下，获取保存溢出标记的Device内存地址，该内存地址后续需作为Workspace参数传递给AI Core算子。

## 函数原型

```
aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| overflowAddr | 输出 | 保存溢出标记的Device内存地址。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

