<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">

            var q_name = "transef";
            var q_readonly = ['txtNoa','txtOrdeno','txtWorker','txtWorker2','txtUnpack'];
            var bbmNum = [['txtMount',10,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
           
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount = 6;
            brwCount2 = 15;
            
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            	,['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            	,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            	,['txtAaddr', 'lblStore', 'store', 'noa,store', 'txtAaddr,txtAddress', 'store_b.aspx']);
           
            function sum() {
                if(q_cur!=1 && q_cur!=2)
                    return;
              /*  var t_price = q_float('txtPrice');
                var t_price2 = q_float('txtPrice2');
                var t_price3 = q_float('txtPrice3');
                var t_total = round(t_price,0);
                var t_total2 = round(q_add(t_price2,t_price3),0);
                
                var t_unpack = q_float('txtTolls') + q_float('txtReserve') + q_float('txtOverh')
                    +q_float('txtOverw')+q_float('txtCommission')+q_float('txtCommission2');
                $('#txtTotal').val(q_trv(t_total));
                $('#txtTotal2').val(q_trv(t_total2));
                $('#txtUnpack').val(q_trv(t_unpack));*/
            }
                
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, "", q_sqlCount, 1, 0, '', r_accy);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtTrandate', r_picd]];
                q_mask(bbmMask);
                
                q_xchgForm();
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }

            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'getChange':
                		//記錄欄位原本的文字顏色      &  還原原本的顏色
                		var obj = $('body').find('input[type="text"],select');
                		for(var i=0;i<obj.length;i++){
                			if(obj.eq(i).attr('id').substring(0,3)=='txt' || obj.eq(i).attr('id').substring(0,3)=='cmb')
	                			if(obj.eq(i).data('orgColor')==undefined)		
	                				obj.eq(i).data('orgColor',obj.eq(i).css('color'));
	                			else{
	                				obj.eq(i).css('color',obj.eq(i).data('orgColor'));
	                				obj.eq(i).attr('title','');
	                			}
	                				
                		}
                		//--------------------------------------------
                		var as = _q_appendData("drun", "", true);
                        if(as[0]!=undefined){
                        	var elementList = [];
                        	var element = new Array();
                        	for(var i=0;i<as.length;i++){
                        		item = as[i].memo.split('\\r\\n');
                        		for(var j=0;j<item.length;j++){
                        			if(item[j].indexOf(':')>=0){
                        				field = item[j].substring(0,item[j].indexOf(':'));
                        				item2 = item[j].substring(item[j].indexOf(':')+1,item[j].length);	
                        				if(field.length>0){
                        					if(elementList.indexOf(field)<0){
                        						elementList = elementList.concat(field);
                        						element.push([]);
                        					}
                        					n = elementList.indexOf(field);
                        					
                        					element[n]=element[n].concat({
                        						datea : as[i].datea
                    							,timea : as[i].timea
                    							,memo : item2
                    						});
                        				}
                        			}
                        		}
                        	}  
                        	for(var i=0;i<elementList.length;i++){
                        		field = elementList[i];
                        		if(element[i]!=undefined){
                        			title = '';
                        			for(var j=0;j<element[i].length;j++){
                        				title = title + (title.length>0?'\n':'') + element[i][j].datea+' '+element[i][j].timea+'：'+element[i][j].memo.replace('=#>',' => ');
                        			}
                        			fieldName = field.substring(0,1).toUpperCase()+field.substring(1,field.length); 
                        			$('#txt'+fieldName).css('color','red');
                        			$('#cmb'+fieldName).css('color','red'); 
                        			$('#txt'+fieldName).attr('title',title);
                        			$('#cmb'+fieldName).attr('title',title);
                        		}
                        	}	
                        }
                		break; 
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }
            }
            function q_popPost(id) {
                switch(id) {
                    default:
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trans_ef_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                sum();
            }
            function btnPrint() {
                q_box('z_trans_wh.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'tranefs', "95%", "95%", m_print);
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
                Lock(1,{opacity:0});
                //日期檢查
                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
                    alert('發送日期錯誤。');
                    Unlock(1);
                    return;
                }
                if($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())){
                    alert('配送日期錯誤。');
                    Unlock(1);
                    return;
                }
                var t_days = 0;
                var t_date1 = $('#txtDatea').val();
                var t_date2 = $('#txtTrandate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                if(t_days>60){
                    alert('發送日期、配送日期相隔天數不可多於60天。');
                    Unlock(1);
                    return;
                }
                sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (q_cur ==1)
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);        
            }

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                
                //修改過的欄位  標記-----------------------------------------
                if($('#txtNoa').val().length>0){
            		t_where = "where=^^action='Update' and tablea='transef' and memo like '%:%=#>%\\r\\n%' and noa='"+$('#txtNoa').val()+"' order by datea desc,timea desc^^";
           			q_gt('drun', t_where, 0, 0, 0, 'getChange');
            	}
           		//-----------------------------------------------------
            }
			
			
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#txtDatea').datepicker();
                	$('#txtTrandate').datepicker();
                }else{
                	$('#txtDatea').datepicker('destroy');
                	$('#txtTrandate').datepicker('destroy');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function checkCaseno(string){
                var key ={0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9,A:10,B:12,C:13,D:14,E:15,F:16,G:17,H:18,I:19,J:20,K:21,L:23,M:24,N:25,O:26,P:27,Q:28,R:29,S:30,T:31,U:32,V:34,W:35,X:36,Y:37,Z:38};
                if((/^[A-Z]{4}[0-9]{7}$/).test(string)){
                    var value = 0;
                    for(var i =0;i<string.length-1;i++){
                        value+= key[string.substring(i,i+1)]*Math.pow(2,i);
                    }
                    return Math.floor(q_add(q_div(value,11),0.09)*10%10)==parseInt(string.substring(10,11));
                }else{
                    return false;
                }
            }
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 950px;
                /*margin: -1px;        
                border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:80px; color:black;">日期</td>
                        <td align="center" style="width:100px; color:black;">空運公司</td>
                        <td align="center" style="width:100px; color:black;">貨主</td>
                        <td align="center" style="width:80px; color:black;">件數</td>
                        <td align="center" style="width:80px; color:black;">單位</td>
                        <td align="center" style="width:150px; color:black;">聯絡電話</td>
                        <td align="center" style="width:150px; color:black;">備註</td>
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="tgg" style="text-align: center;">~tgg</td>
                        <td id="comp" style="text-align: center;">~comp</td>
                        <td id="mount,0" style="text-align: right;">~mount,0</td>
                        <td id="unit" style="text-align: center;">~unit</td>
                        <td id="atel" style="text-align: center;">~atel</td>
                        <td id="memo" style="text-align: center;">~memo</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">日期</a></td>
                        <td>
                        	<input id="txtDatea"  type="text" class="txt c1"/>
                        	<input id="txtTrandate"  type="text" style="display:none;"/>
                        </td>
                        <td><span> </span><a id="lblNoa" class="lbl">電腦編號</a></td>
                        <td>
                            <input id="txtNoa"  type="text" class="txt c1"/>
                            <input id="txtNoq"  type="text" style="display:none;"/>
                        </td>
                        
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblTgg" class="lbl">空運公司</a></td>
                        <td colspan="2">
                        	<input id="txtTggno"  type="text" style="float:left;width:40%;"/>
                            <input id="txtTgg"  type="text" style="float:left;width:60%;"/>
                    	</td>
                        <td><span> </span><a id="lblCust" class="lbl">貨主</a></td>
                        <td colspan="2">
                        	<input id="txtCustno"  type="text" style="float:left;width:40%;"/>
                            <input id="txtComp"  type="text" style="float:left;width:60%;"/>
                            <input id="txtNick" type="text" style="display:none;"/>
                        </td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblStore" class="lbl">倉儲</a></td>
                        <td colspan="2">
                        	<input id="txtAaddr"  type="text" style="float:left;width:40%;"/>
                            <input id="txtAddress"  type="text" style="float:left;width:60%;"/>
                    	</td>
                        <td><span> </span><a id="lblDriver" class="lbl btn">司機</a></td>
                        <td colspan="2">
                            <input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtDriver"  type="text" style="float:left;width:50%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">件數</a></td>
                        <td><input id="txtMount"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">單位</a></td>
                        <td><input type="text" id="txtUnit" list="listUnit" class="txt c1"/></td>
                    	<datalist id='listUnit'>
                    		<option value="板"> </option>
                    	</datalist>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">聯絡電話</a></td>
                        <td colspan="5"><input type="text" id="txtAtel" class="txt c1"/></td>
                    </tr> 
                    <tr>
                        <td><span> </span><a class="lbl">備註</a></td>
                        <td colspan="5"><input type="text" id="txtMemo" class="txt c1"/></td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl">製單員</a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblWorker2" class="lbl">修改人</a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
