# aclrtCmoWaitBarrier

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

等待具有指定barrierId的Invalid内存操作任务执行完成。异步接口。

## 函数原型

```
aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| taskInfo | 输入 | Cache内存操作的任务信息。<br>任务信息中的cmoType当前仅支持ACL_RT_CMO_TYPE_INVALID。 |
| stream | 输入 | 执行等待任务的Stream。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口。 |
| flag | 输入 | 预留参数。当前固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

