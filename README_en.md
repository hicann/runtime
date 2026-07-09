# runtime

## Latest News

- [2026/4] Added support for Ascend 950PR/Ascend 950DT chips. Continuously enhanced AclGraph functionality, optimized documentation structure, and improved developer experience.
- [2025/12] The runtime project was first released.

## Overview

This repository provides the CANN runtime components and diagnostic functionality components.

- Runtime components: Provide Ascend NPU runtime user programming interfaces and core runtime implementations, including device management, stream management, event management, memory management, task scheduling, and other functions.
- Diagnostic functionality components: Include performance data collection, model and operator dump, logging, error logging, and other functions.
    - Performance tuning (msprof) module: When performing performance tuning, you can use the performance tuning tool to collect and analyze key performance metrics of each runtime phase of AI tasks running on the Ascend AI processor SoC NPU IP accelerator. Based on the output performance data, users can quickly identify software and hardware performance bottlenecks and improve the efficiency of AI task performance analysis.
    - Precision debugging (adump) module: Provides the capability to dump input/output data of single operators or models (each layer of operators) for Ascend NPU runtime, allowing comparison with specified operators or models to locate precision issues. It also provides the capability to dump input/output data, workspace information, and tiling information of abnormal operators when the Ascend NPU runtime encounters exceptions, for analyzing AI Core Error issues.
    - Logging (log) module: Provides the capability to record process execution information. While other processes are running, the logging interfaces provide process printing and log persistence functions, facilitating system fault diagnosis and analysis for quick issue localization. The msnpureport tool in this module is a command-line tool that supports exporting device-side logs and querying or setting device-side status.

## Version Compatibility

