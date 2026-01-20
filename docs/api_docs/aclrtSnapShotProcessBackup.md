# aclrtSnapShotProcessBackup

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

备份快照进程中的Device资源，并将Device资源保存在Host侧，以便后续恢复。针对当前进程，支持多次备份，以最后一次生效。

在调用此接口之前，必须确保当前进程处于LOCKED状态；调用该接口后，当前进程将变为BACKED\_UP状态。

## 函数原型

```
aclError aclrtSnapShotProcessBackup()
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

