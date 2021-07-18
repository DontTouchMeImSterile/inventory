/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>

int main() {

  //10 items, 10 attributes, 64 attribute chars
  const char invtext[10][10][64] = {
    {"item name", "type",  "description"},
    {"apple", "food", "fuck"},
    {"mario judah", "person", "where tf is mario judah"},
    {"iron sword", "weapon", "who cares"},
    {"diamond sword", "weapon", "you cannot afford-ford it"}
  };

  //weight, val
  const int invnums[10][10] = {
    {2, 4},
    {1, 8},
  };

  //index is item, value is quantity
  int pitems[5] = {
    0, // item name
    1, // apple
    1, // mario judah
    0, // iron sword
    1  // diamond sword
  };

  //for index in pitem
  //if num is not 0
  //print item name
  for (int i = 0; i < 5; i++) {
    if (!(pitems[i] == 0)) {
	printf("%s\n", invtext[i][0]);
    }
  }
}
