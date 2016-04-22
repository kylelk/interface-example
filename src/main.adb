with Ada.Text_IO;
with KV_Store;
with Hash_Store;
with Redis_Store;

procedure Main is
   package TIO renames Ada.Text_IO;

   generic
      type Data_Store is new KV_Store.KV_Container with private;
   package Items is
      procedure Init(Self : in out Data_Store);
      procedure Done(Self : in out Data_Store);
      procedure New_Item(Self : in out Data_Store; Key, Value : String);
      function Get_Item(Self : in out Data_Store; Key : String) return String;
   end Items;

   package body Items is
      procedure Init(Self : in out Data_Store) is
      begin
         Self.Setup;
      end Init;

      procedure Done(Self : in out Data_Store) is
      begin
         Self.Cleanup;
      end Done;

      procedure New_Item(Self : in out Data_Store; Key, Value : String) is
      begin
         Self.Set(Key, Value);
      end New_Item;

      function Get_Item(Self : in out Data_Store; Key : String) return String is
      begin
         return Self.Get(Key);
      end Get_Item;
   end Items;

   Data : Redis_Store.Data;
   package Client is new Items(Redis_Store.Data);
begin
   Data.Set_Server(Host      => "127.0.0.1",
                         Port      => 6379,
                         Namespace => "interface_example:");

   Client.Init(Data);
   Client.New_Item(Data, "test", "hello " & ASCII.LF & ASCII.CR & " world");
   Client.Done(Data);
end Main;
