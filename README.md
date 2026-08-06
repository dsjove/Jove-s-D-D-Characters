I asked AI to create a new D&D character with image and backstory. Once that was set I then asked it to generate a character sheet with the following requirements. I have yet to find a character sheet that meets those requirements.
Easy to read without my readers
Frequently needed information prominant
Designed for somebody that keeps forgetting nuances of turn actions
Not too busy with adornments
It generated a PDF. But it kept failing to make adjustments. AI admitted that it cannot treat PDF as if it is a source file. Instead it was building python in the background. I looked at the python and then remembered, I hate python. I had it rewritten in swift.
And now I am doing the slow process of of refactoring for reusability. This is not a character generator. I have zero interest in fighting cross-platform frameworks. SwiftUI is a thousand pound buggy gorilla designed for reacive and adaptive UIs. I just want a typesetter.
It is a PDF file generator using CoreGrphics. I have other apps that generate PDFs. So I am looking to have the CoreGraphics PDF builder reused across my apps. I am not out to create the end-all PDF report layout engine. But writing some core graphics helpers is, well, helpful. And no typename should ever be called helper.
