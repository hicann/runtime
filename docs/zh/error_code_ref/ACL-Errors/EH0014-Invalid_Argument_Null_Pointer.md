# EH0014 Invalid\_Argument\_Null\_Pointer

## 错误信息

报错格式如下，占位符%s的含义依次为接口功能、参数名：

```
%s failed because %s cannot be NULL pointers at the same time.
```

报错示例如下：

```
aclrtFunctionGetParamInfo failed because paramOffset and paramSize cannot be NULL pointers at the same time.
```

## 解决方法

请使用正确的指针参数重试。
