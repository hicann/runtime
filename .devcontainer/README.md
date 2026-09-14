# Dev Container 使用说明

简体中文 | [English](./README_en.md)

本目录包含 VS Code Dev Container 配置，用于在容器内编译 runtime 仓及执行 UT。

## 环境规格

| 工具 | 版本 |
|----|------|
| 基础镜像 | Ubuntu 22.04 LTS |
| GCC / G++ | 9.x |
| CMake | 3.22+ |
| Python | 3.10+ |
| ccache | 系统包 |
| lcov | 系统包（用于覆盖率） |
| libasan5 / libtsan0 / libubsan1 | gcc-9 消毒器运行时（`--asan` 时使用） |

## 快速开始

### 1. 启动容器

使用 VS Code 打开本仓目录，按 `F1` → **Dev Containers: Reopen in Container**，等待镜像构建完成。

容器启动时会自动尝试通过网络下载第三方依赖（保存在 `./third_party/`，并软链到 `output/third_party` 以匹配 `build.sh`/`build_ut.sh` 默认查找路径）。

### 2. 编译 runtime 整包

```bash
# 容器启动时已自动下载第三方包到 third_party/ 并软链到 output/third_party。
# 因此可直接执行（无需传 --cann_3rd_lib_path）：
export CMAKE_TLS_VERIFY=0
bash build.sh

# 如果第三方依赖在其他路径，必须使用绝对路径
# （CMake 的 INTERFACE_INCLUDE_DIRECTORIES 不接受相对路径）：
bash build.sh --cann_3rd_lib_path=$(pwd)/third_party
```

> **注意**：完整的 runtime 包编译及运行需要 CANN toolkit 和 NPU 驱动。  
> 请按照 README.md 中"环境准备"章节，在容器内手动下载并安装对应版本的 `Ascend-cann-toolkit` 包：
> ```bash
> chmod +x Ascend-cann-toolkit_${cann_version}_linux-x86_64.run
> ./Ascend-cann-toolkit_${cann_version}_linux-x86_64.run --full --force --quiet
> source /usr/local/Ascend/cann/set_env.sh
> ```
