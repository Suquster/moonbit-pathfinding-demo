///|
test "plan_route finds shortest route around shelves" {
  let w = @moonbit-pathfinding-demo.Warehouse::parse([".....", ".###.", "....."])
  let res = @moonbit-pathfinding-demo.plan_route(w, (0, 0), (2, 4))
  assert_true(res is Some(_))
  let (route, cost) = res.unwrap()
  // Manhattan distance is 6; shelves do not block the border route.
  assert_eq(cost, 6)
  assert_eq(route.length(), 7)
  assert_true(route[0] == (0, 0))
  assert_true(route[route.length() - 1] == (2, 4))
}

///|
test "plan_route detours when the direct aisle is blocked" {
  let w = @moonbit-pathfinding-demo.Warehouse::parse([
    "S.#..", "..#..", "..#..", ".....",
  ])
  let res = @moonbit-pathfinding-demo.plan_route(w, (0, 0), (0, 4))
  assert_true(res is Some(_))
  let (_route, cost) = res.unwrap()
  // Must go down around the shelf wall: 3 down + 4 right + 3 up = 10.
  assert_eq(cost, 10)
}

///|
test "plan_route reports unreachable goals" {
  let w = @moonbit-pathfinding-demo.Warehouse::parse(["..#..", "..#.."])
  let res = @moonbit-pathfinding-demo.plan_route(w, (0, 0), (0, 4))
  assert_true(res is None)
}

///|
test "render_route draws start, goal and route" {
  let w = @moonbit-pathfinding-demo.Warehouse::parse(["...", ".#.", "..."])
  let res = @moonbit-pathfinding-demo.plan_route(w, (0, 0), (2, 2))
  let (route, cost) = res.unwrap()
  assert_eq(cost, 4)
  let picture = @moonbit-pathfinding-demo.render_route(w, route)
  inspect(
    picture,
    content=(
      #|S..
      #|*#.
      #|**G
    ),
  )
}
