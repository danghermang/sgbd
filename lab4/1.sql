Set Serveroutput On;

Create Or Replace Function Lenesi(Givenid Users.Id%Type) 
Return Number As
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

/

Create Or Replace Function Relevanta(Idintrebare Questions.Id%Type)
Return Number As
  Numaraparitii Number:=0;
  Numarraspunsuritotale Number :=0;
  Numarraspunsuricorecte Number :=0;
  Numarafisari Number:=0;
Begin
  Select Asked Into Numaraparitii From Questions 
    Where Questions.Id=Idintrebare;
  If(Numaraparitii<20) Then Return 0;
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
