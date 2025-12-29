# aclrtGetMemUceInfo

**须知：本接口为预留接口，暂不支持。**

## 功能说明

获取内存UCE（uncorrect error，指系统硬件不能直接处理恢复内存错误）的错误虚拟地址。

## 函数原型

```
aclError aclrtGetMemUceInfo(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize, size_t *retSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>与[aclrtSetDevice](aclrtSetDevice.md)接口中Device ID保持一致。 |
| memUceInfoArray | 输入&输出 | aclrtMemUceInfo数组的指针。 |
| arraySize | 输入 | 传入aclrtMemUceInfo数组的长度。 |
| retSize | 输出 | 实际返回的aclrtMemUceInfo数组的有效长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

