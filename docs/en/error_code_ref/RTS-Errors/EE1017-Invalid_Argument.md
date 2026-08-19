# EE1017 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter name, error cause.

```text
%s failed. Parameter %s is invalid. Reason: %s.
```

Error example:

```text
rtsBinaryLoadFromData failed. Parameter option.cpuKernelMode is invalid. Reason: When the AI CPU operator binary is loaded from data, the loading mode 1 is invalid. The valid value can only be 2: LoadFromData.
```

## Solution

Please adjust the parameter value according to the prompts in the Reason.
