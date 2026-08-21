# EP0007 Invalid\_Argument\_Null\_Pointer

## 错误信息

报错格式如下，占位符%s分别表示接口名、参数名：

```text
%s failed because %s cannot be a NULL pointer.
```

报错示例如下：

```text
acldumpRegCallback failed because messageCallback cannot be a NULL pointer.
```

## 解决方法

需按照Reason中的提示检查并修改。
