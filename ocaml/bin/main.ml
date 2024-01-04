(* let rec slow_sieve seq () =
    match seq () with
    | Seq.Cons (m, seq) -> Seq.Cons (m, slow_sieve (Seq.filter (fun n -> n mod m > 0) seq))
    | seq -> seq
;;

let slow_sieve =
    let limit = int_of_string(Sys.argv.(1)) in
    let start = Sys.time() in 
    let primes = Seq.ints 2 |> slow_sieve |> Seq.take_while (fun xs -> xs < limit) |> List.of_seq in
    let time = Sys.time() -. start in
    Printf.printf "OCaml Slow    -- Duration: %f -- Count: %d\n" time (List.length primes)
;; *)

type sieve = {
    size : int;
    bits : bool array
}

let create_sieve limit =
    let size = (limit + 1) / 2 in
    {size = size; bits = (Array.init size (fun _ -> true))}
;;

let count_primes sieve =
    sieve.bits |> Array.map Bool.to_int |> Array.fold_left (fun acc x -> acc + x) 0
;;

let rec next_bit sieve idx after = 
    let bit = Array.get sieve.bits idx in
    match bit with
    | true when idx >= after -> idx
    | false -> next_bit sieve (idx + 1) after
    | _ -> idx (* failed to skip *)
;;

let run_sieve sieve =
    let rec _run_sieve factor idx =
    let q =  Float.of_int sieve.size /. 2. |> Float.sqrt |> Float.add 1. in
    (* mark numbers *)
    if idx < sieve.size then (
        Array.set sieve.bits idx false;
        _run_sieve factor (2 * factor + idx + 1)
    )
    (* get next factor *)
    else (
        if float_of_int(factor) <= q then (
            let factor = factor + 1 in
            let factor = next_bit sieve factor factor in
            _run_sieve factor (2 * factor * (factor + 1))
        )
        else (
            sieve
        )
    )
    in
    _run_sieve 1 4
;;

let fast_sieve =
    let limit = int_of_string(Sys.argv.(1)) in
    let start = Sys.time() in
    let sieve = limit |> create_sieve |> run_sieve in
    let time = Sys.time() -. start in
    Printf.printf "OCaml Fast    -- Duration: %f -- Count: %d\n" time (count_primes sieve)
;;

let () =
    (* slow_sieve is too slow *)
    (* slow_sieve; *)
    fast_sieve
;;