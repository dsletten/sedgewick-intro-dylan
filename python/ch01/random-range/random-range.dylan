Module: random-range

define function random-range (a :: <integer>, b :: <integer>)
  if (a > b)
    random-range(b, a);
  else
    random(b - a + 1, random: make(<random>)) + a;
  end if;
end function;

define function main (name :: <string>, arguments :: <vector>)
  if (arguments.size = 2)
    let a = string-to-integer(arguments[0]);
    let b = string-to-integer(arguments[1]);

    format-out("Random [%d,%d]: %d\n", a, b, random-range(a, b));
  end if;

  exit-application(0);
end function;

main(application-name(), application-arguments());
