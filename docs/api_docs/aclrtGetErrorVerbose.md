# aclrtGetErrorVerbose

**须知：本接口为预留接口，暂不支持。**

## 功能说明

用于在发生设备故障后获取详细错误信息。此接口必须在获取故障事件之后，提交任务中止之前调用。

## 函数原型

```
aclError aclrtGetErrorVerbose(int32_t deviceId, aclrtErrorInfo *errorInfo);
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>与[aclrtSetDevice](aclrtSetDevice.md)接口中Device ID保持一致。 |
| errorInfo | 输出 | 错误信息。<br>typedef enum { <br>   ACL_RT_NO_ERROR = 0,  // 无错误<br>   ACL_RT_ERROR_MEMORY = 1,  // 内存错误，暂不支持<br>   ACL_RT_ERROR_L2 = 2,  // L2 Cache二级缓存错误<br>   ACL_RT_ERROR_AICORE = 3,  // AI Core错误<br>   ACL_RT_ERROR_LINK = 4,  // 暂不支持<br>   ACL_RT_ERROR_OTHERS = 5,  // 其它错误<br>} aclrtErrorType;<br><br>typedef enum aclrtAicoreErrorType { <br>   ACL_RT_AICORE_ERROR_UNKOWN,  // 未知错误<br>   ACL_RT_AICORE_ERROR_SW,  // 建议排查软件错误<br>   ACL_RT_AICORE_ERROR_HW_LOCAL, // 建议排查当前Device的硬件错误<br>} aclrtAicoreErrorType;<br><br>#define ACL_RT_MEM_UCE_INFO_MAX_NUM 20<br>typedef struct {<br>   size_t arraySize;  // memUceInfoArray数组大小<br>   [aclrtMemUceInfo](aclrtMemUceInfo.md) memUceInfoArray[ACL_RT_MEM_UCE_INFO_MAX_NUM];  // 内存UCE的错误虚拟地址数组<br>} aclrtMemUceInfoArray;<br><br>typedef union aclrtErrorInfoDetail { <br>   aclrtMemUceInfoArray uceInfo;  // 内存UCE（uncorrect error）<br>   aclrtAicoreErrorType aicoreErrType;  // AI Core错误<br>} aclrtErrorInfoDetail; <br><br>typedef struct aclrtErrorInfo { <br>   uint8_t tryRepair;  // 是否需要修复 ，0表示无需修复，1表示需修复   <br>   uint8_t hasDetail;  // 是否有详细报错信息，0表示没有，1表示有<br>   uint8_t reserved[2];  // 预留参数<br>   aclrtErrorType errorType;  // 错误类型<br>   aclrtErrorInfoDetail detail; // 错误详细信息<br>} aclrtErrorInfo; |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

