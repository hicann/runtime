# EH0013 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、接口名称、报错原因、扩展信息：

```
%s failed. Reason: Standard function %s failed. [Errno %s] %s. %s
```

报错示例如下：

```
acltdtSendTensor failed. Reason: Standard function memcpy_s failed. [Errno 22] Invalid argument. src=0x1234, dst=0x5678, dstLen=1024, srcLen=512
```

## 解决方法

按照报错提示定位问题。
