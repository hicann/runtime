# EE2002 Config\_Error\_Invalid\_Environment\_Variable

## 错误信息

报错格式如下，占位符%s的含义依次为环境变量值、环境变量名、期望值：

```
Value %s for environment variable %s is invalid. Expected value: %s.
```

报错示例如下：

```
Value 1,2,2 for environment variable ASCEND_RT_VISIBLE_DEVICES is invalid. Expected value: cannot be duplicated.
```

## 解决方法

参考[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)重新设置环境变量。
