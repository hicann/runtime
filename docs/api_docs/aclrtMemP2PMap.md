# aclrtMemP2PMap

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

本接口用于建立同一进程内两个Device之间的内存页表映射，以实现跨Device的内存访问，但在进行此操作前，需先调用[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口以开启两个Device间的数据交互。

调用本接口建立页表映射后，跨Device访问时不会出现内存缺页的问题，首次访问内存时性能更优。

## 函数原型

```
aclError aclrtMemP2PMap(void *devPtr, size_t size, int32_t dstDevId, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输入 | Device内存地址（例如调用aclrtMalloc接口申请的Device内存），此处指共享内存提供方的内存地址。 |
| size | 输入 | 内存大小，单位Byte。 |
| dstDevId | 输入 | Device ID，此处指共享内存使用方的ID。 |
| flags | 输入 | 预留参数，当前固定设置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

