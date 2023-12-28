open! Ctypes
module Types = Types_generated

module Functions (F : Ctypes.FOREIGN) = struct
  open! F

  let quirc_version = foreign "quirc_version" (void @-> returning string)
  let quirc_new = foreign "quirc_new" (void @-> returning (ptr Types.Quirc.t))

  let quirc_destroy =
    foreign "quirc_destroy" (ptr Types.Quirc.t @-> returning void)

  let quirc_resize =
    foreign "quirc_resize" (ptr Types.Quirc.t @-> int @-> int @-> returning int)

  let quirc_begin =
    foreign "quirc_begin"
      (ptr Types.Quirc.t @-> ptr int @-> ptr int @-> returning (ptr uint8_t))

  let quirc_end = foreign "quirc_end" (ptr Types.Quirc.t @-> returning void)

  let quirc_strerror =
    foreign "quirc_strerror" (Types.Decode_error.t @-> returning string)

  let quirc_count = foreign "quirc_count" (ptr Types.Quirc.t @-> returning int)

  let quirc_extract =
    foreign "quirc_extract"
      (ptr Types.Quirc.t @-> int @-> ptr Types.Code.t @-> returning void)

  let quirc_decode =
    foreign "quirc_decode"
      (ptr Types.Code.t @-> ptr Types.Data.t @-> returning Types.Decode_error.t)

  let quirc_flip = foreign "quirc_flip" (ptr Types.Code.t @-> returning void)
end
