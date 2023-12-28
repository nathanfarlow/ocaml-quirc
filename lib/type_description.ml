open! Ctypes

module Types (F : Ctypes.TYPE) = struct
  open! F

  module Quirc = struct
    type t

    let t : t structure typ = structure "quirc"
  end

  module Point = struct
    type t

    let t : t structure typ = structure "quirc_point"
    let x = field t "x" int
    let y = field t "y" int
    let () = seal t
  end

  module Decode_error = struct
    type t =
      | Success
      | Error_invalid_grid_size
      | Error_invalid_version
      | Error_format_ecc
      | Error_data_ecc
      | Error_unknown_data_type
      | Error_data_overflow
      | Error_data_underflow

    let success = constant "QUIRC_SUCCESS" int64_t

    let error_invalid_grid_size =
      constant "QUIRC_ERROR_INVALID_GRID_SIZE" int64_t

    let error_invalid_version = constant "QUIRC_ERROR_INVALID_VERSION" int64_t
    let error_format_ecc = constant "QUIRC_ERROR_FORMAT_ECC" int64_t
    let error_data_ecc = constant "QUIRC_ERROR_DATA_ECC" int64_t

    let error_unknown_data_type =
      constant "QUIRC_ERROR_UNKNOWN_DATA_TYPE" int64_t

    let error_data_overflow = constant "QUIRC_ERROR_DATA_OVERFLOW" int64_t
    let error_data_underflow = constant "QUIRC_ERROR_DATA_UNDERFLOW" int64_t

    let t : t typ =
      enum "quirc_decode_error_t" ~typedef:true
        [
          (Success, success);
          (Error_invalid_grid_size, error_invalid_grid_size);
          (Error_invalid_version, error_invalid_version);
          (Error_format_ecc, error_format_ecc);
          (Error_data_ecc, error_data_ecc);
          (Error_unknown_data_type, error_unknown_data_type);
          (Error_data_overflow, error_data_overflow);
          (Error_data_underflow, error_data_underflow);
        ]
  end

  module Code = struct
    type t

    let t : t structure typ = structure "quirc_code"
    let corners = field t "corners" (array 4 Point.t)
    let size = field t "size" int

    let cell_bitmap =
      field t "cell_bitmap" (array (Int64.to_int Constants.max_bitmap) uint8_t)

    let () = seal t
  end

  module Data = struct
    type t

    let t : t structure typ = structure "quirc_data"
    let version = field t "version" int
    let ecc_level = field t "ecc_level" int
    let mask = field t "mask" int
    let data_type = field t "data_type" int

    let payload =
      field t "payload" (array (Int64.to_int Constants.max_payload) uint8_t)

    let payload_len = field t "payload_len" int
    let eci = field t "eci" uint32_t
    let () = seal t
  end
end
