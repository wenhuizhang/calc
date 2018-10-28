#include <math.h>

#include "calc.h"

DEFINE_OPERATION(ADD);
DEFINE_OPERATION(SUBTRACT);
DEFINE_OPERATION(MULTIPLY);
DEFINE_OPERATION(DIVIDE);
DEFINE_OPERATION(POW);


struct number NEGATE(struct number x) {
        if (IS_NUMBER(x))
                x.long_number = -x.long_number;
        else
                x.integer = -x.integer;

        return x;
}


struct number LESS(struct number x, struct number y) {
  if (IS_NUMBER(x) || IS_NUMBER(y)) {
          ENSURE_NUMBER(x);
          ENSURE_NUMBER(y);
          return NEW_NUMBER(x.long_number < y.long_number);
  } else {
          return NEW_INTEGER(x.integer < y.integer);
  }
}


struct number LESS_EQUAL(struct number x, struct number y) {
  if (IS_NUMBER(x) || IS_NUMBER(y)) {
          ENSURE_NUMBER(x);
          ENSURE_NUMBER(y);
          return NEW_NUMBER(x.long_number <= y.long_number);
  } else {
          return NEW_INTEGER(x.integer <= y.integer);
  }
}


struct number GREATER(struct number x, struct number y) {
  if (IS_NUMBER(x) || IS_NUMBER(y)) {
          ENSURE_NUMBER(x);
          ENSURE_NUMBER(y);
          return NEW_NUMBER(x.long_number > y.long_number);
  } else {
          return NEW_INTEGER(x.integer > y.integer);
  }
}


struct number GREATER_EQUAL(struct number x, struct number y) {
  if (IS_NUMBER(x) || IS_NUMBER(y)) {
          ENSURE_NUMBER(x);
          ENSURE_NUMBER(y);
          return NEW_NUMBER(x.long_number >= y.long_number);
  } else {
          return NEW_INTEGER(x.integer >= y.integer);
  }
}


struct number EQUAL(struct number x, struct number y) {
  if (IS_NUMBER(x) || IS_NUMBER(y)) {
          ENSURE_NUMBER(x);
          ENSURE_NUMBER(y);
          return NEW_NUMBER(x.long_number == y.long_number);
  } else {
          return NEW_INTEGER(x.integer == y.integer);
  }
}


struct number NOT_EQUAL(struct number x, struct number y) {
  if (IS_NUMBER(x) || IS_NUMBER(y)) {
          ENSURE_NUMBER(x);
          ENSURE_NUMBER(y);
          return NEW_NUMBER(x.long_number != y.long_number);
  } else {
          return NEW_INTEGER(x.integer != y.integer);
  }
}
