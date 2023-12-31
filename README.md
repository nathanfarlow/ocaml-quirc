# ocaml-quirc

OCaml bindings for [quirc](https://github.com/dlbeer/quirc). Now you can extract and decode QR codes in OCaml 🐪

## Usage
See [lib/quirc.mli](lib/quirc.mli) for the API

It's not on opam atm, but you can use it in your projects with `opam pin add https://github.com/nathanfarlow/ocaml-quirc` and add `quirc` to your `libraries` stanza in your `dune` file.

See [example/example.ml](example/example.ml) for an example. To run the example:

```bash
git clone --recurse-submodules https://github.com/nathanfarlow/ocaml-quirc.git
cd ocaml-quirc
dune build && dune exec example/example.exe example/hello.pgm
```
