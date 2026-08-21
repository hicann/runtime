# EE1001 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s表示报错原因：

```
The argument is invalid. Reason: %s
```

报错示例如下：

```
The argument is invalid.Reason: Invalid device ID 8. Set drv devId to 8. The valid device range is [0, 7).
```

## 解决方法

1. 检查接口的输入参数范围。
2. 检查接口的调用关系。
