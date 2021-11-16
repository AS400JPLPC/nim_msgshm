#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/ipc.h>
#include<sys/msg.h>
#include<sys/wait.h>
#include<sys/stat.h>
#include<stdbool.h>
#include<sys/times.h>

#define MSGPERM 0600    // msg queue permission
#define MSGTXTLEN 1024  // msg text length 1024
#define Qclient 1
#define Qserveur 0


char * P_msgqid;
char * P_msg;
bool   P_init = false ;


struct msg_buf {
  long mtype;
  char mtext[MSGTXTLEN];
} Q_msg;

struct msqid_ds Q_stat;


/// ouverture de la communication type UDS
int openqMsg(int P_maitre, int P_id)
{ int msgqid = 0;

 if (P_init == false) {
	P_msgqid = (char*) malloc(11);
	P_msg    = (char*) malloc(MSGTXTLEN);
	if (P_maitre == Qserveur )  {
    if (P_id == 0) msgqid = msgget(getpid(), MSGPERM|IPC_CREAT|IPC_EXCL|S_IROTH|S_IWOTH);
    else msgqid = msgget(P_id, MSGPERM|IPC_CREAT|IPC_EXCL|S_IROTH|S_IWOTH);
  }
	else {
    if (P_id == 0) msgqid = msgget(getppid(), IPC_CREAT );
    else msgqid = msgget(P_id, IPC_CREAT );
  }
	if (msgqid > -1 )  P_init = true ;
 }
  if (msgqid < 0) return -1;
   sprintf(P_msgqid ,"%010d",msgqid) ;
  return 0 ;
}


/// send message
int sndqMsg(const char* vmsg )
{
  if (P_init == false) return -1;
  int  msgqid =  atoi(P_msgqid) ; /// envoie message
   Q_msg.mtype = 1;
  sprintf(Q_msg.mtext,"%s", vmsg);

  int rc = msgsnd(msgqid, &Q_msg, sizeof(Q_msg.mtext), IPC_NOWAIT);
  if (rc < 0) return -1;
  return 0 ;
}

/// read message
int readqMsg(char *bufMsg)
{
  if (P_init == false) return -1;
  int msgqid =  atoi(P_msgqid) ; /// recupération message
  int rc = msgrcv(msgqid, &Q_msg, sizeof(Q_msg.mtext), 0, IPC_NOWAIT);
  if (rc < 0) return -1;
  //sprintf(bufMsg,"%s", (char *)Q_msg.mtext);
  strcpy(bufMsg, (char *)Q_msg.mtext);

  return 0 ;
}

/// ctl number  message
int ctlqMsg()
{
  if (P_init == false) return -1;
  int msgqid =  atoi(P_msgqid) ; /// controle lenombre  messages
  int rc = msgctl(msgqid, IPC_STAT, &Q_stat);
  // printf( "msg_qnum = %d\n",     Q_stat.msg_qnum);
  if (rc < 0) return -1;
  return Q_stat.msg_qnum ;
}


/// delete msgq
int dltqMsg()
{
  if (P_init == false) return -1;
  int msgqid =  atoi(P_msgqid) ; /// close file d'attente de message et delete
  int rc = msgctl(msgqid,IPC_RMID,NULL);
  if (rc < 0) return -1;
  return 0 ;
}