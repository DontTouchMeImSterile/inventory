
#include <stdio.h>

int main() {

  //item #
  
  //10 items, 10 attributes, 64 attribute chars
  const char invtext[10][10][64] = {
    {"item name", "type",  "description"},
    {"apple", "food", "fuck"}
  };

  //weight, val
  const int invnums[10][10] = {
    {2, 4},
    {1, 8}
  };

  //index is item, value is quantity
  int pitems[5] = {1, 0, 0, 0, 0};

  //in pitems
  //if quantity is not 0
  //print item name
  for (int i = 0; i < 3; i++) {
    if (!(pitems[i] == 0)) {
	printf("%s", invtext[i][0]);
    }
  }
  return 0;
  
}
