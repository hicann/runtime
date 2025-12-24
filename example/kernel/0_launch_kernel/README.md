## 0_launch_kernel

## 描述
本样例展示了如何基于Launch Kernel方式加载与执行Add算子。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品 
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 200I/500 A2 推理产品
- Atlas 推理系列产品
- Atlas 训练系列产品

## 编译运行

  1.设置环境变量。
  ```bash
  # 指定昇腾AI处理器版本，可使用npu-smi info命令在环境上查阅，获取Name值并删除空格
  export SOC_VERSION=Ascendxxxyy
  # 部分样例中涉及调用AscendC算子，需配置AscendC编译器ascendc.cmake所在的路径，此处以默认路径为例
  # 可在CANN包安装路径下查找ascendc.cmake，例如find ./ -name ascendc.cmake
  export ASCENDC_CMAKE_DIR=/usr/local/Ascend/cann/compiler/tikcpp/ascendc_kernel_cmake
  ```

  2.下载样例代码并上传至安装CANN软件的环境，切换到样例目录。
  ```bash
  cd ${git_clone_path}/example/kernel/0_launch_kernel
  ```

  3.执行以下命令运行样例。
  ```bash
   bash run.sh -r <mode>
  ```
   mode可选simple和placeholder两种模式：
    1. simple模式
    指指针类型参数，其值为Device内存地址。一般来说，算子的输入、输出是该种类型的参数，用户需提前调用Device内存申请接口（例如aclrtMalloc接口）申请内存，并自行拷贝数据至Device侧。
    2. placeholder模式
    也是指针类型参数，但区别在于，用户无需手动将参数数据复制到Device，这项操作由Runtime完成。在追加参数时Runtime并不会填写真实的Device地址，而是在Launch Kernel时才会刷新为真实的Device地址，所以称之为placeholder。

## CANN RUNTIME API
在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtDestroyStreamForce接口强制销毁Stream，丢弃所有任务。
    - 调用aclrtSynchronizeStream可以阻塞等待Stream上任务的完成。
- 内存管理
    - 调用aclrtMallocHost接口申请Host上的内存。
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFreeHost接口释放Host上的内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现Host与Device间的数据传输。
- Kernel加载与执行
    - 调用aclrtBinaryLoadFromFile从文件加载并解析算子二进制文件。
    - 调用aclrtBinaryGetFunction获取核函数句柄。
    - 调用aclrtKernelArgsInit根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。
    - 调用aclrtKernelArgsAppend将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。
    - 调用aclrtKernelArgsAppendPlaceHolder对于placeholder参数，调用本接口占位。
    - 调用aclrtKernelArgsGetPlaceHolderBuffer根据用户指定的内存大小，获取paramHandle占位符指向的内存地址。
    - 调用aclrtKernelArgsFinalize标识参数组装完毕。
    - 调用aclrtLaunchKernelWithConfig指定任务下发的配置信息，并启动对应算子的计算任务。
    - 调用aclrtBinaryUnLoad卸载算子二进制文件。

## 已知issue

  暂无
