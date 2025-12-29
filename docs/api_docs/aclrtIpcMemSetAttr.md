# aclrtIpcMemSetAttr

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

设置IPC共享内存的属性信息。

## 函数原型

```
aclError aclrtIpcMemSetAttr(const char *key, aclrtIpcMemAttrType type, uint64_t attr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| key | 输入 | 共享内存key，字符串长度小于64，以\0结尾。 |
| type | 输入 | 内存映射类型，当前支持配置为ACL_RT_IPC_MEM_ATTR_ACCESS_LINK，用于在跨片访问时，指定双die之间是SIO（serial input/output）通道、还是HCCS（Huawei Cache Coherence System）通道。 |
| attr | 输入 | 属性。<br>当前支持设置为如下宏：<br><br>  - ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_SIO：SIO通道，默认该选项<br>  - ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_HCCS：HCCS通道<br><br><br>宏的定义如下：<br>#define ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_SIO 0<br>#define ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_HCCS 1 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

