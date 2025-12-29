# aclrtGetOpTimeoutInterval


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取硬件支持的算子超时配置的最短时间间隔interval，单位为微秒。

## 函数原型

```
aclError aclrtGetOpTimeoutInterval(uint64_t *interval)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| interval | 输出 | 最短时间间隔，单位为微秒。<br>用户可配置且生效的超时时间是interval * N，N的取值为[1, 254]的整数，如果用户配置的超时时间不等于interval * N，则向上对齐到interval * N，假设interval = 100微秒，用户设置的超时时间为50微秒，则实际生效的超时时间为100 *1 = 100微秒；用户设置的超时时间为30000微秒，则实际生效的超时时间为100 *254 =25400微秒。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

