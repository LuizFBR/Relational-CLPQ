:- module(relational_clpq, [
    op(700, xfx, :>:),
    op(700, xfx, :<:),    
    op(700, xfx, :>=:),  
    op(700, xfx, :=<:),   
    op(700, xfx, :=:),   
    op(700, xfx, :\=:)
]).

:- use_module(library(clpfd)).
:- set_prolog_flag(clpfd_monotonic, true).


% Reification operators:
% :- op(760, yfx, :<==>:). % P :<==>: Q	True iff P and Q are equivalent
% :- op(750, xfy, :==>:).  % P :==>: Q	True iff P implies Q
% :- op(750, yfx, :<==:).  % P :<==: Q	True iff Q implies P
% :- op(740, yfx, :\/:).   % P :\/: Q	    True iff either P or Q
% :- op(730, yfx, :\:).    % P :\: Q	    True iff either P or Q, but not both
% :- op(720, yfx, :/\:).   % P :/\: Q	    True iff both P and Q
% :- op(710,  fy, :\).     % :\ Q	        True iff Q is false

% Comparison operators:
:- op(700, xfx, :>:).    % Expr1 #> Expr2	 Expr1 is greater than Expr2
:- op(700, xfx, :<:).    % Expr1 #< Expr2	 Expr1 is less than Expr2
:- op(700, xfx, :>=:).   % Expr1 #>= Expr2	 Expr1 is greater than or equal to Expr2
:- op(700, xfx, :=<:).   % Expr1 #=< Expr2	 Expr1 is less than or equal to Expr2
:- op(700, xfx, :=:).    % Expr1 #= Expr2	 Expr1 equals Expr2
:- op(700, xfx, :\=:).   % Expr1 #\= Expr2	 Expr1 is not equal to Expr2

% Domain operators:
% :- op(700, xfx, in).
% :- op(700, xfx, ins).
% :- op(450, xfx, .:.). % should bind more tightly than \/ - equivalent clpfd to ..
% :- op(150, fx, :). % equivalent to clpfd #

A :=: B :-  phrase(eval(A :=: B,_),_).

A :\=: B :- phrase(eval(A :\=: B,_),_).

A :=<: B :- phrase(eval(A :=<: B,_),_).

A :<: B :-  phrase(eval(A :<: B,_),_).

A :>=: B :- phrase(eval(B :=<: A,_),_).

A :>: B :-  phrase(eval(B :<: A,_),_).

eval(N,N/1) --> {number(N)}, !.  
eval(V,V/1) --> {var(V)}, !.

eval((L * R), Numerator/Denominator) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {#(Numerator) #= #(LP) * #(RP), #(Denominator) #= #(LQ) * #(RQ)}.

eval((L / R), Numerator/Denominator) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {#(Numerator) #= #(LP) * #(RQ), #(Denominator) #= #(LQ) * #(RP)}.

eval((L + R), Numerator/Denominator) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {
            #(LQ) #= #(RQ),
            #(Numerator) #= #(LP) + #(RP),
            #(Denominator) #= #(LQ)
        ;
            #(LQ) #\= #(RQ),
            #(LP_RQ) #= #(LP) * #(RQ), #(RP_LQ) #= #(RP) * #(LQ),
            #(Numerator) #= #(LP_RQ) + #(RP_LQ),
            #(Denominator) #= #(LQ) * #(RQ)
    }.

eval((L - R), Numerator/Denominator) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {
            #(LQ) #= #(RQ),
            #(Numerator) #= #(LP) - #(RP),
            #(Denominator) #= #(LQ)
        ;
            #(LP_RQ) #= #(LP) * #(RQ), #(RP_LQ) #= #(RP) * #(LQ),
            #(Numerator) #= #(LP_RQ) - #(RP_LQ),
            #(Denominator) #= #(LQ) * #(RQ)
    }.

eval((L :=: R), true) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {#(LP) * #(RQ) #= #(RP) * #(LQ)}.

eval((L :\=: R), true) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {#(LP) * #(RQ) #\= #(RP) * #(LQ)}.

eval((L :=<: R), true) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {#(LP) * #(RQ) #=< #(RP) * #(LQ)}.

eval((L :<: R), true) -->
    eval(L,LP/LQ), eval(R,RP/RQ),
    {#(LP) * #(RQ) #< #(RP) * #(LQ)}.