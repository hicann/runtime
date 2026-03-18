# runtime（运行时）

## 🔥Latest News

- [2025/12] runtime项目首次上线。

## 概述

本仓提供CANN运行时组件和维测功能组件。
- Runtime组件：提供Ascend NPU运行时用户编程接口和运行时核心实现，包括设备管理、流管理、Event管理、内存管理、任务调度等功能。 
- 维测功能组件：包括性能数据采集、模型和算子Dump、日志、错误日志记录等功能。
    - 性能调优（msprof）模块：进行性能调优时，可以使用性能调优工具来采集和分析运行在昇腾AI处理器SoCNPU IP加速器上的AI任务各个运行阶段的关键性能指标，用于可根据输出的性能数据，快速定位软、硬件性能瓶颈，提升AI任务性能分析的效率。
    - 精度调试（adump）模块：提供Ascend NPU运行时用户Dump单算子或模型（每一层算子）的输入/输出数据，用于与指定算子或模型进行对比，定位精度问题；提供Ascend NPU运行异常时Dump异常算子的输入/输出数据、Workspace信息，Tiling信息，用于分析AI Core Error问题。
    - 日志（log）模块：日志提供记录进程执行过程信息的能力，在其他进程运行时，日志的接口提供进程打印和落盘日志的功能，方便系统故障的诊断分析，快速实现问题定位。该模块下的msnpureport为命令行工具，支持导出device侧日志和查询设置device侧状态等功能。

## 版本配套

