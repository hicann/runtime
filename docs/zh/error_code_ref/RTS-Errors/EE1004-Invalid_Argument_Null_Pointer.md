# EE1004 Invalid\_Argument\_Null\_Pointer

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数名：

```
%s failed because %s cannot be a NULL pointer.
```

报错示例如下：

```
rtsStreamSetAttribute failed because attrValue cannot be a NULL pointer.
```

## 解决方法

请使用正确的参数值重试。
