# EE1015 Package\_Error\_Incorrect\_Driver\_Version

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、详细原因：

```text
%s failed. Reason: The driver version capability is insufficient. %s
```

报错示例如下：

```text
rtsIpcMemImportByKey failed. Reason: The driver version capability is insufficient. The driver interface halShmemInfoGet does not exist.
```

## 解决方法

升级driver软件版本。
