# acldumpGetPath

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取Dump数据存放路径，以便用户将自定维测数据保存到该路径下。

在调用本接口前，需通过[aclmdlInitDump](aclmdlInitDump.md)接口初始化Dump功能、通过[aclmdlSetDump](aclmdlSetDump.md)接口配置Dump信息，或者直接通过[aclInit](aclInit.md)接口配置Dump信息。

## 函数原型

```
const char* acldumpGetPath(acldumpType dumpType)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dumpType | 输入 | Dump类型。类型定义请参见[acldumpType](acldumpType.md)。 |

## 返回值说明

返回Dump数据的路径。如果返回空指针，则表示未查询到Dump路径。

