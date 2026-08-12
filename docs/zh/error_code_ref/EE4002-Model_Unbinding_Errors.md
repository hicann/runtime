# EE4002 Model\_Unbinding\_Errors

## 错误信息

报错格式如下，占位符%s表示报错原因：

```
Failed to unbind the stream from the model. %s
```

报错示例如下：

```
Failed to unbind the stream to the model. Failed to unbind stream [1] from model [2]. Reason: model id is not equal to stream model id[0].
```

## 可能原因

1. 要解绑的Stream未绑定到模型。
2. 模型正在运行。

## 解决方法

1. 需检查代码逻辑，确保要解绑的Stream已绑定到模型上。
2. 需确保模型未在运行。
