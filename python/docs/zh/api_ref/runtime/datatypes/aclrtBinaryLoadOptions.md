# aclrtBinaryLoadOptions

## 说明

加载算子二进制文件的可选参数。

## 定义

```python
options = [{"type": option_type, "value": option_value}]
```

说明：options中可同时包含多个dict，每个dict中包含一对type和value。

## 成员

| 成员名称 | 说明 |
| --- | --- |
| option_type | int，参数类型，取值参考[aclrtBinaryLoadOptionType](aclrtBinaryLoadOptionType-aclrtBinaryLoadOptionValue.md)。 |
| option_value | int，参数取值，取值参考[aclrtBinaryLoadOptionValue](aclrtBinaryLoadOptionType-aclrtBinaryLoadOptionValue.md)。 |

说明：option\_type和option\_value配对使用，option\_value随着option\_type的取值来配置不同的值。
