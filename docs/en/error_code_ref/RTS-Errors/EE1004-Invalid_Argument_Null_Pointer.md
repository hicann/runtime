# EE1004 Invalid\_Argument\_Null\_Pointer

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter name.

```text
%s failed because %s cannot be a NULL pointer.
```

Error example:

```text
rtsStreamSetAttribute failed because attrValue cannot be a NULL pointer.
```

## Solution

Try again with a correct pointer argument.
