
# DEVELOPMENT STYLE GUIDE

This guide will produce an example plugin for the IPnCIDR framework. This guide will also touch on some of the more commonly
used API calls. This guide will not document all API calls from the Frameworks Core functions, but rather the coding style
and practices used for rapid development and deployment to the core project.

Developers who wish to contribute their code to the baseline framework are encouraged to read and ask questions. Understanding
the environment is one requirment to conforming within. These questions will align the framework and developer 
expectations and requirements for future improvements.

## __FOCUS__

The focus of the framework is to develop a simple yet effective solution to problematic targeting list.

The initial construct was a success and became much more over time. With additional request and finding other solutions which 
were commonly needed for pre-kickoff information gathering (OSINT) before actually starting an engagement. Development can be 
simplified down to three catagories, as follows:

### MAIN FUNCTION (Primary)

Primary functionality of the module which is to be deployed as a function() stored in hash. This sounds more complex than it
really is. The idea is that the function can be stored in memory after it is injested from the users supplied content. The
hash is a global variable which can be called | modified | cloned inside and outside all modules, classes, and functions. Once
the users code has been injested and consumed, the functionality will also be accessible to any other module or function,
creating an API like experience.

### BULK FUNCTION (Secondary)

This is an optional code block which will take the users original list of objects and be processed in serial through the
modules main function. This is often a list supplied to the function as an argument or as a iterated list, each object being
sent to the main function and being processed and returned to the user as intened by the main function determins.

### SINGLE FUNCTION (Tertiary)

This is an optional code block which will take the users original list of objects and be processed through the main function.
This is a user interactive prompt which will accept users content and validate against expected format and sent to the
main function and being processed and returned to the user as intened by the main function determins.

## __BASIC USAGE__

This section touches one some of the basics required to develop modules or plugins for IPnCIDR.

### __SYSTEM :MAINTAINER API__

The maintainer API is the first thing users will want to use when developing their modules, This performs some basic functions
to build the appropiate location and structre to build out the module.

````ruby
$r[:system][:app][:plugins][:maintainer].()
````

Ever module starts off with maintainer information. This information should be sepecific to the modules, its function, and the
maintainers information. This information will be used to store the content within the global hash. The first line will look
like the example below:

````ruby
$mynewplugin = $r[:system][:app][:plugins][:maintainer].(MAINTAINER, CLASSNAME, FUNCTIONNAME)
````

The line above takes the arguments and assigns a specific location stored in the hash and is assigned to the $mynewplugin. You
can use this variable later as a shortcut to the newly created hash. If you want to call the hash directly, the hash is
constructed as follows:

````ruby
$r[:plugins][:MAINTAINER][:CLASSNAME][:FUNCTIONNAME]
````

Notice the MAINTAINER is a symbol and not a string, this is critical to know when attempting to manually locate this location.
Saves loads of time and stree beforehand when you know what your looking for. Once the hash is assigned to the global plugins
hash, it can now accept additional entries to enable the functionality. Let's examine the HELP section next.

### __MODULE :HELP API__

This is an optional section which will give some details about your module to other users of the framework. This is a simple
single line command and most of the structure has already been created for you. This API call will require the user to supply
three arguments contained within an array, as shown below:

````ruby
$mynewplugin[:help] = ["MyAwesomeThing","ex: ExampleDataHere","Does amazing things with user supplied datasets"]
````

If you notice in the command, the previously assigned global hash ($mynewplugin) has been used and an additional KEY has been
assigned to the hash. The value, the array of content, is stored in this hash and later processed by the framework to display
some helpful information about the module. 

### __MODULE :CMD API__

This is a required section and will be the heart of your module. This is where you will store the code which does awesome
things for the framework, be it an expansion or expanded functionality, or a parser that handles output from another module,
what you create and the bounds are limitless based on your own imagination.

Let's dive right into it, we will make an echo function for our module that will accept user input and display it through
STDOUT to the user while being called. This will be expanded later, but this would be the basic skeleton for testing and
development I currently use.

````ruby
$mynewplugin[:cmd] = method(
 def echomod(userinput)
  puts "User has supplied the following content: #{userinput}"
 end
)
````

This bit of code will now be stored as a method within the global hash. This function can be called at any time within your
application, for example; within the bulk or single runs. Additionally maybe another developer would like to use your
functionality in their design, they will call your newly deployed function like so:

````ruby
$mynewplugin[:cmd].("w00tw00tThisISAwesome")
````

When the applicaition reaches this codeblock, it will print to STDOUT a statement and the users supplied content. As shown
above the code is very simplistic and is just enough to show what is the requirement to store the function you develop.
Development can be from IRB or other IDE of your choice, once your function is ready, its as simple as Copy && Paste inside
the method call and stowed in the global hash.

### __MODULE :ACTION API__

This section is use to give the framework user an interface to interact with your module. This can be optional depending on
how your module will be utilized. If there is no user interaction with the user, this section can be skipped. Developers are
also encouraged to create their own menus if required for additional user interactivity outside of the frameworks control.

After execution of the module and all code has been completed, the module will require the user to interact with the framework
and (re)load target list, or go back to the main menu. In some instances, there is no further interactivity required and the
module will automatically reload the main menu.

For this example we will create a standard user interactive menu giving two options, Bulk or Single runs:

````ruby
$mynewplugin[:action] = $r[:system][:app][:default][:action].clone
````

The first thing we will do is build the structure of the dynamic action menu. This API call will create the :action key and
the default value will be set to a hash. This location will now allow the user to append additional "module functionality" and
give the user options on how the functionality is used. Developers are not limited to the following example, creativity is
encouraged and will give the user a better experience in many cases. In the next block of code we will explore the :Additiona API call to add the 'Bulk' function to the hash. 

````ruby
 $r[:system][:app][:plugins][:addaction].($mynewplugin, ["Bulk","Bulk word echo function", method(
  def bulk(userword)
   userword.each { | eachletter |
    $mynewplugin[:cmd].(eachletter)
   }
  end
 )
]
````

As shown above the user must supply the location of your plugin, here we use the shortcut we created earlier, and a newly an
array which contains three fields. These fileds are as described below:

````ruby
   [NAME,DESCRIPTION,FUNCTION]
````

The name is the short description of the new function, in our case we used the word bulk. The following field, is a short
description that will explain the functionality to the framework user. Last but not least, the handler function which will
be used to manipulate the newly developed $mynewplugin[:cmd].() function.

The application will then append the array to the hash and map an assigned numerical value as they are accepted. If there are
no errors within the code and the module is appended, we can move forward with additional functionality is needed. Further we
will append an additional function to the module hash.

````ruby
$r[:system][:app][:plugins][:addaction].($mynewplugin, ["Single","Single word echo function", method(
  def single(userword)
   $mynewplugin[:cmd].(userword)
  end
 )
]
````
As shown above the module will take a user supplied word in a programmatic way and process it, displaying the output to a
user. This process uses a single function and then can utilize the function in different ways manipulating the data where and
how needed by the devloper, providing the user a new interface for their datasets. The imagination is your limitation 

If all goes well, when you reload the framework, all the newly developed freatures will be presented to the user and
functionality will work as expected. With all coding, using traps and rescues are encouraged to ensure functionality as
needed. Additionally the framework developers have included diagnostic functions which will aid you further in identifying
bugs within your plugin.
