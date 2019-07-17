Create Or Replace Package Lab4 As

  Function Lenesi(Givenid Users.Id%Type) Return Number;
  Function Relevanta(Idintrebare Questions.Id%Type) Return Number;
  Function Relevanta(Numestudent Users.Username%Type) Return Number;
  
End Lab4;
/
Create Or Replace Package Body Lab4 As

  Function Lenesi(Givenid Users.Id%Type) Return Number As
      Numartotal Number :=0;
      Intrebariraspunse Number :=0;      
    Begin
      Select Count(*) Into Numartotal 
        From Answers Where Answers.User_Id=Givenid;
      Select Count(*) Into Intrebariraspunse 
        From Answers 
          Where Answers.User_Id=Givenid And Solved =1;
      If(Numartotal/2 > Intrebariraspunse) Then 
          Return 0;
        Else
          Return 1;
      End If;
    End;
    
  Function Relevanta(Idintrebare Questions.Id%Type) Return Number As
    Numaraparitii Number:=0;
    Numarraspunsuritotale Number :=0;
    Numarraspunsuricorecte Number :=0;
    Numarafisari Number:=0;
  Begin
    Select Asked Into Numaraparitii From Questions Where Questions.Id=Idintrebare;
    If(Numaraparitii<20) Then 
        Return 0;
      End If;
    Select Count (*) Into Numarraspunsuritotale From Answers Where Answers.Question_Id=Idintrebare;
    Select Count (*) Into Numarraspunsuricorecte From Answers Where Answers.Question_Id=Idintrebare And Lenesi(Answers.User_Id)=1 And Solved=1;
    If(Numarraspunsuricorecte<30*Numarraspunsuritotale/100 Or Numarraspunsuricorecte>90*Numarraspunsuritotale/100) Then
      Return 0;
    Else
      Select Asked Into Numarafisari From Questions Where Questions.Id=Idintrebare;
    End If;
    Return Numarafisari;
  End;
  
  Function Relevanta(Numestudent Users.Username%Type) Return Number As
    Temp_Relevance Number :=0;
    Temp_Relevance_Max Number :=0;
    Temp_User_Id Users.Id%Type;
    Cursor Lista_Intrebari Is Select Questions.Id From Questions Where Questions.User_Id = (Select Id From Users Where Users.Username=Numestudent);
  Begin
    For Line In Lista_Intrebari
      Loop
        Temp_Relevance := Relevanta(Line.Id);
        If (Temp_Relevance > Temp_Relevance_Max)
          Then Temp_Relevance_Max := Temp_Relevance;
        End If;
      End Loop;
      Return Temp_Relevance_Max;
  End;
  
End Lab4;
/
select Lab4.relevanta('ana.chistol') from dual;
select Lab4.relevanta(105) from dual;
select count(*) from questions where Lab4.Relevanta(id)!=0;