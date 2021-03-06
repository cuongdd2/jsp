/*    */ package protocol;
/*    */ 
/*    */ import com.goldhuman.Common.Marshal.MarshalException;
/*    */ import com.goldhuman.Common.Marshal.OctetsStream;
/*    */ import com.goldhuman.IO.Protocol.Rpc.Data;
/*    */ 
/*    */ public final class UserRoleCountRes extends Rpc.Data
/*    */ {
/*    */   public int retcode;
/*    */   public int count;
/*    */   public int rolelist;
/*    */ 
/*    */   public OctetsStream marshal(OctetsStream os)
/*    */   {
/* 20 */     os.marshal(this.retcode);
/* 21 */     os.marshal(this.count);
/* 22 */     os.marshal(this.rolelist);
/* 23 */     return os;
/*    */   }
/*    */ 
/*    */   public OctetsStream unmarshal(OctetsStream os) throws MarshalException
/*    */   {
/* 28 */     this.retcode = os.unmarshal_int();
/* 29 */     this.count = os.unmarshal_int();
/* 30 */     this.rolelist = os.unmarshal_int();
/* 31 */     return os;
/*    */   }
/*    */ 
/*    */   public Object clone()
/*    */   {
/*    */     try
/*    */     {
/* 38 */       return (UserRoleCountRes)super.clone();
/*    */     }
/*    */     catch (Exception e) {
/*    */     }
/* 42 */     return null;
/*    */   }
/*    */ }

/* Location:           D:\PW\1.4.5iweb\iweb\WEB-INF\classes\
 * Qualified Name:     protocol.UserRoleCountRes
 * JD-Core Version:    0.6.2
 */