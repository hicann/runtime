# 7. Event管理

本章节描述 CANN Runtime 的 Event 管理接口，用于事件的创建、记录、同步、计时及 IPC 跨进程共享。

- [`aclError aclrtCreateEvent(aclrtEvent *event)`](#aclrtCreateEvent)：创建Event，创建出来的Event可用于统计两个Event之间的耗时、多Stream之间的任务同步等场景。
- [`aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEventWithFlag)：创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。
- [`aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEventExWithFlag)：创建带flag的Event，不同flag的Event用于不同的功能。
- [`aclError aclrtDestroyEvent(aclrtEvent event)`](#aclrtDestroyEvent)：销毁Event，支持在Event未完成前调用本接口销毁Event。此时，本接口不会阻塞线程等Event完成，Event相关资源会在Event完成时被自动释放。
- [`aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)`](#aclrtRecordEvent)：在指定Stream中记录一个Event。异步接口。
- [`aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)`](#aclrtResetEvent)：复位Event，恢复Event初始状态，便于Event对象重复使用。异步接口。
- [`aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)`](#aclrtQueryEvent（废弃）)：查询与本接口在同一线程中的[aclrtRecordEvent](#aclrtRecordEvent)接口所记录的Event是否执行完成。
- [`aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)`](#aclrtQueryEventStatus)：查询该Event捕获的所有任务的执行状态。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节。
- [`aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)`](#aclrtQueryEventWaitStatus)：调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口后查询该Event对应的等待任务是否都执行完成。
- [`aclError aclrtSynchronizeEvent(aclrtEvent event)`](#aclrtSynchronizeEvent)：阻塞当前线程运行直到Event捕获的所有任务都执行完成。
- [`aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)`](#aclrtSynchronizeEventWithTimeout)：阻塞当前线程运行直到Event捕获的所有任务都执行完成（具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节），该接口是在接口[aclrtSynchronizeEvent](#aclrtSynchronizeEvent)基础上进行了增强，支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则当应用程序异常时可根据所设置的超时时间自行退出。
- [`aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)`](#aclrtEventElapsedTime)：统计两个Event之间的耗时。
- [`aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)`](#aclrtStreamWaitEvent)：阻塞指定Stream的运行，直到指定的Event完成，支持多个Stream等待同一个Event的场景。异步接口。
- [`aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)`](#aclrtStreamWaitEventWithTimeout)：获取算子二进制数据在Device上的内存地址及内存大小。
- [`aclError aclrtSetOpWaitTimeout(uint32_t timeout)`](#aclrtSetOpWaitTimeout)：本接口用于设置等待Event完成的超时时间。
- [`aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)`](#aclrtEventGetTimestamp)：获取Event的执行结束时间点（表示从AI处理器系统启动以来的时间）。
- [`aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)`](#aclrtGetEventId)：获取指定Event的ID。
- [`aclError aclrtGetEventAvailNum(uint32_t *eventCount)`](#aclrtGetEventAvailNum)：查询当前Device上可用的Event数量。
- [`aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)`](#aclrtIpcGetEventHandle)：将本进程中的指定Event设置为IPC（Inter-Process Communication） Event，并返回其handle（即Event句柄），用于在跨进程场景下实现任务同步，支持同一个Device内的多个进程以及跨Device的多个进程。
- [`aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)`](#aclrtIpcOpenEventHandle)：在本进程中获取handle的信息，并返回本进程可以使用的Event指针。


<a id="aclrtCreateEvent"></a>

# aclrtCreateEvent

```c
aclError aclrtCreateEvent(aclrtEvent *event)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建Event，创建出来的Event可用于统计两个Event之间的耗时、多Stream之间的任务同步等场景。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

采用本API创建的Event不支持在[aclrtResetEvent](#aclrtResetEvent)接口中使用，否则会导致未定义的行为。

调用本接口创建Event时，并不会实际申请Event资源，只有在调用[aclrtRecordEvent](#aclrtRecordEvent)接口时，才会进行资源申请，因此在调用[aclrtRecordEvent](#aclrtRecordEvent)时，可能会出现线程阻塞，等待Event资源的释放。

不同型号的硬件支持的Event数量不同，如下表所示：


| 型号 | 单个Device支持的Event最大数 |
| --- | --- |
| Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 65536 |


<br>
<br>
<br>



<a id="aclrtCreateEventWithFlag"></a>

# aclrtCreateEventWithFlag

```c
aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| flag | 输入 | Event指针的flag。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_EVENT_TIME_LINE：使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<br><br><br>  - ACL_EVENT_SYNC：使能该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使能该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_EXTERNAL：使能该bit表示创建的Event用于任务捕获场景下的任务更新功能，相关说明请参见[aclmdlRICaptureBegin](15_模型运行实例管理.md#aclmdlRICaptureBegin)。注意：该flag不支持与其他flag进行位或操作。<br>  - ACL_EVENT_DEVICE_USE_ONLY：使能该bit表示创建的Event仅在Device上调用。仅如下型号支持ACL_EVENT_DEVICE_USE_ONLY：<br>Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品<br><br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_EXTERNAL  0x00000020U<br>#define ACL_EVENT_DEVICE_USE_ONLY  0x00000010U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

调用本接口创建Event时，flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作。

若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在以下API中使用本接口创建的Event：[aclrtResetEvent](#aclrtResetEvent)、[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)、[aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus)。若flag参数值**包含**ACL\_EVENT\_SYNC宏或者flag设置为ACL\_EVENT\_EXTERNAL时，则创建出来的Event数量受限，具体如下：


| 型号 | 单个Device支持的Event最大数 |
| --- | --- |
| Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 65536 |


<br>
<br>
<br>



<a id="aclrtCreateEventExWithFlag"></a>

# aclrtCreateEventExWithFlag

```c
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。创建Event时，Event资源不受硬件限制。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| flag | 输入 | Event指针的flag。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_EVENT_TIME_LINE：使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<br><br><br>  - ACL_EVENT_SYNC：使能该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使能该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_IPC：使能该bit表示创建的Event用于进程间通信，详细说明请参见[aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle)。注意：该flag不支持与其他flag进行位或操作。本flag创建出来的Event不支持在以下接口或场景中使用：[aclrtResetEvent](#aclrtResetEvent)、[aclrtQueryEvent](aclrtQueryEvent（废弃）.md)、[aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus)、[aclrtEventElapsedTime](#aclrtEventElapsedTime)、[aclrtEventGetTimestamp](#aclrtEventGetTimestamp)、[aclrtGetEventId](#aclrtGetEventId)、模型捕获场景（参见[aclmdlRICaptureBegin](15_模型运行实例管理.md#aclmdlRICaptureBegin)中的说明），否则返回报错。<br><br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_IPC 0x00000040U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

采用本API创建的Event，不支持在以下接口中使用：[aclrtResetEvent](#aclrtResetEvent)、[aclrtQueryEvent](aclrtQueryEvent（废弃）.md)、[aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus)，否则返回报错。

调用本接口创建Event时，flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作。若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口中使用本接口创建的Event。若flag参数值**包含**ACL\_EVENT\_SYNC宏，并不会实际申请Event资源，只有在调用[aclrtRecordEvent](#aclrtRecordEvent)接口时，才会进行资源申请，因此在调用[aclrtRecordEvent](#aclrtRecordEvent)时，可能会出现线程阻塞，等待Event资源的释放。

不同型号的硬件支持的Event数量不同，如下表所示：


| 型号 | 单个Device支持的Event最大数 |
| --- | --- |
| Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 65536 |


<br>
<br>
<br>



<a id="aclrtDestroyEvent"></a>

# aclrtDestroyEvent

```c
aclError aclrtDestroyEvent(aclrtEvent event)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁Event，支持在Event未完成前调用本接口销毁Event。此时，本接口不会阻塞线程等Event完成，Event相关资源会在Event完成时被自动释放。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 待销毁的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

在调用aclrtDestroyEvent接口销毁指定Event时，需确保其它接口没有正在使用该Event。


<br>
<br>
<br>



<a id="aclrtRecordEvent"></a>

# aclrtRecordEvent

```c
aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在指定Stream中记录一个Event。异步接口。

aclrtRecordEvent接口与aclrtStreamWaitEvent接口配合使用时，主要用于多Stream之间同步等待的场景。

调用aclrtRecordEvent接口时，会捕获当前Stream上已下发的任务，并记录到Event事件中，因此后续若调用[aclrtQueryEventStatus](#aclrtQueryEventStatus)或[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口时，会检查或等待该Event事件中所捕获的任务都已经完成。

另外，对于使用[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)创建的Event：

-   aclrtRecordEvent接口支持对同一个Event多次record实现Event复用，每次Record会重新捕获当前Stream上已下发的任务，并覆盖保存到Event中。在调用aclrtStreamWaitEvent接口时，会使用最近一次Event中所保存的任务，且不会被后续的aclrtRecordEvent调用影响。
-   在首次调用aclrtRecordEvent接口前，由于Event中没有任务，因此调用aclrtQueryEventStatus接口时会返回ACL\_EVENT\_RECORDED\_STATUS\_COMPLETE。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 待记录的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream1。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtResetEvent"></a>

# aclrtResetEvent

```c
aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

复位Event，恢复Event初始状态，便于Event对象重复使用。异步接口。

对于多个Stream间任务同步的场景，通常在调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口之后再复位Event。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 待复位的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>多个Stream间任务同步的场景，例如，Stream2中的任务依赖Stream1中的任务时，此处配置为Stream2。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

仅支持复位由[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag)接口创建的、带有ACL\_EVENT\_SYNC标志的Event。

**注意** ，在多个Stream中的任务需要等待同一个Event的情况下，不建议使用调用此接口来复位Event。如图所示，如果在stream2中的aclrtStreamWaitEvent接口之后调用aclrtResetEvent接口，Event将被复位，这会导致stream3中的aclrtStreamWaitEvent接口无法成功。

![](figures/Device-Context-Stream之间的关系-1.png)


<br>
<br>
<br>



<a id="aclrtQueryEvent（废弃）"></a>

# aclrtQueryEvent（废弃）

```c
aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)
```

**须知：此接口后续版本会废弃，请使用[aclrtQueryEventStatus](#aclrtQueryEventStatus)接口。**

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询与本接口在同一线程中的[aclrtRecordEvent](#aclrtRecordEvent)接口所记录的Event是否执行完成。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定待查询的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| status | 输出 | Event状态的指针。类型定义请参见[aclrtEventStatus](25_数据类型及其操作接口.md#aclrtEventStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtQueryEventStatus"></a>

# aclrtQueryEventStatus

```c
aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询该Event捕获的所有任务的执行状态。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定待查询的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| status | 输出 | Event状态的指针。类型定义请参见[aclrtEventRecordedStatus](25_数据类型及其操作接口.md#aclrtEventRecordedStatus)。<br>如果该Event捕获的所有任务都已经执行完成则返回ACL_EVENT_RECORDED_STATUS_COMPLETE，如果有任何一个任务未执行完成则返回ACL_EVENT_RECORDED_STATUS_NOT_READY。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

如果用户在不同线程上分别调用[aclrtRecordEvent](#aclrtRecordEvent)和aclrtQueryEventStatus，可能由于多线程导致这两个API的执行时间乱序，进而导致查询到的Event对象的完成状态不符合预期。


<br>
<br>
<br>



<a id="aclrtQueryEventWaitStatus"></a>

# aclrtQueryEventWaitStatus

```c
aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口后查询该Event对应的等待任务是否都执行完成。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定待查询的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| status | 输出 | Event状态的指针。类型定义请参见[aclrtEventWaitStatus](25_数据类型及其操作接口.md#aclrtEventWaitStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

通过[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建的Event，不支持调用本接口。


<br>
<br>
<br>



<a id="aclrtSynchronizeEvent"></a>

# aclrtSynchronizeEvent

```c
aclError aclrtSynchronizeEvent(aclrtEvent event)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

阻塞当前线程运行直到Event捕获的所有任务都执行完成。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSynchronizeEventWithTimeout"></a>

# aclrtSynchronizeEventWithTimeout

```c
aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

阻塞当前线程运行直到Event捕获的所有任务都执行完成（具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节），该接口是在接口[aclrtSynchronizeEvent](#aclrtSynchronizeEvent)基础上进行了增强，支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则当应用程序异常时可根据所设置的超时时间自行退出。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeEvent](#aclrtSynchronizeEvent)功能一样。<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtEventElapsedTime"></a>

# aclrtEventElapsedTime

```c
aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

统计两个Event之间的耗时。

本接口需与其它关键接口配合使用，接口调用顺序：调用[aclrtCreateEvent](#aclrtCreateEvent)/[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag)接口创建Event**--\>**调用[aclrtRecordEvent](#aclrtRecordEvent)接口在同一个Stream中记录起始Event、结尾Event**--\>**调用[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成**--\>**调用aclrtEventElapsedTime接口统计两个Event之间的耗时

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ms | 输出 | 表示两个Event之间耗时的指针，单位为毫秒。 |
| startEvent | 输入 | 起始Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| endEvent | 输入 | 结尾Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtStreamWaitEvent"></a>

# aclrtStreamWaitEvent

```c
aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

阻塞指定Stream的运行，直到指定的Event完成，支持多个Stream等待同一个Event的场景。异步接口。

提交到Stream上的所有后续任务都需要等待Event捕获的任务都完成后才能开始执行。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口了解Event捕获的细节。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。 |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

一个进程内，调用[aclInit](02_初始化与去初始化.md#aclInit)接口初始化后，若再调用[aclrtSetOpWaitTimeout](#aclrtSetOpWaitTimeout)接口设置超时时间，那么本进程内后续调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则在调用同步等待接口（例如，[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)）后，会返回报错。


<br>
<br>
<br>



<a id="aclrtStreamWaitEventWithTimeout"></a>

# aclrtStreamWaitEventWithTimeout

```c
aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取算子二进制数据在Device上的内存地址及内存大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。 |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| timeout | 输入 | 超时时间。<br>取值>0，用于配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetOpWaitTimeout"></a>

# aclrtSetOpWaitTimeout

```c
aclError aclrtSetOpWaitTimeout(uint32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

本接口用于设置等待Event完成的超时时间。

不调用本接口，则默认不超时；一个进程内多次调用本接口，则以最后一次设置的时间为准。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 设置超时时间，单位为秒。<br>将该参数设置为0时，表示不超时。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

一个进程内，调用[aclInit](02_初始化与去初始化.md#aclInit)接口初始化后，若再调用[aclrtSetOpWaitTimeout](#aclrtSetOpWaitTimeout)接口设置超时时间，那么本进程内后续调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则在调用同步等待接口（例如，[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)）后，会返回报错。


<br>
<br>
<br>



<a id="aclrtEventGetTimestamp"></a>

# aclrtEventGetTimestamp

```c
aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取Event的执行结束时间点（表示从AI处理器系统启动以来的时间）。

本接口需与其它关键接口配合使用，接口调用顺序：调用[aclrtCreateEvent](#aclrtCreateEvent)/[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag)接口创建Event**--\>**调用[aclrtRecordEvent](#aclrtRecordEvent)接口在Stream中记录Event**\>**调用[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成**--\>**调用aclrtEventGetTimestamp接口获取Event的执行时间。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 查询的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| timestamp | 输出 | Event执行结束的时间点，单位为微秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetEventId"></a>

# aclrtGetEventId

```c
aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取指定Event的ID。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定要查询的Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |
| eventId | 输出 | Event ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetEventAvailNum"></a>

# aclrtGetEventAvailNum

```c
aclError aclrtGetEventAvailNum(uint32_t *eventCount)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询当前Device上可用的Event数量。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| eventCount | 输出 | Event数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtIpcGetEventHandle"></a>

# aclrtIpcGetEventHandle

```c
aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

将本进程中的指定Event设置为IPC（Inter-Process Communication） Event，并返回其handle（即Event句柄），用于在跨进程场景下实现任务同步，支持同一个Device内的多个进程以及跨Device的多个进程。

**本接口需与以下其它关键接口配合使用**，此处以A进程、B进程为例：

1.  A进程中：
    1.  调用[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建flag为ACL\_EVENT\_IPC的Event。
    2.  调用aclrtIpcGetEventHandle接口获取用于进程间通信的Event句柄。
    3.  调用[aclrtRecordEvent](#aclrtRecordEvent)接口在Stream中插入[1.a](#li288673614297)中创建的Event。

2.  B进程中：
    1.  调用[aclrtIpcOpenEventHandle](#aclrtIpcOpenEventHandle)接口获取A进程中的Event句柄信息，并返回本进程可以使用的Event指针。
    2.  调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口阻塞指定Stream的运行，直到指定的Event完成。
    3.  Event使用完成后，调用[aclrtDestroyEvent](#aclrtDestroyEvent)接口销毁Event。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定Event。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。<br>仅支持通过[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建的、flag为ACL_EVENT_IPC的Event。 |
| handle | 输出 | 进程间通信的Event句柄。类型定义请参见[aclrtIpcEventHandle](25_数据类型及其操作接口.md#aclrtIpcEventHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtIpcOpenEventHandle"></a>

# aclrtIpcOpenEventHandle

```c
aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在本进程中获取handle的信息，并返回本进程可以使用的Event指针。

本接口需与其它接口配合使用，以便实现不同进程间的任务同步，请参见[aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle)接口处的说明。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | Event句柄。类型定义请参见[aclrtIpcEventHandle](25_数据类型及其操作接口.md#aclrtIpcEventHandle)。<br>必须先调用[aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle)接口获取指定Event的句柄，再作为入参传入。 |
| event | 输出 | Event指针。类型定义请参见[aclrtEvent](25_数据类型及其操作接口.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
