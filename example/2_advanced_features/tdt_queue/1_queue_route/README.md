# 1_queue_route

## 概述

本示例演示 TDT Queue 路由对象的创建、绑定、查询和解绑流程。

## 功能说明

- 创建两个独立 Queue 作为路由源和目的。
- 创建 Route 与 RouteList 并绑定到运行时。
- 通过 QueryInfo 按源队列和目的队列查询路由。
- 读取路由的源、目的和状态字段。
- 完成路由解绑与资源释放。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

## 运行前环境变量

运行 bash run.sh 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```
## 相关 API

- acltdtCreateQueueRoute / acltdtDestroyQueueRoute
- acltdtCreateQueueRouteList / acltdtDestroyQueueRouteList
- acltdtAddQueueRoute / acltdtGetQueueRoute / acltdtGetQueueRouteNum / acltdtGetQueueRouteParam
- acltdtBindQueueRoutes / acltdtUnbindQueueRoutes / acltdtQueryQueueRoutes
- acltdtCreateQueueRouteQueryInfo / acltdtDestroyQueueRouteQueryInfo / acltdtSetQueueRouteQueryInfo

## 已知 issue

暂无。
