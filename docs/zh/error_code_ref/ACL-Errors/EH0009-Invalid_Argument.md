# EH0009 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数值、参数名、报错原因：

```
%s failed. Value %s for parameter %s is invalid. Reason: %s.
```

报错示例如下：

```
acltdtGetDataItem failed. Value 5 for parameter index is invalid. Reason: index 5 is greater than or equal to dataset size 10.
```

## 解决方法

1. 检查接口的输入参数范围。

2. 检查接口的调用关系。
