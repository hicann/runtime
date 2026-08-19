# EE1007 Resource\_Error\_Bind\_Stream

## 错误信息

报错格式如下，占位符%s的含义依次为Stream ID、报错原因：

```
Failed to bind stream (stream_id=%s). Reason: %s.
```

报错示例如下：

```
Failed to bind stream (stream_id=1). Reason: The stream is already bound.
```

## 解决方法

根据Reason中的提示调整代码逻辑，例如将Stream从已绑定的模型中解绑，然后重新绑定到当前模型。
