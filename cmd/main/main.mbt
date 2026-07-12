///|
/// Warehouse robot route planner demo.
/// Run with `moon run cmd/main` from the project root.
fn main {
  let plan = [
    "S....#....", ".###.#.##.", ".#...#..#.", ".#.###..#.", ".#......#G", ".########.",
    "..........",
  ]
  let w = @moonbit-pathfinding-demo.Warehouse::parse(plan)
  let start = (0, 0)
  let goal = (4, 9)
  match @moonbit-pathfinding-demo.plan_route(w, start, goal) {
    Some((route, cost)) => {
      println("Shortest robot route (cost \{cost}):")
      println(@moonbit-pathfinding-demo.render_route(w, route))
    }
    None => println("Goal unreachable")
  }
}
