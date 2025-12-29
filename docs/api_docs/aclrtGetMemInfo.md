# aclrtGetMemInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据指定属性，获取Device上可用内存的空闲大小和总大小，不包括系统预留内存大小。

## 函数原型

```
aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| attr | 输入 | 需要查询的内存的属性值。 |
| free | 输出 | 对应属性内存空闲大小的指针，单位Byte。 |
| total | 输出 | 对应属性内存总大小的指针，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   调用本接口前必须先指定用于计算的Device（例如调用aclrtSetDevice接口指定用于计算的Device），因此本接口中不体现Device ID。
-   请根据实际硬件支持的情况，选择对应属性的内存，否则调用本接口获取到的空闲大小和总大小都为0。

    **该约束适用以下型号：**

    Atlas A3 训练系列产品/Atlas A3 推理系列产品

    Atlas A2 训练系列产品/Atlas A2 推理系列产品

