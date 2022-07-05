:- module(main, [is_movie_directed_by/2, total_awards_nominated/2, all_movies_directed_by/2, total_movies_released_in/3, all_movies_released_between/4]).
:- [kb].

% DO NOT CHANGE THE UPPER CONTENT, WRITE YOUR CODE AFTER THIS LINE
/*
is_movie_directed_by(moonlight,barry_jenkins).
is_movie_directed_by(inside, bo_burnham).
is_movie_directed_by(parasite, bong_joon_ho).
is_movie_directed_by(gone_girl, david_fincher).
is_movie_directed_by(fight_club, david_fincher).
is_movie_directed_by(social_network, david_fincher).
is_movie_directed_by(lady_bird, greta_gerwig).
is_movie_directed_by(little_women, greta_gerwig).
is_movie_directed_by(dead_poets_society, peter_weir).
is_movie_directed_by(coda, sian_heder).
is_movie_directed_by(what_we_do_in_the_shadows, taika_waititi).
is_movie_directed_by(jojo_rabbit, taika_waititi).
is_movie_directed_by(matrix, wachowski_sisters).
is_movie_directed_by(matrix_reloaded, wachowski_sisters).
is_movie_directed_by(matrix_revolutions, wachowski_sisters).
is_movie_directed_by(matrix_resurrections, wachowski_sisters).
is_movie_directed_by(fantastic_mr_fox, wes_anderson).
is_movie_directed_by(moonrise_kingdom, wes_anderson).
is_movie_directed_by(grand_budapest_hotel, wes_anderson).
is_movie_directed_by(isle_of_dogs, wes_anderson).
is_movie_directed_by(french_dispatch, wes_anderson).
*/
is_movie_directed_by(Movie,Director):-movie(Movie,Director,X,Y,Z,Q).

total(X,Y,Z,Total):- Total is (X+Y+Z).
total_awards_nominated(X,Y):- 
    movie(X,Director, ReleaseYear , OscarNoms , EmmyNoms , GoldenGlobeNoms),
    total(OscarNoms , EmmyNoms , GoldenGlobeNoms, Y).
    
    
all_movies_directed_by(Director, W):- 
    findall(X,movie(X, Director, Year, A, B, C), W).

len_if(Year,[],L,L).
len_if(Year,[X|R],L,Result):-
    movie(X,Director,Year,Y,Z,Q),
    N is L+1,
    len_if(Year,R,N,Result).
len_if(Year,[X|R],L,Result):-
    not(movie(X,Director,Year,Y,Z,Q)),
    len_if(Year,R,L,Result).
    

total_movies_released_in(Movies,Year,Count):-
    len_if(Year,Movies,0,Result),
    Count is Result.

app_if(Year1,Year2,[],[]).
app_if(Year1,Year2,[X|R],[X|E]):-
    movie(X,Director,Year,Y,Z,Q),
    Year =< Year2,
    Year >= Year1,
    app_if(Year1,Year2,R,E).
app_if(Year1,Year2,[X|R],L):-
    movie(X,Director,Year,Y,Z,Q),
    Year < Year1,
    app_if(Year1,Year2,R,L).
app_if(Year1,Year2,[X|R],L):-
    movie(X,Director,Year,Y,Z,Q),
    Year > Year2,
    app_if(Year1,Year2,R,L).
app_if(Year1,Year2,[X|R],L):-
    not(movie(X,Director,Year,Y,Z,Q)),
    app_if(Year1,Year2,R,L).


all_movies_released_between( Movies , MinYear , MaxYear , MoviesBetweenGivenYears ):-
    app_if(MinYear,MaxYear,Movies,MoviesBetweenGivenYears).




