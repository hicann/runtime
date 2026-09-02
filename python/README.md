# ACL

## 介绍

The Python API for ACL(Ascend Computing Language).

AscendCL（Ascend Computing Language）是一套用于在昇腾平台上开发深度神经网络应用的C语言API库，提供运行资源管理、内存管理、模型加载与执行、算子加载与执行、媒体数据处理等API，能够实现利用昇腾硬件计算资源、在昇腾CANN平台上进行深度学习推理计算、图形图像预处理、单算子加速计算等能力。简单来说，就是统一的API框架，实现对所有资源的调用。计算资源层是昇腾AI处理的硬件算力基础，主要完成神经网络的矩阵相关计算、完成控制算子/标量/向量等通用计算和执行控制功能、完成图像和视频数据的预处理，为深度神经网络计算提供了执行上的保障。

pyACL（Python Ascend Computing Language）就是在AscendCL的基础上使用CPython封装得到的Python API库，使用户可以通过Python语言进行昇腾AI处理器的运行管理、资源管理等。

## 文件目录组织结构

```text
python
├── build
│   ├── bep         //
│   └── build.sh    //调用该脚本来完成编译acl.so、生成run包
├── ci              //CI构建的依赖项配置
├── script          //run包的安装、卸载脚本、help、patch等
|── output          //run包构建后最终的存放目录
└── pyACL           //CPython封装ACL源码
```

## 构建

### 在CI环境下

```bash
cd build
cmake ..
make
```

### 在非CI环境下

由于环境不同需要重新配置CMakeLisits文件

将ACL_LIB由"${PROJECT_SOURCE_DIR}/dependency/lib64"替换为环境上CANN包的路径，如：

```cmake
set(ACL_LIB "/usr/local/Ascend/ascend-toolkit/latest/lib64/")
```

通过include_directories设置环境上的CANN包路径，如：

```cmake
include_directories(/usr/local/Ascend/ascend-toolkit/latest/include/)
```

通过include_directories设置环境上的python软件路径，如：

```cmake
include_directories(/usr/local/python3.9.0/include/python3.9/)
include_directories(/usr/local/python3.9.0/lib/python3.9/site-packages/numpy/core/include/)
```

## 使用说明

pyACL集成在cann-toolkit中 <br>
运行依赖：同版本的driver包和runtime组件 <br>

## 开发指导

CPython封装指导：https://docs.python.org/release/3.7.5/extending/extending.html# <br>
CPython数据解析：https://docs.python.org/release/3.7.5/c-api/arg.html#other-objects <br>
CPython异常类型：https://docs.python.org/3/library/exceptions.html#RuntimeError <br>
