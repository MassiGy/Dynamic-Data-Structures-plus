program tries;

const range = 26;
const offset = 64;
Type
    node = ^trie;
    trie = record
    value: char;
    pcontainer: Array[1..range] of node;
end;

var head: node;
var data :Pchar;

procedure trieMaker(var el: node; val: char);
var counter:integer;
begin
    dispose(el);
    new(el);
    el^.value:=val;
      for counter:=1 to range do
    begin
        el^.pcontainer[counter]:=nil;   
    end;    

end;


procedure insert(var head: node; data: Pchar);
var index, data_length: integer;
var tmp : node;
begin
    data_length:=strlen(data);
    if( data_length= 0) then exit;
    if(head=nil) then 
        begin

            // if head is null, create a new node and assign it the first char of the input
            // then set a tmp pointer to this node to create the next node
            // create a loop that walks through the input string.
            // for each remaining character, take the ord and substract 65 (for uppercases) in order to get the position of this character
            // from A (position = 1) through Z (position = 26) - ascii chart character representation maping
            // then take the resault of this mapping formula as the correct slot in the pcontainer array of the parent node
            // then move tmp form the parent node to the new child node
            // repeat the process till the entire string has been inserted

            // but if head can be null, that means that we always need to create a new trie.!!
            trieMaker(head, data[0]);
            tmp:=head;

            for index := 1 to data_length -1 do
                begin
                    new(tmp^.pcontainer[ord(data[index]) - offset]);
                    tmp^.pcontainer[ord(data[index]) - offset]^.value:= data[index];
                    tmp:=tmp^.pcontainer[ord(data[index]) - offset];
                end;
            head:=tmp;
            exit;
        end;
    
   

end;



















begin
    head:=nil;
    insert(head, 'DATA')
end.