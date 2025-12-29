# aclrtCmoSetDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置Cache内存描述符，此接口调用完成后，会将源内存地址、内存大小记录到Cache内存描述符中。

## 函数原型

```
aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| cmoDesc | 输入 | Cache内存描述符地址指针。<br>需先调用aclrtCmoGetDescSize接口获取Cache内存描述符所需的内存大小，再申请Device内存后（例如aclrtMalloc接口），将Device内存地址作为入参传入此处。 |
| src | 输出 | 待操作的Device内存地址。<br>只支持本Device上的Cache内存操作。 |
| size | 输出 | 待操作的Device内存大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

