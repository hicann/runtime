# aclrtIpcMemSetImportPid

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置IPC共享内存的进程白名单。

本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口处的说明。

## 函数原型

```
aclError aclrtIpcMemSetImportPid(const char *key, int32_t *pid, size_t num)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| key | 输入 | 通过[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口获取的内存key。 |
| pid | 输入 | 用于存放白名单进程ID的数组。<br>进程ID可调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |
| num | 输入 | 白名单进程数量，与pid参数数组的大小保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

