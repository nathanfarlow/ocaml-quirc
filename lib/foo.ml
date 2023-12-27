open! Ctypes

(* The way this works is you define the types (structs/unions) and constants in
   type_description.ml. You define the functions in type_description.ml. Then
   you can access these things in a module named "C". These module names aren't
   hardcoded -- you can change all of them in dune. *)

let make_person ~name ~age =
  let person = make C.Types.Person.person in
  setf person C.Types.Person.name name;
  setf person C.Types.Person.age age;
  person

let go () =
  let santa = make_person ~name:"Santa" ~age:100 in
  C.Functions.say_hello (addr santa)
