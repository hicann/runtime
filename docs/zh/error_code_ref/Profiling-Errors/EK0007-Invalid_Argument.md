# EK0007 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为错误模式、正确模式：

```text
Failed to start Profiling in %s mode because it is already in %s mode.
```

报错示例如下：

```text
Failed to start Profiling in subscribe mode because it is already in aclapi mode.
```

## 可能原因

不可同时开启两种及以上性能数据采集方式。举例说明：使用msprof命令行方式启动Profiling时，app中不能通过acl接口启动Profiiling数据采集。

## 解决方法

按要求修改Profiling启动方式。
