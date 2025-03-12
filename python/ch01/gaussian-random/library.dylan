Module: dylan-user
Synopsis: Module and library definition for simple executable application

define library gaussian-random
  use common-dylan;
  use io, import: { format-out };
end library;

define module gaussian-random
  use common-dylan;
  use simple-random;
  use format-out;
end module;
