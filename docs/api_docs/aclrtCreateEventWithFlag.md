# aclrtCreateEventWithFlag

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。

## 函数原型

```
aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输出 | Event的指针。 |
| flag | 输入 | Event指针的flag。<br>当前支持将flag设置为如下宏：<br>  - ACL_EVENT_TIME_LINE：使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<br>  - ACL_EVENT_SYNC：使能该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使能该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_EXTERNAL：使能该bit表示创建的Event用于任务捕获场景下的任务更新功能，相关说明请参见[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)。注意：该flag不支持与其他flag进行位或操作。<br>  - ACL_EVENT_DEVICE_USE_ONLY：使能该bit表示创建的Event仅在Device上调用。<br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_EXTERNAL  0x00000020U<br>#define ACL_EVENT_DEVICE_USE_ONLY  0x00000010U |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

调用本接口创建Event时，flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作：

若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在以下API中使用本接口创建的Event：[aclrtResetEvent](aclrtResetEvent.md)、[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)、[aclrtQueryEventWaitStatus](aclrtQueryEventWaitStatus.md)。若flag参数值**包含**ACL\_EVENT\_SYNC宏或者flag设置为ACL\_EVENT\_EXTERNAL时，则创建出来的Event数量受限，具体如下：
  
| 型号 | 单个Device支持的Event最大数 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 65536 |


