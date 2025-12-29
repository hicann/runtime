# aclrtStreamGetFlags

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询创建Stream时设置的flag标志。

## 函数原型

```
aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>若此处传入NULL，则获取的是默认Stream的flag。 |
| flags | 输出 | 指向查询到的flag值的指针。<br>关于flag值的说明请参见[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口中的flag参数说明。若创建Stream时配置了多个flag，返回值为各flag按位或运算后的结果，例如配置了0x01U和0x02U，则返回0x03U；若创建Stream是没有配置flag，则返回0。<br>对于默认Stream，不同产品型号的flag值可能存在差异，应以本接口查询到的值为准。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

