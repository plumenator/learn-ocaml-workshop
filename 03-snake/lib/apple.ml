open! Base

type t = { location : Position.t } [@@deriving sexp_of]

let location t = t.location

let rec up_to answer combine x =
  match x with 0 -> answer | _ -> combine x (up_to answer combine (x - 1))

(* Implement [create].

   Make sure to inspect the mli to understand the signature of[create]. [create]
   will take in the height and width of the board area, as well as a list of
   locations where the apple cannot be generated, and create a [t] with a random
   location on the board.

   Hint:
   - You can generate a random int up to [bound] via [Random.int bound].
   - You can pick a random element out of a list using [List.random_element_exn list].
*)
let create ~height ~width ~invalid_locations =
  let all_locations =
    up_to []
      (fun r ps ->
        List.map
          (up_to [] (fun c cs -> c :: cs) (width - 1))
          ~f:(fun c -> { Position.col = c; row = r })
        @ ps)
      (height - 1)
  in
  let valid_locations =
    List.filter
      ~f:(fun x ->
        List.for_all
          ~f:(fun y -> not ([%compare.equal: Position.t] y x))
          invalid_locations)
      all_locations
  in
  if List.is_empty valid_locations then None
  else Some { location = List.random_element_exn valid_locations }
