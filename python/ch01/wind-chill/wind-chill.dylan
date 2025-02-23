Module: wind-chill

// Ex. 1.2.22

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

define function wind-chill (t, v)
  35.74d0 + 0.6215d0 * t + (0.4275d0 * t - 35.75d0) * (v ^ 0.16d0);
end function;

define function valid? (x, p)
  p(x);
end function;

define function main (name :: <string>, arguments :: <vector>)
  if (arguments.size = 2)
    let t = string-to-float(arguments[0]);
    let v = string-to-float(arguments[1]);

    if (valid?(t, method(t) abs(t) <= 50d0 end method) &
          valid?(v, method(v) 3d0 <= v & v <= 120d0 end method))
      format-out("Amount: %=\n", wind-chill(t, v));
    else
      format-out("Corrupt\n");
      exit-application(1);
    end if;
  end if;

  exit-application(0);
end function;

main(application-name(), application-arguments());
