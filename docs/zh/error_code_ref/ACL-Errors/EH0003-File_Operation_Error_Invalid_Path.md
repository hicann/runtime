# EH0003 File\_Operation\_Error\_Invalid\_Path

## 错误信息

报错格式如下，占位符%s的含义依次为文件路径、报错原因：

```
Path %s is invalid. Reason: %s.
```

报错示例如下：

```
Path /tmp/invalid.json is invalid. Reason: file open failed.
```

## 解决方法

根据报错检查文件是否存在。
