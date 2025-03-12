Module: day-of-week

// Ex. 1.2.26

define function valid? (x, p)
  p(x);
end;

define function leap-year?(y)
  if (modulo(y, 400) == 0)
    #t;
  elseif (modulo(y, 100) == 0)
    #f;
  else
    modulo(y, 4) == 0
  end;
end;

define function month-length (m, y)
  select (m)
    4, 6, 9, 11 => 30;
    2 => if (leap-year?(y)) 29; else 28 end;
    otherwise => 31;
  end;
end;

define function valid-day? (d, m, y)
  1 <= d & d <= month-length(m, y);
end;

define function day-of-week (d, m, y)
  let y0 = y - truncate/(14 - m, 12);
  let x = y0 + truncate/(y0, 4) - truncate/(y0, 100) + truncate/(y0, 400);
  let m0 = m + 12 * truncate/(14 - m, 12) - 2;

  modulo(d + x + truncate/(31 * m0, 12), 7);
end;

define function get-day-of-week-name (d)
  #["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"][modulo(d + 6, 7)];
end;

define function main (name :: <string>, arguments :: <vector>)
  if (arguments.size = 3)
    block()
      let m = string-to-integer(arguments[0]);
      let d = string-to-integer(arguments[1]);
      let y = string-to-integer(arguments[2]);
      
      if (valid?(m, method(m) 1 <= m & m <= 12 end))
        if (valid?(y, method(y) y >= 1582 end))
          if (valid?(d, method(d) valid-day?(d, m, y) end))
            let dow = day-of-week(d, m, y);

            format-out("%d (%s)\n", dow, get-day-of-week-name(dow));
          else
            format-out("Invalid day of month: %s\n", arguments[1]);
            exit-application(1);
          end;
        else
          format-out("Invalid year: %s\n", arguments[2]);
          exit-application(1);
        end;
      else
        format-out("Invalid month: %s\n", arguments[0]);
        exit-application(1);
      end;
    exception (condition :: <error>)
      format-out("Corrupt\n");
      exit-application(1);
    end;
  end;

  exit-application(0);
end;

main(application-name(), application-arguments());
