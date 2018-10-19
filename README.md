calc
====
Calculator based on lex and yacc. 

##Usage

```
$ make
$ echo '5 + 5' | ./calc
10
$ ./calc
>> foo = 2 * 3
=> 6
>> bar = foo ^ 2
=> 36
>> baz = foo + bar
=> 42
>> 3 + 4.3
=> 7.3
```

##License

calc contains `khash.h` which is licensed under the terms of the MIT license. More info can be found here: http://attractivechaos.awardspace.com/khash.h.html
