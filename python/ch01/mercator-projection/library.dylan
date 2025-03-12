Module: dylan-user
Synopsis: Module and library definition for simple executable application

define library mercator-projection
  use common-dylan;
  use io, import: { format-out };
end library;

define module mercator-projection
  use common-dylan;
  use transcendentals;
  use format-out;
end module;
