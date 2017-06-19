<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">   
        class ParaIn
        {
        	public string tranno,field,value;
        }
        class ParaOut
        {
            public string msg="";
        }
       
        public void Page_Load()
        {
            //參數
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));

            System.Data.DataTable dt = new System.Data.DataTable();
            //連接字串      
            string connString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            //資料
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"
                SET QUOTED_IDENTIFIER OFF
	declare @cmd nvarchar(max)
	declare @prevalue nvarchar(max) = ''
	declare @accy nvarchar(20) = ''
	select top 1 @accy=@accy from view_trans where noa=@t_tranno order by accy,noa desc
	
	declare @tmp table(
		msg nvarchar(max)
	)
	
	Begin Transaction [Trans_Name]
	begin try
		set @cmd =
		""select @prevalue=cast(""+@t_field+"" as nvarchar) from view_trans where accy=@accy and noa=@t_tranno""
		execute sp_executesql @cmd,N'@accy nvarchar(20),@t_tranno nvarchar(20),@prevalue nvarchar(max) output'
			,@accy=@accy,@t_tranno=@t_tranno,@prevalue=@prevalue output
		
		set @cmd =
		""update trans""+@accy+"" set ""+@t_field+"" = CAST(@t_value as float) where noa=@t_tranno""
		execute sp_executesql @cmd,N'@t_value nvarchar(50),@t_tranno nvarchar(20)'
			,@t_value=@t_value,@t_tranno=@t_tranno
		
		insert into drun(datea,timea,usera,[action],noa,tablea,accno,title,memo)
		select left(CONVERT(nvarchar,getdate(),111),10) 
			,left(CONVERT(nvarchar,getdate(),108),5)
			,'modi_trans_wh.aspx','Edit',@t_tranno
			,'trans'+@accy,'出車單'
			,@t_field+'修改'
			,@prevalue+'->'+@t_value
		
		Commit Transaction [Trans_Name] -- 提交所有操作所造成的變更
		insert into @tmp(msg)values('')
	end try
	begin catch
		Rollback Transaction [Trans_Name] -- 復原所有操作所造成的變更
		insert into @tmp(msg)values(error_message())
	end catch
	select * from @tmp
                ";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@t_tranno", itemIn.tranno);
                cmd.Parameters.AddWithValue("@t_field", itemIn.field);
                cmd.Parameters.AddWithValue("@t_value", itemIn.value);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt); 
                connSource.Close();
            }
            ParaOut paraout = new ParaOut();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                paraout.msg = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
            }

            Response.Write(serializer.Serialize(paraout));
        }    
    </script>