# EK0201 Resource\_Error\_Insufficient\_Host\_Memory

## 错误信息

报错格式如下，占位符%s表示内存大小：

```text
Failed to allocate %s host memory for Profiling.
```

报错示例如下：

```text
Failed to allocate 100M host memory for Profiling.
```

## 可能原因

Host内存不足导致内存申请失败。

## 解决方法

需停止不必要的进程，并确保有足够的内存可用。
