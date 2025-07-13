import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils

fn to_int_list(lst: List(String)) -> List(Int) {
  list.map(lst, fn(x) {
    case int.parse(string.trim(x)) {
      Ok(v) -> v
      Error(_) -> panic as { "Unexpected: " <> x }
    }
  })
}

fn sum_ints(lst: List(Int)) -> Int {
  list.fold(lst, 0, fn(a, b) { a + b })
}

pub fn solve() -> Nil {
  let input =
    utils.read_lines()
    |> to_int_list

  let n1 =
    input
    |> list.window_by_2()
    |> list.count(fn(x) { x.1 > x.0 })

  let n2 =
    input
    |> list.window(3)
    |> list.map(fn(x) { sum_ints(x) })
    |> list.window_by_2()
    |> list.count(fn(x) { x.1 > x.0 })

  io.println("Solution 1: " <> int.to_string(n1))
  io.println("Solution 2: " <> int.to_string(n2))
}
