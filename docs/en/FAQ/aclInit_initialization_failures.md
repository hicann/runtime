# Troubleshooting Common Causes of the aclInit Initialization Failure

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:52:33.948Z pushedAt=2026-10-23T07:17:29.079Z -->

## Symptoms

**Symptom 1: A parameter error code is returned when the aclInit API is called**

When the aclInit API is called, **ACL_ERROR_RT_PARAM_INVALID** (error code 107000) is returned, indicating that the parameter is invalid.

Example of the error log:

```text
aclInit failed, ret = 107000
```

**Symptom 2: A repeated initialization error code is returned when the aclInit API is called**

When the aclInit API is called, **ACL_ERROR_REPEAT_INITIALIZE** (error code 100002) is returned, indicating a repeated initialization error.

Example of the error log:

```text
aclInit failed, ret = 100002, repeat initialize
```

**Symptom 3: Failure to parse the configuration file**

The path of the configuration file passed to the aclInit API is incorrect or the format is invalid, causing parsing to fail.

Example of the error log:

```text
Failed to parse config file: /path/to/acl.json
```

## Possible Causes

1. **The configuration file path does not exist or the permission is insufficient**: The configuration file path passed to the aclInit API is incorrect, or the file is unreadable.
2. **Incorrect JSON configuration format**: The configuration file has excessive bracket nesting (up to 10 levels), misspelled fields, or a format that does not comply with the JSON specifications.
3. **Inconsistent configurations across multiple aclInit calls**: When the aclInit API is called repeatedly, the configurations must remain consistent; otherwise, subsequent calls may report errors or the configuration may become invalid.

## Handling

### Cause 1: The Configuration File Path Does Not Exist or the Permission Is Insufficient

**Solution**:

- Use an absolute path: pass the complete file path, for example, `/home/user/acl.json`.
- Check the file permission: ensure that the file is readable, and use `ls -l /path/to/acl.json` to view the permission.
- If the default configuration meets your requirements: pass **nullptr** or configure an empty JSON string `{}`

Example code:

```c
// Use an absolute path.
aclError ret = aclInit("/home/user/config/acl.json");

// Use the default configuration (pass nullptr).
aclError ret = aclInit(nullptr);

// Use an empty configuration (pass an empty JSON string).
// Content of acl.json: {}
aclError ret = aclInit("../acl.json");
```

### Cause 2: Incorrect JSON Configuration Format

**Solution**:

- Check the bracket nesting: In the JSON file, the `{` nesting level can be up to 10, and the `[` nesting level can be up to 10.
- Verify the field spelling: refer to the configuration examples in the API documentation.
- Use a JSON validation tool: use an online JSON validator to check the format correctness.

Typical configuration example:

```json
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```

### Cause 3: Inconsistent Configurations Across Multiple aclInit Calls

**Solution**:

- Keep the configuration consistent: use the same configuration file path and content for each aclInit call.
- Ignore the repeated initialization error: repeated aclInit calls return **ACL_ERROR_REPEAT_INITIALIZE**, which can be ignored to continue service processing.
- Call initialization and deinitialization in pairs: repeated initialization and deinitialization are supported, with the sequence `aclInit → service processing → aclFinalize → aclInit → service processing → aclFinalize`.

Example code:

```c
// Correct way to initialize repeatedly
aclError ret1 = aclInit(nullptr);  // First initialization
// ... Service processing ...
aclError ret2 = aclFinalize();     // Deinitialization

aclError ret3 = aclInit(nullptr);  // Initialization again (with consistent configuration)
// ... Service processing ...
aclError ret4 = aclFinalize();     // Deinitialization again
```

## Related Issues

None
