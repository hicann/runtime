# E20103 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为参数值、参数名、参数最大值：

```text
Value %s for parameter %s is invalid. The value must be in the range of (0, %s].
```

报错示例如下：

```text
Value 256 for parameter --aicore_num is invalid. The value must be in the range of (0, 8].
```

## 解决方法

请根据报错提示调整参数值。
