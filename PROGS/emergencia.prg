
SET DELETED ON
SET DATE BRITISH

SET DEFAULT TO f:\ventas
SET PATH TO DATA,PROGS,FORMULARIOS,INFORMES
SET PROCEDURE TO FUNCIONES

*** igualar amarres de Mysql en data de productos dbf*********

Mystring = "DRIVER={MySQL ODBC 3.51 Driver};" + ;
                    "SERVER=192.168.1.79;" + ;
                    "PORT=3306;" + ;
                    "UID=sistemas;" + ;
                    "PWD=informatica;" + ;
                    "DATABASE=sqmdata;" + ;
                    "OPTIONS=0;"

Local Myfecday,Myfec1
*Myfecday=thisform.text1.Value
Myfec1=CTOD('27-09-2012')
*MysecureDay=Myfecday-3


lnHandle = SQLSTRINGCONNECT(Mystring)
IF lnHandle > 0      
   *cmd2=SQLEXEC(lnHandle,"SELECT a.producto,b.nombre,a.tipodoc,a.numero,a.cliente,a.precio,a.moneda,a.ingreso,a.salida,"+;
                         " a.saldo,a.historial2,a.origen FROM kardex a,productos b WHERE a.producto=b.codigo and a.fecha=?MyFec1 "+;
                         " ORDER by a.producto,a.id ","MyVentaDayA")
                         
    cmd2=SQLEXEC(lnHandle,"SELECT a.*,b.nombre from Kardex a ,productos b WHERE "+;
                          " a.producto=b.codigo and a.fecha>=?MYfec1","xxcv") 
                          
   SQLDISCONNECT(lnHandle)
ELSE
    AERROR(laErr)
     MESSAGEBOX("No se pudo conectar a mySQL. Error: " + CHR(13) + laErr[2])
ENDIF

BROWSE 
