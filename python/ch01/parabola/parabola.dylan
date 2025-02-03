Module: parabola

define class <parabola> (<object>)
  slot a, init-keyword: a:;
  slot b, init-keyword: b:;
  slot c, init-keyword: c:;
end class;

define function main (name :: <string>, arguments :: <vector>)
  let p = make(<parabola>, a: 1, b: 2, c: 1);
  format-out("a: %=\n", p.a);
  format-out("b: %=\n", p.b);
  format-out("c: %=\n", p.c);
  exit-application(0);
end function;

main(application-name(), application-arguments());
