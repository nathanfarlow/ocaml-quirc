This library exists to work around a limitation with ctypes which prevents us
from declaring the type of an array whose length is a macro. Now we can do
something like the following elsewhere:

```ocaml
let payload = field t "payload" (array (Int64.to_int Constants.max_payload) uint8_t)
```
