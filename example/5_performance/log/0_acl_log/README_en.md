## 0_acl_log

This sample demonstrates the public ACL logging APIs in `acl_log.h`: recording debug and run logs, recording through `va_list`, and registering and unregistering a device log callback.

## Build and run

Run the parent directory's `run.sh` in a CANN environment:

```bash
source ${install_root}/cann/set_env.sh
cd ${git_clone_path}/example/5_performance/log
bash run.sh
```

The script checks both the build and the sample output and returns a non-zero status on failure.
