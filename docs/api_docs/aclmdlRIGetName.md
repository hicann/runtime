# aclmdlRIGetName

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取模型运行实例的名称。如果没有调用aclmdlRISetName接口，调用本接口获取到的为空字符串。

## 函数原型

```
aclError aclmdlRIGetName(aclmdlRI modelRI, uint32_t maxLen, char *name)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例。 |
| maxLen | 输入 | 用户申请的用于存放name的最大内存长度，单位Byte。 |
| name | 输出 | 模型运行实例的名称。<br>name的最大长度为512Byte，超过512Byte的部分将被截断并返回。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

