# aclrtNotifyGetExportKey

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将本进程中的指定Notify设置为IPC（Inter-Process Communication） Notify，并返回key（即Notify共享名称），用于在多Device上不同进程间实现任务同步。

**本接口需与以下其它关键接口配合使用**，以便实现多Device上不同进程间的任务同步，此处以Device 0上的A进程、Device 1上的B进程为例，说明两个进程间的任务同步接口调用流程:

1.  在A进程中：
    1.  调用[aclrtCreateNotify](aclrtCreateNotify.md)接口创建Notify。
    2.  调用[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口导出key（即Notify共享名称）。

        调用[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[aclrtNotifySetImportPid](aclrtNotifySetImportPid.md)接口将B进程的进程ID设置为白名单；反之，则无需调用[aclrtNotifySetImportPid](aclrtNotifySetImportPid.md)接口。

    3.  调用[aclrtWaitAndResetNotify](aclrtWaitAndResetNotify.md)接口下发等待任务。
    4.  调用[aclrtDestroyNotify](aclrtDestroyNotify.md)接口销毁Notify。

        涉及IPC Notify的进程都需要释放Notify，所有涉及IPC Notify的进程都完成释放操作，Notify才真正释放。

2.  在B进程中：
    1.  调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口，获取B进程的进程ID。

        本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    2.  调用[aclrtNotifyImportByKey](aclrtNotifyImportByKey.md)获取key的信息，并返回本进程可以使用的Notify指针。

        调用[aclrtIpcMemImportByKey](aclrtIpcMemImportByKey.md)接口前，需确保IPC Notify，不能提前释放。

    3.  调用[aclrtRecordNotify](aclrtRecordNotify.md)接口下发Record任务。
    4.  调用[aclrtDestroyNotify](aclrtDestroyNotify.md)接口销毁Notify。

## 函数原型

```
aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notify | 输入 | 指定Notify。 |
| key | 输出 | Notify共享名称。 |
| len | 输入 | Notify共享名称的长度，最小长度为65。 |
| flags | 输入 | 是否启用进程白名单校验。<br>取值为如下宏：<br><br>  - ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。配置为该值时，需单独调用[aclrtNotifySetImportPid](aclrtNotifySetImportPid.md)接口将使用Notify共享名称的进程ID设置为白名单。<br>  - ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。配置为该值时，则无需调用[aclrtNotifySetImportPid](aclrtNotifySetImportPid.md)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x02UL |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

昇腾虚拟化实例场景不支持该操作。

