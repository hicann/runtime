# aclrtHostGetDevicePointer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取由aclrtHostRegisterV2接口注册映射的Device内存地址。映射后的Device内存地址不能用于内存操作，例如内存复制。

## 函数原型

```
aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| pHost | 输入 | 通过aclrtHostRegisterV2接口注册映射的Host内存地址。 |
| pDevice | 输出 | Host内存映射成的Device内存地址。 |
| flag | 输入 | 预留参数，当前固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

