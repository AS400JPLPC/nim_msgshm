# nim_msgshm
Single communication area between programs or between threads 

Hello,

the goal is to be able to communicate between two or more programs or between threads.

functions:  
  
msgget  ---> oppen zone communiquation  shared  
  
msgsend ---> send message  
  
msgread ---> get message and len   
  
getNbrMsg -> get number message  
  
  
msgctl  --->  close and delte zone communication  
  
  
example :  
  
msgq01 msgq02  
  
  
api "C"  to connect module nim<br>   
  
respect process type Linux and os400 unix   
  
data len max 1024 *all character  
  
  
For the realization I relied on the documentation: <br>
IBM ZOS
LINUX system development under Linux (Eyrolles)
advanced NIM documentation 


doc : [SOURCE](https://github.com/AS400JPLPC/nim_msgshm/blob/master/exemple/msgq01.nim)

doc : [SOURCE](https://github.com/AS400JPLPC/nim_msgshm/blob/master/exemple/msgq02.nim)
