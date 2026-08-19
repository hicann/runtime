# EE2002 Config\_Error\_Invalid\_Environment\_Variable

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: environment variable value, environment variable name, expected value.

```text
Value %s for environment variable %s is invalid. Expected value: %s.
```

Error example:

```text
Value 1,2,2 for environment variable ASCEND_RT_VISIBLE_DEVICES is invalid. Expected value: cannot be duplicated.
```

## Solution

Reset the environment variable by referring to the Environment Variable Reference.
