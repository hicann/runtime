# 1_queue_route

## 概述

本示例演示 TDT Queue 路由对象的创建、绑定、查询和解绑流程。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

- 创建两个独立 Queue 作为路由源和目的。
- 创建 Route 与 RouteList 并绑定到运行时。
- 通过 QueryInfo 按源队列和目的队列查询路由。
- 读取路由的源、目的和状态字段。
- 完成路由解绑与资源释放。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# 将 /usr/local/Ascend 替换为实际 CANN 安装根目录
source /usr/local/Ascend/cann/set_env.sh
export ASCEND_INSTALL_PATH=/usr/local/Ascend/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 aclInit 接口初始化 AscendCL 配置。
    - 调用 aclFinalize 接口实现 AscendCL 去初始化。
- Device管理
    - 调用 aclrtSetDevice 接口指定用于运算的 Device。
    - 调用 aclrtResetDeviceForce 接口强制复位当前 Device，回收 Device 上的资源。
- Queue 创建与属性配置
    - 调用 acltdtCreateQueueAttr 接口创建 Queue 属性对象。
    - 调用 acltdtSetQueueAttr 接口设置 Queue 名称和深度。
    - 调用 acltdtCreateQueue 接口创建源 Queue 和目的 Queue。
    - 调用 acltdtDestroyQueueAttr 接口销毁 Queue 属性对象。
- Route 创建与绑定
    - 调用 acltdtCreateQueueRoute 接口创建路由对象。
    - 调用 acltdtCreateQueueRouteList 和 acltdtAddQueueRoute 接口组装路由列表。
    - 调用 acltdtBindQueueRoutes 接口将路由关系绑定到运行时。
- Route 查询与参数获取
    - 调用 acltdtCreateQueueRouteQueryInfo 和 acltdtSetQueueRouteQueryInfo 接口构造查询条件。
    - 调用 acltdtQueryQueueRoutes 接口查询匹配的路由列表。
    - 调用 acltdtGetQueueRouteNum、acltdtGetQueueRoute 和 acltdtGetQueueRouteParam 接口读取路由数量及路由参数。
- Route 解绑与资源释放
    - 调用 acltdtUnbindQueueRoutes 接口解除路由绑定。
    - 调用 acltdtDestroyQueueRouteList、acltdtDestroyQueueRouteQueryInfo 和 acltdtDestroyQueueRoute 接口释放路由相关对象。
    - 调用 acltdtDestroyQueue 接口销毁源 Queue 和目的 Queue。

## 已知 issue

暂无。
