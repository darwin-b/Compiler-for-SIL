#define INT 			1
#define BOOL 			2
#define VOID 			3
#define TRUE 			4
#define FALSE 			5
#define INITIAL     		6

#define ID_NODE			7
#define NUM_NODE		8
#define IF_NODE 		9
#define IF_ELSE_NODE		10
#define WHILE_NODE		11
#define	READ_NODE		12
#define	WRITE_NODE		13
#define	EQUAL_NODE		14
#define ASSIGN_NODE		15


int* var[26];


struct treenode {

int type; 						// Integer, Boolean or Void (for statements)
							 	/* Must point to the type expression tree for user defined types */

int nodetype;

								/* this field should carry following information:

								* a) operator : (+,*,/ etc.) for expressions

								* b) statement Type : (WHILE, READ etc.) for statements */


char* name; 					// For Identifiers/Functions

int value; 						// for constants

struct treenode *arglist; 				// List of arguments for functions

struct treenode *ptr1, *ptr2, *ptr3;	// Maximum of three subtrees (3 required for IF THEN ELSE 

struct Gsymbol *gentry; 				// For global identifiers/functions

struct Lsymbol *lentry; 				// For Local variables

};

struct treenode *maketreenode(int type,int nodetype,int value,char* name,struct treenode* arglist,struct treenode* ptr1,struct treenode* ptr2,struct treenode* ptr3);

int evaluate(struct treenode* root);
