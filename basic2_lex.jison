/* description: Basic grammar that contains a nullable A nonterminal. */

%lex
%%

\s+               {/* skip whitespace */}
[a-zA-Z_]\w*      {return 'ID';}
\d+(\.\d*)?([-+]?[eE]\d+)? {yytext = Number(yytext); return 'NUM';}
[=;] {return yytext;}
. {return 'INVALID';}

/lex

%%

P : S { 
    var SS = JSON.stringify(s,undefined,2);
    console.log(SS);
    return "<ul>\n<li>symbol table:<p>"+ SS +"\n</ul>";
    }
  ;

S : E
  | S ';' E
  ;
  
E : ID'='NUM';' {s[$1]=$$=$3;}
  | ID'='INVALID';' {throw new Error('Number Expected on line' + (yy.lexer.yylineno + 1)+":\n" + yy.lexer.showPosition() + '\n');}
  ;
 