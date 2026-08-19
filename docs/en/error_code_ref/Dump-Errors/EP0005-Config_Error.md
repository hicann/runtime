# EP0005 Config\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: file name, error cause.

```text
Conflict of configuration items in configuration file %s. Reason: %s.
```

Error example:

```text
Conflict of configuration items in configuration file /home/acl.json. Reason: Configuration items dump_scene and dump_stats cannot be both configured.
```

## Solution

Please check and modify the value as prompted in the Reason.
