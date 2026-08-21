# EE1011 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数值、参数名、报错原因：

```
%s failed. Value %s for parameter %s is invalid. Reason: %s.
```

报错示例如下：

```
StreamSwitchN failed. Value 0 for parameter stm->modelNum is invalid. Reason: The stream is not bound to a model.
```

## 解决方法

1. 检查接口的输入参数范围。
2. 检查接口的调用关系。
