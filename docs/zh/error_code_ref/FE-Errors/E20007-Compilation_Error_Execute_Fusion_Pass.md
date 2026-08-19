# E20007 Compilation\_Error\_Execute\_Fusion\_Pass

## 错误信息

报错格式如下，占位符%s的含义依次为融合规则名、融合规则类型：

```text
Graph fusion pass %s failed. The pass type is %s.
```

报错示例如下：

```text
Graph fusion pass UserSemanticInferencePass failed. The pass type is built-in-before-transnode-insertion-graph-pass.
```

## 可能原因

当前场景超出了融合规则的处理范围。

## 解决方法

如果融合规则是自定义的，请检查融合规则的实现逻辑。 如果融合规则不是自定义的，请获取Host日志并联系技术支持，网址为<https://www.hiascend.com/support>。
