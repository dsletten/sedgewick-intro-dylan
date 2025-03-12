Module: gaussian-random

// Ex. 1.2.24

define function random-double(rs)
  // as(<double-float>, random($maximum-integer, random: rs)) /
  //   as(<double-float>, $maximum-integer);

  //     private static final double DOUBLE_UNIT = 0x1.0p-53; // 1.0 / (1L << 53)
  let double-unit = 1d0 / as(<double-float>, ash(1, 53));   
  let max-int = ash(1, 63) - 1;

  // let high = ash(logand(random($maximum-integer, random: rs), ash(1, 48) - 1), -22);
  // let low = ash(logand(random($maximum-integer, random: rs), ash(1, 48) - 1), -21);
  let high = ash(logand(random(max-int, random: rs), ash(1, 48) - 1), -22);
  let low = ash(logand(random(max-int, random: rs), ash(1, 48) - 1), -21);

  as(<double-float>, ash(high, 27) + low) * double-unit;
end;

define function main (name :: <string>, arguments :: <vector>)
  let rs = make(<random>);
  // let u = random-double(rs);
  // let v = random-double(rs);

//  format-out("%d\n", $maximum-integer);
  format-out("%=\n", random-double(rs));
  format-out("%=\n", random-double(rs));
  format-out("%=\n", random-double(rs));
  format-out("%=\n", random-double(rs));
  format-out("%=\n", random-double(rs));


  // format-out("u: %=\n", u);
  // format-out("v: %=\n", v);

  exit-application(0);
end;

main(application-name(), application-arguments());
