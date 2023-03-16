# Collection of notes to be distributed categorically based on study guide requirements. 

---
---

# Why write tests?

In the beginning, we focus on tests for preventing regression. Tests are run in order to make sure that updates and changes to the code do not introduce problems in overall functionality. If the code worked as expected before the changes, we test to ensure that it still works after the changes. 

We are able to automate testing in order to avoid manually verifying that the code still works after each update or change. 


# Minitest is Ruby's default testing library and part of Ruby's standard library
  - It is a bundled gem shipped with the default Ruby installation but maintained outside of the Ruby core team and can uninstalled if necessary.


# Minitest vs RSpec

  - Minitest can do everything that RSpec can, but provides simpler syntax.
  - RSpec is a Domain Specific Language for writing tests.
  - Minitest can be used in a way that reads like ordinary Ruby code.

# Vocab 

  - Test Suite: entire set of tests that accompanies program or application. This describes all the tests for a project.
  - Test: context in which tests are run. Tests can contain multiple assertions.
  - Assertion: verification step to confirm that the data returned by the program is what is expected.

# Expectation syntax

  - Different from assert-style syntax 
  - Called expectation or spec-style syntax
  - Tests grouped into `describe` blocks, and individual tests written with the `it` method.
  - Use expectation matchers instead of assertions. 


# Assertions

  - full list here http://docs.seattlerb.org/minitest/Minitest/Assertions.html


