Module: divides

//
//    Ex. 1.2.11
//

define function divides? (m, n)
  zero?(modulo(m, n)) | zero?(modulo(n, m));
end function;

define function main (name :: <string>, arguments :: <vector>)
  if (arguments.size = 2)
    let m = string-to-integer(arguments[0]);
    let n = string-to-integer(arguments[1]);

    if (m <= 0  |  n <= 0)
      format-out("Corrupt\n");
      exit-application(1);
    else
      if (divides?(m, n))
        format-out("True\n");
      else
        format-out("False\n");
      end if;
    end if;
  end if;

  exit-application(0);
end function;

main(application-name(), application-arguments());
