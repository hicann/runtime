# aclprofInit

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

初始化Profiling，目前用于设置保存性能数据的文件的路径。

## 函数原型

```
aclError aclprofInit(const char *profilerResultPath, size_t length)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| profilerResultPath | 输入 | 指定保存性能数据的文件的路径，支持配置为绝对路径或相对路径。 |
| length | 输入 | profilerResultPath的长度，单位为Byte，最大长度不超过4096字节。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

与[aclprofFinalize](aclprofFinalize.md)接口配对使用，先调用aclprofInit接口再调用aclprofFinalize接口。

