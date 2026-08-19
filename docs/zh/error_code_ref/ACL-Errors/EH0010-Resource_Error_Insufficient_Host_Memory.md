# EH0010 Resource\_Error\_Insufficient\_Host\_Memory

## 错误信息

报错格式如下，占位符%s分别表示内存大小、内存申请接口：

```
Failed to allocate %s bytes of host memory via %s to ACL.
```

报错示例如下：

```
Failed to allocate 1024 bytes host memory for ACL.
```

## 可能原因

Host内存不足导致内存分配失败。

## 解决方法

确保有足够的可用内存。您可以停止不必要的进程以释放内存。
