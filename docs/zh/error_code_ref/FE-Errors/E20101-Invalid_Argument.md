# E20101 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为参数值、参数名、报错原因：

```text
Value %s for parameter %s is invalid. Reason: %s.
```

报错示例如下：

```text
Value -1 for parameter --aicore_num is invalid. Reason: The AI Core num should be a positive integer.
```

## 解决方法

需按照Reason中的提示、参考官方文档中的说明调整参数值。
