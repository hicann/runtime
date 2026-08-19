# W40011 Directory\_Operation\_Error\_Create\_Failed

## 错误信息

报错格式如下，占位符%s的含义依次为目录、错误结果、报错原因：

```text
Failed to create disk cache directory %s. Result: %s. Reason: %s.
```

报错示例如下：

```text
Failed to create disk cache directory /root. Result: unable to copy files to npu path. Reason: path is invalid.
```

## 可能原因

目录权限不对，或者目录名称无效。

## 解决方法

需调整目录权限或目录名称后重试。
