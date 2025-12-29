# aclrtCmoAsyncWithBarrier

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

实现Device上的Cache内存操作，同时携带barrierId，barrierId表示Cache内存操作的屏障标识。异步接口。

## 函数原型

```
aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| src | 输入 | 待操作的Device内存地址。<br>只支持本Device上的Cache内存操作。 |
| size | 输入 | 待操作的Device内存大小，单位Byte。 |
| cmoType | 输入 | Cache内存操作类型。 |
| barrierId | 输入 | 屏障标识。<br>当cmoType为ACL_RT_CMO_TYPE_INVALID时，barrierId有效，支持传入大于0的数字，配合[aclrtCmoWaitBarrier](aclrtCmoWaitBarrier.md)接口使用，等待具有指定barrierId的Invalid内存操作任务执行完成。当cmoType为其它值时，barrierId固定传0。 |
| stream | 输入 | 执行内存操作任务的Stream。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

