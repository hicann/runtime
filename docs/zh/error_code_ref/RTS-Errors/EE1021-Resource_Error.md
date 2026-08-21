# EE1021 Resource\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为资源类型、接口名：

```
The runtime module failed to create host %s through API %s.
```

报错示例如下：

```
The runtime module failed to create host semaphore through API sem_init.
```

## 可能原因

由于系统资源不足，无法创建信号量、锁或线程等资源.

## 解决方法

停止不必要的线程，并确保所需资源可用。
