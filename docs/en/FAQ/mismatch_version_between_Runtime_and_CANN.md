# Issues Caused by Runtime Version and CANN Version Mismatch

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T10:01:36.566Z pushedAt=2026-10-22T09:22:40.188Z -->

## Symptoms

**Symptom 1: The API returns a feature-not-supported error code**

When a Runtime API is called, **ACL_ERROR_RT_FEATURE_NOT_SUPPORT** (error code 207000) is returned, indicating that the current version does not support this feature.

Example of the error log:

```text
aclrtGetVersion failed, ret = 207000, feature not supported
```

**Symptom 2: Abnormal API behavior**

API parameters are incompatible or return values do not meet expectations. The inconsistency between the runtime library version and the compile-time version causes behavioral differences.

Typical scenario example:

```c
// Use the new-version header file at compile time, but load the old-version library at runtime.
aclError ret = aclrtGetVersion(&major, &minor, &patch);  // The return value does not meet expectations
```

**Symptom 3: Compilation linking errors**

Some API definitions cannot be found during compilation, and the header file version does not match the library file version.

Example of the error log:

```text
undefined reference to `aclrtGetVersion'
```

## Possible Causes

1. **API differences between CANN versions**: New versions introduce new APIs, while earlier versions do not support certain features.
2. **Inconsistent runtime library versions**: The library version linked at compile time differs from the library version loaded at runtime.
3. **Incorrect environment variable configuration**: **ASCEND_HOME**, **LD_LIBRARY_PATH**, and other variables point to the incorrect version directory.

## Handling

### Cause 1: API Differences Between CANN Versions

**Solution**:

- Check the version information: use **aclsysGetVersionNum** to query the current Runtime version.
- Refer to the API documentation: confirm the support status of the API in different versions.
- Upgrade or downgrade the version: adjust the CANN version as required.

Example of version query:

```c
char pkgName[] = "runtime";
int32_t versionNum = 0;
aclError ret = aclsysGetVersionNum(pkgName, &versionNum);
printf("Runtime version: %d\n", versionNum);
```

### Cause 2: Inconsistent Runtime Library Versions

**Solution**:

- Check the compile-time linked library: confirm the version of **libascendcl.so** linked during compilation.
- Check the runtime loaded library: use the `ldd` command to view the actually loaded library path.
- Ensure version consistency: use the same CANN version for compilation and runtime.

Command example:

```bash
# View the library linked to the executable.
ldd your_program | grep ascendcl

# View the installed CANN version.
cat /usr/local/Ascend/version.info
```

### Cause 3: Incorrect Environment Variable Configuration

**Solution**:

- Check **ASCEND_HOME**: confirm that it points to the correct CANN installation directory.
- Check **LD_LIBRARY_PATH**: Ensure that it contains the correct library path.
- Update environment variables: Modify **~/.bashrc** or **~/.bash_profile**.

Command example:

```bash
# View the environment variables.
echo $ASCEND_HOME
echo $LD_LIBRARY_PATH

# Set the environment variables (example).
export ASCEND_HOME=/usr/local/Ascend
export LD_LIBRARY_PATH=$ASCEND_HOME/lib64:$LD_LIBRARY_PATH
```

## Related Issues

None
