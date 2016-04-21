with Ada.Text_IO;
with KV_Store;
with Hash_Store;

procedure Main is
   package TIO renames Ada.Text_IO;

   generic
      type Data_Store is private;
   package Items is
      type Status is tagged record
         Values : Data_Store;
      end record;

      procedure Set(Self : in out Status; Key, Value : String);
   end Items;

   package body Items is
   begin
      end Items;
begin
   TIO.Put_Line ("hello world");
end Main;
