Hello
Accepted
The Intermediate Code Is:


------------------------------------------------------------------
TableName                 ColumnName                References                
------------------------------------------------------------------
ABC                       PersonID                                           
ABC                       LastName                  DEF                      
ABC                       FirstName                                          
ABC                       City                      DEF                      
------------------------------------------------------------------

Accepted
The Intermediate Code Is:


------------------------------------------------------------------
TableName                 ColumnName                References                
------------------------------------------------------------------
ABC                       PersonID                                           
ABC                       LastName                  DEF                      
ABC                       FirstName                                          
ABC                       City                      DEF                      
DEF                       Pid                                                
DEF                       Lost                      ABC                      
DEF                       Addr                                               
DEF                       Town                      NEWTAB                   
------------------------------------------------------------------

