open Base
open Ctypes
module T = C.Types
module F = C.Functions

module Image : sig
  type t = int array array

  val create : int array array -> t
end = struct
  type t = int array array

  let assert_valid t =
    assert (Array.length t > 0);
    let width = Array.length t.(0) in
    Array.iter t ~f:(fun row ->
        assert (Array.length row = width);
        Array.iter row ~f:(fun pixel -> assert (pixel >= 0 && pixel <= 255)))

  let create t =
    assert_valid t;
    t
end

module Point = struct
  type t = { x : int; y : int }
end

module Code = struct
  type t = {
    corners : Point.t list;
    cell_bitmap : bool array array;
    version : int;
    ecc_level : int;
    mask : int;
    data_type : int;
    payload : string;
    eci : int;
  }

  let corners t = t.corners
  let cell_bitmap t = t.cell_bitmap
  let version t = t.version
  let ecc_level t = t.ecc_level
  let mask t = t.mask
  let data_type t = t.data_type
  let payload t = t.payload
  let eci t = t.eci

  let of_c code data =
    let corners =
      getf code T.Code.corners |> CArray.to_list
      |> List.map ~f:(fun p ->
             { Point.x = getf p T.Point.x; Point.y = getf p T.Point.y })
    in
    let cell_bitmap =
      let size = getf code T.Code.size in
      let cell_bitmap = Array.make_matrix ~dimx:size ~dimy:size false in
      let pixels = getf code T.Code.cell_bitmap in
      for y = 0 to size - 1 do
        for x = 0 to size - 1 do
          let i = (y * size) + x in
          let is_black =
            CArray.get pixels (i lsr 3)
            |> Unsigned.UInt8.to_int
            |> ( land ) (1 lsl (i land 7))
            |> ( <> ) 0
          in
          cell_bitmap.(y).(x) <- is_black
        done
      done;
      cell_bitmap
    in

    let version = getf data T.Data.version in
    let ecc_level = getf data T.Data.ecc_level in
    let mask = getf data T.Data.mask in
    let data_type = getf data T.Data.data_type in
    let eci = getf data T.Data.eci |> Unsigned.UInt32.to_int in

    let payload =
      let payload = getf data T.Data.payload in
      let payload_len = getf data T.Data.payload_len in
      List.take (CArray.to_list payload) payload_len
      |> List.map ~f:Unsigned.UInt8.to_string
      |> String.concat
    in
    { corners; cell_bitmap; version; ecc_level; mask; data_type; payload; eci }
end

let decode image =
  let qr = F.new_ () |> Option.value_exn in

  let width = Array.length image.(0) in
  let height = Array.length image in
  assert (F.resize qr width height = 0);

  let _width = allocate int 0 in
  let _height = allocate int 0 in

  let image_buffer = F.begin_ qr _width _height in
  assert (!@_width = width && !@_height = height);
  Array.iteri image ~f:(fun y row ->
      Array.iteri row ~f:(fun x value ->
          let offset = (y * width) + x in
          let _ = image_buffer +@ offset <-@ Unsigned.UInt8.of_int value in
          ()));
  F.end_ qr;

  let num_codes = F.count qr in
  let codes =
    List.init num_codes ~f:(fun i ->
        let code = allocate_n T.Code.t ~count:1 in
        let data = allocate_n T.Data.t ~count:1 in
        F.extract qr i code;
        F.decode code data |> function
        | Success -> Some (Code.of_c !@code !@data)
        | _ -> None)
    |> List.filter_opt
  in

  F.destroy qr;
  codes
