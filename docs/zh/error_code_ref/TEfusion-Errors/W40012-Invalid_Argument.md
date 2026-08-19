# W40012 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为参数值、参数名、取值范围、默认值：

```text
Value %s for parameter %s is invalid. The value must be in the range of %s and defaults to %s.
```

报错示例如下：

```text
Value -2 for parameter ASCEND_MAX_OP_CACHE_SIZE is invalid. The value must be in the range of [1, 2147483647) or -1 and defaults to 500.
```

## 可能原因

参数取值无效。

## 解决方法

请根据取值范围修改参数值。
