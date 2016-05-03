with Ada.Containers.Hashed_Maps;
with Ada.Strings;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash;
with KV_Store;

package Hash_Store is
   use Ada.Strings.Unbounded;
   package KV_Map is new Ada.Containers.Hashed_Maps
     (Key_Type        => Unbounded_String,
      Element_Type    => Unbounded_String,
      Hash            => Ada.Strings.Unbounded.Hash,
      Equivalent_Keys => "=");

   type Data is new KV_Store.KV_Interface with record
      Values   : KV_Map.Map;
      Modified : Boolean := False;
   end record;

   procedure Setup (self : in out Data);

   procedure Cleanup (self : in out Data);

   procedure Set (Self : in out Data; Key, Value : String);

   function Get (Self : in out Data; Key : String) return String;

   function Contains (Self : Data; Key : String) return Boolean;

   procedure Remove (Self : in out Data; Key : String);

   procedure Commit (Self : in out Data);
end Hash_Store;
