#pragma once

struct Person {
  char *name;
  int age;
};

void say_hello(struct Person *person);
