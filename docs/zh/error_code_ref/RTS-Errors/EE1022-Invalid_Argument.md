# EE1022 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为接口功能、参数值、参数名、报错原因：

```
%s failed. Values %s for parameters %s are invalid. Reason: %s.
```

报错示例如下：

```
MemGetAddressRange failed. Values nullptr and nullptr for parameters pbase and psize are invalid. Reason: Parameters pbase and psize cannot both be nullptr.
```

## 解决方法

1. 检查函数的输入参数取值范围。
2. 检查函数的调用关系。
