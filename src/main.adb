with Ada.Text_IO;
with KV_Store;
with Hash_Store;

procedure Main is
   package TIO renames Ada.Text_IO;

   generic
      type Data_Store is new KV_Store.KV_Container with private;
   package Items is
      procedure New_Item(Self : in out Data_Store; Key, Value : String);
      function Get_Item(Self : in out Data_Store; Key : String) return String;
   end Items;

   package body Items is
      procedure New_Item(Self : in out Data_Store; Key, Value : String) is
      begin
         Self.Set(Key, Value);
      end New_Item;

      function Get_Item(Self : in out Data_Store; Key : String) return String is
      begin
         return Self.Get(Key);
      end Get_Item;
   end Items;

   Data : Hash_Store.Data;
   package Client is new Items(Hash_Store.Data);
begin
   Client.New_Item(Data, "message", "hello world");
   TIO.Put_Line(Client.Get_Item(Data, "message"));
end Main;
