# EE1009 Execution\_Error\_Model

## 错误信息

报错格式如下，占位符%s的含义依次为Model ID、报错原因：

```
Failed to execute model (model_id=%s). Reason: %s.
```

报错示例如下：

```
Failed to execute model (model_id=63). Reason: The current aclgraph model running instance neither contains any executable task nor contains any executable stream.
```

## 解决方法

根据Reason中的提示调整代码逻辑。
