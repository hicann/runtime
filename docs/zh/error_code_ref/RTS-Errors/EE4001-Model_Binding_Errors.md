# EE4001 Model\_Binding\_Errors

## 错误信息

报错格式如下，占位符%s表示报错原因：

```
Failed to bind the stream to the model. %s
```

报错示例如下：

```
Failed to bind the stream to the model. Stream [1] has been bound to model [2] and failed to be bound to model [3].
```

## 可能原因

该Stream已绑定到其他模型。

## 解决方法

请调整代码逻辑，删除对Stream的重复绑定操作。
