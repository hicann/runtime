# 3_cond_model

## 描述
本样例展示 aclGraph 条件操作（IF/WHILE/SWITCH）的图捕获与执行，覆盖 3 个典型场景：
1. IF 条件双分支验证（true 分支 alpha=2.0，false 分支 alpha=0.5）
2. WHILE 单次迭代循环（循环体执行一次后退出）
3. SWITCH 多分支选择（3 个 case 各用不同 alpha）

**核心结论**：aclGraph 条件操作通过 `aclmdlRICondHandle` + `aclmdlRIAddCondTask` 实现 IF/WHILE/SWITCH 分支捕获，通过 `aclmdlRICondHandleGetCondPtr` 获取设备端条件指针，执行时由条件值动态决定分支走向。

**注意**：本样例需要 CANN 版本支持 aclGraph 条件操作 API（`aclmdlRICondHandleCreate`、`aclmdlRIAddCondTask`、`aclmdlRICaptureToModelRIBegin` 等），请确认 CANN 版本包含这些接口后再运行。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/2_advanced_features/model_ri/3_cond_model
```

2.设置环境变量。
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 设置 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3.执行以下命令运行样例。
```bash
bash run.sh
```

## CANN RUNTIME API

在该样例中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtResetDeviceForce` 接口复位当前运算的 Device，回收 Device上的资源。
- Context 管理
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务的完成。
- 内存管理
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口通过内存复制的方式实现数据传输。
    - 调用 `aclrtMemcpyAsync` 接口进行异步的内存复制。
- aclGraph 条件操作
    - 调用 `aclmdlRICaptureBegin` 接口开始图捕获。
    - 调用 `aclmdlRICaptureEnd` 接口结束图捕获，得到 modelRI 句柄。
    - 调用 `aclmdlRICaptureGetInfo` 接口获取图捕获状态和 modelRI。
    - 调用 `aclmdlRICondHandleCreate` 接口创建条件句柄。
    - 调用 `aclmdlRICondHandleGetCondPtr` 接口获取条件指针。
    - 调用 `aclmdlRIAddCondTask` 接口注册条件任务（IF/WHILE/SWITCH）。
    - 调用 `aclmdlRICaptureToModelRIBegin` 接口开始子模型捕获。
    - 调用 `aclmdlRIExecuteAsync` 接口异步执行模型运行实例。
    - 调用 `aclmdlRIDestroy` 接口销毁模型运行实例。
- aclnn 算子
    - 调用 `aclnnAddGetWorkspaceSize` 和 `aclnnAdd` 接口执行加法算子计算。

## 已知issue

暂无
