# EK0203 Resource\_Error

## 错误信息

报错格式如下，占位符%s表示报错原因：

```text
Failed to create host thread for Profiling. Reason: %s.
```

报错示例如下：

```text
Failed to create host thread for Profiling. Reason: 11 returned when the pthread_create API is called.
```

## 可能原因

系统线程资源不足，无法创建新线程。

## 解决方法

需停止不必要的进程，并确保有足够的内存可用。
