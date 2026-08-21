# EP0005 Config\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为文件名、报错原因：

```text
Conflict of configuration items in configuration file %s. Reason: %s.
```

报错示例如下：

```text
Conflict of configuration items in configuration file /home/acl.json. Reason: Configuration items dump_scene and dump_stats cannot be both configured.
```

## 解决方法

需按照Reason中的提示检查并修改。
