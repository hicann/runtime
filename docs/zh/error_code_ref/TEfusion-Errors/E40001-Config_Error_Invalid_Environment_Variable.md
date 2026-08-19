# E40001 Config\_Error\_Invalid\_Environment\_Variable

## 错误信息

报错格式如下，占位符%s的含义依次为环境变量值、环境变量名、报错阶段、报错原因：

```text
Value %s for environment variable %s is invalid when %s. Reason: %s.
```

报错示例如下：

```text
Value /usr/local/Ascend/cann/opp for environment variable PATH is invalid when executing the cmd python3 -V and python -V. Reason: invalid Python version.
```

## 解决方法

需按照Reason中的提示设置环境变量，或根据《环境变量参考》重新设置环境变量。
