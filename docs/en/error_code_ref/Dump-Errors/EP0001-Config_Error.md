# EP0001 Config\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: configuration item name, configuration file, error cause.

```text
The content of configuration item %s in configuration file %s is invalid. Reason: %s.
```

Error example:

```text
The content of configuration item dump_path in configuration file acl.json is invalid. Reason: The configuration item is not found.
```

## Solution

Please check the configuration and configure the correct value as prompted in the Reason.
