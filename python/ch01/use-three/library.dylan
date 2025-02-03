Module: dylan-user
Synopsis: Module and library definition for simple executable application

define library use-three
  use common-dylan;
  use io, import: { format-out };
end library;

define module use-three
  use common-dylan;
  use format-out;
end module;
