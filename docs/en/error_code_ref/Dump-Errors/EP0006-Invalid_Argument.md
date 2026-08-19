# EP0006 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: API name, parameter name, error cause.

```text
%s failed. Value %s for parameter %s is invalid. Reason: %s
```

Error example:

```text
aclopStartDumpArgs failed. Value /output for parameter path is invalid. Reason: The parameter is a path and the path fails to be created. Error: No such file or directory.
```

## Solution

Please check and modify the value as prompted in the Reason.
