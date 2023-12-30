This library exists to work around a limitation with ctypes which prevents us
from declaring the type of an array whose length is a named constant. In other
words we want to represent `uint8_t payload[QUIRC_MAX_PAYLOAD];` in
quirc/lib/quirc.h. Now we can do

In lib/type_description.ml:

```ocaml
let payload = field t "payload" (array (Int64.to_int Constants.max_payload) uint8_t)
```
