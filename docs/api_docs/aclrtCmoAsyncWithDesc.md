# aclrtCmoAsyncWithDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

使用内存描述符（二级指针方式）操作Device上的Cache内存。异步接口。

## 函数原型

```
aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| cmoDesc | 输入 | Cache内存描述符地址指针，Device侧内存地址。<br>此处需先调用aclrtCmoSetDesc接口设置内存描述符，再将内存描述符地址指针作为入参传入本接口。 |
| stream | 输入 | 执行内存操作任务的Stream。 |
| cmoType | 输入 | Cache内存操作类型。<br>当前仅支持ACL_RT_CMO_TYPE_PREFETCH（内存预取）。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

