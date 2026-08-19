# W40010 Config\_Error\_Invalid\_Environment\_Variable

## 错误信息

报错格式如下，占位符%s的含义依次为环境变量值、环境变量名、错误结果、报错原因：

```text
Value %s for environment variable %s is invalid. Result: %s. Reason: %s.
```

报错示例如下：

```text
Value  for environment variable ASCEND_ADK_PATH is invalid. Result: unable to get current adk version info. Reason: path does not exist.
```

## 解决方法

需按照Reason中的提示设置环境变量，或根据环境变量参考文档重新设置环境变量。
