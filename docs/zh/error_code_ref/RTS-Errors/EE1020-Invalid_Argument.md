# EE1020 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为接口名称、接口名称、报错原因、扩展信息：

```
%s failed. Reason: Standard function %s failed. [Errno %s] %s. %s
```

报错示例如下：

```
rtGetStreamId failed. Reason: Standard function memcpy_s failed. [Errno 1] Operation not permitted. src=socName, dest=3257281401236631602, dest_max=1223, count=1222.
```

## 解决方法

按照报错提示定位问题。
