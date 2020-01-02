DECLARE

 CURSOR C1 IS SELECT STATE , CITY , SNAME , AMT , COMM FROM SALESORDER ORDER BY STATE , CITY , SNAME ASC;

 STATE     SALESORDER.STATE%TYPE;
 CITY      SALESORDER.CITY%TYPE;
 SNM       SALESORDER.SNAME%TYPE;
 AMT       SALESORDER.AMT%TYPE;
 COMM      SALESORDER.COMM%TYPE;
 
 TSTATE    SALESORDER.STATE%TYPE:=' ';
 TCITY     SALESORDER.CITY%TYPE;
 TNM       SALESORDER.SNAME%TYPE;
 
 STATEAMT  SALESORDER.AMT%TYPE;
 STATECOMM SALESORDER.COMM%TYPE; 
 CITYAMT   SALESORDER.AMT%TYPE;
 CITYCOMM  SALESORDER.COMM%TYPE;
 NMAMT     SALESORDER.AMT%TYPE;
 NMCOMM    SALESORDER.COMM%TYPE;
 TOTALAMT  NUMBER(15,2):=0;
 TOTALCOMM NUMBER(15,2):=0;

BEGIN

 DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');
 DBMS_OUTPUT.PUT_LINE(LPAD('STATE',20) || LPAD('CITY',20) || LPAD('SNAME',20) || LPAD('AMOUNT',16) || LPAD('COMM',16));
 DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');

 OPEN C1;
 LOOP
  
   FETCH C1 INTO STATE,CITY,SNM,AMT,COMM;
   EXIT WHEN C1%NOTFOUND;

   IF (TSTATE = ' ') THEN

     TSTATE:=STATE;
     TCITY:=CITY;
     TNM:=SNM;

     STATEAMT:=AMT;
     STATECOMM:=COMM;

     CITYAMT:=AMT;
     CITYCOMM:=COMM;  
     
     NMAMT:=AMT;
     NMCOMM:=COMM;       
 
     DBMS_OUTPUT.PUT_LINE(LPAD(STATE,20) || LPAD(CITY,20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));
 
   ELSE
 
     IF (TSTATE = STATE) THEN
 
       STATEAMT:=STATEAMT + AMT;
       STATECOMM:=STATECOMM + COMM;

       IF (TCITY = CITY) THEN
       
          CITYAMT:=CITYAMT + AMT;
          CITYCOMM:=CITYCOMM + COMM;

           IF(TNM = SNM)THEN 
       
             NMAMT:=NMAMT + AMT;
             NMCOMM:=NMCOMM + COMM;
 
             DBMS_OUTPUT.PUT_LINE(LPAD('---',20) || LPAD('---',20) || LPAD('---',20) || LPAD(AMT,16) || LPAD(COMM,16));

           ELSE
  
             TNM:=SNM;

             DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',60) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
   
             NMAMT:=AMT;
             NMCOMM:=COMM;
   
             DBMS_OUTPUT.PUT_LINE(LPAD('---',20) || LPAD('---',20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));

           END IF;
 
         ELSE
  
           DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',60) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
           
           TCITY:=CITY;
           TNM:=SNM;
     
           DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL City Wise:: ',60) || LPAD(CITYAMT,16) || LPAD(CITYCOMM,16));

           CITYAMT:=AMT;
           CITYCOMM:=COMM;

           NMAMT:=AMT;
           NMCOMM:=COMM;

           DBMS_OUTPUT.PUT_LINE(LPAD('---',20) || LPAD(CITY,20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));
 
         END IF;

       ELSE
   
         DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',60) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
         DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL City Wise:: ',60) || LPAD(CITYAMT,16) || LPAD(CITYCOMM,16));
          
         TSTATE:=STATE;
         TCITY:=CITY;
         TNM:=SNM; 

         DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL State Wise :: ',60) || LPAD(STATEAMT,16) || LPAD(STATECOMM,16));

         STATEAMT:=AMT;
         STATECOMM:=COMM;

         CITYAMT:=AMT;
         CITYCOMM:=COMM;  
     
         NMAMT:=AMT;
         NMCOMM:=COMM;   

         DBMS_OUTPUT.PUT_LINE(LPAD(STATE,20) || LPAD(CITY,20) || LPAD(SNM,20) || LPAD(AMT,16) || LPAD(COMM,16));
  
       END IF; 
  END IF;              
 
   TOTALAMT := TOTALAMT + AMT;
   TOTALCOMM := TOTALCOMM + COMM;
   
 END LOOP;

CLOSE C1;


 DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');
 DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL Name Wise :: ',60) || LPAD(NMAMT,16) || LPAD(NMCOMM,16));
 DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');

 
 DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL City Wise :: ',60) || LPAD(CITYAMT,16) || LPAD(CITYCOMM,16));
 DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');

 DBMS_OUTPUT.PUT_LINE(LPAD('TOTAL State Wise :: ',60) || LPAD(STATEAMT,16) || LPAD(STATECOMM,16));
 DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');

 DBMS_OUTPUT.PUT_LINE(LPAD('GRAND TOTAL :: ',60) || LPAD(TOTALAMT,16) || LPAD(TOTALCOMM,16));
 
END;
/


