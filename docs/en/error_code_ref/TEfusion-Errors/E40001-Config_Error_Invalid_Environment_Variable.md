# E40001 Config\_Error\_Invalid\_Environment\_Variable

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: environment variable value, environment variable name, error stage, error cause.

```text
Value %s for environment variable %s is invalid when %s. Reason: %s.
```

Error example:

```text
Value /usr/local/Ascend/cann/opp for environment variable PATH is invalid when executing the cmd python3 -V and python -V. Reason: invalid Python version.
```

## Solution

Reset the environment variable by referring to the Environment Variable Reference.
