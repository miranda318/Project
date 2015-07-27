//weifengcui

July 24, 14:38

-create group Framework
-add Parse framework



//When save an object to database
- [SaveToParse saveToParse]

//read from DB
- QueryFromParse, for now, only a demo could be used, copy the code and change to yours


--read product info, using upc from Amazon
[AmazonAPI getProductInfoFromUPC:(NSString*)upcID]

------------------------------------------------------

July 27,15

Add Facebook login

Steps:

-add two frame work, facebookcore and facebook login
-info.plist
-in appdelegate.m
-add code to viewcontroller