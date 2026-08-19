# E40024 Environment\_Error\_Call\_Python\_Function\_Failed

## 错误信息

报错格式如下，占位符%s的含义依次为Python函数名、报错原因：

```text
Failed to call Python Method %s. Reason: %s.
```

报错示例如下：

```text
Failed to call Python Method op_params_to_json. Reason: TypeError: op_params_to_json() takes 1 positional argument but 2 were given.
```

## 可能原因

Python函数不存在。

## 解决方法

1. 检查调用的函数是否正确，或确认Python依赖库是否已安装。
2. 检查CANN环境变量设置。
3. 重新安装CANN包。
