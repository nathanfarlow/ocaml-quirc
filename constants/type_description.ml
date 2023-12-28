open! Ctypes

module Types (F : Ctypes.TYPE) = struct
  open F

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
