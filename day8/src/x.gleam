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
  //io.println(int.to_string(solve1(a)))

  io.debug(
    solve2(a)
  )
}

pub fn solve1(input: String) -> Int {
  let lines = string.split(input, "\n")

  let assert Ok(header) = list.first(lines)
  let lines = list.drop(lines, 1)
  let lines = list.filter(lines, fn(line) -> Bool { string.length(line) > 1 })

  let nodes = prepare_dict(lines)
  let round = Round(0, header, "AAA")

  solve_round(nodes, round)
}

pub fn solve2(input: String) -> Int {
  let lines = string.split(input, "\n")

  let assert Ok(header) = list.first(lines)
  let lines = list.drop(lines, 1)
  let lines = list.filter(lines, fn(line) -> Bool { string.length(line) > 1 })

  let nodes = prepare_dict(lines)

  let rounds = lines
  |> iterator.from_list
  |> iterator.map(fn(line: String) -> String {
    let assert Ok(key) = line
    |> string.split(_, " = ")
    |> list.first
    key
  })
  |> iterator.map(fn(key: String) -> Round { Round(0, header, key) })
  |> iterator.filter(fn(round: Round) -> Bool {
      case current_nth_letter(round, 2) {
        "A" -> { True }
        _ -> { False }
      }
    })
  |> iterator.to_list

  let solutions = rounds
  |> iterator.from_list
  |> iterator.map(solve_round(nodes, _))
  |> iterator.to_list

  find_lcm(solutions)
}

fn find_lcm(nums: List(Int)) -> Int {
  nums
  |> iterator.from_list
  |> iterator.map(fn(a: Int) -> List(Int) {
    prime_factors(a)
  })
  |> iterator.to_list
  |> io.debug

  io.println("^^^ these are prime factors, LCM is the highest of each power multiplied together")
  io.println("I noticed in my dataset there were no sets like [2,2,3] and [2,3,3]")
  io.println("Only sets like [3,19],[5,19], so I skipped the programming challenge to filter")
  io.println("Instead I just multilied the uniq primes together and submitted.")

  -1
}

type Carry {
  Carry(to_factor: Int, factors: List(Int), check_next: Int)
}

fn prime_factors(to_factor: Int) -> List(Int) {
  let factors = iterator.unfold(from: Carry(to_factor, [], 2), with: fn(c) {
    case c.to_factor {
      1 -> {
        iterator.Done
      }
      _ -> {
        let remainder = c.to_factor % c.check_next
        case remainder {
          0 -> {
            // do stuff

            let to_factor = c.to_factor / c.check_next
            let out = Carry(to_factor, list.append(c.factors, [c.check_next]), c.check_next)
            iterator.Next(element: out, accumulator: out)
          }
          _ -> {
            let out = Carry(c.to_factor, c.factors, c.check_next + 1)
            iterator.Next(element: out, accumulator: out)
          }
        }
      }
    }
  })
  |> iterator.last
  |> result.unwrap(_, Carry(-1, [-1], -1))

  factors.factors
}

fn prepare_dict(lines: List(String)) -> dict.Dict(String, String) {
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
  nodes
}

fn current_nth_letter(round: Round, n: Int) -> String {
  let assert Ok(last_letter) = list.at(string.split(round.current, ""), n)
  last_letter
}

fn solve_round(nodes: dict.Dict(String, String), round: Round) -> Int {
  let final = iterator.unfold(from: round, with: fn(round: Round) {
    let potentially_z = current_nth_letter(round, 2)

    case potentially_z {
      "Z" -> {
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

fn access(nodes: dict.Dict(String, String), round: Round) -> String {
  let key = string.join([round.current, "-", lr(round)], "")
  let assert Ok(next) = dict.get(nodes, key)
  next
}

type Round {
  Round(counter: Int, lrlr: String, current: String)
}

fn next(round: Round, new: String) {
  Round(..round, counter: round.counter + 1, current: new)
}

fn lr(round: Round) -> String {
  let lrlr = string.split(round.lrlr, "")
  let assert Ok(idx) = int.modulo(round.counter, list.length(lrlr))
  let assert Ok(lrlr) = list.at(lrlr, idx)
  lrlr
}
