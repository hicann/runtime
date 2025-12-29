# aclrtMemset

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

初始化内存，将内存中的内容设置为指定的值。

要初始化的内存支持在Host侧或Device侧，系统根据地址判定是Host还是Device。如果Host内存不是用acl接口（例如aclrtMallocHost）申请的，将会导致未定义的行为。

## 函数原型

```
aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输入 | 内存起始地址的指针。 |
| maxCount | 输入 | 内存的最大长度，单位Byte。 |
| value | 输入 | 设置的值。 |
| count | 输入 | 需要设置为指定值的内存长度，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

本接口会立刻进行内存初始化，函数内部不会进行隐式的device同步或流同步。

