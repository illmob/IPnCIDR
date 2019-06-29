# IPnCIDR

Application designed to aid assessors with breaking down of larger IP || CIDR range(s), and DNS name(s) given by users. Sometimes these lists are combined with different technologies and targeting requirements, and can become cumbersome. This implementation is designed to aid in such situations.

Users who might not be comfortable with Ruby are encouraged to utilize the compiled Binary contained within this project. The currently contained version matches the origin branch of this project. This will allow you to operate the application and develop with little to no staging time. After you have developed your Module or Plugin, submit a Merge Request and work with the Development team for future rollouts. 

Designed with modularity in mind utilizing a plug and play design, frameworked with application API calls, internal storage, preliminary OSINT and Information Gathering before kickoff. Identify issues before loading targeting list into tools and resources that may consume resources. Aid in the identification of mistargeting ranges or erroneous Domains. 

Adding modules to the EXE is quite easy. Follow the design requirements of your module and create the file structure in the directory containing the IPnCIDR.exe as required for your module. Execute the binary and these folders and files will be processed and presented as designed. No need to recompile the binary from source.

Imagination is the limitation that's limitless.

# Requirements and Restrictions

The following are some things to remember about the execution of IPnCIDR:

  -_The application:_
   * will require external Gems, please read GEM section for more information
   * will require user to ensure the environment is correct for proper operation
   * will require a priviledged user for some operations
   * will require users to provide a Targeting list at execution
   * will require a network connection for some module's execution
   * will require the user to interact with a CLI terminal
   * will require modifications to the filesystem if adding external functionality (Modules|Plugins)
   * will require user to direct application towards writing data to disk
   * will utilize Raw Sockets in some conditions
   * will be very loud, there are no plans to reduce any signatures

# IP Address list creation constraints

Supply your own targeting list of data sets, will require internet access. The file should include entries in the following format types. The formats are very common, however; if a type is not identified and you feel it should, create a feature request and describe the format and give an example data set for additional type casting functionality.

  - _CIDR_  = 1.1.1.0/24
  - _DEC_   = 123456789
  - _RANGE_ = 1.1.1.1-1.1.1.45
  - _RANGE_ = 1.1.1-2.1-254
  - _IP_    = 1.1.1.1
  - _DNS_   = google.com
 
Unknown types which do not conform will be identified and disavowed from consumption but will allow the user to later display these items through STDOUT. When a data set is consumed it will be sorted and stored internally within the applications memory. After processing of these datasets the user can display these stored list and/or save them to disk.

Modules and Plugins are used to expand the functionality of the applications framework. Most the baseline functionality and default content which makes the framework functional has been included with this repo or Windows EXEC file. 

# Features will be implemented as time permits

- Whois:  FINISHED
  * Registration Information - FINISHED
  * Known External ranges - FINISHED
  * Other information - FINISHED
- DNS Queries:  FINISHED
  * Forward - FINISHED
  * Reverse - FINISHED
  * DeepScan - FINISHED
- Shodan:  PRIVATE
  * Scanning of known external targets - PRIVATE
  * Scraping of relevant information about targets - PRIVATE
  * Gather historical information - PRIVATE
- Internal IP list:  FINISHED
- External IP list:  FINISHED
- Breakdown:  FINISHED
  * Seperate CIDR ranges to individual IP Address - FINISHED
  * Total Range count output - FINISHED
- Discover:  PLANNED
  * Lee Baird - future - PLANNED
  * Additional modules as time given - PLANNED
