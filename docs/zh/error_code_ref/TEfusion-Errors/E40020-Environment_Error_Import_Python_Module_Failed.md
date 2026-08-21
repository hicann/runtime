# E40020 Environment\_Error\_Import\_Python\_Module\_Failed

## 错误信息

报错格式如下，占位符%s的含义依次为Python模块名、报错原因：

```text
Failed to import Python module %s. Reason: %s.
```

报错示例如下：

```text
Failed to import Python module tbe.common. Reason: ModuleNotFoundError: No module named 'tbe.common'.
```

## 可能原因

一些必需的Python模块未安装。

## 解决方法

检查所有必需组件是否已正确安装，并且指定的Python路径与Python安装目录一致。如果路径与目录不一致，请运行安装包中的set\_env.sh脚本。
