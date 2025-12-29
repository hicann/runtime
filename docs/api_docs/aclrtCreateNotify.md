# aclrtCreateNotify

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建Notify。

## 函数原型

```
aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notify | 输出 | Notify的指针。 |
| flag | 输入 | Notify指针的flag。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_NOTIFY_DEFAULT使能该bit表示创建的Notify默认在Host上调用。#define ACL_NOTIFY_DEFAULT 0x00000000U<br><br><br>  - ACL_NOTIFY_DEVICE_USE_ONLY使能该bit表示创建的Notify仅在Device上调用。#define ACL_NOTIFY_DEVICE_USE_ONLY 0x00000001U |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

不同型号的硬件支持的Notify数量不同，如下表所示：


| 型号 | 单个Device支持的Notify最大数 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 8192 |

