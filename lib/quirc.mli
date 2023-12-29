module Image : sig
  type t

  val create : int array array -> t
  (** Create a new image with a 2D array of grayscale pixels (0-255). Row
      major. *)
end

module Point : sig
  type t = { x : int; y : int }
end

module Code : sig
  type t

  val corners : t -> Point.t list
  (** The four corners of the QR-code, from top left, clockwise **)

  val cell_bitmap : t -> bool array array
  (** 2D array which represents the QR-code. Row major. *)

  (* Various parameters of the QR code *)
  val version : t -> int
  val ecc_level : t -> int
  val mask : t -> int

  val data_type : t -> int
  (** Highest valued data type in the QR code *)

  val payload : t -> string
  (**	 Data payload. For the Kanji datatype, payload is encoded as Shift-JIS.
       For all other datatypes, payload is ASCII text. *)

  val eci : t -> int
  (** ECI assignment number *)
end

val decode : Image.t -> Code.t list
(** Decode a QR code from an image. Returns a list of all QR codes found in the image. *)
