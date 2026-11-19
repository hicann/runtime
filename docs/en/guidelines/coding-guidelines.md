# Coding Guidelines

This document defines the unified coding guidelines to follow when you implement code in the Runtime repository.

Document structure:

- `1. General C/C++ Coding Guidelines` apply to all C/C++ code in the Runtime repository, including source code and UT code.
- `2. Runtime Constraint Guidelines` mainly apply to `src/`, `include/`, `pkg_inc/`, `cmake/`, and other non-test code. When you review or write UT code, refer to these guidelines only when the related scenario actually applies.

## 1. General C/C++ Coding Guidelines

### Rule 1: Do not hardcode sensitive information and do not use prohibited sensitive words

- Do not hardcode high-level sensitive data such as plaintext passwords and keys in source code.
- Thoroughly clean up legacy abandoned accounts, passwords, and sensitive configurations with unclear purposes.
- Avoid large arrays with unclear purposes or vague semantics and hidden data definitions with poor readability. Such content is easily suspected as a backdoor implementation.
- When code or configuration hardcodes public IP addresses, domain names, email addresses, or sensitive words that easily cause misunderstanding, you must explain a reasonable purpose. In particular, do not include suspicious public addresses pointing to China.

### Rule 2: When external data serves as an array index or pointer offset, you must ensure the access range is valid

- If external parties directly control an array index, memory offset, length, or capacity, perform a strict range check first to prevent out-of-bounds access.

### Rule 3: Strictly check integer operations to ensure no overflow, wraparound, or division by zero

- If an integer operation result participates in memory allocation, offset calculation, loop bounds, or copy length, evaluate the risks of overflow, wraparound, truncation, and division by zero.

### Rule 4: Resource management and lifecycle must be clear, and acquisition and release must be paired

- File handles, memory, and handles such as device, driver, context, stream, event, and notify handles must be released in time after the lifecycle ends.
- Exception branches and early-return paths must not omit cleanup actions.
- Assign a clear new value immediately after you release a resource to avoid dangling pointers and double free.
- The acquisition and release of resources such as memory, locks, and handles must be paired. Prefer RAII to manage the resource lifecycle.

### Rule 5: Check the size before memory allocation and verify success after allocation

- The allocation size may come from external input. Check its validity, and do not allocate zero-length memory.
- An external allocator must verify both the returned structure pointer and the `data` pointer inside the structure.
- After memory allocation, evaluate whether initialization is required to avoid reading uninitialized memory.

### Rule 6: Validate external input, null pointers, array subscripts, and loop bounds first

- External input such as user parameters, driver return values, configuration files, and environment variables must pass a validity check before it enters critical logic.
- Confirm a pointer is valid before you dereference it.
- Array subscripts, lengths, and loop bounds must stay within the valid range.

### Rule 7: Error handling must be complete, and do not swallow errors

- Error return values on the call chain must be propagated correctly. Do not silently swallow errors.
- Returned error codes must have accurate semantics.
- Resources already allocated on an error path must be released accordingly.
- Use error handling macros correctly. Avoid the cases of "logging an error without closing the flow" or "returning directly without context".

### Rule 8: Buffers, memory operations, and object lifecycle must meet basic security constraints

- Array or buffer access must avoid out-of-bounds access.
- `new/delete`, `malloc/free`, and `new[]/delete[]` must be strictly paired. Do not mix them.
- Check for null when you use `new(std::nothrow)`. Do not perform a `nullptr` check when you use plain `new`.
- Do not return the address of stack space.
- Before you release an object, define the handling policy for member pointers inside the object to avoid double free and dangling references.

### Rule 9: Concurrency scenarios must explicitly guarantee thread safety

- Shared data in multi-threaded scenarios must have a clear protection policy to avoid race conditions and visibility problems.
- Do not nest ordinary locks arbitrarily to avoid deadlock risks.
- When thread context switching, asynchronous tasks, or callbacks are involved, define the timing relationship and the validity period of resources.

### Rule 10: Do not write code that depends on expression evaluation order or implicit precedence

- Code such as `func(a++, a)` depends on an unspecified evaluation order. This is undefined behavior, and you must avoid it.
- Use parentheses in complex expressions to make the operation precedence explicit. Do not depend on the default precedence.

### Rule 11: Code style and committed content must be clean and consistent

- Changed code must conform to the `.clang-format` configuration of the repository.
- Naming must follow project conventions. Use UpperCamelCase for function names, and a trailing underscore is allowed for private methods. Use lowerCamelCase for variable names. Use ALL_CAPS with underscores for constants and macros. Use UpperCamelCase for class names.
- New files must contain the CANN Open Software License copyright header.
- The include order must follow project conventions.
- Do not leave debug code, commented-out code, unused includes, or unused variables in a commit.
- File permissions of new files must be reasonable. Source code should be 644, and executable scripts should be 755.

## 2. Runtime Constraint Guidelines

### Rule 12: Reserved parameters of open interfaces must be strictly validated to prevent compatibility problems when later versions enable them

- Reserved parameters must force users to pass invalid values. Otherwise, enabling them in a later version easily introduces compatibility problems.
- The invalid value of a numeric reserved parameter is generally `0`.
- The invalid value of a pointer reserved parameter is generally `nullptr`.

### Rule 13: Return values or parameters that express memory length in open interfaces should preferably use `size_t`

- For semantics such as memory length, buffer size, and byte count, preferably use `size_t` to avoid the insufficiency of 32-bit length expressions.

