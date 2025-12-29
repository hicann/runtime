# aclrtNotifySetImportPid

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置共享Notify的进程白名单**。**

本接口需与其它接口配合使用，以便实现多Device上不同进程间的任务同步，请参见[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口处的说明。

## 函数原型

```
aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notify | 输入 | 指定Notify，与[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口中的Notify保持一致。 |
| pid | 输入 | 用于存放白名单进程ID的数组。<br>进程ID可调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |
| num | 输入 | 白名单进程数量，与pid参数数组的大小保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

昇腾虚拟化实例场景不支持该操作。

