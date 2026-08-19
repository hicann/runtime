# EK0202 Resource\_Error\_Insufficient\_Host\_Memory

## 错误信息

报错格式如下，占位符%s表示申请内存的模块：

```text
Failed to allocate host memory by %s.
```

报错示例如下：

```text
Failed to allocate host memory by std::make_shared.
```

## 可能原因

Host内存不足导致内存申请失败。

## 解决方法

需停止不必要的进程，并确保有足够的内存可用。
