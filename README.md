# nim_msgshm
Single communication area between programs or between threads 

Hello,

the goal is to be able to communicate between two or more programs or between threads.

functions:  
  
msgget  ---> opening shared communication area   
  
msgsend ---> send message  
  
msgread ---> get message and len   
  
getNbrMsg -> get number message  
  
  
msgctl  --->  close and delete zone communication  
  
doc : [MSGSHM](http://htmlpreview.github.io/?https://github.com/AS400JPLPC/nim_msgshm/blob/master/htmldocs/msgshm.html)
  
example :  
  
msgq01 msgq02  
  
  
api "C"  to connect module nim<br>   
  
respect process type Linux and os400 unix   
  
data len max 1024 *all character  
  
  
For the realization I relied on the documentation: 

IBM ZOS 

LINUX system development under Linux (Eyrolles) 

advanced NIM documentation  


doc : [SOURCE](https://github.com/AS400JPLPC/nim_msgshm/blob/master/exemple/msgq01.nim)

doc : [SOURCE](https://github.com/AS400JPLPC/nim_msgshm/blob/master/exemple/msgq02.nim)


message :)

Suddenly, if I understood correctly, it is network communication on the local loop between threads within the same process, 

so that it is practical, simple to implement and quite flexible.

=> There is no limitation of signals under linux (signals already dedicated or not very customizable)

=> no need to configure and implement (and therefore maintain) a message bus system.

=> The message mechanism leaves flexibility, with a limitation of 1024 characters but which precisely 

allows not to have messages that would contain huge clusters of data 

(it is not made for, by design, which de facto maintains the performance ) 
