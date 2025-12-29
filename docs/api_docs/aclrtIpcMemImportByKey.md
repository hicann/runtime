# aclrtIpcMemImportByKey

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在本进程中获取key的信息，并返回本进程可以使用的Device内存地址指针。

本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口处的说明。

## 函数原型

```
aclError aclrtIpcMemImportByKey(void **devPtr, const char *key, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输出 | Device内存地址指针。 |
| key | 输入 | 共享内存key<br>必须先调用[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口获取共享内存key，再作为入参传入。 |
| flags | 输入 | 是否开启两个Device之间的数据交互。<br>取值为如下宏：<br><br>  - ACL_RT_IPC_MEM_IMPORT_FLAG_DEFAULT：默认值，关闭两个Device之间的数据交互。配置为该值时，需单独调用[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口开启两个Device之间的数据交互。<br>  - ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS：开启两个Device之间的数据交互。配置为该值时，则无需调用[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_IPC_MEM_IMPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS 0x1UL |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

