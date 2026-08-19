# EK0001 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为参数值、参数名、报错原因：

```text
Value %s for parameter %s is invalid. Reason: %s.
```

报错示例如下：

```text
Value 64 for parameter device id is invalid. Reason: The device id should be in range [0, 1)
```

## 解决方法

需按照Reason中的提示输入正确的参数值，或参考官方文档查看相关参数的使用说明。
