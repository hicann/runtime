# E40024 Environment\_Error\_Call\_Python\_Function\_Failed

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: Python API name, error cause.

```text
Failed to call Python Method %s. Reason: %s.
```

Error example:

```text
Failed to call Python Method op_params_to_json. Reason: TypeError: op_params_to_json() takes 1 positional argument but 2 were given.
```

## Possible Cause

The Python Method does not exist.

## Solution

1. Check that the called function is correct or the Python dependency library is installed.
2. Check the CANN environment variable settings.
3. Reinstall the CANN package.
