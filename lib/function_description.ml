open! Ctypes
module Types = Types_generated

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  let say_hello =
    foreign "say_hello" (ptr Types.Person.person @-> returning void)
end
