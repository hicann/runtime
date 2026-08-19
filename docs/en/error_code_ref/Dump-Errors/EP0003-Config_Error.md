# EP0003 Config\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: configuration item value, configuration item name, configuration file, error cause.

```text
Value %s for configuration item %s in configuration file %s is invalid. Reason: %s.
```

Error example:

```text
Value /npu/abc for configuration item dump_path in configuration file acl.json is invalid. Reason: The value is a path without read and write permissions.
```

## Solution

Please check the configuration and configure the correct value as prompted in the Reason.
