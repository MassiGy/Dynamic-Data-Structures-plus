## Welcome the the trees manipulation algorithms

In the ./trees.pas you will find the trees algorithms written in pascal programming language.
I want to mention that not all the trees algorithm are there.


Some Notes:

For the tree traversal, I implemented the depth first principle
so the idea is to go down till the end, then rise up one level each time.

There is also the breadth first principle, that I did not implement in this repo, which descripeses the idea of visiting one level of the tree at the time.
This second principle takes more memory complexity to implement it.
you can either use a queue, or change your binary search tree structure by adding a pointer that points to the parent node of the current node, this new design will give you the ability to go up so it is very efficient when using the breadth first traversal principle.

so if you want to learn more about it, check out this link: https://medium.com/basecs/breaking-down-breadth-first-search-cebe696709d9;

my code about it is at :https://github.com/MassiGy/Dynamic-Data-Structures/blob/master/trees.pas
