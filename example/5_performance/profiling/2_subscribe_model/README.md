## 2_subscribe_model

## 描述
本样例展示了订阅算子信息。通过调用消息订阅接口实现将采集到的Profiling数据解析后写入管道，由用户读入内存，再由用户调用API获取性能数据。当前支持获取网络模型中算子的性能数据，包括算子名称、算子类型名称、算子执行时间等。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Profiling 样例的 run.sh 还会读取 ASCEND_HOME_PATH，请一并设置为同一路径
export ASCEND_HOME_PATH=${install_root}/cann

# 编译运行
bash run.sh
```
## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 调用aclprofCreateSubscribeConfig接口，创建模型订阅的配置并且进行模型订阅
- 调用aclprofModelSubscribe接口进行模型订阅
- 调用aclprofModelUnSubscribe接口释放模型订阅
- 调用aclprofDestroySubscribeConfig释放config指针

## CANN GE API
在该sample中，涉及模型的关键功能点及其关键接口，如下所示：
- 调用aclmdlLoadFromFile接口，加载模型
- 调用aclmdlExecute接口，执行模型

请移步[LINK](https://gitcode.com/cann/ge)查看模型相关流程

## 已知issue

   暂无
