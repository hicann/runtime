# EH0005 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为参数名、报错原因：

```
AIPP argument %s is invalid. Reason: %s.
```

报错示例如下：

```
AIPP argument batch_index is invalid. Reason: batch_index 3 is greater than or equal to batch_number 2.
```

## 解决方法

根据报错提示调整参数值。
