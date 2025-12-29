# aclrtMallocHostWithCfg

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。与aclrtMallocHost接口相比，本接口在申请内存时，还可以指定内存相关的配置信息。

## 函数原型

```
aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输出 | “已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| cfg | 输入 | 内存配置信息。<br>不指定配置时，此处可传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

