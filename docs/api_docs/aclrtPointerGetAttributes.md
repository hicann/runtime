# aclrtPointerGetAttributes

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取内存属性信息，包括内存是位于Host还是Device、页表大小等信息。

## 函数原型

```
aclError aclrtPointerGetAttributes(const void *ptr, aclrtPtrAttributes *attributes)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 内存地址。<br>此处仅支持通过acl接口申请的内存。 |
| attributes | 输出 | 内存属性信息。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

