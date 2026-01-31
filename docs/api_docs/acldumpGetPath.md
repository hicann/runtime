# acldumpGetPath

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取Dump数据路径。此接口需与[aclmdlInitDump](aclmdlInitDump.md)接口、[aclmdlSetDump](aclmdlSetDump.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，以获取Dump数据路径，从而将用户自定义的维测数据保存到该路径下。

接口调用顺序如下：aclmdlInitDump接口 -\> aclmdlSetDump接口 -\> acldumpGetPath接口 -\> 执行算子或模型 -\> aclmdlFinalizeDump。

## 函数原型

```
const char* acldumpGetPath(acldumpType dumpType)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dumpType | 输入 | Dump类型。 |

## 返回值说明

返回Dump数据的路径。如果返回空指针，则表示未查询到Dump路径。

