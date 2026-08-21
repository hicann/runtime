# E21002 File\_Operation\_Error\_Parse

## 错误信息

报错格式如下，占位符%s的含义依次为文件名、报错原因：

```text
Failed to parse file %s. Reason: %s.
```

报错示例如下：

```text
Failed to parse file /home/pb/support_errmsg_check.pb. Reason: The configuration file is not in JSON format or its content is invalid.
```

## 可能原因

配置文件路径不存在。

## 解决方法

需配置正确的文件路径。
