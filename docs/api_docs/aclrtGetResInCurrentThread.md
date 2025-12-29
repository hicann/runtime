# aclrtGetResInCurrentThread

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前线程可使用的Device资源。

获取时，按照如下优先级返回value：Stream级别的Device资源限制（调用[aclrtSetStreamResLimit](aclrtSetStreamResLimit.md)接口设置） \> 当前进程的Device资源限制（调用[aclrtSetDeviceResLimit](aclrtSetDeviceResLimit.md)接口设置） \>  昇腾AI处理器硬件默认的资源限制

## 函数原型

```
aclError aclrtGetResInCurrentThread(aclrtDevResLimitType type, uint32_t *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| type | 输入 | 资源类型，当前支持Cube Core、Vector Core。 |
| value | 输出 | 资源数量。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

