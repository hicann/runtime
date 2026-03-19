# aclrtMemPoolSetAttr

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置属性值。

多次对同一个内存池的同一个属性值进行设置，以最后一次为准。

## 函数原型

```
aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| memPool | 输入 | 内存池实例，类型为 [aclrtMemPool](aclrtMemPool.md)。 |
| attr | 输入 | 指定属性，类型为 [aclrtMemPoolAttr](aclrtMemPoolAttr.md)。 |
| value | 输入 | 指向写入属性值地址的指针，写入的数据，其类型需要与 attr 处指定属性的类型相同。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

