student(baker).
student(bloom).
student(campbell).
student(dahle).
student(gaeta).
student(bing_hong).
student(kaeppel).
student(mcauliffe).
student(meconi).
student(medlock).
student(pietenpol).

pairStudents(P) :- student(X), student(Y), X \= Y, P =.. [pair,X,Y].
