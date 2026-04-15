# 8. Notify管理

本章节描述 CANN Runtime 的 Notify 管理接口，用于 Notify 的创建、记录、等待/重置及跨进程共享。

- [`aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)`](#aclrtCreateNotify)：创建Notify。
- [`aclError aclrtDestroyNotify(aclrtNotify notify)`](#aclrtDestroyNotify)：销毁Notify。
- [`aclError aclrtRecordNotify(aclrtNotify notify, aclrtStream stream)`](#aclrtRecordNotify)：在指定Stream上记录一个Notify。异步接口。
- [`aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)`](#aclrtWaitAndResetNotify)：阻塞指定Stream的运行，直到指定的Notify完成，再复位Notify。异步接口。
- [`aclError aclrtGetNotifyId(aclrtNotify notify, uint32_t *notifyId)`](#aclrtGetNotifyId)：获取指定Notify的ID。
- [`aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)`](#aclrtNotifyBatchReset)：批量复位Notify。
- [`aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)`](#aclrtNotifyGetExportKey)：将本进程中的指定Notify设置为IPC（Inter-Process Communication） Notify，并返回key（即Notify共享名称），用于在多Device上不同进程间实现任务同步。
- [`aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)`](#aclrtNotifySetImportPid)：设置共享Notify的进程白名单**。**
- [`aclError aclrtNotifySetImportPidInterServer(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)`](#aclrtNotifySetImportPidInterServer)：设置共享Notify的进程白名单。
- [`aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flags)`](#aclrtNotifyImportByKey)：在本进程中获取key的信息，并返回本进程可以使用的Notify指针。


<a id="aclrtCreateNotify"></a>

# aclrtCreateNotify

```c
aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建Notify。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输出 | Notify的指针。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| flag | 输入 | Notify指针的flag。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_NOTIFY_DEFAULT：使能该bit表示创建的Notify默认在Host上调用。<br><br><br>  - ACL_NOTIFY_DEVICE_USE_ONLY：使能该bit表示创建的Notify仅在Device上调用。<br><br><br>宏的定义如下：<br>#define ACL_NOTIFY_DEFAULT 0x00000000U<br>#define ACL_NOTIFY_DEVICE_USE_ONLY 0x00000001U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

不同型号的硬件支持的Notify数量不同，如下表所示：


| 型号 | 单个Device支持的Notify最大数 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | 65535 |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 8192 |


<br>
<br>
<br>



<a id="aclrtDestroyNotify"></a>

# aclrtDestroyNotify

```c
aclError aclrtDestroyNotify(aclrtNotify notify)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁Notify。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 待销毁的Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtRecordNotify"></a>

# aclrtRecordNotify

```c
aclError aclrtRecordNotify(aclrtNotify notify, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在指定Stream上记录一个Notify。异步接口。

aclrtRecordNotify接口与aclrtWaitAndResetNotify接口配合使用时，主要用于多Stream之间同步等待的场景。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 待记录的Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream1。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtWaitAndResetNotify"></a>

# aclrtWaitAndResetNotify

```c
aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

阻塞指定Stream的运行，直到指定的Notify完成，再复位Notify。异步接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 需等待的Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。 |
| timeout | 输入 | 等待的超时时间。<br>取值说明如下：<br><br>  - 0：表示永久等待；<br>  - >0：配置具体的超时时间，单位是秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetNotifyId"></a>

# aclrtGetNotifyId

```c
aclError aclrtGetNotifyId(aclrtNotify notify, uint32_t *notifyId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取指定Notify的ID。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 指定要查询的Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| notifyId | 输出 | Notify ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtNotifyBatchReset"></a>

# aclrtNotifyBatchReset

```c
aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

批量复位Notify。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notifies | 输入 | Notify数组。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| num | 输入 | Notify数组的长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

昇腾虚拟化实例场景不支持该操作。


<br>
<br>
<br>



<a id="aclrtNotifyGetExportKey"></a>

# aclrtNotifyGetExportKey

```c
aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

将本进程中的指定Notify设置为IPC（Inter-Process Communication） Notify，并返回key（即Notify共享名称），用于在多Device上不同进程间实现任务同步。

**本接口需与以下其它关键接口配合使用**，以便实现多Device上不同进程间的任务同步，此处以Device 0上的A进程、Device 1上的B进程为例，说明两个进程间的任务同步接口调用流程:

1.  在A进程中：
    1.  调用[aclrtCreateNotify](#aclrtCreateNotify)接口创建Notify。
    2.  调用[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口导出key（即Notify共享名称）。

        调用[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[aclrtNotifySetImportPid](#aclrtNotifySetImportPid)接口将B进程的进程ID设置为白名单；反之，则无需调用[aclrtNotifySetImportPid](#aclrtNotifySetImportPid)接口。

    3.  调用[aclrtWaitAndResetNotify](#aclrtWaitAndResetNotify)接口下发等待任务。
    4.  调用[aclrtDestroyNotify](#aclrtDestroyNotify)接口销毁Notify。

        涉及IPC Notify的进程都需要释放Notify，所有涉及IPC Notify的进程都完成释放操作，Notify才真正释放。

2.  在B进程中：
    1.  调用[aclrtDeviceGetBareTgid](04_Device管理.md#aclrtDeviceGetBareTgid)接口，获取B进程的进程ID。

        本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    2.  调用[aclrtNotifyImportByKey](#aclrtNotifyImportByKey)获取key的信息，并返回本进程可以使用的Notify指针。建议flag使用ACL\_RT\_NOTIFY\_IMPORT\_FLAG\_ENABLE\_PEER\_ACCESS开启两个Device之间的数据交互。

        调用[aclrtIpcMemImportByKey](11-07_IPC进程间内存共享.md#aclrtIpcMemImportByKey)接口前，需确保IPC Notify，不能提前释放。

    3.  调用[aclrtRecordNotify](#aclrtRecordNotify)接口下发Record任务。
    4.  调用[aclrtDestroyNotify](#aclrtDestroyNotify)接口销毁Notify。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 指定Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| key | 输出 | Notify共享名称。 |
| len | 输入 | Notify共享名称的长度，最小长度为65。 |
| flags | 输入 | 是否启用进程白名单校验。<br>取值为如下宏：<br><br>  - ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。配置为该值时，需单独调用[aclrtNotifySetImportPid](#aclrtNotifySetImportPid)接口将使用Notify共享名称的进程ID设置为白名单。<br>  - ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。配置为该值时，则无需调用[aclrtNotifySetImportPid](#aclrtNotifySetImportPid)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x02UL |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

昇腾虚拟化实例场景不支持该操作。


<br>
<br>
<br>



<a id="aclrtNotifySetImportPid"></a>

# aclrtNotifySetImportPid

```c
aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置共享Notify的进程白名单。

本接口需与其它接口配合使用，以便实现多Device上不同进程间的任务同步，请参见[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口处的说明。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 指定Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。<br>与[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口中的Notify保持一致。 |
| pid | 输入 | 用于存放白名单进程ID的数组。<br>进程ID可调用[aclrtDeviceGetBareTgid](04_Device管理.md#aclrtDeviceGetBareTgid)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |
| num | 输入 | 白名单进程数量，与pid参数数组的大小保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

昇腾虚拟化实例场景不支持该操作。


<br>
<br>
<br>



<a id="aclrtNotifySetImportPidInterServer"></a>

# aclrtNotifySetImportPidInterServer

```c
aclError aclrtNotifySetImportPidInterServer(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

设置共享Notify的进程白名单。

该接口仅针对针对Atlas A3 训练系列产品/Atlas A3 推理系列产品中的超节点产品，

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输入 | 指定Notify。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。<br>必须先调用[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口获取指定Notify的共享名称，再作为入参传入。 |
| serverPids | 输入 | 白名单信息数组。类型定义请参见[aclrtServerPid](25_数据类型及其操作接口.md#aclrtServerPid)。 |
| num | 输入 | serverPids数组的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtNotifyImportByKey"></a>

# aclrtNotifyImportByKey

```c
aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flags)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在本进程中获取key的信息，并返回本进程可以使用的Notify指针。

本接口需与其它接口配合使用，以便实现多Device上不同进程间的任务同步，请参见[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口处的说明。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| notify | 输出 | Notify指针。类型定义请参见[aclrtNotify](25_数据类型及其操作接口.md#aclrtNotify)。 |
| key | 输入 | Notify共享名称。<br>必须先调用[aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey)接口获取指定Notify的共享名称，再作为入参传入。 |
| flags | 输入 | 是否开启两个Device之间的数据交互。<br>取值为如下宏：<br><br>  - ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT：默认值，关闭两个Device之间的数据交互。配置为该值时，需单独调用[aclrtDeviceEnablePeerAccess](04_Device管理.md#aclrtDeviceEnablePeerAccess)接口开启两个Device之间的数据交互。<br>  - ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS：开启两个Device之间的数据交互。配置为该值时，则无需调用[aclrtDeviceEnablePeerAccess](04_Device管理.md#aclrtDeviceEnablePeerAccess)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS 0x02UL |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

昇腾虚拟化实例场景不支持该操作。
