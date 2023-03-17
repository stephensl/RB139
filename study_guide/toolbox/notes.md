# Version managers

  - rbenv
  - RVM 


# Ruby installation 

  - Core library
  - Standard library
  - `irb` REPL (Read Evaluate Print Loop)
  - `rake` utility: automates Ruby development tasks
  - `gem` command: manages ruby gems
  - Documentation tools (`rdoc` and `ri`)


# Gems

  Packages of code that you can download, install, and in Ruby programs or from command line.

  Common gems:
    - `rubocop`
    - `pry`
    - `sequel`- provides classes and methods that simplify database access
    - `rails` - web app framework

  ## Gems and File System

    - Installed to local library 


  ## If need different version of gem

  - Provide an absolute path name to `require`.
  - Add an appropriate `-I` option to the Ruby invocation.
  - Modify $LOAD_PATH prior to requiring `somegem`.
  - Modify the `RUBYLIB` environment variable.