# EE1020 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: API name, API name, error code, error cause, extended information.

```text
%s failed. Reason: Standard function %s failed. [Errno %s] %s. %s
```

Error example:

```text
rtGetStreamId failed. Reason: Standard function memcpy_s failed. [Errno 1] Operation not permitted. src=socName, dest=3257281401236631602, dest_max=1223, count=1222.
```

## Solution

Please locate the issue based on the prompts in the error message.
