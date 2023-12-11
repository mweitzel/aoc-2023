import gleam/io
import gleam/int
import gleam/list
import gleam/string
import gleam/dict
import gleam/iterator
import gleam/result
import simplifile

pub fn main() {
  let assert Ok(a) = simplifile.read("./input")
  io.println(int.to_string(solve1(a)))
}

pub fn solve1(input: String) -> Int {
  let lines = string.split(input, "\n")

  let assert Ok(header) = list.first(lines)
  let lines = list.drop(lines, 1)
  let lines = list.filter(lines, fn(line) -> Bool { string.length(line) > 1 })

  let nodes = iterator.from_list(lines)
  |> iterator.fold(dict.new(), fn(nodes, line) {
    let assert Ok(key) = line
    |> string.split(_, " = ")
    |> list.first

    let assert Ok(vals) = line
    |> string.split(_, " = ")
    |> list.last

    let vals = vals
    |> string.replace(_, "(", "")
    |> string.replace(_, ")", "")
    |> string.replace(_, ",", "")
    |> string.split(_, " ")

    let assert Ok(left) = list.first(vals)
    let assert Ok(right) = list.last(vals)

    nodes
    |> dict.insert(string.join([key,"-L"], ""), left)
    |> dict.insert(string.join([key,"-R"], ""), right)
  })

  let round = Round(0, header, "AAA")

  let final = iterator.unfold(from: round, with: fn(round: Round) {
    case round.current {
      "ZZZ" -> {
        iterator.Done
      }
      _ -> {
        let next_key = access(nodes, round)
        let rounder = next(round, next_key)
        iterator.Next(element: rounder, accumulator: rounder)
      }
    }
  })
  |> iterator.last
  |> result.unwrap(_, Round(-1, "", ""))

  final.counter
}

pub fn access(nodes: dict.Dict(String, String), round: Round) -> String {
  let key = string.join([round.current, "-", lr(round)], "")
  let assert Ok(next) = dict.get(nodes, key)
  next
}

pub opaque type Round {
  Round(counter: Int, lrlr: String, current: String)
}

pub fn next(round: Round, new: String) {
  Round(..round, counter: round.counter + 1, current: new)
}

pub fn lr(round: Round) -> String {
  let lrlr = string.split(round.lrlr, "")
  let assert Ok(idx) = int.modulo(round.counter, list.length(lrlr))
  let assert Ok(lrlr) = list.at(lrlr, idx)
  lrlr
}
