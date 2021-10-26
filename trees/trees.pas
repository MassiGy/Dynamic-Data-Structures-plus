
Program trees;


Type 
  node = ^tree;
  tree = Record
    value: integer;
    left: node;
    right: node;
  End;



Var head, el: node;

Var counter, nodecount: integer;




Procedure treeMaker(Var node: node);
Begin
  new(node);
  writeln('insert you value');
  readln(node^.value);
  node^.left := Nil;
  node^.right := Nil;
End;

// algorithm that calculates the length of a tree with recursion
// the length of a binary tree is the max between the lenght of the 
// right side and the lenght of the left side

// so we need to build an algorithm that is going deep in the tree
// and increment how many level this one containes 
// and we need to do this in the left and the right side
// then at the end return the max of these values.

Function max(x, y : integer): integer;
Begin
  If (x>y) Then max := x
  Else max := y;
End;



Function tree_length(head: node): integer;
Begin
  If (head= Nil) Then tree_length := 0
  Else tree_length := 1 + max(tree_length(head^.left), tree_length(head^.right));
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


// algorithm that deletes one node on the tree
// if we want to delete a node without generating a conflict in the tree initial sort we can
// check if the node is  a leaf, if so just free it,
// if not,  the node is a parent
// so, just move up the left son as the new parent node, 
// if the left son of the parent is nil, just move up the right son as the new parent
// if the right son of the parent is nil, just move up the left son as the new parent
// if the right and the left son are not equal to nil;
// we know that the left side is always smaller then the right one,
// so all we need to do is to put the right sub-tree (right son) as the new parent,
// then append (insert at the end) the left sub tree to this new parent



Procedure delete(Var head: node; query: integer);

Var tmp, tmp2: node;
Begin
  If (head= Nil) Then exit;
  If ((head^.right = Nil)And(head^.left = Nil )And (head^.value <> query)) Then exit;
  If ((head^.right = Nil)And(head^.left = Nil )And (head^.value = query)) Then
    Begin
      dispose(head);
      head := Nil;
      exit;
    End;
  If (((head^.right <> Nil)or(head^.left <> Nil ))and (head^.value = query)) Then
    Begin
      If ((head^.right = Nil)And(head^.left <> Nil )) Then
        Begin
          tmp := head^.left;
          dispose(head);
          head := tmp;
          exit;
        End;
      If ((head^.right <> Nil)And(head^.left = Nil )) Then
        Begin
          tmp := head^.right;
          dispose(head);
          head := tmp;
          exit;
        End;
      If ((head^.right <> Nil)And(head^.left <> Nil )) Then
        Begin
          tmp := head^.left;
          tmp2 := head^.right;
          dispose(head);
          insert(tmp2, tmp);
          head := tmp2;
          exit;
        End;
    End;


  delete(head^.left, query);
  delete(head^.right, query);


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
      writeln('destroyed value :', tree^.value);
      dispose(tree);
      exit;
    End
  Else
    Begin

      free(tree^.left);
      free(tree^.right);
    End;
  writeln('destroyed value :', tree^.value);
  dispose(tree);
End;







Begin
  head := Nil;
  writeln('how many nodes your tree will containe');
  readln(nodecount);
  For counter := 1 To nodecount Do
    Begin
      treeMaker(el);
      insert(head,el);
    End;
  writeln('');
  print_tree_inOrder(head);
  writeln('');
  writeln('the tree length is ', tree_length(head));
  delete(head, 3);
  writeln('');
  print_tree_inOrder(head);
  writeln('');
  writeln('the tree length is ', tree_length(head));
  free(head);

  el:=nil;
End.
