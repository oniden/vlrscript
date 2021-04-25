grammar Biol;

// parser

vlrImport : Import MODIDENT ;

assignment : TYPE VFIDENT (Assign argList)? ;

expression : VFIDENT # Vfident
     | STRLIT # Strlit
     | INTLIT # Intlit
     | DECLIT # Declit
     | '(' binOp ')' # Binop
     | '(' funcCall ')' # Funccall
     | '(' expression ')' # Expr
     ;

argList : (VFIDENT | expression)+ ;

binOp : expression Oper expression # Leaf
      | binOp Oper expression # Inner
      | expression Oper binOp # Inner
      ;

funcCall : VFIDENT Assign (argList)? ;

statement : expression
          | assignment
          | VFIDENT RevAssign VFIDENT
          ;

root : (vlrImport | binOp | assignment | funcCall | statement | NL)* ;


// lexer
// Keywords' and symbols' first letter of each word is capitalized
// Lexer rules detailing user controlled names/numbers should be full capital (VFIDENT, MODIDENT)

fragment LOWERCASE : [a-z] ;
fragment UPPERCASE : [A-Z] ;
fragment DIGIT : [0-9] ;
fragment IDENTBODY : (DIGIT | UPPERCASE | LOWERCASE | '_')* ;

WS : (' ' | '\t') -> channel(HIDDEN) ;
NL : ('\r'? '\n' | '\r')+ ;

Assign : '<<' ;
RevAssign : '>>' ;

Import : 'bib' ;

/* built in
'ENTY'
'CLNT'
'VLR'
'CTRL'
*/
TYPE : UPPERCASE+ ;

INTLIT : ('-' | '+')? DIGIT+ ;
// sign, integral, decimal (integral if no .)
DECLIT : ('-' | '+')? (DIGIT* '.')? DIGIT+ ;

Oper : '+'
     | '-'
     | '*'
     | '/'
     | '^'
     ;

// variable / function identifier
VFIDENT : (DIGIT | UPPERCASE) IDENTBODY ;
MODIDENT : (DIGIT | LOWERCASE) IDENTBODY ;
STRLIT : '"' ( '\\' [btnfr"'\\] | ~[\r\n\\"] )* '"' ;