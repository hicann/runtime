# aclrtMemPoolGetAttr

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取指定属性的值。

如果未通过 [aclrtMemPoolSetAttr](aclrtMemPoolSetAttr.md) 接口设置相应属性，则获取该属性的默认值。

## 函数原型

```
aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| memPool | 输入 | 内存池实例，类型为 [aclrtMemPool](aclrtMemPool.md)。 |
| attr | 输入 | 指定属性，类型为 [aclrtMemPoolAttr](aclrtMemPoolAttr.md)。 |
| value | 输出 | 指向输出属性值地址的指针，该指针指向的类型需与 attr 处指定属性的类型相同。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

