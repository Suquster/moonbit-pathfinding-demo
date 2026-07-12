// Learn more about moon.mod configuration:
// https://docs.moonbitlang.com/en/latest/toolchain/moon/module.html
//
// To add a dependency, run this command in your terminal:
//   moon add moonbitlang/x
//
// Or manually declare it in `import`, for example:
// import {
//   "moonbitlang/x@0.4.6",
// }

name = "Suquster/moonbit-pathfinding-demo"

version = "0.1.0"

readme = "README.md"

repository = "https://github.com/Suquster/moonbit-pathfinding-demo"

license = "Apache-2.0"

keywords = [ ]

preferred_target = "wasm-gc"

description = "Warehouse robot route planner demo built on Suquster/moonbit-pathfinding"

import {
  "Suquster/moonbit-pathfinding@0.1.0",
}
