(lang dune 3.11)

(using ctypes 0.3)

(name quirc)

(generate_opam_files true)

(source
 (github nathanfarlow/ocaml-quirc))

(authors "Nathan Farlow")

(maintainers "Nathan Farlow")

(license MIT)

(documentation https://github.com/nathanfarlow/ocaml-quirc)

(package
 (name quirc)
 (synopsis "OCaml bindings for quirc, a QR code decoder library")
 (description "Decode QR codes with OCaml!")
 (depends ocaml dune base ctypes)
 (tags
  (quirc QR decoder reader)))
