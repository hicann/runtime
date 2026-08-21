# EP0001 Config\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为配置项、配置文件、报错原因：

```text
The content of configuration item %s in configuration file %s is invalid. Reason: %s.
```

报错示例如下：

```text
The content of configuration item dump_path in configuration file acl.json is invalid. Reason: The configuration item is not found.
```

## 解决方法

需按照Reason中的提示检查并修改配置。
