# ASCEND\_RT\_VISIBLE\_DEVICES

## 功能描述

指定哪些Device对当前进程可见，支持一次指定一个或多个Device ID。通过该环境变量，可实现不修改应用程序即可调整所用Device的功能。

其中Device ID为AI处理器的逻辑ID，例如可用Device数量为8，Device ID分别为：0、1、2、3、4、5、6、7，使用场景说明如下：

- 设置“export ASCEND\_RT\_VISIBLE\_DEVICES=1”，则表示当前进程仅可使用Device ID为1的Device，获取到的Device数量为1，此时Device的索引值为0，后续在指定Device计算设备时，需使用该索引值。
- 设置“export ASCEND\_RT\_VISIBLE\_DEVICES=1,2,3”，则表示当前进程仅可使用Device ID为1、2、3的三个Device，获取到的Device数量为3，此时各Device的索引值分别为0、1、2，后续在指定Device计算设备时，需使用该索引值。

    多个Device ID之间以英文逗号分隔，不能包含其它字符或无效的Device ID，若包含其它字符或无效的Device ID，则只读取其它字符或无效Device ID之前的Device ID。例如，若设置“export ASCEND\_RT\_VISIBLE\_DEVICES=1, 2,3”环境变量设置命令中，2前面有一个空格，则这时只读取空格之前的Device ID，也就是1；若设置“export ASCEND\_RT\_VISIBLE\_DEVICES=1,3,8”环境变量设置命令中，8是无效的Device ID，则这时只读取8之前的Device ID，也就是1和3。

>**须知：**
>
>- 该环境变量为试用环境变量，后续版本可能存在变更，不支持应用于生产环境中。
>- 仅支持指定的Device ID按照升序配置。
>- 不支持使用DCMI接口时使用该环境变量。DCMI接口说明请参见《[DCMI API参考](https://support.huawei.com/enterprise/zh/ascend-computing/ascend-hdk-pid-252764743?category=developer-documents&subcategory=api-reference)》。
>- 不支持使用HCCN Tool接口时使用该环境变量。HCCN Tool接口说明请参见《[HCCN Tool 接口参考](https://support.huawei.com/enterprise/zh/ascend-computing/ascend-hdk-pid-252764743?category=developer-documents&subcategory=interface-reference)》。
>- 不支持使用Profiling功能时使用该环境变量。

**该环境变量使用场景：**

离线推理程序执行场景。

TensorFlow/PyTorch等框架网络在昇腾平台执行训练或在线推理的场景。

## 配置示例

- 指定一个Device ID：

    ```bash
    export ASCEND_RT_VISIBLE_DEVICES=1
    ```

- 指定多个Device ID：

    ```bash
    export ASCEND_RT_VISIBLE_DEVICES=1,2,3
    ```

## 使用约束

针对TensorFlow框架网络在昇腾平台执行训练或在线推理的场景，ASCEND\_RT\_VISIBLE\_DEVICES环境变量的优先级高于ASCEND\_DEVICE\_ID。若同时使用两个环境变量，ASCEND\_DEVICE\_ID环境变量只能设置为ASCEND\_RT\_VISIBLE\_DEVICES环境变量中的Device索引值，否则会导致训练或推理应用程序运行异常。

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
## 支持的型号

<!-- npu="950" id2 -->
Ascend 950PR/Ascend 950DT
<!-- end id2 -->

<!-- npu="A3" id3 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id3 -->

<!-- npu="910b" id4 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id4 -->

<!-- npu="310b" id5 -->
Atlas 200I/500 A2 推理产品
<!-- end id5 -->

<!-- npu="310p" id6 -->
Atlas 推理系列产品
<!-- end id6 -->

<!-- npu="910" id7 -->
Atlas 训练系列产品
<!-- end id7 -->
<!-- end id1 -->
