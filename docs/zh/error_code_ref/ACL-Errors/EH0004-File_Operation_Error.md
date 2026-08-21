# EH0004 File\_Operation\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为文件路径、报错原因：

```
File %s is invalid. Reason: %s.
```

报错示例如下：

```
File /home/acl.json is invalid. Reason: config content differs from the first aclInit config file path: /etc/acl.json.
```

## 解决方法

根据报错检查文件内容是否正确。
