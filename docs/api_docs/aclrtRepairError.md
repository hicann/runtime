# aclrtRepairError

**须知：本接口为预留接口，暂不支持。**

## 功能说明

基于[aclrtGetErrorVerbose](aclrtGetErrorVerbose.md)接口获取的详细信息进行故障恢复，此接口应该在提交任务中止之后调用。

## 函数原型

```
aclError aclrtRepairError(int32_t deviceId, const aclrtErrorInfo *errorInfo)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>与[aclrtSetDevice](aclrtSetDevice.md)接口中Device ID保持一致。 |
| errorInfo | 输入 | 错误信息。<br>aclrtErrorInfo结构体的描述请参见[aclrtGetErrorVerbose](aclrtGetErrorVerbose.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

