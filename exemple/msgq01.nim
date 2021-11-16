import std/osproc
import msgshm

proc main =
  echo "-----------start msgq01-----------"
  var op :bool = openMsg(Qserveur)
  #var op :bool = openMsg(Qserveur,8599)
  echo "openMsg -->",op
  var P_msg= "la pêche"

  op = sndMsg(P_msg)
  echo "sndMsg -->",op

  op = getNbrMsg()
  echo "getNbrMsg() -->",op
  echo "msg_qnum-:",Q_stat.msg_qnum


  discard execCmd("./msgq02")

  op = readMsg()
  echo "readMsg -->",op
  echo "mlen-:",Q_msg.mlen
  echo "mtext >",Q_msg.mtext,"<"


  #exemple
  discard sndMsg("msg-01")
  discard sndMsg("msg-02")
  discard sndMsg("msg-03")
  op = getNbrMsg()
  echo "getNbrMsg() -->",op
  echo "msg_qnum-:",Q_stat.msg_qnum

  while  Q_stat.msg_qnum > 0 :
    discard readMsg()
    echo "mtext >",Q_msg.mtext,"<"
    discard getNbrMsg()


  discard dltMsg()
  echo "-----------end msgq01-----------"

main()