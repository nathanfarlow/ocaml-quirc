module Image : sig
  type t

  (** Create a new image with grayscale pixels (0-255). One char per pixel. Row
      major. *)
  val create : char array -> width:int -> height:int -> t
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
  val cell_bitmap : t -> bool array array

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

(** Decode a QR code from an image. Returns a list of all QR codes found in the image. *)
val decode : Image.t -> Code.t list
