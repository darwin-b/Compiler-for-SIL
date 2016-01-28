
struct treenode *maketreeNode(int type,int nodetype,int value,char* name,struct treenode* arglist,struct treenode* ptr1,struct treenode* ptr2,struct treenode* ptr3)
{
    struct treenode *temp;
    temp = (struct treenode*)malloc(sizeof(struct treenode));
    temp->type = type;
    temp->nodetype = nodetype;
    temp->value = value;
    temp->name = name;
    temp->arglist = arglist;
    temp->ptr1 = ptr1;
    temp->ptr2 = ptr2;
    temp->ptr3 = ptr3;

    return temp;

}

int evaluate(struct treenode *root){

    int i;
    if(root->nodetype == INITIAL)
    {
	evaluate(root->ptr2);         
	evaluate(root->ptr1);
          
    }

    else
    {
        switch(root->nodetype)
        {
            case NUM_NODE : {return root->value; break;}

            case ID_NODE  : {return *var[*(root->name)-'a'] ; break;}

            case '+' :  {
                            return evaluate(root->ptr1) + evaluate(root->ptr2);
                            break;
                        }

            case '-' :  {
                            return evaluate(root->ptr1) - evaluate(root->ptr2);
                            break;
                        }

            case '*' :  {
                            return evaluate(root->ptr1) * evaluate(root->ptr2);
                            break;
                        }
                        
            case '/' :  {
                            return evaluate(root->ptr1) / evaluate(root->ptr2);
                            break;
                        }

            case '<' :  {
                            if(evaluate(root->ptr1)<(evaluate(root->ptr2)))
                                return 1;
                            else
                                return 0;
                            break;
                        }

            case '>' :  {
                            if(evaluate(root->ptr1)>(evaluate(root->ptr2)))
                                return 1;
                            else
                                return 0;
                            break;
                        }

            case EQUAL_NODE : {
                            if(evaluate(root->ptr1)==(evaluate(root->ptr2)))
                                return 1;
                            else
                                return 0;
                            break;
                        }

            case READ_NODE :     {
                                if(var[*(root->ptr2->name)-'a'] == NULL)
                                    var[*(root->ptr2->name)-'a'] = malloc(sizeof(int));

                                scanf("%d",var[*(root->ptr2->name) -'a']);
                                break;

                            }

            case WRITE_NODE:     {
                                
                                i = evaluate(root->ptr2);
                                printf("PRINT: ....... %d\n",i);
                                break;
                            }

            case ASSIGN_NODE:    { int j;
                                if(var[*(root->ptr1->name)-'a']==NULL)
                                    var[*(root->ptr1->name)-'a'] = malloc(sizeof(int));
				
				i = evaluate(root->ptr2);
				
                                *var[*(root->ptr1->name)-'a'] = i;
				//printf(".....%d",*var[*(root->ptr1->name)-'a']);
                                break;                    
                            }


            case IF_NODE:   {
                                if(evaluate(root->ptr1))
                                {
                                    evaluate(root->ptr2);
                                }
                                break;
                            }

            case IF_ELSE_NODE:  {
                                        if(evaluate(root->ptr1))
                                        {
                                            evaluate(root->ptr2);
                                        }
                                        else
                                        {
                                            evaluate(root->ptr3);
                                        }
					break;

                                }
            case WHILE_NODE:     {
                                while(evaluate(root->ptr1))
                                {
                                    evaluate(root->ptr2);
                                };
				break;
                            }
            default:
                        printf("ERROR: UNKNOWN NODE TYEP \n" );
                        exit(1);
           
        }
    }
return 0;

}
