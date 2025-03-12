Module: dylan-user
Synopsis: Module and library definition for simple executable application

define library order-check
  use common-dylan;
  use io, import: { format-out };
end library;

define module order-check
  use common-dylan;
  use format-out;
end module;
