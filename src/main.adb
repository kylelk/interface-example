with Ada.Text_IO;
with KV_Store;
with Hash_Store;
with Redis_Store;

procedure Main is
   package TIO renames Ada.Text_IO;

   package Items is
      use KV_Store;
      procedure Init(Data : in out KV_Interface'Class);
      procedure Done(Data : in out KV_Interface'Class);
      procedure New_Item(Data : in out KV_Interface'Class; Key, Value : String);
      function Get_Item(Data : in out KV_Interface'Class; Key : String) return String;
   end Items;

   package body Items is
      procedure Init(Data : in out KV_Interface'Class) is
      begin
         Data.Setup;
      end Init;

      procedure Done(Data : in out KV_Interface'Class) is
      begin
         Data.Cleanup;
      end Done;

      procedure New_Item(Data : in out KV_Interface'Class; Key, Value : String) is
      begin
         Data.Set(Key, Value);
      end New_Item;

      function Get_Item(Data : in out KV_Interface'Class; Key : String) return String is
      begin
         return Data.Get(Key);
      end Get_Item;
   end Items;

   Data : Hash_Store.Data;
begin
   -- initalize the data store
   Items.Init(Data);

   -- create a new item
   Items.New_Item(Data, "test", "hello world");

   -- get an item by it's key name
   TIO.Put_Line(Items.Get_Item(Data, "test"));

   -- close the data store
   Items.Done(Data);
end Main;
