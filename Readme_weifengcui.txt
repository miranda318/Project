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