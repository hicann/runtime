# aclrtMemPoolCreate

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建内存池。

## 函数原型

```
aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| memPool | 输出 | 内存池实例，类型为 [aclrtMemPool](aclrtMemPool.md)。 |
| poolProps | 输入 | 内存池配置，类型为 [aclrtMemPoolProps](aclrtMemPoolProps.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

