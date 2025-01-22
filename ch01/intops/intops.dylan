Module: intops

define function main
    (name :: <string>, arguments :: <vector>)
  let a = string-to-integer(arguments[0]);
  let b = string-to-integer(arguments[1]);

  let sum = a + b;
  let difference = a - b;
  let product = a * b;
//  let quotient = truncate(a / b);
  let remainder = remainder(a, b);
  let power = a ^ b;


  format-out("%d + %d = %d\n", a, b, sum);
  format-out("%d - %d = %d\n", a, b, difference);
  format-out("%d * %d = %d\n", a, b, product);
//  format-out("%d / %d = %d\n", a, b, quotient);
  format-out("%d %% %d = %d\n", a, b, remainder);
  format-out("%d ^ %d = %d\n", a, b, power);

  exit-application(0);
end function;

// Calling our top-level function (which may have any name) is the last
// thing we do.
main(application-name(), application-arguments());
