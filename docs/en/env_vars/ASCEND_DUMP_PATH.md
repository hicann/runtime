# ASCEND_DUMP_PATH

<!-- md-trans-meta sourceCommit=fb621a8aa4155a0c73927815942666be8dd7efe8 translatedAt=2026-11-11T06:28:53.378Z pushedAt=2026-11-16T03:19:48.721Z nl=2 -->

## Description

Specifies the storage path for exception operator dump information. The path can be an absolute path or a path relative to the execution program. The specified path supports uppercase and lowercase letters (a-z, A-Z), digits (0-9), underscores (_), hyphens (-), periods (.), and Chinese characters. The executing user must have read, write, and execute permissions on the path. If the path does not exist, the system automatically creates the directories in the path. If no path is specified, exception operator dump information is stored in the current execution directory of the application by default.

Note the following when using this environment variable:

- When exception operator dump is enabled through the **ASCEND_DUMP_SCENE** environment variable, the priority from high to low is as follows: **ASCEND_DUMP_PATH** environment variable \> **ASCEND_WORK_PATH** environment variable \> default path (the current execution directory of the application).
- When exception operator dump is enabled through a configuration file (**aclInit** API or **aclmdlSetDump** API), the priority from high to low is as follows: **ASCEND_DUMP_PATH** environment variable \> **ASCEND_WORK_PATH** environment variable \> configuration file path (**dump_path** field) \> default path (the current execution directory of the application).
- Setting this environment variable automatically enables operator kernel data dump by default. The priority of the dump information storage path from high to low is as follows: **ASCEND_DUMP_PATH** environment variable \> **ASCEND_WORK_PATH** environment variable \> configuration file path (**dump_path** field).

## Configuration Example

```bash
export ASCEND_DUMP_PATH=/repo/task001
```

## Constraints

- When enabling exception operator dump, this environment variable must be used together with **ASCEND_DUMP_SCENE**.
- When enabling operator kernel data dump, you only need to set this environment variable.

## Supported Models

Supported on all chips.
