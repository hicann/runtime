# EE1016 Not\_Supported

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、报错原因：

```
%s failed. Reason: %s.
```

报错示例如下：

```
MemCopySync failed. Reason: The current thread 198840 is in the capture state and the current operation cannot be performed. Check whether the mode set by the aclmdlRICaptureBegin API supports the current operation. This operation is supported only in the RELAXED mode. The mode set using the aclmdlRICaptureBegin API is 1, the capture mode of the current thread is 1, and the mode set using the aclmdlRICaptureThreadExchangeMode API is 1.
```

## 解决方法

根据Reason中的提示调整参数值。
