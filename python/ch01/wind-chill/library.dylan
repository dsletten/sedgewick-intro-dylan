Module: dylan-user
Synopsis: Module and library definition for simple executable application

define library wind-chill
  use common-dylan;
  use io, import: { format-out };
end library;

define module wind-chill
  use common-dylan;
  use format-out;
end module;
