
Program tries;

Const range = 26;

// the offset is the value of the ascii code of the uppercase 'A'.
// this is important to find the right slot of each uppercase character from 'A' through 'Z' in our pcontainer.
// for exemple ord('B') = 66, so we substract 64, which will give us 2, and which correspends to the right slot for the character
// 'B' in our pcontainer.
// and it is super simple because it just giving us the position of the Character in the alphabit.

Const offset = 64;

Type 
  node = ^trie;
  trie = Record
    value: char;
    pcontainer: Array[1..range] Of node;
  End;

Var head: node;







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

  if(head=nil) then exit;
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


    if(head=nil) then exit;
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


function is_leaf(head:node):boolean;
  var counter:integer;
begin
  if(head=nil)Then  
    begin
       is_leaf:=false;
       exit;
    end;
  
  is_leaf:=true;
  for counter := 1 to range do
    begin
        if (head^.pcontainer[counter] <> nil) then 
          begin
              is_leaf:=false;
              exit;
          end;  
    end;
end;




procedure free(var head: node);
  var index:integer;
begin
  if(head=nil) then exit;
  if(is_leaf(head)) then 
    begin
      dispose(head);
      head:=nil;
      exit;
    end
  else for index := 1 to range do free(head^.pcontainer[index]);
end;



procedure delete_in_trie(var head: node; query: Pchar);
  var tmp:node;
  var query_length, i,j:integer;
  var answer:char;
begin
  query_length:=strlen(query);
  if(head= nil) then exit;
  if(query_length=0) then exit;
  if(find_in_trie(head, query)= false) then exit;


  // we can do this with recursion or iterativly.

  // to delete one sting in the trie we need to
  // go down to the last character node.
  // free it.
  // go back one level, so now we are at the before last character.
  // free it.
  // redo the process until we are in the first node which is the root then exit.

  // the iterativ way
  // we know that this tipical approach is based on a 0(n²) time complexity.
  // but, this is not that meaningful in this case.
  // cuz, the n, or the number of input, is reduced to the number of charachter of the query string.
  // so, even if we have que 0(n²) algorithm approach, the n² never goas super high to slow up our system.
  // with that said, we can afford using this algorithm.

  //          CAUTION.
  // but, if you are going to store texts or paragraphs in your trie,
  // you have to lookup another solution
  // because even so this algorithm is ment to delete some words, 
  // but, there is nothing limiting it to delete texts
  // since the query is a Pchar data type.
  // which is basicly a linked list of characters.
  // in this particular case you have to go with another approach.

  tmp:=head;
  for i:=1 to query_length  do
    begin
      tmp:=head;
      for j:=0 to query_length -i do tmp := tmp^.pcontainer[ord(query[j]) - offset];

      // the problem of the this approach is that when we have a lot of data going on the trie.
      // and one time we delete one letter like 'D';
      // so, all the word that begins with this letter will be orphined (will be not accessible)
      // but, they still taking up memory on our system, and this is super bad
      // because taking memory without giving it back to the system can cause segmentation faults 
      // which can make our envirement crash!!

      // so we need to check if the tobedeleted node is a leaf
      // if so delete it, that's fine
      // otherwise, ask the use if he wants to continue
      // if no, exit
      // if yes, delete all the words that begins with that letter
      // then delete the node the contains that letter
      if(is_leaf(tmp)) then
        begin
          dispose(tmp);
          tmp:=nil;
        end
      else 
        begin
          writeln('CAUTION: This is not a leaf, all the data that begins with the given query: "', query,'" will be erased!');
          writeln('PROMPT : do you want to delete it any way? y/n');
          readln(answer);
          if(answer = 'n') then exit;
          if(answer = 'y') then
            begin
                // in this case we want to delete all the branches related to the tmp node.
                // in other words delete all the word form the letter that will be deleted.
                free(tmp);
                 dispose(tmp);
                tmp:=nil;
            end;
        end;
    end;

    // the recursiv way

    // the idea is the same.
    // we go through the query string.
    // for each charachter we delete the next one in the trie, befor deleting the current one
    // do this until we are on the last character of the query string.

    // the hard part of this approach is that we need to dynamicly change the query string in each recursiv call
    // for exemple is if we call it with a query string set to 'DATA' at first
    // the second call should be done with a subset of the initial query string 
    // which should be equal to 'ATA'.
    // and we repeat this until the new dynamic sub string of the query has a length equal to 1.


    // this approach we coast more time, and more effort for the same reasult, and not that much gain.
    // and we will need to create our sub_string_generator function and pass it dynamicly for each new recursiv call.
    // and this is getting things fade away from the purpuse of this folder which is to master data structers and not create 
    // all the function out there.
    // so, that's the reason for not doing it here
    // but feel free to do it and send it me if you will

end;















































Begin
  head := Nil;
  trieMaker(head,'#');
  insert(head, 'DATA');
  insert(head, 'WAKA');
  insert(head, 'MONGIKYU');
  insert(head, 'AZUMA');
  writeln(find_in_trie(head,'DATA'));
  delete_in_trie(head, 'D');
  writeln(find_in_trie(head,'DATA'));
 

End.
