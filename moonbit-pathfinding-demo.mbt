///|
/// Warehouse floor plan: `#` = shelf (blocked), `.` = free aisle cell.
pub struct Warehouse {
  rows : Int
  cols : Int
  blocked : Array[Bool]
}

///|
/// Parse an ASCII floor plan into a `Warehouse`.
pub fn Warehouse::parse(lines : Array[String]) -> Warehouse {
  let rows = lines.length()
  let cols = if rows > 0 { lines[0].length() } else { 0 }
  let blocked = Array::make(rows * cols, false)
  for r in 0..<rows {
    for c in 0..<cols {
      if lines[r][c] == '#' {
        blocked[r * cols + c] = true
      }
    }
  }
  { rows, cols, blocked }
}

///|
/// 4-neighbour successors with unit move cost, skipping shelves.
pub fn Warehouse::successors(
  self : Warehouse,
  cell : (Int, Int),
) -> Array[((Int, Int), Int)] {
  let (r, c) = cell
  let out : Array[((Int, Int), Int)] = []
  let deltas = [(-1, 0), (1, 0), (0, -1), (0, 1)]
  for d in deltas {
    let (dr, dc) = d
    let nr = r + dr
    let nc = c + dc
    if nr >= 0 && nr < self.rows && nc >= 0 && nc < self.cols {
      if !self.blocked[nr * self.cols + nc] {
        out.push(((nr, nc), 1))
      }
    }
  }
  out
}

///|
/// Shortest robot route via A* with the Manhattan-distance heuristic
/// (admissible on a 4-connected unit grid), powered by
/// `Suquster/moonbit-pathfinding`.
pub fn plan_route(
  w : Warehouse,
  start : (Int, Int),
  goal : (Int, Int),
) -> (Array[(Int, Int)], Int)? {
  @directed.astar(
    start,
    fn(cell) { w.successors(cell) },
    fn(cell) {
      let (r, c) = cell
      let (gr, gc) = goal
      let dr = if r > gr { r - gr } else { gr - r }
      let dc = if c > gc { c - gc } else { gc - c }
      dr + dc
    },
    fn(cell) { cell == goal },
  )
}

///|
/// Render the floor plan with the route drawn as `*` (start `S`, goal `G`).
pub fn render_route(w : Warehouse, route : Array[(Int, Int)]) -> String {
  let cells : Array[Char] = []
  for r in 0..<w.rows {
    for c in 0..<w.cols {
      cells.push(if w.blocked[r * w.cols + c] { '#' } else { '.' })
    }
  }
  for i in 0..<route.length() {
    let (r, c) = route[i]
    let mark = if i == 0 {
      'S'
    } else if i == route.length() - 1 {
      'G'
    } else {
      '*'
    }
    cells[r * w.cols + c] = mark
  }
  let sb = StringBuilder::new()
  for r in 0..<w.rows {
    for c in 0..<w.cols {
      sb.write_char(cells[r * w.cols + c])
    }
    if r < w.rows - 1 {
      sb.write_char('\n')
    }
  }
  sb.to_string()
}
