# aclrtSnapShotProcessRestore

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

恢复快照进程中的Device资源。根据备份好的Device资源进行恢复，从最后一次备份点进行恢复。

在调用该接口之前，必须确保当前进程处于BACKED\_UP状态；调用该接口后，当前进程将变为LOCKED状态。

## 函数原型

```
aclError aclrtSnapShotProcessRestore()
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

恢复和备份需要在同一个Device上（指Device ID相同）。恢复时，若Device被其他进程占用，则恢复失败。

