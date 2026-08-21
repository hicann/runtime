# EE1006 Not\_Supported

## 错误信息

报错格式如下，占位符%s的含义依次为接口功能、不支持的参数或参数值、报错原因：

```
%s failed. %s is not supported. Reason: %s.
```

报错示例如下：

```
StreamWaitEvent failed. Parameter evt.eventFlag_ value 0x10 is not supported. Reason: Device-only events can be called only on the device.
```

## 解决方法

功能不支持，需调整代码逻辑。
