# aclrtCheckArchCompatibility

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据昇腾AI处理器版本判断算子指令是否兼容。

## 函数原型

```
aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| socVersion | 输入 | 昇腾AI处理器版本。 |
| canCompatible | 输出 | 是否兼容，1表示兼容，0表示不兼容。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

