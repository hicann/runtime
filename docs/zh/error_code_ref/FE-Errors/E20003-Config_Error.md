# E20003 Config\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为配置项、配置文件、报错原因：

```text
Configuration item %s in configuration file %s is invalid. Reason: %s.
```

报错示例如下：

```text
Configuration item false in configuration file /home/module/fusion_switch.json is invalid. Reason: The switch value of pass CustomSelfDefinePass must be on or off, instead of false.
```

## 可能原因

配置文件的内容或格式不符合规范。

## 解决方法

需按照Reason中的提示设置配置项，或参考官方文档中的说明配置文件。
