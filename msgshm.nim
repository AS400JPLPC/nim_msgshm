import std/unicode
const cHeader = currentSourcePath().substr(0, high(currentSourcePath()) - 4) & "/msgshm.c"
{.compile: cHeader.}

const MSGTXTLEN = 1024

const Qclient* : cint = 1
const Qserveur* : cint = 0

type
  msg_buf* = object
    mlen*: int
    mtext*: string
# https://www.ibm.com/docs/en/i/7.4?topic=ssw_ibm_i_74/apis/ipcmsgct.htm
# ref https://man7.org/linux/man-pages/man2/msgctl.2.html
  msg_stat* = object
    msg_qnum*: int

var Q_msg* : msg_buf
var Qstat* : msg_stat

proc openqMsg(P_maitre: cint ; P_id : cint): cint {.importc:"openqMsg".}
proc sndqMsg(P_vmsg: cstring): cint {.importc:"sndqMsg".}
proc readqMsg(bufMsg: cstring): cint {.importc:"readqMsg".}
proc ctlqMsg(): cint {.importc:"ctlqMsg".}

## / ouverture de la communication type UDS
proc openMsg*(P_maitrex: cint; P_npid : cint = 0): bool=
  result =bool(openqMsg(P_maitrex,P_npid))

## / send message
proc sndMsg*(P_vmsgx: string): bool=
  result =bool(sndqMsg(cstring(P_vmsgx)))

## / read message

proc readMsg*():bool =
  var qmsg  = newString(MSGTXTLEN)
  Q_msg.mtext = ""
  Q_msg.mlen = readqMsg(qmsg.cstring)

  if Q_msg.mlen == -1 :
    Q_msg.mtext = ""
    return true
  else:
    for i in 0..int(MSGTXTLEN) :
      if qmsg[i] == char(0x00) : break
      Q_msg.mtext &= qmsg[i]

    Q_msg.mlen =  runelen(Q_msg.mtext)
    return false


## / get number message

proc getNbrMsg*():bool =
  Q_stat.msg_qnum = ctlqMsg()
  if Q_stat.msg_qnum == -1 :
    Q_stat.msg_qnum = 0
    return true
  else :
    return false


## / delete msgq

proc dltMsg*(): cint {. importc: "dltqMsg"}