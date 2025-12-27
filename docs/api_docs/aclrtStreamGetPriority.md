# aclrtCreateStreamWithConfig

## AI处理器支持情况
| AI处理器类型 | 是否支持 |
|--------------|----------|
| Ascend 910C  | √        |
| Ascend 910B  | √        |


## 功能说明

查询指定Stream的优先级。

## 函数原型

```
aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)
```


## 参数说明

| 参数名   | 输入/输出 | 说明 |
|----------|-----------|------|
| stream   | 输入      | 指定 Stream。<br>若传入 NULL，则获取默认 Stream 的优先级。 |
| priority | 输出      | 优先级，数值越小表示优先级越高。<br>取值范围参见 [aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md) 中的 `priority` 参数说明。 |


## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。