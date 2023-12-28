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

  module Const = struct
    let max_version = constant "QUIRC_MAX_VERSION" int64_t
    let max_grid_size = constant "QUIRC_MAX_GRID_SIZE" int64_t
    let max_bitmap = constant "QUIRC_MAX_BITMAP" int64_t
    let max_payload = constant "QUIRC_MAX_PAYLOAD" int64_t
    let ecc_level_m = constant "QUIRC_ECC_LEVEL_M" int64_t
    let ecc_level_l = constant "QUIRC_ECC_LEVEL_L" int64_t
    let ecc_level_h = constant "QUIRC_ECC_LEVEL_H" int64_t
    let ecc_level_q = constant "QUIRC_ECC_LEVEL_Q" int64_t
    let data_type_numeric = constant "QUIRC_DATA_TYPE_NUMERIC" int64_t
    let data_type_alpha = constant "QUIRC_DATA_TYPE_ALPHA" int64_t
    let data_type_byte = constant "QUIRC_DATA_TYPE_BYTE" int64_t
    let data_type_kanji = constant "QUIRC_DATA_TYPE_KANJI" int64_t
    let eci_iso_8859_1 = constant "QUIRC_ECI_ISO_8859_1" int64_t
    let eci_ibm437 = constant "QUIRC_ECI_IBM437" int64_t
    let eci_iso_8859_2 = constant "QUIRC_ECI_ISO_8859_2" int64_t
    let eci_iso_8859_3 = constant "QUIRC_ECI_ISO_8859_3" int64_t
    let eci_iso_8859_4 = constant "QUIRC_ECI_ISO_8859_4" int64_t
    let eci_iso_8859_5 = constant "QUIRC_ECI_ISO_8859_5" int64_t
    let eci_iso_8859_6 = constant "QUIRC_ECI_ISO_8859_6" int64_t
    let eci_iso_8859_7 = constant "QUIRC_ECI_ISO_8859_7" int64_t
    let eci_iso_8859_8 = constant "QUIRC_ECI_ISO_8859_8" int64_t
    let eci_iso_8859_9 = constant "QUIRC_ECI_ISO_8859_9" int64_t
    let eci_windows_874 = constant "QUIRC_ECI_WINDOWS_874" int64_t
    let eci_iso_8859_13 = constant "QUIRC_ECI_ISO_8859_13" int64_t
    let eci_iso_8859_15 = constant "QUIRC_ECI_ISO_8859_15" int64_t
    let eci_shift_jis = constant "QUIRC_ECI_SHIFT_JIS" int64_t
    let eci_utf_8 = constant "QUIRC_ECI_UTF_8" int64_t
  end

  module Data = struct
    type t

    let t : t structure typ = structure "quirc_data"
    let version = field t "version" int
    let ecc_level = field t "ecc_level" int
    let mask = field t "mask" int
    let data_type = field t "data_type" int

    (* This should be QUIRC_MAX_PAYLOAD, but I can't encode that with ctypes.
       Extremely sad :( *)
    let payload = field t "payload" (array 8896 uint8_t)
    let payload_len = field t "payload_len" int
    let eci = field t "eci" uint32_t
    let () = seal t
  end
end