本项目源码会跟随CANN软件版本发布，关于CANN软件版本与本项目标签的对应关系请参阅[release仓库](https://gitcode.com/cann/release-management)中的相应版本说明。
请注意，为确保您的源码定制开发顺利进行，请选择配套的CANN版本与Gitcode标签源码，使用master分支可能存在版本不匹配的风险。

## 目录结构

关键目录结构如下：

  ```
  ├── cmake                                          # 工程编译目录
  ├── docs                                           # 文档介绍
  ├── example                                        # 基于acl接口开发的样例代码
  ├── include                                        # 3.1包整体对外发布的头文件
  |   ├── dfx                                        # dfx相关头文件  
  |   ├── driver                                     # 驱动相关头文件
  |   ├── external                                   # 本仓对外提供的头文件
  |   ......
  ├── pkg_inc                                        # 仓间管控相关头文件 
  ├── scripts                                        # 辅助构建相关文件
  ├── src                                            # 所有3.1包内各模块的源代码
  |   ├── acl                                        # acl对外api存放目录  
  |   ├── dfx                                        # dfx模块目录
  |   |   ├── adump                                  # adump模块目录
  |   |   ├── log                                    # log模块目录
  |   |   ├── msprof                                 # msprof模块目录
  |   |   ├── trace                                  # trace模块目录
  |   |   ......                                     
  |   ├── mmpa                                       # mmpa模块目录
  |   ├── runtime                                    # runtime模块目录
  |   ......
  ├── stub                                           # 打桩相关目录
  ├── tests                                          # UT用例
  ......
  ├── CMakeLists.txt                                 # 构建编译配置文件
  ├── build.sh                                       # 项目工程编译脚本
  ```


## 源码编译&部署

### Runtime仓整包源码编译

#### 前提条件

使用本项目前，请确保如下基础依赖、NPU驱动和固件已安装。

1. **安装依赖**

    本项目源码编译用到的依赖如下，请注意版本要求。

    - python >= 3.7.0
    - pip3
    - gcc >= 7.3.0, <= 13
    - cmake >= 3.16.0
    - ccache
    - autoconf
    - gperf
    - libtool
    - make
    - asan （仅执行UT时依赖。asan通常不需要单独安装，已集成在gcc中，如需要单独安装asan，请确保与gcc版本兼容，例如gcc 9.5.0匹配libasan6版本。）

    上述依赖包（asan除外）可通过项目根目录下install_deps.sh安装，命令如下。
    ```bash
    bash install_deps.sh
    ```
    注意：该脚本中会通过 `sudo` 执行系统级依赖安装，需要当前用户在sudoers中；如果当前用户无法配置该权限，建议手动通过源码安装上述依赖包。

2. **安装驱动与固件（运行态依赖）**

    若仅编译runtime包，可跳过本操作步骤。运行Runtime时必须安装驱动与固件。

    单击[下载链接](https://www.hiascend.com/hardware/firmware-drivers/community)，根据实际产品型号和环境架构，获取对应的`Ascend-hdk-<chip_type>-npu-driver_<version>_linux-<arch>.run`、`Ascend-hdk-<chip_type>-npu-firmware_<version>.run`包。
    安装指导详见《[CANN 软件安装指南](https://www.hiascend.com/document/redirect/CannCommunityInstSoftware)》。

    通过如下方式验证驱动安装是否正常
    ```bash
    # 运行npu-smi, 若能正常显示设备信息，则驱动正常。
    npu-smi info
    ```

#### 环境准备

1. **安装CANN toolkit包**

    单击[下载链接](https://ascend.devcloud.huaweicloud.com/cann/run/software/8.5.0-beta.1)，根据实际环境架构，获取对应的`Ascend-cann-toolkit_${cann_version}_linux-${arch}.run`包。

    ```bash
    # 确保安装包具有可执行权限
    chmod +x Ascend-cann-toolkit_${cann_version}_linux-${arch}.run
    # 安装命令
    ./Ascend-cann-toolkit_${cann_version}_linux-${arch}.run --full --force --quiet --install-path=${install_path}
    ```
    - \$\{cann\_version\}：表示CANN包版本号。
    - \$\{arch\}：表示CPU架构，如aarch64、x86_64。
    - \$\{install\_path\}：表示指定安装路径，可选，root用户默认安装在`/usr/local/Ascend`目录，普通用户默认安装在当前目录。

2. **配置环境变量**
	
	根据实际场景，选择合适的命令。

    ```bash
    # 默认路径安装，以root用户为例（非root用户，将/usr/local替换为${HOME}）  
    source /usr/local/Ascend/cann/set_env.sh
    # 指定路径安装
    # source ${install_path}/cann/set_env.sh
    ```

3. **下载源码**

    ```bash
    # 下载项目源码，以master分支为例
    git clone https://gitcode.com/cann/runtime.git
    ```

> [!NOTE] 注意
> gitcode平台在使用HTTPS协议的时候要配置并使用个人访问令牌代替登录密码进行克隆，推送等操作。  

若您的编译环境无法访问网络，由于无法通过`git`指令下载代码，须在联网环境中下载源码后，手动上传至目标环境。
- 在联网环境中，进入[本项目主页](https://gitcode.com/cann/runtime.git), 通过`下载ZIP`或`clone`按钮，根据指导，完成源码下载。
- 连接至离线环境中，上传源码至您指定的目录下。若下载的为源码压缩包，还需进行解压。

#### 开源第三方软件依赖

Runtime在编译时，依赖的第三方开源软件列表如下：

| 开源软件 | 版本 | 下载地址 |
|---|---|---|
| abseil-cpp | 20230802.1 | [abseil-cpp-20230802.1.tar.gz](https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1/abseil-cpp-20230802.1.tar.gz) |
| acl-compat (x86_64) | 8.5.0 | [acl-compat_8.5.0_linux-x86_64.tar.gz](https://mirrors.huaweicloud.com/artifactory/cann-run/8.5.0/inner/x86_64/acl-compat_8.5.0_linux-x86_64.tar.gz) |
| acl-compat (aarch64) | 8.5.0 | [acl-compat_8.5.0_linux-aarch64.tar.gz](https://mirrors.huaweicloud.com/artifactory/cann-run/8.5.0/inner/aarch64/acl-compat_8.5.0_linux-aarch64.tar.gz) |
| boost | 1.87.0 | [boost_1_87_0.tar.gz](https://gitcode.com/cann-src-third-party/boost/releases/download/v1.87.0/boost_1_87_0.tar.gz) |
| eigen | 5.0.0 | [eigen-5.0.0.tar.gz](https://gitcode.com/cann-src-third-party/eigen/releases/download/5.0.0/eigen-5.0.0.tar.gz) |
| googletest | 1.14.0 | [googletest-1.14.0.tar.gz](https://gitcode.com/cann-src-third-party/googletest/releases/download/v1.14.0/googletest-1.14.0.tar.gz) |
| json | 3.11.3 | [include.zip](https://gitcode.com/cann-src-third-party/json/releases/download/v3.11.3/include.zip) |
| libboundscheck | 1.1.16 | [libboundscheck-v1.1.16.tar.gz](https://gitcode.com/cann-src-third-party/libboundscheck/releases/download/v1.1.16/libboundscheck-v1.1.16.tar.gz) |
| libseccomp | 2.5.4 | [libseccomp-2.5.4.tar.gz](https://gitcode.com/cann-src-third-party/libseccomp/releases/download/v2.5.4/libseccomp-2.5.4.tar.gz) |
| mockcpp | 2.7-h5 | [mockcpp-2.7.tar.gz](https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7.tar.gz) |
| mockcpp_patch | 2.7-h5 | [mockcpp-2.7_py3.patch](https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7-h5.patch) |
| openssl | 3.0.9 | [openssl-openssl-3.0.9.tar.gz](https://gitcode.com/cann-src-third-party/openssl/releases/download/openssl-3.0.9/openssl-openssl-3.0.9.tar.gz) |
| protobuf | 25.1 | [protobuf-25.1.tar.gz](https://gitcode.com/cann-src-third-party/protobuf/releases/download/v25.1/protobuf-25.1.tar.gz) |
| makeself | 2.5.0 | [makeself-release-2.5.0-patch1.tar.gz](https://gitcode.com/cann-src-third-party/makeself/releases/download/release-2.5.0-patch1.0/makeself-release-2.5.0-patch1.tar.gz) |

> [!NOTE]注意
> 如果您从其他地址下载，请确保版本号一致。

#### 编译安装

若您的编译环境可以访问网络，编译过程中将自动下载上述开源第三方软件，可以使用如下命令进行编译：

```bash
export CMAKE_TLS_VERIFY=0
bash build.sh
```

若您的编译环境无法访问网络，可以直接调用脚本获取开源组件压缩包，脚本将自动下载至当前新建的 `third_party` 目录中：

```bash
python download_3rd_party.py
```

下载完成后，可以使用如下命令进行编译：
```bash
bash build.sh --cann_3rd_lib_path=third_party
```
更多编译参数可以通过`bash build.sh -h`查看。

编译完成之后会在`build_out`目录下生成`cann-npu-runtime_<version>_linux-<arch>.run`软件包。
\<version>表示版本号。
\<arch>表示操作系统架构，取值包括x86_64与aarch64。
可执行如下命令安装编译生成的Runtime软件包，非正式发布包无社区签名。因此安装完成后，如果需要验证功能，请务必参考 "关于签名的补充说明" 进行操作。

```bash
./cann-npu-runtime_<version>_linux-<arch>.run --full --install-path=${install_path}
```
- \$\{version\}：表示run包版本号。
- \$\{arch\}：表示CPU架构，如aarch64、x86_64。
- \$\{install\_path\}：表示指定安装路径，可选，默认安装在`/usr/local/Ascend`目录。

安装完成之后，用户编译生成的Runtime软件包会替换已安装CANN开发套件包中的Runtime相关软件。
                                       
#### 关于签名的补充说明

* 本仓编译产生`cann-npu-runtime_<version>_linux-<arch>.run`软件包中含有`cann-tsch-compat.tar.gz`（Runtime兼容升级包)。
* `cann-tsch-compat.tar.gz`会在业务启动时加载至Device，加载过程中默认会由驱动进行安全验签，确保包可信。
* 开发者下载本仓源码自行编译产生`cann-tsch-compat.tar.gz` 采用社区证书签名头，为此采用关闭驱动安全验签的机制。
* 关闭验签方式：</br>
配套使用HDK 25.5.T2.B001或以上版本，并通过该HDK配套的npu-smi工具关闭验签。详见[设置自定义验签能力使能状态](https://support.huawei.com/enterprise/zh/doc/EDOC1100540362/3152813c?idPath=23710424|251366513|254884019|261408772|252764743), [设置验签模式](https://support.huawei.com/enterprise/zh/doc/EDOC1100540362/a484ba7b?idPath=23710424|251366513|254884019|261408772|252764743)命令文档，以root用户在物理机上执行。 </br>
以device 0为例 (其中 -i 后面的参数是device id）：
    ```bash
  npu-smi set -t custom-op-secverify-enable -i 0 -d 1     # 使能自定义验签
  npu-smi set -t custom-op-secverify-mode -i 0 -d 0      # 设置成"关闭验签"模式
 	```
  
## 本地验证 

编译完成后，用户可以进行开发测试（DT：Development Testing），验证项目功能是否正常。
> 说明：
执行 UT 用例依赖 googletest 单元测试框架，详细介绍参见 [googletest 官网](https://google.github.io/googletest/advanced.html#running-a-subset-of-the-tests)。

编译执行`UT`测试用例：

```bash
bash tests/build_ut.sh --ut=acl --target=ascendcl_utest -c --cann_3rd_lib_path={your_3rd_party_path}
```

**指定测试模块**

通过`--ut`指定模块名称，上述示例中指定的模块名称为`acl`。

`runtime`仓中的`UT`用例按模块分类归档在`tests/ut/`的不同目录下，所有模块名称以及和用例路径的映射关系可以查询`tests/build.sh`中的`ut_path_map`，例如：`acl`模块的`UT`在`tests/ut/acl`下，`runtime`模块的`UT`在`tests/ut/runtime/runtime`下。

**指定测试目标文件**

通过`--target`指定待测用例编译出的具体目标文件。

各个模块所包含的目标文件可以从对应模块的`CMakeLists.txt`文件中查看。例如对于`acl`，从`tests/ut/acl/CMakeLists.txt`中的`add_custom_target`可以看出将编译目标命名为`ascendcl_utest`，并且包含了`ascendcl_c_utest`和`ascendcl_cpp_utest`两个目标文件。上述示例中通过指定`target`为`ascendcl_utest`表示编译执行`acl`模块中的所有用例。也可以指定具体的目标文件进行编译执行(可以同时指定多个，用空格分隔)。

**其他编译参数**

通过`-c`可以获取覆盖率，如无需获取覆盖率，可省略此参数。
> 需先安装 `lcov`(Ubuntu / Debian：`sudo apt install lcov`；openEuler：`sudo dnf install lcov`)；若因版本差异报错，请按提示调整脚本参数。

通过`--cann_3rd_lib_path`指定第三方依赖的路径，若在联网环境中，可省略此参数。

更加详细的编译命令参数可以通过`bash tests/build_ut.sh -h`查看。


UT测试用例编译的过程件以及产物位于`output`和`build`下，如果想清除历史编译记录，可以执行如下操作：

```bash
rm -rf output/ build/
```

**接下来可参考[example](example/README.md)目录下的样例，进一步了解本仓**。

## 学习教程

Runtime提供了开发指南、API参考，详细可参见 [Runtime 参考资料](./docs/README.md)。

## 相关信息
- [贡献指南](CONTRIBUTING.md)
- [安全声明](SECURITY.md)
- [许可证](LICENSE)
