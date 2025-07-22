import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

type Stats {
  Stats(zeros: Int, ones: Int)
}

fn split(str: String) -> List(Int) {
  string.split(str, on: "")
  |> list.map(utils.str_to_int)
}

fn calc_stats(input: List(String), n: Int) -> Stats {
  list.fold(input, Stats(0, 0), fn(stats, str) {
    case string.slice(from: str, at_index: n, length: 1) {
      "0" -> Stats(stats.zeros + 1, stats.ones)
      "1" -> Stats(stats.zeros, stats.ones + 1)
      x -> panic as { "Unknown " <> x }
    }
  })
}

fn filter(input: List(String), n: Int, v: String) -> List(String) {
  list.filter(input, fn(str) { string.slice(str, n, 1) == v })
}

fn most_common(stats: Stats) -> String {
  case stats.zeros > stats.ones {
    True -> "0"
    False -> "1"
  }
}

fn least_common(stats: Stats) -> String {
  case stats.zeros <= stats.ones {
    True -> "0"
    False -> "1"
  }
}

fn find(input: List(String), n: Int, func) -> String {
  case list.length(input) {
    1 -> list.first(input) |> result.unwrap("")
    _ -> {
      let stats = calc_stats(input, n)
      let v = func(stats)
      find(filter(input, n, v), n + 1, func)
    }
  }
}

fn merge(acc: List(Stats), str: String) -> List(Stats) {
  list.map2(acc, split(str), fn(a, b) {
    case b {
      0 -> Stats(a.zeros + 1, a.ones)
      1 -> Stats(a.zeros, a.ones + 1)
      _ -> panic as "Error"
    }
  })
}

pub fn solve() -> Nil {
  let input = utils.read_input()

  let stats =
    input
    |> list.fold(list.repeat(Stats(0, 0), 20), merge)

  let gamma =
    list.fold(stats, "", fn(a, stats) {
      case most_common(stats) {
        "0" -> a <> "0"
        "1" -> a <> "1"
        v -> panic as { "Unexpected: " <> v }
      }
    })
    |> int.base_parse(2)
    |> utils.get_ok

  let epsilon =
    list.fold(stats, "", fn(a, stats) {
      case least_common(stats) {
        "0" -> a <> "0"
        "1" -> a <> "1"
        v -> panic as { "Unexpected: " <> v }
      }
    })
    |> int.base_parse(2)
    |> utils.get_ok

  let n1 = gamma * epsilon

  let oxygen = find(input, 0, most_common) |> int.base_parse(2) |> utils.get_ok
  let co2 = find(input, 0, least_common) |> int.base_parse(2) |> utils.get_ok

  let n2 = oxygen * co2

  io.println("Solution 1: " <> int.to_string(n1))
  io.println("Solution 2: " <> int.to_string(n2))
}