### Rule 14: When you modify an open interface, you must strictly ensure API and ABI compatibility

- All modifications at the boundary of `include/`, `include/external/acl/`, and externally released header files must strictly evaluate API/ABI compatibility.
- Do not use `std::string` as an ABI boundary type in public interfaces of external header files. Use the compatible alternative in the repository.
- Consider reserved fields and backward compatibility when you add or modify structures.
- Deprecated interfaces should preferably receive a compatibility marker instead of direct deletion.

### Rule 15: Do not hardcode chip, platform, or driver capability branches in common paths

- Common logic should preferably handle differences through capability query, configuration registration, or platform isolation directories.
- Logic that must distinguish platforms should be confined to `config/`, platform subdirectories, or a clear capability adaptation layer.

### Rule 16: Do not add EVENT/TRACE prints arbitrarily in load/execution hot paths

- Massive logs in hot paths introduce obvious performance jitter and IO pressure.
- Do not add EVENT/TRACE level logs that are enabled by default in load/execution hot paths.
- You can add DEBUG/INFO logs that are disabled by default, but evaluate the switch policy and the string overhead.
- Use ERROR logs only for real exceptions. Do not use them for normal branches.

### Rule 17: When you call an interface provided by another component that requires Runtime to pass resources, confirm the resource lifecycle constraints in advance

- In both the design and coding phases, define whether a cross-component interface holds a passed pointer, when it reuses the pointer, and when it releases the pointer.

### Rule 18: For logic sensitive to execution order, do not depend on the traversal result of unordered containers

- If container traversal order affects the order of tasks, events, notifications, callback registration, or resource initialization, do not directly depend on the traversal result of unordered containers such as `std::unordered_map`.
- When a stable order is required, preferably use ordered containers or explicit sorting.
- Do not use in-process address values as a basis for ordering.

### Rule 19: Do not implement the singleton pattern inline in header files

- An inline singleton in a header file may cause multiple instances, destruction timing problems, and crashes in multi-compilation-unit, dynamic library, and `dlopen` scenarios.

### Rule 20: Do not add undisclosed open interface boundaries

- Add new open interfaces only in clearly public boundary header files. Do not expose capabilities externally through internal header files or internal symbols.

### Rule 21: Do not make cross-SO function calls in destructors of static or global objects

- The destruction order across dynamic libraries is unpredictable, and it easily causes dangling references, abnormal termination, and crashes.
- Typical risks include the following. The dependent SO is already unloaded. A `shared_ptr` destructor triggers a virtual destructor, but the SO that hosts the actual type is already invalid. Other threads still access the static object during program exit.
- The recommended practice is to put cleanup work in an explicit `Finalize()` or an equivalent interface, complete the cleanup during the runtime phase, and keep the destruction phase as a no-op or limited to local object recovery.

### Rule 22: Implementation logic must be consistent with design and interface constraints

- Before coding, define the design intent, interface constraints, and scenario expectations of the change.
- Do not omit branches, boundary conditions, or exception paths in the implementation.
- The handling of normal flows, exception flows, and boundary scenarios must be consistent.

### Rule 23: When you write logs, ensure the level, content, and hot path overhead are reasonable

- Use `RT_LOG_ERROR` only for unrecoverable errors, `RT_LOG_WARNING` for function degradation or non-fatal exceptions, `RT_LOG_INFO` for key operation nodes, and `RT_LOG_DEBUG` for debug information.
- Log content must contain sufficient context, and do not print sensitive information.
- Format strings must match the parameter types.
- Do not hardcode function names in log content, and do not include English spelling errors.
- Do not introduce high-frequency logs in hot paths.
- Use the error log macros in the project correctly, for example `COND_RETURN_ERROR_MSG_INNER` and `RecordErrorLog`.
- In logs and error messages, use Arabic numerals for English words that express numeric values. Replace the standalone word `zero` with `0`, for example `count is zero` becomes `count is 0`, and `greater than zero` becomes `greater than 0`. Do not replace hyphenated compound words (`zero-size`, `non-zero`, `divide-by-zero`, `zero-copy`) and technical terms (`zero copy`).

### Rule 24: Modifying public interfaces must satisfy compatibility requirements

- When you modify header files in the `include/` directory, design the change according to the backward compatibility principle.
- Public API function signatures must not have breaking changes unless the change is explicitly accepted and the migration design is complete.
- Deprecate interfaces through markers instead of direct deletion.
- Do not introduce `XX_MAX` arbitrarily in enum definitions or affect multi-version matching compatibility.
- Do not add content to `pkg_inc/runtime/runtime` by mistake. When an addition is truly required, first confirm whether another public boundary is more appropriate.

### Rule 25: When you modify public interfaces and error codes, update the documents accordingly

- When you modify `include/external/acl/acl_rt.h`, update the corresponding `docs/` document in the same change.
- When you modify `include/external/acl/error_codes/rt_error_codes.h`, update `docs/zh/api_ref/25_data_types_and_operation_APIs.md` in the same change.

### Rule 26: The implementation must follow the existing software architecture and build boundaries

- Non-`api` directories in `src/runtime` should not call methods of the `api` directory. For example, the `feature` directory should not access `Api::Instance`.
- When you write an implementation, keep the existing directory boundaries, platform isolation boundaries, and component responsibility boundaries clear.
- The `src/runtime` directory allows only `STATIC_RT_LIB`, `RUNTIME_API`, `CFG_DEV_PLATFORM_PC`, and compiler built-in macros. Do not add other compile macros.
