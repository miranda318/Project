# Project
Home View Controller 
-	Search bar: For decoration purpose
-	Scan button: link to Scan barcode view controller
-	View: solution 1: fake table view for product category
         Solution 2: static product list
Scan Barcode View Controller
-	Cancel: programmatically link back to home view controller or search product table view controller (depends)
-	Rescan: rescan 
-	Player view: capture barcode
-	View under player view: appear when scan success. If success, it becomes a link to product review table view controller
Product review table view controller 
-	Header: 
o	section 1: product image, product name, brand, rating view to display rating (average of all the ratings), price, number of likes (not implement according to current plan).
o	Section 2: 2 buttons
o	Section 3: review summary from Amazon API
-	Table view: individual user review
Add Review view controller 
-	Cancel: back to product review table view controller
-	Post: post 
-	Rating view: add ratings
-	Subject: review title 
-	Text view: review details
Login: haven’t done so far.

TPFloatRatingView: the library that can display and capture star ratings (whole star, half star, and floating star) Demo: https://github.com/strekfus/TPFloatRatingView
