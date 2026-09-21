# AUTO\_USE\_UC\_MEMORY

## 功能描述

控制系统是否允许算子搬移数据不经过L2 Cache的功能。

取值为：

- 0或其他值：否，表示所有算子搬移数据都必须经过L2 Cache。
- 1：是，表示允许算子搬移数据可以不经过L2 Cache，具体是否经过L2 Cache，由算子Kernel代码中的逻辑决定。默认值为1。

    配置为1后，部分算子性能可得到提升，但可能存在AI Core Error风险。

>**须知：**
>本环境变量为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。

## 配置示例

```bash
export AUTO_USE_UC_MEMORY=0
```

## 使用约束

在调用aclInit接口初始化时，会触发读取该环境变量。

<!-- npu="A3,910b,310p" id1 -->
## 支持的型号

<!-- npu="310p" id2 -->
Atlas推理系列产品
<!-- end id2 -->

<!-- npu="910b" id3 -->
Atlas A2系列产品
<!-- end id3 -->

<!-- npu="A3" id4 -->
Atlas A3系列产品
<!-- end id4 -->
<!-- end id1 -->
