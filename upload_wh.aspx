<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        string savepath = @"c:\inetpub\wwwroot\doc\wh\";
        public void Page_Load()
        {
        	 
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            string filename ="", noa = "", noq="";
            try
            {
            	filename = Request.Headers["filename"];
            	noa = Request.Headers["noa"];
            	noq = Request.Headers["noq"];
            	savepath += noa+"\\"+noq+"\\";
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);

                if (!System.IO.Directory.Exists(savepath))
                {
                    System.IO.Directory.CreateDirectory(savepath);
                }

                parseFile(HttpUtility.UrlDecode(filename), encoding.GetString(formData));
				//Response.Write("done");
            }
            catch (Exception e)
            {
                Response.Write(filename+"\n"+e.Message);
            }
        }
        public void parseFile(string filename, string data)
        {
            byte[] formData = new byte[0];
            if (data.Length >= (data.IndexOf("base64") + 7))
                formData = Convert.FromBase64String(data.Substring(data.IndexOf("base64") + 7));

            System.IO.FileStream aax = new System.IO.FileStream(savepath + filename, System.IO.FileMode.OpenOrCreate);
            System.IO.BinaryWriter aay = new System.IO.BinaryWriter(aax);
            aay.Write(formData);
            aax.Close();
        }

        
    </script>
