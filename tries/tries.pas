
Program tries;

Const range = 26;

Const offset = 64;

Type 
  node = ^trie;
  trie = Record
    value: char;
    pcontainer: Array[1..range] Of node;
  End;

Var head: node;
Var data : Pchar;






Procedure trieMaker(Var el: node; val: char);

Var counter: integer;
Begin
  dispose(el);
  new(el);
  el^.value := val;
  For counter:=1 To range Do
    Begin
      el^.pcontainer[counter] := Nil;
    End;

End;


Procedure insert(Var head: node; data: Pchar);

Var index, data_length: integer;

Var tmp : node;
Begin
  data_length := strlen(data);
  If ( data_length= 0) Then exit;

  tmp := head;
  For index := 0 To data_length -1 Do
    Begin
      new(tmp^.pcontainer[ord(data[index]) - offset]);
      tmp^.pcontainer[ord(data[index]) - offset]^.value := data[index];
      tmp := tmp^.pcontainer[ord(data[index]) - offset];
    End;
End;


function find_in_trie(head: node; query:Pchar): boolean;
var tmp:node;
var index, query_length:integer;
begin
    query_length:=strlen(query);
    find_in_trie:=true;
    if ( (query_length= 0) )then
    begin
        find_in_trie:=false;
         exit;
    end;
    // set find_in_trie to true
    // set tmp equal to head
    // for each character we need to find the right slot on the current node
    // then check if this node is equal to nil then set find_in_trie to false
    // otherwise, set tmp to this particular node
    // research for the new tmp node;
    tmp:=head;
    for index := 0 to query_length -1 do
    begin  
     if(tmp^.pcontainer[ord(query[index]) - offset] = nil ) then
            begin
                find_in_trie:=false;
                exit;
            end
     else tmp := tmp^.pcontainer[ord(query[index]) - offset];

    end;


end;


















Begin
  head := Nil;
  trieMaker(head,'#');
  insert(head, 'DATA');
  writeln(find_in_trie(head,'A'));
End.
