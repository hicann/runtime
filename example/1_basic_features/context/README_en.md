# context

This directory focuses on Context creation, switching, binding, and destruction, as well as context usage patterns in multi-thread scenarios.

## Sample List

- [0_context_query](./0_context_query/README_en.md): Queries the current Context, default Stream, and current thread resource limits.
- [1_context_scoped_determinism](./1_context_scoped_determinism/README_en.md): Observes the default Context state and verifies that deterministic computation settings remain isolated between two Contexts.

## Recommendations

- Typical usage of `aclrtCreateContext`, `aclrtSetCurrentContext`, `aclrtDestroyContext`, and other interfaces.
- Relationship between Device and Context.
- Context isolation and reuse in multi-thread scenarios.

## References

- [../device/](../device/README_en.md): Device initialization and switching.
- [../stream/](../stream/README_en.md): Relationship between stream and context.
