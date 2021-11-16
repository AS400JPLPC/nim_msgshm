
import msgshm


proc main =
  echo "-----------start msgq02-----------"
  var op:bool  = openMsg(Qclient)
  #var op:bool  = openMsg(Qclient,8599)
  echo "openMsg -->", bool(op)
  op = readMsg()
  echo "readMsg -->",bool(op)
  echo "mlen-:",Q_msg.mlen
  echo "mtext >",Q_msg.mtext,"<"



  var P_msg= "poisson"
  op = sndMsg(P_msg)
  echo "sndMsg -->",bool(op)
  echo "-----------end msgq02-----------"


main()