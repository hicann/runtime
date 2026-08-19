# EE1012 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数值、参数名、报错原因：

```
%s failed. Value %s for %s is invalid. Reason: %s.
```

报错示例如下：

```
NotifyWait failed. Value 1 for current deviceId is invalid. Reason: The current device cannot deliver Notify Wait, the corresponding Notify Wait must be delivered on the device that creates the IPC Notify.
```

## 解决方法

根据Reason中的提示调整参数值。
