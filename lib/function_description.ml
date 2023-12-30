open Ctypes
module Types = Types_generated

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  let version = foreign "quirc_version" (void @-> returning string)
  let new_ = foreign "quirc_new" (void @-> returning (ptr_opt Types.Quirc.t))
  let destroy = foreign "quirc_destroy" (ptr Types.Quirc.t @-> returning void)
  let resize = foreign "quirc_resize" (ptr Types.Quirc.t @-> int @-> int @-> returning int)

  let begin_ =
    foreign
      "quirc_begin"
      (ptr Types.Quirc.t @-> ptr int @-> ptr int @-> returning (ptr uint8_t))
  ;;

  let end_ = foreign "quirc_end" (ptr Types.Quirc.t @-> returning void)
  let strerror = foreign "quirc_strerror" (Types.Decode_error.t @-> returning string)
  let count = foreign "quirc_count" (ptr Types.Quirc.t @-> returning int)

  let extract =
    foreign
      "quirc_extract"
      (ptr Types.Quirc.t @-> int @-> ptr Types.Code.t @-> returning void)
  ;;

  let decode =
    foreign
      "quirc_decode"
      (ptr Types.Code.t @-> ptr Types.Data.t @-> returning Types.Decode_error.t)
  ;;

  let quirc_flip = foreign "quirc_flip" (ptr Types.Code.t @-> returning void)
end
