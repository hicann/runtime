# EH0012 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数名、报错原因：

```
%s failed. Parameter %s is invalid. Reason: %s.
```

报错示例如下：

```
aclrtAllocatorGetByStream failed. Parameter stream is invalid. Reason: The stream is not registered with any allocator.
```

## 解决方法

根据Reason中的提示调整参数值。
