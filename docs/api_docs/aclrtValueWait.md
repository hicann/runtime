# aclrtValueWait

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

等待指定内存中的数据满足一定条件后解除阻塞。异步接口。

## 函数原型

```
aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream) 
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devAddr | 输入 | Device侧内存地址。<br>devAddr的有效内存位宽为64bit。 |
| value | 输入 | 需与内存中的数据作比较的值。 |
| flag | 输入 | 比较的方式，等满足条件后解除阻塞。取值如下：<br>ACL_VALUE_WAIT_GEQ = 0x0;  // 等到(int64_t)(*devAddr - value) >= 0 <br>ACL_VALUE_WAIT_EQ = 0x1;  // 等到*devAddr == value<br>ACL_VALUE_WAIT_AND = 0x2;  // 等到(*devAddr & value) != 0<br>ACL_VALUE_WAIT_NOR = 0x3;  // 等到~(*devAddr | value) != 0 |
| stream | 输入 | 执行等待任务的stream。<br>此处支持传NULL，表示使用默认Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

