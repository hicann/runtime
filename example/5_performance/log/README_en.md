# log

This directory provides runnable samples for the public ACL logging APIs. The directory-level script reports a unified success or failure result.

## Samples

- [0_acl_log](./0_acl_log/README_en.md): Covers `acllogRecord`, `acllogVaList`, `acllogCheckDebugLevel`, `acllogRegisterCallback`, and `acllogUnregisterCallback`.

## Build and run

```bash
source ${install_root}/cann/set_env.sh
bash run.sh
```

The script returns 0 when all steps succeed and a non-zero value when build or execution fails. Detailed output is written to `output_msg.txt`.
