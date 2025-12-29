# aclrtStreamGetPriority

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询指定Stream的优先级。

## 函数原型

```
aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>若此处传入NULL，则获取的是默认Stream的优先级。 |
| priority | 输出 | 优先级，数字越小代表优先级越高。<br>关于优先级的取值范围请参见[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口中的priority参数说明。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

