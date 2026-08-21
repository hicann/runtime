# E40003 File\_Operation\_Error\_Open

## 错误信息

报错格式如下，占位符%s表示文件名：

```text
Failed to open the JSON file: %s.
```

报错示例如下：

```text
Failed to open the JSON file: /usr/local/Ascend/cann/ascend-toolkit/opp/built-in/op_impl/ai_core/tbe/kernel/config/fusion_ops.json.
```

## 可能原因

文件已被删除或锁定，或者没有权限打开该文件。

## 解决方法

在单用户环境中再次运行程序，确保没有其他用户访问该文件。
