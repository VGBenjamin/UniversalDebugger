# Introduction
This is tool you have always wanted but you will never confess that you use it! :-)

With this tool you just need to drop 3 files in your site (even in production because it doesn't restart your iis) to be able to write and execute all the C# code you want in the context of your site.
Very useful for debugging of course.

![Screenshot](/Doc/Screenshot-1.png)

# How to install?
* Download the 3 files UniversalDebugger.aspx, UniversalDebugger.aspx.cs and UniversalDebugger.aspx.designer.cs in the root of your site
* [Optional] Edit the file UniversalDebugger.aspx.cs to change the securityGuid to your own for a minimum of security
* Copy those files to the root of your site
* Open the page http[s]://YOUR_HOST/universaldebugger.aspx?security=YOUR_SECURITY_GUID

Remark: <httpRuntime requestValidationMode="4.5" /> need to be set to your web.config to allow the postback of the code. If you didn't set it you will have an error like "A potentially dangerous Request.Form value was detected from the client"

When you didn't need it anymore do not forget to delete the 3 files from your site's folder.

# How to use it?
* "System dll to load": Here are the dll references to add from the GAC
* "Project dlls to load": These are the dll references contained in your bin folder (by default this is completed with all the dlls from the bin folder)
* "Code": this is the code to execute you can write all the messages you want into the "Output" zone by doing some yield return
* "Output": the result of your code execution
* "Run now": the button to execute your program.

# What is possible with the tool?
All the craps you want! C# 7 is not supported only c# until version 6 is supported

# Disclamer
I am not responsible of what you goanna do with this tool.
