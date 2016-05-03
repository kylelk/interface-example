with Ada.Text_IO;
with KV_Store;
with Hash_Store;
with Redis_Store;

procedure Main is
   package TIO renames Ada.Text_IO;

   package Items is
      use KV_Store;
      type Status is tagged record
         Items_Inserted : Integer := 0;
         Items_Remove   : Integer := 0;
      end record;

      procedure Init (Info : in out Status; Data : in out KV_Interface'Class);

      procedure Done (Info : in out Status; Data : in out KV_Interface'Class);

      procedure New_Item
        (Info       : in out Status;
         Data       : in out KV_Interface'Class;
         Key, Value :        String);

      function Get_Item
        (Info : in out Status;
         Data : in out KV_Interface'Class;
         Key  :        String) return String;
   end Items;

   package body Items is
      procedure Init
        (Info : in out Status;
         Data : in out KV_Interface'Class)
      is
      begin
         Data.Setup;
      end Init;

      procedure Done
        (Info : in out Status;
         Data : in out KV_Interface'Class)
      is
      begin
         Data.Cleanup;
      end Done;

      procedure New_Item
        (Info       : in out Status;
         Data       : in out KV_Interface'Class;
         Key, Value :        String)
      is
      begin
         if not Data.Contains (Key) then
            Info.Items_Inserted := Info.Items_Inserted + 1;
         end if;
         Data.Set (Key, Value);
      end New_Item;

      function Get_Item
        (Info : in out Status;
         Data : in out KV_Interface'Class;
         Key  :        String) return String
      is
      begin
         return Data.Get (Key);
      end Get_Item;
   end Items;

   Data   : Hash_Store.Data;
   Client : Items.Status;
begin
   -- initalize the data store
   --Items.Init(Status, Data);
   Client.Init (Data);

   for I in 1 .. 10 loop
      -- create a new item
      Client.New_Item (Data, "test" & I'Img, "item" & I'Img);

      -- get an item by it's key name
      TIO.Put_Line (Client.Get_Item (Data, "test" & I'Img));
   end loop;

   TIO.Put_Line ("inserted " & Client.Items_Inserted'Img & " new items");

   -- close the data store
   Client.Done (Data);
end Main;
