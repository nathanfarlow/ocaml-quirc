module Image : sig
  type 'a t

  (** Row major, one 'a per pixel *)
  val create : 'a array -> width:int -> height:int -> 'a t

  val get : 'a t -> x:int -> y:int -> 'a
  val set : 'a t -> x:int -> y:int -> 'a -> unit
  val width : 'a t -> int
  val height : 'a t -> int
end

module Point : sig
  type t =
    { x : int
    ; y : int
    }
end

module Code : sig
  type t

  (** The four corners of the QR-code, from top left, clockwise **)
  val corners : t -> Point.t list

  (** 2D array of QR code's pixels. true when black, false when white. Row
      major. *)
  val cell_bitmap : t -> bool Image.t

  (* Various parameters of the QR code *)
  val version : t -> int
  val ecc_level : t -> int
  val mask : t -> int
  val eci : t -> int

  (** Highest valued data type in the QR code *)
  val data_type : t -> int

  (**  Data payload. For the Kanji datatype, payload is encoded as Shift-JIS.
       For all other datatypes, payload is ASCII text. *)
  val payload : t -> string
end

(** Decode a QR code from a grayscale image. Returns a list of all QR codes
    found in the image. *)
val decode : char Image.t -> Code.t list
