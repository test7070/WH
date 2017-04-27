<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4lkDc9H0JanDkP8MUpO-mzXRtmugbiI8&signed_in=true&callback=initMap" async defer></script>
		-->
		<script type="text/javascript">
			q_tables = 's';
			var q_name = "tran";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtTotal','txtTotal2','txtTotal3','txtMount','txtVolume','txtWeight'];
			var q_readonlys = ['txtOrdeno','txtNo2'];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = new Array(['txtDatea', '999/99/99'],['txtTrandate', '999/99/99']);
			var bbsNum = new Array();
			var bbsMask = new Array();
			var bbtNum  = new Array(); 
			var bbtMask = new Array();
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			//q_xchg = 1;
			brwCount2 = 7;
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
				,['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b.aspx']
				,['txtEndaddrno_', 'btnEndaddr_', 'addr', 'noa,addr', 'txtEndaddrno_,txtEndaddr_', 'addr_b.aspx']
				,['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_', 'car2_b.aspx']
				,['txtCustno_', 'btnCust_', 'cust', 'noa,comp,nick', 'txtCustno_,txtComp_,txtNick_', 'cust_b.aspx']
				,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']);

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				var t_mount=0,t_volume=0, t_weight=0,t_total=0,t_total2=0,t_total3=0;
				for(var i=0;i<q_bbsCount;i++){
					//cuft = round(0.0000353 * q_float('txtLengthb_'+i)* q_float('txtWidth_'+i)* q_float('txtHeight_'+i)* q_float('txtMount_'+i),2); 
					//$('#txtVolume_'+i).val(cuft);
					//$('#txtWeight_'+i).val(round(q_float('txtMount_'+i)*q_float('txtUweight_'+i),0));
					t_mount = q_add(t_mount,q_float('txtMount_'+i));
					t_volume = q_add(t_volume,q_float('txtVolume_'+i));
					t_weight = q_add(t_weight,q_float('txtWeight_'+i));
					t_total = q_add(t_total,q_float('txtTotal_'+i));
					t_total2 = q_add(t_total2,q_float('txtTotal2_'+i));
					t_total3 = q_add(t_total3,q_float('txtReserve_'+i));
				}
				$('#txtMount').val(t_mount);
				$('#txtVolume').val(t_volume);
				$('#txtWeight').val(t_weight);
				$('#txtTotal').val(t_total);
				$('#txtTotal2').val(t_total2);
				$('#txtTotal3').val(t_total3);
			}
			
			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_mask(bbmMask);
				
				var t_type = q_getPara('trans.typea').split(',');
				for(var i=0;i<t_type.length;i++){
					$('#listTypea').append('<option value="'+t_type[i]+'"></option>');
				}
				var t_unit = q_getPara('trans.unit').split(',');
				for(var i=0;i<t_unit.length;i++){
					$('#listUnit').append('<option value="'+t_unit[i]+'"></option>');
				}
				
				$('#btnTranvcce').click(function(e) {
                	var t_where ='';
                	var t_noa = $.trim($('#txtNoa').val());
                	var t_driverno = $.trim($('#txtDriverno').val());
                	if(t_driverno.length==0){
                		alert('請輸入司機編號!');
                		return;
                	}
                	q_box("tranvccewh_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({project:q_getPara('sys.project').toUpperCase(),tranno:t_noa,driverno:t_driverno}), "tranvcce_tran", "95%", "95%", '');
                });
			}
			//依序上傳
			function UploadFile(n,files,curCount){
				if(curCount>=files.length){
					//done
					return;
				}else{
					var noa = $('#txtNoa').val();
					var noq = $('#txtNoq_'+n).val(); 
					var fr = new FileReader();
					var ext = '';
					var extindex = files[curCount].name.lastIndexOf('.');
					if(extindex>=0){
						ext = files[curCount].name.substring(extindex,files[curCount].name.length);
					}
					fr.filename = files[curCount].name;
					fr.noa = noa;
					fr.noq = noq;
					fr.n = n;
					//abort 事件處理器，於讀取被中斷時觸發。
					fr.onabort = function(e){
						q_msg($('#btnUpload_'+fr.n), '<progress value="50" max="100"></progress>' );
						$('#msg').text("讀取中斷");
						UploadFile(n,files,curCount+1);
					};

					//error 事件處理器，於讀取發生錯誤時觸發。
					fr.onerror = function(e){
						$('#msg').text("讀取錯誤");
						UploadFile(n,files,curCount+1);
					};
					
					//load 事件處理器，於讀取完成時觸發。
					fr.onload = function(e){
						var oReq = new XMLHttpRequest();
						oReq.upload.addEventListener("progress",function(e) {
							if (e.lengthComputable) {
								q_msg($('#btnUpload_'+fr.n), '<a>上傳中...</a><br><progress value="'+Math.round((e.loaded / e.total) * 100,0)+'" max="100"></progress>' );
								//$('#progress').attr('value',Math.round((e.loaded / e.total) * 100,0));
							}
						}, false);
						oReq.upload.addEventListener("load",function(e) {
							q_msg($('#btnUpload_'+fr.n), '<a>上傳開始</a><br><progress value="0" max="100"></progress>' );
							//$('#msg').text("上傳開始");
						    //$('#progress').attr('value',0);
						}, false);
						oReq.upload.addEventListener("error",function(e) {
							q_msg($('#btnUpload_'+fr.n), '<a>上傳發生錯誤</a>');
                            //$('#msg').text("上傳錯誤");
						}, false);
						oReq.addEventListener("loadend", function(e) {
							q_msg($('#btnUpload_'+fr.n), '<a>上傳結束</a>');
							UploadFile(n,files,curCount+1);
						   //$('#msg').text("上傳完成");	
						}, false);
						
						oReq.onreadystatechange = function() {
						    if (oReq.readyState == XMLHttpRequest.DONE) {
						        if(oReq.responseText.length>0)
						        	alert(oReq.responseText);
						    }
						};	
						oReq.timeout = 360000;
						oReq.ontimeout = function () { $('#msg').text("Timed out!!!");};
						oReq.open("POST", 'upload_wh.aspx', true);
						oReq.setRequestHeader("Content-type", "text/plain");
                        oReq.setRequestHeader("filename", fr.filename);
                        oReq.setRequestHeader("noa", fr.noa);
                        oReq.setRequestHeader("noq", fr.noq);
						oReq.send(fr.result);
					};
					
					//loadstart 事件處理器，於讀取開始時觸發。
					fr.onloadstart = function(e){
						q_msg($('#btnUpload_'+fr.n), '<a>開始讀取</a><br><progress value="0" max="100"></progress>' );
                        //$('#msg').text("讀取開始");
						//$('#progress').attr('value',0);
					};
					
					//loadend 事件處理器，於每一次讀取結束之後觸發（不論成功或失敗），會於 onload 或 onerror 事件處理器之後才執行。
					fr.onloadend = function(e){
							
					};
                    //progress 事件處理器，於讀取 Blob 內容時觸發。
                    fr.onprogress = function(e){
						if ( e.lengthComputable ) { 
                        	q_msg($('#btnUpload_'+fr.n), '<a>讀取中...</a><br><progress value="'+Math.round((e.loaded / e.total) * 100,0)+'" max="100"></progress>' );
                            //$('#msg').text("讀取中..."+fr.Filename);
							//$('#progress').attr('value',Math.round( (e.loaded * 100) / e.total));
						}
					};
					
					fr.readAsDataURL(files[curCount]);
				}
			}
			
			
			
            
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                    $('#btnUpload_' + i).click(function(e){
                    	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    	UploadFile(n,$('#btnFile_' + n)[0].files,0);
                    });
                	$('#txtMount_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtVolume_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtWeight_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtTotal_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtTotal2_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtReserve_' + i).change(function(e) {
                        sum();
                    });
                    
                	$('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                    });
                    $('#txtCustno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCust_'+n).click();
                    });
                    $('#txtStraddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                    });
                    $('#txtEndaddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnEndaddr_'+n).click();
                    });
				}
				_bbsAssign();
				$('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
				refreshBbs();
			}
			function refreshWV(n){
				var t_productno = $.trim($('#txtProductno_'+n).val());
				if(t_productno.length==0){
					$('#txtWeight_'+n).val(0);
					$('#txtVolume_'+n).val(0);
				}else{
					q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0, JSON.stringify({action:"getUcc",n:n}));
				}
			}

			function bbsSave(as) {
				if (!as['carno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['trandate'] = abbm2['trandate'];
				as['datea'] = abbm2['datea'];
				as['driverno'] = abbm2['driverno'];
				as['driver'] = abbm2['driver'];
				return true;
			}
			function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'tranvcce_tran':
                        if (b_ret != null) {
                        	for(var i=0;i<q_bbsCount;i++)
                        		$('#btnMinus_'+i).click();
                        	as = b_ret;
                        	while(q_bbsCount<as.length)
                        		$('#btnPlus').click();
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtCstype,txtCarno,txtCustno,txtComp,txtNick,txtProductno,txtProduct,txtMount,txtUnit,txtVolume,txtWeight,txtStraddrno,txtStraddr,txtEndaddrno,txtEndaddr,txtMemo,txtTotal,txtTotal2,txtReserve'
                        	, as.length, as, 'ordeno,typea,carno,custno,cust,cust,productno,product,mount,unit,volume,weight,straddrno,straddr,endaddrno,endaddr,memo,total,total2,total3', '','');
                        	sum();
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action=="getUcc"){
                    			var n = t_para.n;
                    			as = _q_appendData("ucc", "", true);
                    			if(as[0]!=undefined){
                    				$('#txtWeight_'+n).val(round(q_mul(q_float('txtMount_'+n),parseFloat(as[0].uweight)),3));
                    				$('#txtVolume_'+n).val(round(q_mul(q_float('txtMount_'+n),parseFloat(as[0].stkmount)),0));
                    			}else{
                    				$('#txtWeight_'+n).val(0);
                    				$('#txtVolume_'+n).val(0);
                    			}
                    		}else {
							}
							sum();
                		}catch(e){
                    		Unlock(1);
                    	}
                        break;
                }
            }

		
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tran_wh_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtTrandate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtTrandate').focus();
			}

			function btnPrint() {
				q_box('z_trans_wh.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    form : 'trans_wh'
		                    ,noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
			}

			function btnOk() {
				$('#txtTrandate').val($.trim($('#txtTrandate').val()));
				if ($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())) {
                    alert(q_getMsg('lblTrandate') + '錯誤。');
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
				var t_date = trim($('#txtTrandate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
				
			}
			function refreshBbs(){
				switch(q_getPara('sys.project').toUpperCase()){
					default:
						break;
				}
				for(var i=0;i<q_bbsCount;i++){
					if(q_cur==1 || q_cur==2){
						$('#btnFile_'+i).attr('disabled','disabled');
						$('#btnUpload_'+i).attr('disabled','disabled');
					}else if($('#txtNoq_'+i).val().length>0){
						$('#btnFile_'+i).removeAttr('disabled');
						$('#btnUpload_'+i).removeAttr('disabled');
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtTrandate').datepicker('destroy');
					$('#btnTranvcce').attr('disabled','disabled');
				}else{
					$('#txtDatea').datepicker();
					$('#txtTrandate').datepicker();
					$('#btnTranvcce').removeAttr('disabled');
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
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id){
					case 'txtProductno_':
						var n = b_seq;
						refreshWV(n);
						break;
					default:
						break;
				}
			}
			
		</script>
		
		<style type="text/css">
			#dmain {
				overflow: auto;
				width: 1600px;
			}
			.dview {
				float: left;
				width: 700px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 600px;
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
				width: 12%;
			}
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
			}
			.tbbm .tdZ {
				width: 1%;
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
			.dbbs {
				width: 1500px;
			}
			.dbbt {
				width: 2000px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
			
          /*  #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }*/
		</style>
	</head>
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a>交運日期</a></td>
						<td align="center" style="width:80px; color:black;"><a>登錄日期</a></td>
						<td align="center" style="width:120px; color:black;"><a>司機</a></td>
						<td align="center" style="width:80px; color:black;"><a>應收金額</a></td>
						<td align="center" style="width:80px; color:black;"><a>盤車</a></td>
						<td align="center" style="width:80px; color:black;"><a>應付金額</a></td>
						<td align="center" style="width:150px; color:black;"><a>電腦編號</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='trandate' style="text-align: center;">~trandate</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='total' style="text-align: right;">~total</td>
						<td id='total3' style="text-align: right;">~total3</td>
						<td id='total2' style="text-align: right;">~total2</td>
						<td id='noa' style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTrandate" class="lbl">交運日期</a></td>
						<td><input type="text" id="txtTrandate" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl">交運日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl">司機</a></td>
						<td colspan="2">
							<input type="text" id="txtDriverno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtDriver" class="txt" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl">數量</a></td>
						<td><input type="text" id="txtMount" class="txt c1"/></td>
						<td><span> </span><a id="lblVolume" class="lbl">材積</a></td>
						<td><input type="text" id="txtVolume" class="txt c1"/></td>
						<td><span> </span><a id="lblWeight" class="lbl">重量</a></td>
						<td><input type="text" id="txtWeight" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTotal" class="lbl">應收金額</a></td>
						<td><input type="text" id="txtTotal" class="txt c1"/></td>
						<td><span> </span><a id="lblTotal3" class="lbl">盤車</a></td>
						<td><input type="text" id="txtTotal3" class="txt c1"/></td>
						<td><span> </span><a id="lblTotal2" class="lbl">應付金額</a></td>
						<td><input type="text" id="txtTotal2" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6">
							<textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input type="text" id="txtNoa" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><input type="button" id="btnTranvcce" value="派車匯入"/></td>
					</tr>
				</table>
			</div>
			<img id="img" crossorigin="anonymous" style="float:left;display:none;"/> 
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:80px;"><a>類型</a></td>
					<td align="center" style="width:80px;"><a>車牌</a></td>
					<td align="center" style="width:120px;"><a>客戶</a></td>
					<td align="center" style="width:120px;"><a>起點</a></td>
					<td align="center" style="width:120px;"><a>迄點</a></td>
					<td align="center" style="width:60px;"><a>數量</a></td>
					<td align="center" style="width:60px;"><a>單位</a></td>
					<td align="center" style="width:60px;"><a>材積</a></td>
					<td align="center" style="width:60px;"><a>重量</a></td>
					<td align="center" style="width:60px;"><a>應收<br>運費</a></td>
					<td align="center" style="width:60px;"><a>盤車</a></td>
					<td align="center" style="width:60px;"><a>應付<br>運費</a></td>
					<td align="center" style="width:60px;"><a>收貨</a></td>
					<td align="center" style="width:60px;"><a>代收</a></td>
					<td align="center" style="width:120px;"><a>備註</a></td>
					<td align="center" style="width:100px;"><a>派車<br>單號</a></td>
					<td align="center" style="width:150px;"><a> </a></td>
					</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					
					<td><input type="text" id="txtCstype.*" list="listTypea" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarno.*" style="width:95%;"/>
						<input type="button" id="btnCarno.*" style="display:none;"/>
						<input type="text" id="txtDriverno.*" style="display:none;"/>
						<input type="text" id="txtDriver.*" style="display:none;"/>
						<input type="text" id="txtTrandate.*" style="display:none;"/>
						<input type="text" id="txtDatea.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:40%;"/>
						<input type="text" id="txtComp.*" style="float:left;width:45%;"/>
						<input type="text" id="txtNick.*" style="display:none;"/>
						<input type="button" id="btnCust.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtStraddrno.*" style="float:left;width:40%;"/>
						<input type="text" id="txtStraddr.*" style="float:left;width:45%;"/>
						<input type="button" id="btnStraddr.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtEndaddrno.*" style="float:left;width:40%;"/>
						<input type="text" id="txtEndaddr.*" style="float:left;width:45%;"/>
						<input type="button" id="btnEndaddr.*" style="display:none;"/>
					</td>
					
					<td><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtUnit.*" list="listUnit" style="width:95%;"/></td>
					<td><input type="text" id="txtVolume.*" class="num " style="width:95%;"/></td>
					<td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtReserve.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtOverw.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtOverh.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
					<td><input type="text" id="txtOrdeno.*" style="width:95%;"/></td>
					<td>
						<input type="file" id="btnFile.*" style="float:left;width:65%;" multiple/>
						<input type="button" id="btnUpload.*" value="上傳" style="float:left;width:30%;"/>
						<input type="button" id="btnDownload.*" value="下載" style="display:none;"/>
						<input type="text" id="txtSender.*" style="display:none;"/>
						<input type="text" id="txtSaddr.*" style="display:none;"/>
					</td>
				</tr>

			</table>
		</div>
		<datalist id="listUnit"> </datalist>
		<datalist id="listTypea"> </datalist>
		<input id="q_sys" type="hidden" />
	</body>
</html>
