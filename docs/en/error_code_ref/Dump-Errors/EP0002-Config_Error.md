# EP0002 Config\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: configuration item value, configuration item name, configuration file, expected value.

```text
Value %s for configuration item %s in configuration file %s is invalid. Expected value: %s.
```

Error example:

```text
Value abc for configuration item dump_op_switch in configuration file acl.json is invalid. Expected value: on/off.
```

## Solution

Please check the configuration and configure the correct value as prompted in error message.
