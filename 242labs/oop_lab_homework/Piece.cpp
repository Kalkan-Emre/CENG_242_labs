#include "Piece.h"


/****************************************************/
/****               *** PIECE ***                ****/

/* Contsructor : initializes <edges> of the object to the those given in the
   argument. The edges given in the argument array should be cloned first,
   and its clones should be reserved, not the edges themselves.
   Note that the ordering of the given edges will always be as follows:
   edges[0]: Left side edge, 
   edges[1]: Bottom side edge, 
   edges[2]: Right side edge, 
   edges[3]: Top side edge.
*/
Piece::Piece(Edge* edges[4]) {
    // TODO
    this->edges[0] = edges[0]->clone();
    this->edges[1] = edges[1]->clone();
    this->edges[2] = edges[2]->clone();
    this->edges[3] = edges[3]->clone();
}

/* Destructor  : It should destruct its edges too.
*/
Piece::~Piece() {
    // TODO
    for(int i=0; i<4 ; i++){
        delete edges[i];
        edges[i] = NULL;
    }
    //delete[] edges;
}

/* Copy constructor : Apply deep copy.
*/
Piece::Piece(const Piece& piece) {
    // TODO
    for(int i=0; i<4 ; i++){
        this->edges[i] = piece.edges[i];
    }
}

// This is already implemented for you, do NOT change it!
ostream& operator<< (ostream& os, const Piece& piece) {

	for (int i = 0; i < 4; i++)
		os << piece.edges[i]->getId() << "  \n";
	return os;
}
