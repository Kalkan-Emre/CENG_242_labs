#include "Edge.h"


/****************************************************/
/****                *** EDGE ***                ****/

/* Contsructor : initializes <id> of the object to the given integer
   and <password> of the object to the given Password object.   
*/
Edge::Edge(int id, Password password) {
    // TODO
    this->id = id;
    this->password = password;
    this->matchingEdge = NULL;
}

/* Destructor  : It is NOT responsible of the destruction of the matchingEdge!
*/
Edge::~Edge() {
    // TODO
}

/* Returns the <id> of the object
*/
int Edge::getId() const {
	// TODO
	return id;
}

/* Returns the pointer to the matching partner of the current edge.
   If the edge had not been matched before, it returns NULL.
*/
Edge* Edge::getMatchingEdge() const {
    // TODO
    if(this->matchingEdge == NULL){
        return NULL;
    }
    else{
        return this->matchingEdge;
    }
}

/* It tries to match the current Edge object with the one given in the argument.
   If the two edges are matchable then it does the matching by storing
   <matchingEdge> variables with each other, and returns true. Otherwise,
   it does not match and returns false.
   It applies the matching rules given in the pdf.
   Note that match operation is a mutual operation. Namely, if the current
   edge is matched, then its partner edge should be matched with the current 
   one too.
   HINT: It may need matchWithHelper(Password) method.
   
   Note: Of course, it would be nicer to overload this method for taking 
   different types of Edges as arguments, yet this design was preffered 
   specifically for you to discover mechanism of virtual. Helper method
   is given to the issue.
*/
bool Edge::matchWith(Edge& edge) {
    // TODO
    if(matchWithHelper(edge.password)){
        this->matchingEdge = &edge;
        edge.matchingEdge = this;
        return true;
    }
    else{
        this->matchingEdge = NULL;
        edge.matchingEdge = NULL;
        return false;
    }
}

/* If the current edge was matched with some edge before, then this method
   breaks the match, i.e. there is no match between those two edges anymore.
   Note that breaking match operation is a mutual operation. Namely, if the 
   matching of the current edge is broken, the matching recorded in its partner 
   edge should be broken too.
*/
void Edge::breakMatch() {
    // TODO
    this->matchingEdge->matchingEdge = NULL;
    this->matchingEdge = NULL;
}

/****************************************************/
/****            *** STRAIGHT EDGE ***           ****/

/* Contsructor : initializes <id> of the object to the given integer
   and <password> of the object.
   Note that Password variable has a fixed value which is SEND_ME_STRAIGHT,
   therefore it is not given as an argument.
*/
StraightEdge::StraightEdge(int id): Edge(id, SEND_ME_STRAIGHT) {
	// TODO
}

/* Destructor  : It is not responsible of the destruction of the matchingEdge!
*/
StraightEdge::~StraightEdge() {
    // TODO
}

/* This method clones the current object and returns the pointer to its clone.
   Cloning is actually a deep-copy operation, so you need to construct a new
   StraightEdge object.
   Note that if the current edge is matched with some other edge, then its
   matchingEdge should be cloned too and only the clones should be matched 
   with each other.
*/
Edge* StraightEdge::clone() const {
    // TODO
    StraightEdge* my_clone = new StraightEdge(getId());
    if(this->matchingEdge == NULL)
    {
        my_clone->matchingEdge= NULL;
    }
    else if(this->password == SEND_ME_STRAIGHT)
    {
        StraightEdge* my_second_clone = new StraightEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    else if(this->password == SEND_ME_OUTWARDS)
    {
        OutwardsEdge* my_second_clone = new OutwardsEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    else if(this->password == SEND_ME_INWARDS)
    {
        InwardsEdge* my_second_clone = new InwardsEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    return my_clone;
}

/* This method may be needed as a helper for the operation of matchWith(Edge&).
*/
bool StraightEdge::matchWithHelper(Password password) {
    // TODO
    if(password==SEND_ME_STRAIGHT){
        return true;
    }
    else return false;
}

/****************************************************/
/****            *** INWARDS EDGE ***            ****/

/* Contsructor : initializes <id> of the object to the given integer
   and <password> of the object.
   Note that Password variable has a fixed value which is SEND_ME_OUTWARDS,
   therefore it is not given as an argument.
*/
InwardsEdge::InwardsEdge(int id): Edge(id, SEND_ME_OUTWARDS) {
    // TODO
}

/* Destructor  : It is not responsible of the destruction of the matchingEdge!
*/
InwardsEdge::~InwardsEdge() {
    // TODO
}

/* This method clones the current object and returns the pointer to its clone.
   Cloning is actually a deep-copy operation, so you need to construct a new
   InwardsEdge object.
   Note that if the current edge is matched with some other edge, then its
   matchingEdge should be cloned too and only the clones should be matched 
   with each other.
*/
Edge* InwardsEdge::clone() const {
    // TODO
    InwardsEdge* my_clone = new InwardsEdge(getId());
    if(this->matchingEdge == NULL)
    {
        my_clone->matchingEdge= NULL;
    }
    else if(this->password == SEND_ME_STRAIGHT)
    {
        StraightEdge* my_second_clone = new StraightEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    else if(this->password == SEND_ME_OUTWARDS)
    {
        OutwardsEdge* my_second_clone = new OutwardsEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    else if(this->password == SEND_ME_INWARDS)
    {
        InwardsEdge* my_second_clone = new InwardsEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    return my_clone;
}

/* This method may be needed as a helper for the operation of matchWith(Edge&).
*/
bool InwardsEdge::matchWithHelper(Password password) {
    // TODO
    if(password==SEND_ME_INWARDS){
        return true;
    }
    else return false;
}

/****************************************************/
/****            *** OUTWARDS EDGE ***           ****/

/* Contsructor : initializes <id> of the object to the given integer
   and <password> of the object.
   Note that Password variable has a fixed value which is SEND_ME_INWARDS,
   therefore it is not given as an argument.
*/
OutwardsEdge::OutwardsEdge(int id) : Edge(id, SEND_ME_INWARDS){
    // TODO
}

/* Destructor  : It is not responsible of the destruction of the matchingEdge!
*/
OutwardsEdge::~OutwardsEdge() {
    // TODO
}

/* This method clones the current object and returns the pointer to its clone.
   Cloning is actually a deep-copy operation, so you need to construct a new
   OutwardsEdge object.
   Note that if the current edge is matched with some other edge, then its
   matchingEdge should be cloned too and only the clones should be matched 
   with each other.
*/
Edge* OutwardsEdge::clone() const {
    // TODO
    OutwardsEdge* my_clone = new OutwardsEdge(getId());
    if(this->matchingEdge == NULL)
    {
        my_clone->matchingEdge= NULL;
    }
    else if(this->password == SEND_ME_STRAIGHT)
    {
        StraightEdge* my_second_clone = new StraightEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    else if(this->password == SEND_ME_OUTWARDS)
    {
        OutwardsEdge* my_second_clone = new OutwardsEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    else if(this->password == SEND_ME_INWARDS)
    {
        InwardsEdge* my_second_clone = new InwardsEdge(getMatchingEdge()->getId());
        my_clone->matchWith(*my_second_clone);
    }
    return my_clone;
}

/* This method may be needed as a helper for the operation of matchWith(Edge&).
*/
bool OutwardsEdge::matchWithHelper(Password password) {
	// TODO
    if(password==SEND_ME_OUTWARDS){
        return true;
    }
    else return false;
}
