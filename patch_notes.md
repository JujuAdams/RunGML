# RunGML Patch Notes

## 1.0.2 (2025-04-13)
- Added a new operator: `"iter"`
    - Returns the value of the current loop iterator
- Added a new operator: `"iters"`
    - Returns a list of loop iterator values ordered by increasing loop depth
- Added a new `loop` example program

## 1.0.1 (2025-04-13)

- Switched to semantic versioning (2025.04.11.0 -> 1.0.0)
- Added a macro to toggle constraint validation: `RunGML_I_checkConstraints`
- Changed some config settings from globals to macros
- The `"run"` operator now creates and uses a separate interperter instance
- Added a new operator: `"for"`
    - Takes 5 arguments:
        - starting value
        - name of comparison operator
        - reference value
        - increment value
        - program wrapped in a struct
    - Example usage: `["for", 0, "lt", 5, 1, {"do": ["print", "foo"]}]`
        - Will print the string "foo" five times
- Improved performance of `RunGML_clone()`
- Improved performance of type checking
- Improved performance when iterating over arrays
- Removed unnecessary debug message from bounce example program


## 2025.04.11.0

Initial release
