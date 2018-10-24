#define TRUE 1
#define FALSE 0
#define BOOL int

struct number {
  long integer;
  double long_number;
  BOOL is_number;
};
typedef struct number NUM;

struct number get_var(char *);
struct number set_var(char *, struct number);

struct number ADD(struct number x, struct number y);
struct number SUBTRACT(struct number x, struct number y);
struct number MULTIPLY(struct number x, struct number y);
struct number DIVIDE(struct number x, struct number y);
struct number POW(struct number x, struct number y);
struct number NEGATE(struct number x);

#define IS_NUMBER(x) x.is_number == TRUE
#define NEW_INTEGER(x) (struct number){ x, 0, FALSE }
#define NEW_NUMBER(x) (struct number){ 0, x, TRUE }

#define ENSURE_NUMBER(x) \
        do { \
                if (!(IS_NUMBER(x))) { \
                        x.long_number = (double)x.integer; \
                        x.is_number = TRUE; \
                } \
        } while(0)

#define PRINT_NUMBER(x) \
        do { \
                if (IS_NUMBER(x)) \
                        printf("%lg\n", x.long_number); \
                else \
                        printf("%ld\n", x.integer); \
        } while (0)

#define ADD_INTEGER(x, y) NEW_INTEGER(x.integer + y.integer)
#define ADD_NUMBER(x, y) NEW_NUMBER(x.long_number + y.long_number)

#define SUBTRACT_INTEGER(x, y) NEW_INTEGER(x.integer - y.integer)
#define SUBTRACT_NUMBER(x, y) NEW_NUMBER(x.long_number - y.long_number)

#define MULTIPLY_INTEGER(x, y) NEW_INTEGER(x.integer * y.integer)
#define MULTIPLY_NUMBER(x, y) NEW_NUMBER(x.long_number * y.long_number)

#define DIVIDE_INTEGER(x, y) NEW_INTEGER(x.integer / y.integer)
#define DIVIDE_NUMBER(x, y) NEW_NUMBER(x.long_number / y.long_number)

#define POW_INTEGER(x, y) NEW_INTEGER(pow(x.integer, y.integer))
#define POW_NUMBER(x, y) NEW_NUMBER(pow(x.long_number, y.long_number))


#define DEFINE_OPERATION(name) \
        struct number name(struct number x, struct number y) { \
                if (IS_NUMBER(x) || IS_NUMBER(y)) { \
                        ENSURE_NUMBER(x); \
                        ENSURE_NUMBER(y); \
                        return name##_NUMBER(x, y); \
                } \
                else { \
                        return name##_INTEGER(x, y); \
                } \
        }

