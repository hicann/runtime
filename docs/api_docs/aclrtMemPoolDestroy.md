# aclrtMemPoolDestroy

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁通过 [aclrtMemPoolCreate](aclrtMemPoolCreate.md) 创建的内存池。

## 函数原型

```
aclError aclrtMemPoolDestroy(const aclrtMemPool memPool)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| memPool | 输入 | 内存池实例，类型为 [aclrtMemPool](aclrtMemPool.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

