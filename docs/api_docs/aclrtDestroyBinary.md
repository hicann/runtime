# aclrtDestroyBinary

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁通过[aclrtCreateBinary](aclrtCreateBinary.md)接口创建的aclrtBinary类型的数据。此处的算子为使用Ascend C语言开发的自定义算子。

注意，此处仅销毁aclrtBinary的数据，调用[aclrtCreateBinary](aclrtCreateBinary.md)接口时传入的data内存需由用户自行、及时释放，否则可能会导致内存异常。

## 函数原型

```
aclError aclrtDestroyBinary(aclrtBinary binary)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binary | 输入 | 待销毁的aclrtBinary类型的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

