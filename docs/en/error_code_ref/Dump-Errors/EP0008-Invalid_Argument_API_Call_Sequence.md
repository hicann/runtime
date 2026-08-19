# EP0008 Invalid\_Argument\_API\_Call\_Sequence

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: API name, error cause.

```text
%s failed. Reason: %s.
```

Error example:

```text
aclmdlInitDump failed. Reason: aclInit must be executed before aclmdlInitDump is called.
```

## Solution

Please check and modify the value as prompted in the Reason.
