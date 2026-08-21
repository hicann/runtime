# EE1002 Execution\_Error\_Stream\_Synchronize\_Timeout

## 错误信息

报错格式如下，占位符%s表示报错原因：

```
Stream synchronize timeout. %s
```

报错示例如下：

```
Stream synchronize timeout. rtModelExecute execution failed.
```

## 可能原因

超时时间间隔设置不合理。

## 解决方法

1. 需调整超时时间。
2. 检查网络是否正常。
