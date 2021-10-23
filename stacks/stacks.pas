Program stacks;


Type 
  node = ^list;
  list = Record
    value: integer;
    next : node;
  End;

Var head: node;



Procedure nodeMaker(Var el: node);

Var val: integer;
Begin
  new(el);
  writeln('what is the value of your node');
  readln(val);
  el^.value := val;
  el^.next := Nil;
End;



Function list_length(list : node): integer;
  var tmp: node;
Begin
  if(list = nil ) Then
    begin
      list_length:=0;
      exit;
    end;

  list_length:=1;
  tmp:=list;

  While(tmp^.next <> nil) Do
    begin
      list_length:=list_length+1;
      tmp:=tmp^.next;
    end;

End;





Procedure unshift(Var list, element: node);
Begin
  If (list = Nil) Then
    Begin
      list := element;
      exit;
    End;
  element^.next := list;
  list := element;
End;

function shift(var list:node):node;
  var tmp: node;
begin
  if(list = nil ) then exit;
  if(list^.next = nil) then 
    begin
      shift:=list;
      list:=nil;
      exit
    end;
  tmp:=list^.next;
  shift:=list;
  list:=tmp;

  shift^.next:=nil;
end;



Procedure fill_From_Top(Var list: node);
Var 
  length , counter: integer;
  element: node;
Begin
  list := Nil;
  writeln('what is the length of you new list');
  readln(length);
  For counter := 1 To length Do
    Begin
      nodeMaker(element);
      unshift(list, element);
    End;

End;




Procedure print_list(list: node);

Var tmp: node;
Begin
  If (list = Nil) Then
    Begin
      writeln('list empty');
      exit;
    End;

  tmp := list;
  While (tmp <> Nil) Do
    Begin
      writeln('data is equal to ', tmp^.value);
      tmp := tmp^.next;
    End;

End;



procedure free(var list: node);
 var tmp:node;
begin
  if(list = nil) then exit;
  if(list^.next = nil ) then
    begin
      dispose(list);
      exit;
    end;
  
  tmp:=list^.next;
  While(list <> nil)Do
    begin
      dispose(list);
      list:=tmp;
      if(tmp<>nil) then tmp:=tmp^.next;
      writeln('freed')
    end;
end;



Begin
  fill_From_Top(head);
  print_list(head);
  
  free(head);
End.