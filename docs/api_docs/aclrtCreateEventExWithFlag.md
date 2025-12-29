# aclrtCreateEventExWithFlag

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。创建Event时，Event资源不受硬件限制。

## 函数原型

```
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输出 | Event的指针。 |
| flag | 输入 | Event指针的flag。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_EVENT_TIME_LINE：使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<br><br><br>  - ACL_EVENT_SYNC：使能该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使能该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_IPC：使能该bit表示创建的Event用于进程间通信，详细说明请参见[aclrtIpcGetEventHandle](aclrtIpcGetEventHandle.md)。注意：该flag不支持与其他flag进行位或操作。本flag创建出来的Event不支持在以下接口中使用：[aclrtResetEvent](aclrtResetEvent.md)、[aclrtQueryEvent](aclrtQueryEvent（废弃）.md)、[aclrtQueryEventWaitStatus](aclrtQueryEventWaitStatus.md)、[aclrtEventElapsedTime](aclrtEventElapsedTime.md)、[aclrtEventGetTimestamp](aclrtEventGetTimestamp.md)、[aclrtGetEventId](aclrtGetEventId.md)，否则返回报错。<br><br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_IPC 0x00000040U |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   采用本API创建的Event，不支持在以下接口中使用：[aclrtResetEvent](aclrtResetEvent.md)、[aclrtQueryEvent](aclrtQueryEvent（废弃）.md)、[aclrtQueryEventWaitStatus](aclrtQueryEventWaitStatus.md)，否则返回报错。
-   调用本接口创建Event时，flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作。
    -   若flag参数值**包含**ACL\_EVENT\_SYNC宏，后续调用[aclrtRecordEvent](aclrtRecordEvent.md)接口时，系统内部才会申请Event资源，因此会受Event数量的限制，Event达到上限后，系统内部会等待资源释放。

        不同型号的硬件支持的Event数量不同，如下表所示：

        
        | 型号 | 单个Device支持的Event最大数 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 65536 |

    -   若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口中使用本接口创建的Event。

