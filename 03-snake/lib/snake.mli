open! Base

type t [@@deriving sexp_of]
(** A [t] represents a snake on the board.

    Note that this interface is immutable, meaning that when we want to change
    something about a [Snake.t], we will need to create a new [Snake.t]. This
    is why functions like [grow_over_next_steps] and [set_direction] return a
    [t] rather than a [unit]. *)

val create : length:int -> t
(** [create] makes a new snake with the given length. The length must be
    positive.

    The snake will initially be occupy the (column, row) locations:
    (0,0), (1,0), (2,0), ..., (length - 1, 0)

    The head will be at position (length - 1, 0) and the initial direction
    should be towards the right. *)

val grow_over_next_steps : t -> int -> t
(** [grow_over_next_steps t n] tells the snake to grow by [n] in length over
    the next [n] steps. *)

val locations : t -> Position.t list
(** [location] returns the current locations that the snake occupies. The first
    element of the list is the head of the snake. We hold as an invariant that
    [locations] is always non-empty. *)

val head_location : t -> Position.t
(** [head_location] returns the location of the snake's head. *)

val set_direction : t -> Direction.t -> t
(** [set_direction] tells the snake to move in a specific direction the next
    time [step] is called. *)

val step : t -> t option
(** [step] moves the snake forward by 1. [step] returns [None] if the snake collided
    with itself. *)
