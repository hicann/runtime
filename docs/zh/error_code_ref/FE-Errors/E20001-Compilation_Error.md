# E20001 Compilation\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为算子名称、算子类型：

```text
Operator %s compilation failed. Optype is %s.
```

报错示例如下：

```text
Operator QuantBatchMatmulV3 compilation failed. Optype is QuantBatchMatmulV3.
```

## 可能原因

算子参数无效或者算子实现逻辑异常。

## 解决方法

对于自定义算子，请根据错误日志检查算子实现和参数。对于内置算子，请获取Host日志并联系技术支持，网址为<https://www.hiascend.com/support>。
