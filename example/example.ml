open Core

(* You can probably use imagelib or something irl *)
let parse_pgm s =
  let open Angstrom in
  let whitespace = skip_while Char.is_whitespace in
  let comment = char '#' *> skip_while (Char.( <> ) '\n') in
  let lex p = p <* whitespace <* option () comment <* whitespace in
  let integer = take_while1 Char.is_digit >>| Int.of_string in
  let header =
    lift4
      (fun _ width height max_val -> width, height, max_val)
      (lex (string "P2"))
      (lex integer)
      (lex integer)
      (lex integer)
  in
  let pixels = many (lex integer >>| Float.of_int) in
  let pgm =
    header
    >>= fun (width, height, max_val) ->
    pixels
    >>= fun pixels ->
    let pixels =
      List.map pixels ~f:(fun x ->
        Float.(iround_exn (x /. of_int max_val *. 255.) |> Char.of_int_exn))
      |> Array.of_list
    in
    return (Quirc.Image.create pixels ~width ~height)
  in
  parse_string ~consume:All pgm s
;;

let () =
  Command_unix.run
  @@ Command.basic
       ~summary:"Decode QR codes in a PGM image"
       (let%map_open.Command image = anon ("image.pgm" %: string) in
        fun () ->
          In_channel.read_all image
          |> parse_pgm
          |> Result.ok_or_failwith
          |> Quirc.decode
          |> List.map ~f:Quirc.Code.payload
          |> List.iter ~f:print_endline)
;;
