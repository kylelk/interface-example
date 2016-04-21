with Ada.Text_IO;
with KV_Store;
with Hash_Store;

procedure Main is
   package TIO renames Ada.Text_IO;

   generic
      type Data_Store is new KV_Store.KV_Container with private;
   package Items is
      procedure New_Item(Self : in out Data_Store; Key, Value : String);
   end Items;

   package body Items is
      procedure New_Item(Self : in out Data_Store; Key, Value : String) is
      begin
         Self.Set(Key, Value);
      end New_Item;
   end Items;


begin


   TIO.Put_Line ("hello world");
end Main;
