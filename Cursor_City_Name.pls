DECLARE

 CURSOR C1 IS SELECT CITY , SNAME , AMT , COMM FROM SALESORDER ORDER BY CITY , SNAME ASC;

 CITY      SALESORDER.CITY%TYPE;
 SNM       SALESORDER.SNAME%TYPE;
 AMT       SALESORDER.AMT%TYPE;
 COMM      SALESORDER.COMM%TYPE;

 TNM       SALESORDER.SNAME%TYPE;
 TCITY     SALESORDER.CITY%TYPE:=' ';
 
 CITYAMT   SALESORDER.AMT%TYPE;
 CITYCOMM  SALESORDER.COMM%TYPE;
 NMAMT     SALESORDER.AMT%TYPE;
 NMCOMM    SALESORDER.COMM%TYPE;
 TOTALAMT  NUMBER(15,2):=0;
 TOTALCOMM NUMBER(15,2):=0;

BEGIN

 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
 DBMS_OUTPUT.PUT_LINE(LPAD('CITY',20) || LPAD('SNAME',20) || LPAD('AMOUNT',16) || LPAD('COMM',16));
 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');

 OPEN C1;
 LOOP
  
   FETCH C1 INTO CITY,SNM,AMT,COMM;
   EXIT WHEN C1%NOTFOUND;

   IF (TCITY = ' ') THEN

     TCITY:=CITY;
     TNM:=SNM;

     CITYAMT:=AMT;
     CITYCOMM:=COMM;  
     
     NMAMT:=AMT;
     NMCOMM:=COMM;       
 
     DBMS_OUTPUT.PUT_LINE(LPAD(CITY,20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));
 
   ELSE
 
     IF (TCITY = CITY) THEN
       
       CITYAMT:=CITYAMT + AMT;
       CITYCOMM:=CITYCOMM + COMM;

       IF(TNM = SNM)THEN 
       
         NMAMT:=NMAMT + AMT;
         NMCOMM:=NMCOMM + COMM;
 
         DBMS_OUTPUT.PUT_LINE(LPAD('---',20) || LPAD('---',20) || LPAD(AMT,16) || LPAD(COMM,16));

       ELSE
  
         TNM:=SNM;

         DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',40) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
   
         NMAMT:=AMT;
         NMCOMM:=COMM;
   
         DBMS_OUTPUT.PUT_LINE(LPAD('---',20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));

       END IF;
 
     ELSE
  
       DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',40) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
         
       TCITY:=CITY;
       TNM:=SNM;
     
       DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL City Wise :: ',40) || LPAD(CITYAMT,16) || LPAD(CITYCOMM,16));

       CITYAMT:=AMT;
       CITYCOMM:=COMM;

       NMAMT:=AMT;
       NMCOMM:=COMM;

       DBMS_OUTPUT.PUT_LINE(LPAD(CITY,20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));
 
     END IF;
  
   END IF;               
 
   TOTALAMT := TOTALAMT + AMT;
   TOTALCOMM := TOTALCOMM + COMM;
   
 END LOOP;

CLOSE C1;


 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
 DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',40) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');

 DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL City Wise :: ',40) || LPAD(CITYAMT,16) || LPAD(CITYCOMM,16));
 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');

 DBMS_OUTPUT.PUT_LINE(LPAD('GRAND TOTAL :: ',40) || LPAD(TOTALAMT,16) || LPAD(TOTALCOMM,16));
 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
 
END;
/

