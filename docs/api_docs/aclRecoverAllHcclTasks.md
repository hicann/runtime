# aclRecoverAllHcclTasks

**须知：本接口为预留接口，暂不支持。**

## 功能说明

维测场景下，本接口恢复指定Device上的所有集合通信任务。

## 函数原型

```
aclError aclRecoverAllHcclTasks(int32_t deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用aclrtGetDeviceCount接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

