# EK0003 Config\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为参数值、参数名、报错原因：

```text
Value %s for %s is invalid. Reason: %s.
```

报错示例如下：

```text
Value /home/prof_path for output is invalid. Reason: The operation on directory /home/prof_path is abnormal. [Error 13] Permission denied.
```

## 解决方法

需按照Reason中的提示输入正确的参数值，或参考官方文档查看相关参数的使用说明。
