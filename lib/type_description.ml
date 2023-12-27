open! Ctypes

module Types (F : Ctypes.TYPE) = struct
  open F

  module Person = struct
    type t

    let person : t structure typ = structure "Person"
    let name = field person "name" string
    let age = field person "age" int
    let () = seal person
  end
end
