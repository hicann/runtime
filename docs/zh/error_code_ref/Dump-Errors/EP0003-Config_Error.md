# EP0003 Config\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为取值、配置项、文件名、报错原因：

```text
Value %s for configuration item %s in configuration file %s is invalid. Reason: %s.
```

报错示例如下：

```text
Value /npu/abc for configuration item dump_path in configuration file acl.json is invalid. Reason: The value is a path without read and write permissions.
```

## 解决方法

需按照Reason中的提示检查并修改配置。
