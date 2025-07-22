import gleam/int
import gleam/list
import gleam/string
import gleam/yielder
import stdin

pub fn read_input() -> List(String) {
  stdin.read_lines() |> yielder.to_list |> list.map(string.trim)
}

pub fn str_to_int(str: String) -> Int {
  case int.parse(str) {
    Ok(n) -> n
    Error(_) -> panic as { "Expected number but got: " <> str }
  }
}

pub fn to_int_list(lst: List(String)) -> List(Int) {
  lst |> list.map(str_to_int)
}

pub fn get_ok(r: Result(ok, err)) -> ok {
  case r {
    Ok(ok) -> ok
    Error(_) -> panic as "Expected ok"
  }
}
