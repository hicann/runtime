# E40023 File\_Operation\_Error\_Invalid\_Path

## 错误信息

报错格式如下，占位符%s的含义依次为路径、参数名、错误结果、报错原因：

```text
Path %s for %s is invalid. Result: %s. Reason: %s.
```

报错示例如下：

```text
Path /aaa/bbb for --debug_dir is invalid. Result: real path get failed. Reason: the path does not exist or its access permission is denied.
```

## 解决方法

根据报错提示，配置正确的路径。
