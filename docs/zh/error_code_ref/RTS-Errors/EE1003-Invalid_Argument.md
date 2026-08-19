# EE1003 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数值、参数名、期望值：

```
%s failed because value %s for parameter %s is invalid. Expected value: %s.
```

报错示例如下：

```
rtsStreamSetAttribute failed because value -5 for parameter stmAttrId is invalid. Expected value: [0, 5).
```

## 解决方法

1. 检查接口的输入参数范围。
2. 检查接口的调用关系。
