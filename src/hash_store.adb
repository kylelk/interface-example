package body Hash_Store is
   procedure Setup (self : in out Data) is
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
         (Position => Result_Cursor, New_Item => To_Unbounded_String (Value));
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

   procedure Remove (Self : in out Data; Key : String) is
   begin
      if Self.Contains (Key) then
         Self.Values.Delete (To_Unbounded_String (Key));
      else
         raise KV_Store.No_Key_Error;
      end if;
   end Remove;

   procedure Commit (Self : in out Data) is
   begin
      null;
   end Commit;
end Hash_Store;
