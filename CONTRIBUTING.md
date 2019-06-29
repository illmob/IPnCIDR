Contributions to the project must follow a specific coding guideline for uniformity. These standards will aid in the overall
ability to develop and distribute this additional functionality to all users with little to no modifications of the main project.

At times there will be requirements to modify the underlying functionality of the main application, however; this is only after the module has been vetted by project maintainers and tested to ensure the functionality will deliver 100% of the time or within reasonable stop gaps and exception handlers to provide a clean user experience.

Development can be summed up to three actual coding requirements:

__MAIN FUNCTION__

Primary functionality of the module which is to be deployed as a function() stored in hash. This sounds more complex than it really is. The idea is that the function can be stored in memory after it is injested from the users supplied content. The hash is a global variable which can be called | modified | cloned inside and outside all modules, classes, and functions. Once the users code has been injested and consumed, the functionality will also be accessible to any other module or function, creating an API like experience.

__BULK FUNCTION__

This is an optional code block which will take the users original list of objects and be processed in serial through the modules main function. This is often a list supplied to the function as an argument or as a iterated list, each object being sent to the main function and being processed and returned to the user as intened by the main function determins.

__SINGLE FUNCTION__

This is an optional code block which will take the users original list of objects and be processed through the main function.
This is a user interactive prompt which will accept users content and validate against expected format and sent to the
main function and being processed and returned to the user as intened by the main function determins.

**BASIC TRAINING**

This section touches one some of the basics required to develop modules or plugins for IPnCIDR.

__SYSTEM :MAINTAINER API__

The maintainer API is the first thing users will want to use when developing their modules, This performs some basic functions
to build the appropiate location and structre to build out the module.

````ruby
$r[:system][:app][:plugins][:maintainer].()
````

Ever module starts off with maintainer information. This information should be sepecific to the modules, its function, and the maintainers information. This information will be used to store the content within the global hash. The first line will look like the example below:

````ruby
$mynewplugin = $r[:system][:app][:plugins][:maintainer].(MAINTAINER, CLASSNAME, FUNCTIONNAME)
````

The line above takes the arguments and assigns a specific location stored in the hash and is assigned to the $mynewplugin. You can use this variable later as a shortcut to the newly created hash. If you want to call the hash directly, the hash is constructed as follows:

````ruby
$r[:plugins][:MAINTAINER][:CLASSNAME][:FUNCTIONNAME]
````

Notice the MAINTAINER is a symbol and not a string, this is critical to know when attempting to manually locate this location. Saves loads of time and stree beforehand when you know what your looking for. Once the hash is assigned to the global plugins hash, it can now accept additional entries to enable the functionality. Let's examine the HELP section next.

__MODULE :HELP API__

This is an optional section which will give some details about your module to other users of the framework. This is a simple single line command and most of the structure has already been created for you. This API call will require the user to supply three arguments contained within an array, as shown below:

````ruby
$mynewplugin[:help] = ["MyAwesomeThing","ex: ExampleDataHere","Does amazing things with user supplied datasets"]
````

If you notice in the command, the previously assigned global hash ($mynewplugin) has been used and an additional KEY has been assigned to the hash. The value, the array of content, is stored in this hash and later processed by the framework to display
some helpful information about the module. 

__MODULE :CMD API__

This is a required section and will be the heart of your module. This is where you will store the code which does awesome things for the framework, be it an expansion or expanded functionality, or a parser that handles output from another module, what you create and the bounds are limitless based on your own imagination.

Let's dive right into it, we will make an echo function for our module that will accept user input and display it through STDOUT to the user while being called. This will be expanded later, but this would be the basic skeleton for testing and development I currently use.

````ruby
$mynewplugin[:cmd] = method(
 def echomod(userinput)
  puts "User has supplied the following content: #{userinput}"
 end
)
````

This bit of code will now be stored as a method within the global hash. This function can be called at any time within your application, for example; within the bulk or single runs. Additionally maybe another developer would like to use your functionality in their design, they will call your newly deployed function like so:

````ruby
$mynewplugin[:cmd].("w00tw00tThisISAwesome")
````

When the applicaition reaches this codeblock, it will print to STDOUT a statement and the users supplied content. As shown above the code is very simplistic and is just enough to show what is the requirement to store the function you develop. Development can be from IRB or other IDE of your choice, once your function is ready, its as simple as Copy && Paste inside the method call and stowed in the global hash.


