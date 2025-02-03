Module: dylan-user
Synopsis: Module and library definition for simple executable application

define library floatops
  use common-dylan;
  use io, import: { format-out };
  use json;
end library;

define module floatops
  use common-dylan;
  use format-out;
  use json;
end module;
