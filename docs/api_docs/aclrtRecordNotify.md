# aclrtRecordNotify

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在指定Stream上记录一个Notify。异步接口。

aclrtRecordNotify接口与aclrtWaitAndResetNotify接口配合使用时，主要用于多Stream之间同步等待的场景。

## 函数原型

```
aclError aclrtRecordNotify(aclrtNotify notify, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notify | 输入 | 待记录的Notify。 |
| stream | 输入 | 指定Stream。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream1。<br>如果使用默认Stream，此处设置为NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

