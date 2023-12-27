#include "foo.h"

#include <stdio.h>

void say_hello(struct Person *person) {
  printf("Hello, %s!\n", person->name);
  printf("You are %d years old.\n", person->age);
}
