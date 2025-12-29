# aclrtProfTrace

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

支持用户在网络指定位置下发自定义的Profling打点。异步接口。

## 函数原型

```
aclError aclrtProfTrace(void *userdata, int32_t length, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| userdata | 输入 | 自定义信息。 |
| length | 输入 | userdata的长度，单位Byte。<br>length建议配置为18字节；如果未满18字节，将会自动在数据末尾补0到18字节；如果超过18字节，接口会校验报错返回。 |
| stream | 输入 | 指定执行打点任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

