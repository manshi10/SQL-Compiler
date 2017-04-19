CREATE TABLE ABC ( PersonID int, LastName byte REFERENCES DEF, FirstName varchar, City int REFERENCES DEF );
CREATE TABLE DEF ( Pid int, Lost byte REFERENCES ABC, Addr varchar, Town int REFERENCES NEWTAB );
