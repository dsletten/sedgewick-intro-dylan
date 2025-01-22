Module: floatops

define method string-to-float(s :: <string>) => (f :: <float>)
  local method is-digit?(ch :: <character>) => (b :: <boolean>)
    let v = as(<integer>, ch);
    v >= as(<integer>, '0') & v <= as(<integer>, '9');
  end method;
  let lhs = make(<stretchy-vector>);
  let rhs = make(<stretchy-vector>);
  let state = #"start";
  let sign = 1;

  local method process-char(ch :: <character>)
    select(state)
      #"start" =>
        select(ch)
          '-' => 
            begin
              sign := -1;
              state := #"lhs";
            end;
          '+' =>
            begin
              sign := 1;
              state := #"lhs";
            end;
          '.' =>
            begin
              lhs := add!(lhs, '0');
              state := #"rhs";
            end;
          otherwise =>
            begin
              state := #"lhs";
              process-char(ch);
            end;
        end select;
      #"lhs" => 
        case
          is-digit?(ch) => lhs := add!(lhs, ch);
          ch == '.' => state := #"rhs";
          otherwise => error("Invalid floating point value.");
        end case;
      #"rhs" =>
        case
          is-digit?(ch) => rhs := add!(rhs, ch);
          otherwise => error("Invalid floating point value.");
        end case;
      otherwise => error("Invalid state while parsing floating point.");
    end select;
  end method;

  for(ch in s)
    process-char(ch);
  end for;

  let lhs = as(<string>, lhs);
  let rhs = if(empty?(rhs)) "0" else as(<string>, rhs) end;
  (string-to-integer(lhs) * sign)
   + as(<double-float>, string-to-integer(rhs) * sign)
     / (10 ^ min(rhs.size, 7)); 
end method string-to-float;

define function main
    (name :: <string>, arguments :: <vector>)
  let a = string-to-float(arguments[0]);
  let b = string-to-float(arguments[1]);

  // let a = 123.456d0;
  // let b = 78.9d0;
  
  let sum = a + b;
  let difference = a - b;
  let product = a * b;
  let quotient = a / b;
//  let remainder = remainder(a, b);
  let power = a ^ b;


  format-out("%d + %d = %d\n", a, b, sum);
  format-out("%d - %d = %d\n", a, b, difference);
  format-out("%d * %d = %d\n", a, b, product);
  format-out("%d / %d = %d\n", a, b, quotient);
//  format-out("%d %% %d = %d\n", a, b, remainder);
  format-out("%d ^ %d = %d\n", a, b, power);

  exit-application(0);
end function;

// Calling our top-level function (which may have any name) is the last
// thing we do.
main(application-name(), application-arguments());
