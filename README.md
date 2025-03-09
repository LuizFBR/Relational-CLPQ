# Relational-CLPQ

## !!! This library currently does not work for properly constraining Prolog variables rationally !!!

A Prolog pack built on top of CLPFD that allows reasoning about the rational numbers.

To-do:
- More robust testing strategy (Limit Value Analysis);
- Implementing logical (and, or, ...) operators;
- Implementing domain/membership operators.
- Implementing other arithmetic operators (^, mod, rem, min, max,...).

## Installation

To install the relational-clpq library, type the following in the SWI-Prolog shell:

```Prolog
? - pack_install('relational_clpq').
  true.
```
or, alternatively, you can install directly from this github repo:

```Prolog
?- pack_install('https://github.com/LuizFBR/Relational-CLPQ.git').
  true.
```

## Examples

### Comparison of rational numbers:

```Prolog
1 ?- 10 :=: 10 .
true.
```

The following example shows clpfd's purity (two-way relation) in action:

```Prolog
2 ?- (10 + X) / Y :=: Z .
clpfd: #=(10+ #(X), #(_A)),
clpfd: #=(#(Z)* #(Y), #(_A)) .
```



```Prolog
3 ?- 1/2 :=<: 1/2 .
true ;
false.
```

```Prolog
3 ?- 1/2 :=<: 1/4 .
false.
```

## List of all comparison constraints:


| Operator          | Meaning                                   |
| ----------------- | ----------------------------------------- |
| Expr1 :=:  Expr2	| Expr1 equals Expr2                        |
| Expr1 :\=: Expr2	| Expr1 is not equal to Expr2               |
| Expr1 :>=: Expr2	| Expr1 is greater than or equal to Expr2   |
| Expr1 :=<: Expr2	| Expr1 is less than or equal to Expr2      |
| Expr1 :>:  Expr2	| Expr1 is greater than Expr2               |
| Expr1 :<:  Expr2	| Expr1 is less than Expr2                  |


## Importing

Import this module with

```Prolog
:- use_module(library(relational_clpq)).
```

## Dependencies

This library depends on Markus Triskas' clpfd library:

https://www.swi-prolog.org/man/clpfd.html
