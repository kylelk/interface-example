with Ada.Text_IO;
with Ada.Containers.Hashed_Maps;
with Ada.Strings;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash;

with KV_Store;

procedure Main is

   package Hash_Store is
      use Ada.Strings.Unbounded;
      package KV_Map is new Ada.Containers.Hashed_Maps
        (Key_Type        => Unbounded_String,
         Element_Type    => Unbounded_String,
         Hash            => Ada.Strings.Unbounded.Hash,
         Equivalent_Keys => "=");

      type Data is abstract new KV_Store.KV_Container with record
         Values   : KV_Map.Map;
         Modified : Boolean := False;
      end record;

      procedure Setup (self : out Data);
      procedure Cleanup (self : in out Data);
      procedure Set (Self : in out Data; Key, Value : String);
      function Get (Self : in out Data; Key : String) return String;
      function Contains (Self : Data; Key : String) return Boolean;
   end Hash_Store;

   package body Hash_Store is
      procedure Setup (self : out Data) is
      begin
         null;
      end Setup;

      procedure Cleanup (self : in out Data) is
      begin
         null;
      end Cleanup;

      procedure Set (Self : in out Data; Key, Value : String) is
         Result_Cursor : KV_Map.Cursor;
         Inserted      : Boolean;
      begin
         Self.Modified := True;
         Self.Values.Insert
         (To_Unbounded_String
            (Key), To_Unbounded_String
            (Value), Result_Cursor, Inserted);
         if not Inserted then
            Self.Values.Replace_Element
            (Position                  =>
               Result_Cursor, New_Item =>
               To_Unbounded_String (Value));
         end if;
      end Set;

      function Get (Self : in out Data; Key : String) return String is
      begin
         if Self.Contains (Key) then
            return To_String (Self.Values.Element (To_Unbounded_String (Key)));
         else
            raise KV_Store.No_Key_Error;
         end if;
      end Get;

      function Contains (Self : Data; Key : String) return Boolean is
      begin
         return Self.Values.Contains (To_Unbounded_String (Key));
      end Contains;
   end Hash_Store;

   package TIO renames Ada.Text_IO;
begin
   TIO.Put_Line ("hello world");
end Main;
