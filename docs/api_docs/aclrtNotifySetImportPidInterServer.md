# aclrtNotifySetImportPidInterServer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

针对Atlas A3 训练系列产品/Atlas A3 推理系列产品中的超节点产品，设置共享Notify的进程白名单。

## 函数原型

```
aclError aclrtNotifySetImportPidInterServer(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notify | 输入 | 指定Notify。<br>必须先调用[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口获取指定Notify的共享名称，再作为入参传入。 |
| serverPids | 输入 | 白名单信息数组。 |
| num | 输入 | serverPids数组的大小。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

