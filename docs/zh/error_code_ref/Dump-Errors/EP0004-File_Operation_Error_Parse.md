# EP0004 File\_Operation\_Error\_Parse

## 错误信息

报错格式如下，占位符%s的含义依次为文件名、报错原因：

```text
Failed to parse file %s. Reason: %s.
```

报错示例如下：

```text
Failed to parse file /home/test_dump/acl.json. Reason: [json.exception.type_error.302] type must be array, but is string.
```

## 解决方法

需按照Reason中的提示检查并修改。
