# W40010 Config\_Error\_Invalid\_Environment\_Variable

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: environment variable value, environment variable name, result, error cause.

```text
Value %s for environment variable %s is invalid. Result: %s. Reason: %s.
```

Error example:

```text
Value  for environment variable ASCEND_ADK_PATH is invalid. Result: unable to get current adk version info. Reason: path does not exist.
```

## Solution

Please set the environment variable as prompted in the Reason, or reconfigure it referring to the environment variable reference documentation.
