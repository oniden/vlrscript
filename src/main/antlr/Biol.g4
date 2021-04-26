grammar Biol;

// parser

vlrImport : Import MODIDENT ;

funcCall : VFIDENT Assign (argList)? ;

assignment : TYPE VFIDENT (Assign argList)? ;

expression : VFIDENT # Vfident
           | STRLIT # Strlit
           | INTLIT # Intlit
           | DECLIT # Declit
           | Lpar funcCall Rpar # Funccall
           | Lpar binOp Rpar # Binop
           | Lpar expression Rpar # Expr
           ;

argList : (VFIDENT | expression)+ ;

binOp : binOp Pow binOp
      | binOp (Mul | Div) binOp
      | binOp (Add | Sub) binOp
      | binOp SQuote binOp
      | expression
      ;

statement : expression
          | assignment
          | VFIDENT RevAssign VFIDENT
          ;

root : (vlrImport | binOp | assignment | funcCall | statement | NL)* EOF ;


// lexer
// Keywords' and symbols' first letter of each word is capitalized
// Lexer rules detailing user controlled names/numbers should be full capital (VFIDENT, MODIDENT)

fragment LOWERCASE : [a-z] ;
fragment UPPERCASE : [A-Z] ;
fragment LETTER : UPPERCASE | LOWERCASE ;
fragment DIGIT : [0-9] ;
fragment ALPHANUM : LETTER | DIGIT ;
fragment IDENTBODY : (ALPHANUM '_')* ;

WS : (' ' | '\t') -> channel(HIDDEN) ;
NL : ('\r'? '\n' | '\r')+ ;

Assign : '<<' ;
RevAssign : '>>' ;
SQuote : '\'' ;
Compare : '=' ;

Import : 'bib' ;

Add : '+' ;
Sub : '-' ;
Mul : '*' ;
Div : '/' ;
Pow : '^' ;
Lpar : '(' ;
Rpar : ')' ;

Comment : '|' '.*' '(?<!\)|' ;


/* built in
'ENTY'
'CLNT'
'VLR'
'CTRL'
*/
TYPE : UPPERCASE+ ;
// variable / function identifier
VFIDENT : (DIGIT | UPPERCASE) IDENTBODY? ;
MODIDENT : (DIGIT | LOWERCASE) IDENTBODY ;

INTLIT : ('-')? DIGIT+ ;
// sign, integral, decimal (integral if no .)
DECLIT : ('-')? (DIGIT* '.')? DIGIT+ ;
STRLIT : '"' ( '\\' [btnfr"'\\] | ~[\r\n\\"] )* '"' ;