import gleam/yielder
import stdin

pub fn read_lines() -> List(String) {
  stdin.read_lines() |> yielder.to_list
}
