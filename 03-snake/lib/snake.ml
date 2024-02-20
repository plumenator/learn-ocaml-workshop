open! Base

type t = {
  (* [direction] represents the orientation of the snake's head. *)
  direction : Direction.t;
  (* [extensions_remaining] represents how many more times we should extend the
     snake. *)
  extensions_remaining : int;
  (* [locations] represents the current set of squares that the snake
     occupies. The first element of the list is the head of the snake. We hold
     as an invariant that [locations] is always non-empty. *)
  locations : Position.t list;
}
[@@deriving sexp_of]

(* Implement [create].

   Note that at the beginning of the game, the snake will not need to grow at all, so
   [extensions_remaining] should be initialized to 0. *)
let create ~length =
  {
    direction = Direction.Right;
    extensions_remaining = 0;
    locations =
      List.map
        ~f:(fun x -> { Position.col = x; row = 0 })
        (List.rev (List.range 0 length));
  }

(* Implement [grow_over_next_steps].

   Read over the documentation of this function in the mli.

   Notice that this function should not actually grow the snake, but only record that we
   should grow the snake one block for the next [by_how_much] squares. *)
let grow_over_next_steps t by_how_much =
  { t with extensions_remaining = t.extensions_remaining + by_how_much }

(* Implement [locations]. *)
let locations t = t.locations

(* Implement [head_location]. *)
let head_location t = List.hd_exn t.locations

(* Implement [set_direction]. *)
let set_direction t direction = { t with direction }

(* Implement [step].

   Read over the documentation of this function in the mli.

   [step] should:
   - move the snake forward one block, growing it and updating [t.locations] if necessary
   - check for self collisions *)
let step t =
  let next_head = Direction.next_position t.direction (head_location t) in
  if
    List.exists
      ~f:(fun x -> [%compare.equal: Position.t] next_head x)
      t.locations
  then None
  else if t.extensions_remaining > 0 then
    Some
      {
        t with
        locations = next_head :: t.locations;
        extensions_remaining = t.extensions_remaining - 1;
      }
  else Some { t with locations = next_head :: List.drop_last_exn t.locations }
