# EK0006 Invalid\_Argument\_Null\_Pointer

## 错误信息

报错格式如下，占位符%s的含义依次为接口、参数名：

```text
%s failed because parameter %s cannot be a null pointer.
```

报错示例如下：

```text
aclprofDestroyConfig failed because parameter profilerConfig cannot be a null pointer.
```

## 解决方法

参数值为空指针，需根据错误提示修改相应参数的值。
