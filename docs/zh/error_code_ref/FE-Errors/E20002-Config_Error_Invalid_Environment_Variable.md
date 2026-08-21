# E20002 Config\_Error\_Invalid\_Environment\_Variable

## 错误信息

报错格式如下，占位符%s的含义依次为环境变量值、环境变量名、报错原因：

```text
Value %s for environment variable %s is invalid. Reason: %s.
```

报错示例如下：

```text
Value /usr/local/Ascend/cann/opp for environment variable ASCEND_OPP_PATH is invalid. Reason: ASCEND_OPP_PATH does not exist or access permission is denied during FE initialization.
```

## 解决方法

需按照Reason中的提示设置环境变量，或根据环境变量参考文档重新设置环境变量。