The source code of this project is released with CANN software versions. For the correspondence between CANN software versions and project tags, refer to the relevant version descriptions in the [release repository](https://gitcode.com/cann/release-management).

Note: To ensure smooth source code customization development, select the compatible CANN version and Gitcode tag source code. Using the master branch may pose version mismatch risks.

## Directory Structure

The key directory structure is as follows:

```
├── cmake                                          # Build compilation directory
├── docs                                           # Documentation
├── example                                        # Sample code based on acl interfaces
├── include                                        # Header files for the 3.1 package release
|   ├── dfx                                        # dfx-related header files
|   ├── driver                                     # Driver-related header files
|   ├── external                                   # Header files provided by this repository
|   ......
├── pkg_inc                                        # Repository management-related header files
├── scripts                                        # Build auxiliary files
├── src                                            # Source code for all modules in the 3.1 package
|   ├── acl                                        # acl external API directory
|   ├── dfx                                        # dfx module directory
|   |   ├── adump                                  # adump module directory
|   |   ├── log                                    # log module directory
|   |   ├── msprof                                 # msprof module directory
|   |   ├── trace                                  # trace module directory
|   |   ......
|   ├── mmpa                                       # mmpa module directory
|   ├── runtime                                    # runtime module directory
|   ......
├── stub                                           # Stub-related directory
├── tests                                          # UT test cases
......
├── CMakeLists.txt                                 # Build configuration file
├── build.sh                                       # Project build script
```

## Environment Deployment

### Environment Installation

#### Manual Installation

For developers with Ascend devices, if you want to manually set up the Ascend environment, refer to the following steps.

##### Install Basic Dependencies

The basic dependencies for this project are as follows. Note the version requirements.

- python >= 3.7.0 (Python 3.7 and Python 3.8 have reached official EOL. CANN will stop supporting them in March 2027. Please upgrade to version 3.9.0 or later.)
- pip3
- gcc >= 7.3.0, <= 13
- cmake >= 3.16.0
- ccache
- autoconf
- gperf
- libtool
- make
- libc6-dev/glibc-devel

Installation command examples for Ubuntu/Debian operating systems:

```bash
sudo apt install python3 python3-pip python3-dev gcc-9 g++-9 libc6-dev cmake ccache autoconf gperf libtool libtool-bin make
```

Installation command examples for CentOS/EulerOS operating systems:

```bash
sudo yum install python3 python3-pip python3-devel gcc gcc-c++ glibc-devel cmake ccache autoconf gperf libtool make
```

##### Install Software

- **Scenario 1: Experience master version capabilities or develop based on the master version**

  1. **Install driver and firmware (optional, only required for running [samples](example/README_en.md))**

      If you only need to compile the runtime package, you can skip this step. Installing the driver and firmware is required for running runtime samples.

      For download and installation instructions, refer to the "Preparing Software Packages" and "Installing NPU Driver and Firmware" sections in the [CANN Software Installation Guide](https://www.hiascend.com/document/redirect/CannCommunityInstWizard).

  2. **Install CANN packages**

      Click [download link](https://ascend.devcloud.huaweicloud.com/artifactory/cann-run-mirror/software/master/) to select the latest version, and download the corresponding package based on the product model and environment architecture. For installation commands, refer to the [CANN Software Installation Guide](https://www.hiascend.com/document/redirect/CannCommunityInstWizard).

      - Install CANN toolkit package

        ```bash
        # Ensure the installation package has executable permissions
        chmod +x Ascend-cann-toolkit_${cann_version}_linux-${arch}.run
        # Installation command
        ./Ascend-cann-toolkit_${cann_version}_linux-${arch}.run --install --install-path=${install_path}
        ```
        - `${cann_version}`: Indicates the CANN package version number.
        - `${arch}`: Indicates the CPU architecture, such as `aarch64` or `x86_64`.
        - `${install_path}`: Indicates the specified installation path. It must be the same as the Toolkit package installation path. For root users, the default installation path is `/usr/local/Ascend`.

      - Install CANN ops operator package (optional, only required for running [samples](example/README_en.md))

        If you only need to compile the runtime package, you can skip this step. Installing the CANN ops operator package is required for running runtime samples.

        ```bash
        # Ensure the installation package has executable permissions
        chmod +x Ascend-cann-${soc_name}-ops_${cann_version}_linux-${arch}.run
        # Installation command
        ./Ascend-cann-${soc_name}-ops_${cann_version}_linux-${arch}.run --install --install-path=${install_path}
        ```
        - `${soc_name}` indicates the NPU model name.

          | Product | soc_name |
          | --- | --- |
          | Atlas A2 training series products/Atlas A2 inference series products | 910b |
          | Atlas A3 training series products/Atlas A3 inference series products | A3 |
          | Ascend 950PR/Ascend 950DT products | 950 |

- **Scenario 2: Experience released version capabilities or develop based on released versions**

    Visit the [CANN official download center](https://www.hiascend.com/cann/download), select the release version (only CANN 8.5.0 and later versions are supported), product model, and environment architecture. Follow the CANN quick installation guide to complete the installation.

### Environment Verification

After installing the CANN package, verify that the environment and driver are functioning properly.

- **Check NPU device**

    ```bash
    # Run npu-smi. If device information is displayed properly, the driver is working correctly.
    npu-smi info
    ```

- **Check CANN version**

  ```bash
    # View the version information from the version field of the CANN Toolkit development suite package (default path installation). <arch> indicates the CPU architecture (aarch64 or x86_64).
    cat /usr/local/Ascend/cann/<arch>-linux/ascend_toolkit_install.info
    # View the CANN ops package version information (default path installation)
    cat /usr/local/Ascend/cann/${arch}-linux/ascend_ops_install.info
  ```

## Source Code Build

This project supports source code building. Before compiling and running, complete the environment deployment following the steps above.

Source code building can be done using the following methods:

- **Local source code build**: Follow the "Download Source Code", "Environment Variable Configuration", and "Compile runtime package" sections below.
- **Docker source code build**: Refer to [.devcontainer/README_en.md](.devcontainer/README_en.md) to complete source code building in a container.

### Download Source Code

```bash
# Download project source code, using the master branch as an example
git clone https://gitcode.com/cann/runtime.git
```

### Environment Variable Configuration

Select the appropriate command to set the environment variables based on your needs.

```bash
# Default path installation, for root users (for non-root users, replace /usr/local with ${HOME})
source /usr/local/Ascend/cann/set_env.sh
# Specified path installation
source ${install_path}/cann/set_env.sh
```

### Compile runtime package

If your build environment can access the network, open-source third-party software will be automatically downloaded during compilation. You can use the following command to compile:

```bash
bash build.sh
```

If your build environment cannot access the network, you can directly invoke the script to obtain the open-source component compressed packages. The script will automatically download to the newly created `third_party` directory:

```bash
python download_3rd_party.py
```

After the download is complete, you can use the following command to compile:

```bash
bash build.sh --cann_3rd_lib_path=third_party
```

For more compilation parameters, run `bash build.sh -h` to view them.

After compilation, the `cann-npu-runtime_<version>_linux-<arch>.run` software package will be generated in the `build_out` directory.
\<version> indicates the version number.
\<arch> indicates the operating system architecture, with values including x86_64 and aarch64.

**Open-source Third-party Software Dependencies**

The third-party open-source software dependencies for runtime compilation are as follows:

| Open-source Software | Version | Download Address |
|---|---|---|
| abseil-cpp | 20230802.1 | [abseil-cpp-20230802.1.tar.gz](https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1/abseil-cpp-20230802.1.tar.gz) |
| acl-compat (x86_64) | 9.1.0 | [acl-compat_9.1.0_linux-x86_64.tar.gz](https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.1.0_linux-x86_64.tar.gz) |
| acl-compat (aarch64) | 9.1.0 | [acl-compat_9.1.0_linux-aarch64.tar.gz](https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cann/acl-compat/acl-compat_9.1.0_linux-aarch64.tar.gz) |
| boost | 1.87.0 | [boost_1_87_0.tar.gz](https://gitcode.com/cann-src-third-party/boost/releases/download/v1.87.0/boost_1_87_0.tar.gz) |
| eigen | 5.0.0 | [eigen-5.0.0.tar.gz](https://gitcode.com/cann-src-third-party/eigen/releases/download/5.0.0/eigen-5.0.0.tar.gz) |
| googletest | 1.14.0 | [googletest-1.14.0.tar.gz](https://gitcode.com/cann-src-third-party/googletest/releases/download/v1.14.0/googletest-1.14.0.tar.gz) |
| json | 3.11.3 | [include.zip](https://gitcode.com/cann-src-third-party/json/releases/download/v3.11.3/include.zip) |
| libboundscheck | 1.1.16 | [libboundscheck-v1.1.16.tar.gz](https://gitcode.com/cann-src-third-party/libboundscheck/releases/download/v1.1.16/libboundscheck-v1.1.16.tar.gz) |
| libseccomp | 2.5.4 | [libseccomp-2.5.4.tar.gz](https://gitcode.com/cann-src-third-party/libseccomp/releases/download/v2.5.4/libseccomp-2.5.4.tar.gz) |
| mockcpp | 2.7-h5 | [mockcpp-2.7.tar.gz](https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7.tar.gz) |
| mockcpp_patch | 2.7-h5 | [mockcpp-2.7-h5.patch](https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7-h5.patch) |
| protobuf | 25.1 | [protobuf-25.1.tar.gz](https://gitcode.com/cann-src-third-party/protobuf/releases/download/v25.1/protobuf-25.1.tar.gz) |
| makeself | 2.5.0 | [makeself-release-2.5.0-patch1.tar.gz](https://gitcode.com/cann-src-third-party/makeself/releases/download/release-2.5.0-patch1.0/makeself-release-2.5.0-patch1.tar.gz) |
| cann-cmake | master-026 | [cmake-master-026.tar.gz](https://cann-3rd.obs.cn-north-4.myhuaweicloud.com/cmake/cmake-master-026.tar.gz) |

> [!NOTE]
> If you download from other addresses, ensure that the version numbers are consistent.

### Install runtime package

Run the following command to install the compiled runtime software package.

```bash
cd build_out;
./cann-npu-runtime_<version>_linux-<arch>.run --full --install-path=${install_path}
```
- $\{version\}: Indicates the run package version number.
- $\{arch\}: Indicates the CPU architecture, such as aarch64 or x86_64.
- $\{install\_path\}: Indicates the specified installation path. This is optional. The default installation path is `/usr/local/Ascend`.

After installation, the user-compiled Runtime software package will replace the Runtime-related software in the installed CANN development suite package.

### Local Verification

After compilation, you can perform development testing to verify that the project functions properly. This section describes how to perform unit testing (UT: Unit Testing).
> Note:
Executing UT test cases requires the googletest unit testing framework. For detailed introduction, refer to the [googletest official website](https://google.github.io/googletest/advanced.html#running-a-subset-of-the-tests).

Compile and execute `UT` test cases:

```bash
bash tests/build_ut.sh --ut=acl --target=ascendcl_utest -c --cann_3rd_lib_path={your_3rd_party_path}
```
Where `{your_3rd_party_path}` must be an absolute path.

**Specify Test Module**

Use `--ut` to specify the module name. In the example above, the module name is `acl`.

UT test cases in the `runtime` repository are categorized by module and stored in different directories under `tests/ut/`. You can find all module names and their mapping to test case paths in the `ut_path_map` in `tests/build_ut.sh`. For example, UT cases for the `acl` module are located in `tests/ut/acl`, and UT cases for the `runtime` module are located in `tests/ut/runtime/runtime`.

**Specify Test Target File**

Use `--target` to specify the specific target file compiled from test cases.

The target files included in each module can be viewed from the corresponding module's `CMakeLists.txt` file. For example, for `acl`, from the `add_custom_target` in `tests/ut/acl/CMakeLists.txt`, you can see that the compilation target is named `ascendcl_utest`, and it includes two target files: `ascendcl_c_utest` and `ascendcl_cpp_utest`. In the example above, specifying `target` as `ascendcl_utest` means compiling and executing all test cases in the `acl` module. You can also specify specific target files for compilation and execution (you can specify multiple files separated by spaces).

**Other Compilation Parameters**

Use `-c` to obtain coverage information. If you do not need coverage information, you can omit this parameter.
> You need to install `lcov` first (Ubuntu/Debian: `sudo apt install lcov`; openEuler: `sudo dnf install lcov`). If errors occur due to version differences, adjust the script parameters according to the prompts.

Use `--asan` to enable AddressSanitizer for memory error detection. If you do not need to enable it, you can omit this parameter.
> AddressSanitizer typically does not require separate installation and is integrated in gcc. If you need to install asan separately, ensure it is compatible with the gcc version, for example, gcc 9.5.0 matches the libasan6 version.

Use `--cann_3rd_lib_path` to specify the path for third-party dependencies. If you are in a networked environment, you can omit this parameter.

For more detailed compilation command parameters, run `bash tests/build_ut.sh -h`.

The intermediate files and artifacts from the UT test case compilation process are located in `output` and `build`. If you want to clear historical compilation records, you can perform the following operations:

```bash
rm -rf output/ build/
```

**For further understanding of this repository, refer to the samples in the [example](example/README_en.md) directory.**

## Learning Resources

Runtime provides development guides and API references. For details, refer to [Runtime Reference Documentation](./docs/zh/README.md).

## Related Information
- [Contributing Guide](CONTRIBUTING_en.md)
- [Security Statement](SECURITY_en.md)
- [License](LICENSE)