DECLARE

 CURSOR C1 IS SELECT SNAME,AMT,COMM FROM SALESORDER ORDER BY SNAME ASC;

 SNM       SALESORDER.SNAME%TYPE;
 TNM       SALESORDER.SNAME%TYPE:=' ';
 SUBAMT    SALESORDER.AMT%TYPE;
 SUBCOMM   SALESORDER.COMM%TYPE;
 TOTALAMT  NUMBER(15,2):=0;
 TOTALCOMM NUMBER(15,2):=0;
 AMT       SALESORDER.AMT%TYPE;
 COMM      SALESORDER.COMM%TYPE;

BEGIN

 DBMS_OUTPUT.PUT_LINE('------------------------------------');
 DBMS_OUTPUT.PUT_LINE('SNAME           AMOUNT          COMM');
 DBMS_OUTPUT.PUT_LINE('------------------------------------');

 OPEN C1;
 LOOP
  
   FETCH C1 INTO SNM,AMT,COMM;
   EXIT WHEN C1%NOTFOUND;

   IF (TNM = ' ') THEN

     TNM:=SNM;
     SUBAMT:=AMT;
     SUBCOMM:=COMM;  
     
     DBMS_OUTPUT.PUT(SNM);
     DBMS_OUTPUT.PUT(LPAD(AMT,19,' '));
     DBMS_OUTPUT.PUT_LINE(LPAD(COMM,14,' '));
 
   ELSE
 
     IF (TNM = SNM) THEN
 
       SUBAMT:=SUBAMT + AMT;
       SUBCOMM:=SUBCOMM + COMM;
 
       DBMS_OUTPUT.PUT('---');
       DBMS_OUTPUT.PUT(LPAD(AMT,19,' '));
       DBMS_OUTPUT.PUT_LINE(LPAD(COMM,14,' '));
 
     ELSE
 
       DBMS_OUTPUT.PUT_LINE('------------------------------------');
       DBMS_OUTPUT.PUT('TOTAL :: ');
       DBMS_OUTPUT.PUT(LPAD(SUBAMT,13,' '));
       DBMS_OUTPUT.PUT_LINE(LPAD(SUBCOMM,14,' '));
       DBMS_OUTPUT.PUT_LINE('------------------------------------');

       DBMS_OUTPUT.PUT(SNM);
       DBMS_OUTPUT.PUT(LPAD(AMT,19,' '));
       DBMS_OUTPUT.PUT_LINE(LPAD(COMM,14,' '));

       TNM:=SNM;
       SUBAMT:=AMT;
       SUBCOMM:=COMM;
      
     END IF;

   END IF;               
 
   TOTALAMT := TOTALAMT + AMT;
   TOTALCOMM := TOTALCOMM + COMM;
   
 END LOOP;

CLOSE C1;

 DBMS_OUTPUT.PUT_LINE('------------------------------------');
 DBMS_OUTPUT.PUT('TOTAL :: ');
 DBMS_OUTPUT.PUT(LPAD(SUBAMT,13,' '));
 DBMS_OUTPUT.PUT_LINE(LPAD(SUBCOMM,14,' '));
 DBMS_OUTPUT.PUT_LINE('------------------------------------');

 DBMS_OUTPUT.PUT('GRAND TOTAL :: ');
 DBMS_OUTPUT.PUT(LPAD(TOTALAMT,7,' '));
 DBMS_OUTPUT.PUT_LINE(LPAD(TOTALCOMM,14,' '));
 DBMS_OUTPUT.PUT_LINE('------------------------------------');
 DBMS_OUTPUT.PUT_LINE('------------------------------------');

END;
/
