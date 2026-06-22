# context

This directory focuses on Context creation, switching, binding, and destruction, as well as context usage patterns in multi-thread scenarios.

## Recommendations

- Typical usage of `aclrtCreateContext`, `aclrtSetCurrentContext`, `aclrtDestroyContext`, and other interfaces.
- Relationship between Device and Context.
- Context isolation and reuse in multi-thread scenarios.

## References

- [../device/](../device/README_en.md): Device initialization and switching.
- [../stream/](../stream/README_en.md): Relationship between stream and context.