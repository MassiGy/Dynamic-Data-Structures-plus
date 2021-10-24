
Program singleLinkedLists;


Type 
  node = ^list;
  list = Record
    value: integer;
    next : node;
  End;

Var head, el: node;



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





procedure free(var list: node);
 var tmp:node;
begin
  if(list = nil) then exit;
  if(list^.next = nil ) then
    begin
      dispose(list);
      exit;
    end;
  // freeing all the node of the list, by seting tmp as a pointer to one element after the head
  // then disposing the head, and move the tmp one step further again, 
  // repeat this processing until all the nodes are freed one after the other
  tmp:=list^.next;
  While(list <> nil)Do
    begin
      dispose(list);
      list:=tmp;
      if(tmp<>nil) then tmp:=tmp^.next;
      writeln('freed')
    end;
end;



Procedure push(Var list: node; element: node);

Var tmp : node;
Begin
  If (list = Nil) Then
    Begin
      list := element;
      exit;
    End;
  tmp := list;
  While (tmp^.next <> Nil) Do
    tmp := tmp^.next;
  tmp^.next := element;
End;


function pop(var list:node):node;
  var tmp:node;
begin
  if(list  = nil ) then exit;
  if(list^.next = nil) then 
    begin
      pop:=list;
      list:=nil;
      exit;
    end;
  tmp:=list;
  While(tmp^.next^.next<>nil) Do tmp:=tmp^.next;
  pop:=tmp^.next;
  tmp^.next:=nil;
end;


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


Procedure fill_From_End(Var list: node);

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
      push(list, element);
    End;
End;

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


procedure insert_after_position(var list, element: node; position: integer);
  var tmp:node;
  var counter: integer;
begin
  if(list = nil) then 
    begin
      list:=element;
      exit;
    end;
  if(position >= list_length(list)) then
    begin
      push(list, element);
      exit;
    end; 
  tmp:=list;
  counter:=1;
  While(counter<position) Do
    begin
      tmp:=tmp^.next;
      counter:=counter+1;
    end;
  element^.next:=tmp^.next;
  tmp^.next:=element;
end;


procedure replace(var list: node; val, newVal: integer);
  var tmp: node;
begin
  if(list = nil) then exit;
  if((list^.next = nil) and (list^.value <> val)) then exit;

  // walk trough the list until the end, or until we find the correct val
  tmp:=list;
  while((tmp^.next <> nil )and(tmp^.value <> val)) Do tmp:=tmp^.next;
  // case analytics
  if( tmp^.value = val )then 
    begin
      tmp^.value:=newVal;
      exit;
    end; 
  if(tmp^.next = nil)then  
    begin
      if(tmp^.value <> val ) then exit;
      if(tmp^.value = val )  then
        begin
          tmp^.value:=newVal;
          exit;
        end;
    end;
end;


function find(var list: node; val: integer):node;
  var tmp: node;
begin
  find:=nil;

  if(list = nil) then exit;
  if((list^.next = nil) and (list^.value <> val)) then exit;

  // walk trough the list until the end, or until we find the correct val
  tmp:=list;
  while((tmp^.next <> nil )and(tmp^.value <> val)) Do tmp:=tmp^.next;
  // case analytics
  if( tmp^.value = val )then 
    begin
      find:=tmp;
      exit;
    end; 
  if(tmp^.next = nil)then  
    begin
      if(tmp^.value <> val ) then exit;
      if(tmp^.value = val )  then
        begin
          find:=tmp;
          exit;
        end;
    end;
end;



procedure splice_after_position(var list: node; position, elcount: integer);
  var begining, ending, tmp:node;
  var counter:integer;
begin
  if(list = nil) then exit;
  if(elcount = 0) then exit;
  if((list^.next = nil)and (position = 1)) then
    begin
      shift(list);
      exit;
    end;
  if(position >= list_length(list)) then exit;


  // go to the position;
  // set begining and ending to the node after the element at the given position
  // walktrough the list with the pointer ending elcount times
  // now the ending is elcount steps away from the begining pointer
  // set the begining next pointer feild to the ending next pointer value

  // tmp will helps us to keep track of the spliced chunk of the list;
  // in order to display it, for debugging purpuses, and more importantly 
  // to free it.

  begining:=list;
  counter:=1;
  while(counter<position) Do
    begin
      begining:=begining^.next;
      counter:=counter+1;
    end;
  ending:=begining;
  counter:=0;
  while(counter<elcount)do 
    begin
      ending:=ending^.next;
      counter:=counter+1;
    end;
  
  tmp:=begining^.next;
  begining^.next:=ending^.next;
  ending^.next:=nil;
  free(tmp);
  ending:=nil;
end;




Begin
  fill_From_End(head);
  print_list(head);
  

  free(head);
End.