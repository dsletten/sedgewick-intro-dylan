Module: mercator-projection

//
//    Ex. 1.2.28
//    Can't use lat/long with > 7 digits to right of decimal point!!!!
//    

define constant r = 6378137d0; // Earth equatorial mean radius (m) https://en.wikipedia.org/wiki/World_Geodetic_System

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
end;

define function valid? (x, p)
  p(x);
end;

define function degrees->radians (theta)
//  theta * $double-pi / 180d0;
  theta * ($double-pi / 180d0); // Consistent with Lisp/Java
end;

define function mercator-projection-degrees (long0, long, lat)
  mercator-projection(degrees->radians(long0), degrees->radians(long), degrees->radians(lat));
end;

define function mercator-projection (long0, long, lat)
  values(r * (long - long0), r * 0.5d0 * log((1 + sin(lat)) / (1- sin(lat))));
end;

define function main (name :: <string>, arguments :: <vector>)
  if (arguments.size = 3)
    block()
      let long0 = string-to-float(arguments[0]);
      let lat = string-to-float(arguments[1]);
      let long = string-to-float(arguments[2]);
      
      if (valid?(long0, method(long0) -180 <= long0 & long0 <= 180 end))
        if (valid?(lat, method(lat) -90 < lat & lat < 90 end))
          if (valid?(long, method(long) -180 <= long & long <= 180 end))
            let (x, y) = mercator-projection-degrees(long0, long, lat);
            format-out("Latitude: %=° Longitude: %=° -> (%= m, %= m)\n", lat, long, x, y);
          else
            format-out("Invalid longitude: %s\n", arguments[2]);
            exit-application(1);
          end;
        else
          format-out("Invalid latitude: %s\n", arguments[1]);
          exit-application(1);
        end;
      else
        format-out("Invalid λ₀ center: %s\n", arguments[0]);
        exit-application(1);
      end;
    exception (condition :: <error>)
      format-out("Corrupt\n");
      exit-application(1);
    end;
  end;

  exit-application(0);
end function;

main(application-name(), application-arguments());
