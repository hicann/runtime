# aclrtCmoAsync

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

实现Device上的Cache内存操作。异步接口。

## 函数原型

```
aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| src | 输入 | 待操作的Device内存地址。<br>只支持本Device上的Cache内存操作。 |
| size | 输入 | 待操作的Device内存大小，单位Byte。 |
| cmoType | 输入 | Cache内存操作类型。<br>当前仅支持ACL_RT_CMO_TYPE_PREFETCH（内存预取）。 |
| stream | 输入 | 执行内存操作任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

