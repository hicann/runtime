# aclrtMemUceRepair

**须知：本接口为预留接口，暂不支持。**

## 功能说明

修复内存UCE的错误虚拟地址。

## 函数原型

```
aclError aclrtMemUceRepair(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>与[aclrtSetDevice](aclrtSetDevice.md)接口中Device ID保持一致。 |
| memUceInfoArray | 输入 | aclrtMemUceInfo数组的指针。 |
| arraySize | 输入 | 传入aclrtMemUceInfo数组的长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

