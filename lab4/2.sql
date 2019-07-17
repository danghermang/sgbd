Set Serveroutput On;

Declare
  Cursor Id_Special Is Select Questions.Id,Users.Username From Questions Join Users On Questions.User_Id=Users.Id 
  Where Questions.Id >=120 And Questions.Id<=140 And Users.User_Role Not Like 'admin' Order By Questions.Id;
  Temp_Id Users.Id%Type:=0;
  Temp_Relevance Number:=0;
  Temp_Relevance_Max Number:=0;
  Temp_Id_Max Users.Id%Type:=0;
  Temp_Username Users.Username%Type :='null';
  Temp_Username_Max Users.Username%Type :='null';
Begin
  For Line In Id_Special Loop
    Temp_Relevance:=Relevanta(Line.Id);
    Dbms_Output.Put_Line(Line.Username||' '||Line.Id||' '||Temp_Relevance);
    If(Temp_Relevance_Max<Temp_Relevance)
      Then Temp_Relevance_Max:=Temp_Relevance;
          Temp_Username_Max:=Line.Username;
          Temp_Id_Max:=Line.Id;
    End If;
  End Loop;
  Dbms_Output.Put_Line('');
  Dbms_Output.Put_Line('username:'||Temp_Username_Max||'   id:'||Temp_Id_Max||'   relevanta maxima:'||Temp_Relevance_Max);
End;