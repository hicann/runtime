# E40020 Environment\_Error\_Import\_Python\_Module\_Failed

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: Python module name, error cause.

```text
Failed to import Python module %s. Reason: %s.
```

Error example:

```text
Failed to import Python module tbe.common. Reason: ModuleNotFoundError: No module named 'tbe.common'.
```

## Possible Cause

Some required Python modules are not installed.

## Solution

Check that all required components are properly installed and the specified Python path matches the Python installation directory. If the path does not match the directory, run set\_env.sh in the installation package.
