# Pre-work - *TipMe*

TipMe is a tip calculator application for iOS.

Submitted by: Rob Enriquez

Time spent: 20 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] User can choose to enter either tax percentage or tax amount.
- [X] User can choose to divide the bill amount amongst the group (e.g. 2 people, etc).
- [X] Settings page to change the default number of people to split the bill with.
- [X] User can choose a different country, then the currency and thousands separator will update per the country's locale.
- [X] Utilizes Cocoapods to handle dependencies (e.g. countryPicker).

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

https://github.com/robegamesios/tipCalculator/blob/develop/demoGif2.gif

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** The iOS development platform is constantly changing, but for the better. Swift has made it easier for a lot of people to learn to code. Outlets and actions provide a way to reference an object you added to the storyboard in the source file. This creates a property for the object in the viewController, which lets you access and maniputate the object from code at runtime.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** For example, you have two objects, Object A and Object B. If object A holds a strong reference to object B and object B has a strong reference to object A then we have a strong reference cycle.  You can avoid this in blocks or closures by holding a weak reference to the object, e.g. weakSelf or [weak self]. By capturing the weak reference to self, the block won’t maintain a strong relationship to the object.


## License

	MIT License

	Copyright (c) 2017 Robert Enriquez

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.