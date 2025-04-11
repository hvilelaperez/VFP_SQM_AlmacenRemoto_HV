
SET DELETED ON
SET DATE BRITISH

SET DEFAULT TO f:\ventas
SET PATH TO DATA,PROGS,FORMULARIOS,INFORMES
SET PROCEDURE TO FUNCIONES


Mystring = "DRIVER={MySQL ODBC 3.51 Driver};" + ;
                    "SERVER=192.168.1.79;" + ;
                    "PORT=3306;" + ;
                    "UID=sistemas;" + ;
                    "PWD=informatica;" + ;
                    "DATABASE=sqmdata;" + ;
                    "OPTIONS=0;"

Mifecha=DATE()-30


lnHandle = SQLSTRINGCONNECT(Mystring)
IF lnHandle > 0
                                                       
    cmd1=SQLEXEC(lnHandle," SELECT DISTINCT a.codigoc, b.producto FROM factura A, detafacturas b "+;        
						  "	WHERE a.unico = b.unico AND a.fecha >=?Mifecha ORDER BY b.producto ","Mibase")
    					       
    SQLDISCONNECT(lnHandle)    
    
ELSE
    AERROR(laErr)
    MESSAGEBOX("No se pudo conectar a mySQL. Error: " + CHR(13) + laErr[2])
ENDIF

SELECT COUNT(codigoc) as Numero,producto FROM mibase GROUP BY producto ORDER BY producto INTO CURSOR mibase2 

SELECT mibase2
BROWSE

