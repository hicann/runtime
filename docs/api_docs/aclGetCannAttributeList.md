# aclGetCannAttributeList

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询运行环境中CANN软件和对应昇腾AI处理器支持的特性列表。

## 函数原型

```
aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| cannAttrList | 输出 | 用于保存运行环境支持的特性枚举数组。<br>用户无需提前申请内存，应用进程退出时，内存自动释放。 |
| num | 输出 | 用于保存支持的特性数量，与cannAttrList数组长度保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

