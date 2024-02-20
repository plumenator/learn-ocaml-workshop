open! Base
open! Position

type t = Left | Up | Right | Down [@@deriving sexp_of]

(* Implement [next_position].

   Make sure to take a look at the signature of this function to understand what it does.
   Recall that the origin of the board is in the lower left hand corner. *)
let next_position t position =
  match t with
  | Left -> { position with col = position.col - 1 }
  | Up -> { position with row = position.row + 1 }
  | Right -> { position with col = position.col + 1 }
  | Down -> { position with row = position.row - 1 }
