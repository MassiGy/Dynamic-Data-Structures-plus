
Program trees;


Type 
  node = ^tree;
  tree = Record
    value: integer;
    left: node;
    right: node;
  End;



Var head, el: node;
var counter, nodecount:integer;




Procedure treeMaker(Var node: node);
Begin
  new(node);
  writeln('insert you value');
  readln(node^.value);
  node^.left := Nil;
  node^.right := Nil;
End;

// algorithm that inserts a node to an entire tree/ O(log(n))

Procedure insert(Var head, el: node);
Begin
  If (head = Nil) Then head := el;
  If (el^.value < head^.value) Then
    Begin
      insert(head^.left, el);
      exit;
    End;
  If (el^.value > head^.value) Then
    Begin
      insert(head^.right, el);
      exit;
    End;
End;


// algorithm that prints an entire tree/ O(log(n))

Function print_tree_inorder(root: node): integer;

// then get the value of the left son,
// get the value of the current node, 
// then get the value of the right son,
Begin
  If (root= Nil) Then exit;
  If ((root^.left= Nil)And (root^.right= Nil)) Then
    Begin
      print_tree_inorder := root^.value;
    End;
  print_tree_inorder(root^.left);
  write(' ',root^.value,'');
  print_tree_inorder(root^.right);
End;

// algorithm that prints an entire tree/ O(log(n))

Function print_tree_postOrder(root: node): integer;

// then get the value of the left son,
// then get the value of the right son,
// get the value of the current node, 
Begin
  If (root= Nil) Then exit;
  If ((root^.left= Nil)And (root^.right= Nil)) Then
    Begin
      print_tree_postOrder := root^.value;
    End;
  print_tree_postOrder(root^.left);
  print_tree_postOrder(root^.right);
  write(' ',root^.value,'');
End;

// algorithm that prints an entire tree/ O(log(n))

Function print_tree_preOrder(root: node): integer;
// get the value of the current node, 
// then get the value of the left son,
// then get the value of the right son,
Begin
  If (root= Nil) Then exit;
  If ((root^.left= Nil)And (root^.right= Nil)) Then
    Begin
      print_tree_preOrder := root^.value;
    End;
  write(' ',root^.value,'');
  print_tree_preOrder(root^.left);
  print_tree_preOrder(root^.right);
End;


// algorithm that destroyes a entire tree/ O(log(n))
Procedure free(Var tree: node);
// the idea is to free up the left son then the right son, then the parent node,

//** in other words:
// the idea is to go all the way down to the most on left sub-tree,
// then freeup the left node then the right node;
// then go back to the parent tree that containes this sub-tree, and free up the left node,
// and do this again and again with recursion.
// then at some point the left half of the tree will be freed up
// then the algorithm will free up the right half with the same process
// and after this was done, all that is remaining is the initial root, the real one,
// so all we need to to is the free it as the single remaining node.

Begin
  If (tree= Nil) Then exit;
  If ((tree^.left= Nil)And (tree^.right= Nil)) Then
    Begin
      writeln('destroyed data :', tree^.value);
      dispose(tree);
      exit;
    End
  Else
    Begin

      free(tree^.left);
      free(tree^.right);
    End;
      writeln('destroyed data :', tree^.value);
    dispose(tree);
End;







Begin
  head := Nil;
  writeln('how many nodes your tree will containe');
  readln(nodecount);
  for counter := 0 to nodecount do
      begin
          treeMaker(el);
          insert(head,el);
      end;
  writeln('');
  print_tree_inOrder(head);
  writeln('');

  free(head);

End.
