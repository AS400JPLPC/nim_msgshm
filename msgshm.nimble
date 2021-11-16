# Package
packageName   = "msgshm"
version       = "0.1.1"
author        = "msgshm communication ram AS400JPLPC"
description   = "message queu ram"
license       = "(MIT or Apache License 2.0) and Simplified BSD"

# Dependencies

requires "nim >= 1.2"


task docs, "generate doc":
    exec "nim doc2 -o:docs/websi.html msgshm.nim"


