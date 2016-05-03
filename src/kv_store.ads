package KV_Store is
   type KV_Interface is interface;
   No_Key_Error : exception;

   procedure Setup (self : in out KV_Interface) is abstract;

   procedure Cleanup (Self : in out KV_Interface) is abstract;

   procedure Commit (Self : in out KV_Interface) is abstract;

   procedure Set (Self : in out KV_Interface; Key, Value : String) is abstract;

   function Get (Self : in out KV_Interface; Key : String) return String is abstract;

   function Contains(Self : KV_Interface; Key : String) return Boolean is abstract;

   procedure Remove(Self : in out KV_Interface; Key : String) is abstract;
end KV_Store;
