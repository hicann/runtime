# aclrtDeviceGetBareTgid

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前进程的进程ID。

本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配置其它接口使用（配合流程请参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)），达到物理内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

## 函数原型

```
aclError aclrtDeviceGetBareTgid(int32_t *pid)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| pid | 输出 | 进程ID。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

