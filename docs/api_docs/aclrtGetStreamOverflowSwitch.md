# aclrtGetStreamOverflowSwitch

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

针对指定Stream，获取其当前溢出检测开关是否打开。

## 函数原型

```
aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 待操作Stream。<br>若传入NULL，则操作默认Stream。 |
| flag | 输出 | 溢出检测开关，取值范围如下：<br><br>  - 0：关闭<br>  - 1：打开 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

