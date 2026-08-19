# EP0002 Config\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为取值、配置项、文件名、期望值：

```text
Value %s for configuration item %s in configuration file %s is invalid. Expected value: %s.
```

报错示例如下：

```text
Value abc for configuration item dump_op_switch in configuration file acl.json is invalid. Expected value: on/off.
```

## 解决方法

需按照报错提示检查并修改配置项的取值。
