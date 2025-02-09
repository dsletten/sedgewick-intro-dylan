Module: triangle

//
//    Ex. 1.2.12
//
//    https://en.wikipedia.org/wiki/Triangle_inequality
//
//    Explicitly: a + b > c  &  b + c > a  &  a + c > b
//    Equivalently: |a - b| < c < a + b
//    or
//    max(a, b, c) < a + b + c - max(a, b, c) => 2 max(a, b, c) < a + b + c
//    or
//    Area of triangle > 0.
//    
define function triangle-sedgewick? (a :: <integer>, b :: <integer>, c :: <integer>)
  ~((a >= b + c) | (b >= a + c) | (c >= a + b));
end function;

define function triangle? (a :: <integer>, b :: <integer>, c :: <integer>)
  (a < b + c) & (b < a + c) & (c < a + b);
end function;

define function triangle-abs? (a :: <integer>, b :: <integer>, c :: <integer>)
  abs(a - b) < c & c < a + b;
end function;

define function triangle-max? (a :: <integer>, b :: <integer>, c :: <integer>)
  2 * max(a, b, c) < a + b + c;
end function;

define function goldberg-heron (a :: <integer>, b :: <integer>, c :: <integer>)
  //
  //   Assumes a ≥ b ≥ c
  //   
  local method heron (a :: <integer>, b :: <integer>, c :: <integer>)
          let product = (a + (b + c)) * (c - (a - b)) * (c + (a - b)) * (a + (b - c));

          if (product < 0)
            0;
          else
            as(<double-float>, product) ^ 0.5 / 4;
          end if;
        end method;

  apply(heron, sort(list(a, b, c), test: \>));
end function;

define function triangle-area? (a :: <integer>, b :: <integer>, c :: <integer>)
  goldberg-heron(a, b, c) > 0;
end function;

define function main (name :: <string>, arguments :: <vector>)
  if (arguments.size = 3)
    let a = string-to-integer(arguments[0]);
    let b = string-to-integer(arguments[1]);
    let c = string-to-integer(arguments[2]);

    if (every?(positive?, list(a, b, c)))
      if (triangle-sedgewick?(a, b, c))
        format-out("True\n");
      else
        format-out("False\n");
      end if;

      if (triangle?(a, b, c))
        format-out("True\n");
      else
        format-out("False\n");
      end if;

      if (triangle-abs?(a, b, c))
        format-out("True\n");
      else
        format-out("False\n");
      end if;

      if (triangle-max?(a, b, c))
        format-out("True\n");
      else
        format-out("False\n");
      end if;

      if (triangle-area?(a, b, c))
        format-out("True\n");
      else
        format-out("False\n");
      end if;
    else
      format-out("Corrupt\n");
      exit-application(1);
    end if;
  end if;

  exit-application(0);
end function;

main(application-name(), application-arguments());
