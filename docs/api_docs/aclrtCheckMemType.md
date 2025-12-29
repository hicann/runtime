# aclrtCheckMemType

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

检查Device内存类型。

## 函数原型

```
aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| addrList | 输入 | Device内存地址数组。 |
| size | 输入 | addrList数组大小。 |
| memType | 输入 | Device内存类型。若addrList数组中有多种不同类型的内存地址，则memType处需配置为多种内存类型位或，例如配置为：RT_MEM_MASK_DEV_TYPE | RT_MEM_MASK_DVPP_TYPE<br>当前支持设置为如下宏：<br><br>  - ACL_RT_MEM_TYPE_DEV：表示调用[aclrtMalloc](aclrtMalloc.md)、[aclrtMallocWithCfg](aclrtMallocWithCfg.md)等接口申请的Device内存。<br><br><br>  - ACL_RT_MEM_TYPE_DVPP：表示DVPP专用的Device内存，可调用相关内存申请接口（例如hi_mpi_dvpp_malloc）申请该内存。<br>  - ACL_RT_MEM_TYPE_RSVD：表示调用[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口预留的虚拟内存。<br><br><br>宏定义如下：<br>#define ACL_RT_MEM_TYPE_DEV  (0X2U)<br>#define ACL_RT_MEM_TYPE_DVPP  (0X8U)<br>#define ACL_RT_MEM_TYPE_RSVD  (0X10U) |
| checkResult | 输出 | 检查addrList数组中内存地址类型与memType处是否匹配。<br><br>  - 1：匹配<br>  - 0：不匹配 |
| reserve | 输入 | 预留参数，当前固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

