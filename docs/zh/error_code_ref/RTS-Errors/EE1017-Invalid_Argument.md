# EE1017 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、参数名、报错原因：

```
%s failed. Parameter %s is invalid. Reason: %s.
```

报错示例如下：

```
rtsBinaryLoadFromData failed. Parameter option.cpuKernelMode is invalid. Reason: When the AI CPU operator binary is loaded from data, the loading mode 1 is invalid. The valid value can only be 2: LoadFromData.
```

## 解决方法

根据Reason中的提示调整参数值。
