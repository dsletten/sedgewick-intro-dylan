Module: use-three

define function main
    (name :: <string>, arguments :: <vector>)
  format-out("Hi %s, %s, and %s.\n", arguments[2], arguments[1], arguments[0]);
//  format-out("%=\n", reverse(arguments));

  exit-application(0);
end function;

// Calling our top-level function (which may have any name) is the last
// thing we do.
main(application-name(), application-arguments());
