# ASCEND_DUMP_SCENE

<!-- md-trans-meta sourceCommit=26bdc48d09be0c66d6adc6e7e9f097ae9753ff82 translatedAt=2026-11-11T06:29:00.939Z pushedAt=2026-11-16T03:21:04.163Z nl=2 -->

## Description

Enables exception operator dump and exports the input/output data, workspace information, and tiling information of exception operators. This environment variable is used for reproducing a problem scenario.

The following values are supported:

- **aic_err_brief_dump**: lightweight exception dump, used to export the input/output and workspace data of AI Core error operators.
- **aic_err_norm_dump**: normal exception dump. In addition to lightweight exception dump, it also exports **Shape**, **Data Type**, **Format**, and attribute information.
<!-- npu="950,A3,910b" id4 -->
- **aic_err_detail_dump**: In addition to lightweight exception dump, it also exports the internal storage, register, and call stack information of AI Cores.

    When setting this option, note the following:

  - This option is supported only on the following models:

    <!-- npu="910b" id1 -->
    Atlas A2 products
    <!-- end id1 -->

    <!-- npu="A3" id2 -->
    Atlas A3 products
    <!-- end id2 -->

    <!-- npu="950" id3 -->
    Ascend 950PR&950DT products
    <!-- end id3 -->
  - During the export of dump files, the AI Core where the exception operator resides is paused, which may affect the normal execution of other service processes on the device. After the dump files are exported, the AI Core is automatically restored.
  - After the dump files are exported, the user service process on the host side is forcibly exited. Errors reported during the forced exit may not be used as input for AI Core problem analysis.
  - After the **aic_err_detail_dump** option is configured, if dump files are generated but are not **\*.core** files, it indicates that the feature corresponding to **aic_err_detail_dump** is not enabled successfully, and the system automatically switches to dumping according to the **aic_err_brief_dump** option.
<!-- end id4 -->

## Configuration Example

```bash
export ASCEND_DUMP_SCENE=aic_err_brief_dump
```

## Constraints

- Exception operator dump can be enabled in multiple ways, with priority in descending order: **ASCEND_DUMP_SCENE** environment variable \> **NPU_COLLECT_PATH** environment variable \> configuration file (**aclInit** API and **aclmdlSetDump** API).
- The storage path of the dump information exported through this environment variable follows the priority in descending order: **ASCEND_DUMP_PATH** environment variable \> **ASCEND_WORK_PATH** environment variable \> default path (the current execution directory of the application).

## Supported Models

Supported on all chips.
