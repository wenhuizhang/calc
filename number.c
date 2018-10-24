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
