import argv
import day01
import gleam/io

pub fn main() -> Nil {
  let args = argv.load().arguments

  case args {
    [] -> io.println("Usage: ./prog <day>")
    ["1"] -> day01.solve()
    _ -> io.println("Error")
  }
}
