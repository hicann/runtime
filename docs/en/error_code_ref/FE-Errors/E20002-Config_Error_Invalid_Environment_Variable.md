# E20002 Config\_Error\_Invalid\_Environment\_Variable

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: environment variable value, environment variable name, error cause.

```text
Value %s for environment variable %s is invalid. Reason: %s.
```

Error example:

```text
Value /usr/local/Ascend/cann/opp for environment variable ASCEND_OPP_PATH is invalid. Reason: ASCEND_OPP_PATH does not exist or access permission is denied during FE initialization.
```

## Solution

Reset the environment variable by referring to the Environment Variable Reference.
