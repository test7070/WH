<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "tre";
            var q_readonly = ['txtCarchgno','txtAccno', 'txtNoa', 'txtMoney', 'txtTotal', 'txtWorker2', 'txtWorker', 'txtRc2ano', 'txtPlusmoney', 'txtMinusmoney', 'txtAccno', 'txtAccno2', 'txtYear2', 'txtYear1'];
            var q_readonlys = ['txtTranaccy', 'txtTranno', 'txtTrannoq','txtTrandate','txtCarno','txtComp','txtStraddr','txtEndaddr','txtMount','txtVolume','txtWeight','txtMoney','txtMemo'];
            var bbmNum = [['txtMoney', 10, 0], ['txtTotal', 10, 0], ['txtPlusmoney', 10, 0], ['txtMinusmoney', 10, 0]];
            var bbsNum = [['txtMount', 10, 3], ['txtPrice', 10, 3], ['txtDiscount', 10, 3], ['txtMoney', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            aPop = aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtBdriverno', '', 'driver', 'noa,namea', 'txtBdriverno', 'driver_b.aspx']
            , ['txtEdriverno', '', 'driver', 'noa,namea', 'txtEdriverno', 'driver_b.aspx']
            , ['textDriverno_import', 'lblDriverno_import', 'driver', 'noa,namea', 'textDriverno_import', 'driver_b.aspx']);
            
            q_xchg = 1;
            brwCount2 = 20;
			var t_carteam = "";
            function tre() {
            }


            tre.prototype = {
                isLoad : false,
                carchgno : new Array()
            };

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('carteam', '', 0, 0, 0, "");
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
            	
                q_getFormat();
                bbmMask = [['txtDatea_import', r_picd],['txtBdate_import', r_picd], ['txtEdate_import', r_picd],['txtDatea', r_picd], ['txtDate2', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtPaydate', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
				
				//q_cmbParse("cmbCarteamno", t_carteam);
                //q_cmbParse("cmbCarteamno_import", t_carteam);
                
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtYear1').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });
                $('#lblAccno2').click(function() {
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtYear2').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });

                $('#txtPlusmoney').change(function(e) {
                    sum();
                });
                $('#txtMinusmoney').change(function(e) {
                    sum();
                });

                $("#btnCarchg").click(function(e) {
                	Lock(1,{opacity:0});
                	
                    if ($('#txtDriverno').val().length == 0) {
                        alert('請輸入司機!');
                        Unlock(1);
                        return;
                    }
                    
                    t_carchgno = 'carchgno=' + $('#txtCarchgno').val();
                    t_where = " driverno='" + $('#txtDriverno').val() + "' and  (treno='" + $('#txtNoa').val() + "' or len(isnull(treno,''))=0) ";
                    q_box("carchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_carchgno + ";", 'carchg', "95%", "95%", q_getMsg('popCarchg'));  
                });
                $('#lblCarchgno').click(function(e){
					var t_where = "1!=1";
					var t_carchgno = $('#txtCarchgno').val().split(',');
					for(var i in t_carchgno){
						if(t_carchgno[i].length>0)
							t_where += " or noa='"+t_carchgno[i]+"'";
					}
					q_box("carchg_ds.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'carchg', "95%", "95%", q_getMsg("popCarchg"));
				});
				//-----------------------------------------------
                $('#divImport').mousedown(function(e) {
                    if (e.button == 2) {
                        $(this).data('xtop', parseInt($(this).css('top')) - e.clientY);
                        $(this).data('xleft', parseInt($(this).css('left')) - e.clientX);
                    }
                }).mousemove(function(e) {
                    if (e.button == 2 && e.target.nodeName != 'INPUT') {
                        $(this).css('top', $(this).data('xtop') + e.clientY);
                        $(this).css('left', $(this).data('xleft') + e.clientX);
                    }
                }).bind('contextmenu', function(e) {
                    if (e.target.nodeName != 'INPUT')
                        e.preventDefault();
                });

                $('#btnImport').click(function() {
                    $('#divImport').toggle();
                    $('#txtDatea_import').focus();
                });
                $('#btnCancel_import').click(function() {
                    $('#divImport').toggle();
                });
                $('#btnImport_trans').click(function() {
                	const t_key = q_getPara('sys.key_tre');
               		const t_treno = $('#txtNoa').val();
               		const t_worker = r_name;
           			const t_date = $('#textDate').val();
           			const t_driverno = $('#textDriverno').val();
           			const t_bdate = $('#textBdate').val();
           			const t_edate = $('#textEdate').val();
           			const t_btrandate = $('#textBtrandate').val();
           			const t_etrandate = $('#textEtrandate').val();
               			
					if(q_cur==1 || q_cur==2){
						q_func('qtxt.query.tre_import_wh2', 'tre.txt,tre_import_wh2,' 
               				+ encodeURI(t_key) + ';'
               				+ encodeURI(t_user) + ';'
               				+ encodeURI(t_treno) + ';'
               				+ encodeURI(t_date) + ';'
               				+ encodeURI(t_driverno) + ';'
               				+ encodeURI(t_bdate) + ';'
               				+ encodeURI(t_edate) + ';' 
               				+ encodeURI(t_btrandate) + ';' 
               				+ encodeURI(t_etrandate)); 
					}else{
               			q_func('qtxt.query.tre_import_wh', 'tre.txt,tre_import_wh,' 
               				+ encodeURI(t_key) + ';'
               				+ encodeURI(t_user) + ';'
               				+ encodeURI('AUTO') + ';'
               				+ encodeURI(t_date) + ';'
               				+ encodeURI(t_driverno) + ';'
               				+ encodeURI(t_bdate) + ';'
               				+ encodeURI(t_edate) + ';' 
               				+ encodeURI(t_btrandate) + ';' 
               				+ encodeURI(t_etrandate)); 
                	}
                });
                $('#txtDatea_import').keydown(function(e) {
                    if (e.which == 13)
                        $('#txtBdate_import').focus();
                });
                $('#txtBdate_import').keydown(function(e) {
                    if (e.which == 13)
                        $('#txtEdate_import').focus();
                });
                $('#txtEdate_import').keydown(function(e) {
                    if (e.which == 13)
                        $('#cmbCarteamno_import').focus();
                });
                $('#textDate').datepicker();
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
                $('#textBtrandate').datepicker();
                $('#textEtrandate').datepicker();
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.tre_import_wh2':
                		var as = _q_appendData("tmp0", "", true, true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtTranaccy,txtTranno,txtTrannoq,txtTrandate,txtCarno,txtComp,txtStraddr,txtEndaddr,txtMount,txtVolume,txtWeight,txtMoney,txtMemo'
                        , as.length, as, 'accy,noa,noq,trandate,carno,comp,straddr,endaddr,mount,volume,weight,money,memo', '','');
                        
                        for (let i = as.length-1; i < q_bbsCount; i++) {
                            _btnMinus("btnMinus_" + i);
                        }
                        sum();
                        
                		break;
                	case 'qtxt.query.tre_import_wh':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	alert(as[0].msg);
                        	location.reload();
                        } else {
                        }
                		break;
                    case 'tre.import_ds':
                        if (result.length == 0) {
                            alert('No data!');
                            Unlock(1);
                        } else
                            location.reload();
                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'carchg':
                        if (b_ret != null) {
                            var t_where = '1!=1';
                            $('#txtCarchgno').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtCarchgno').val($('#txtCarchgno').val()+($('#txtCarchgno').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('carchg', "where=^^" + t_where + "^^", 0, 0, 0, "");
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        t_carteam = "@";
                        for ( i = 0; i < as.length; i++) {
                            t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        /*q_cmbParse("cmbCarteamno", t_item);
                        q_cmbParse("cmbCarteamno_import", t_item);
                        if (abbm[q_recno] != undefined) {
                            $("#cmbCarteamno").val(abbm[q_recno].carteamno);
                        }
                        q_gridv('tview', browHtm, fbrow, abbm, brwNowPage, brwCount);
                        if(q_getPara('sys.project').toUpperCase()=='DH'){
		                	$('.DH_show').show();
		                	$('.DH_hide').hide();
		                }*/
		                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                        break;
                        
                	case 'btnDele':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnModi();
		                sum();
		                Unlock(1);
		                $('#txtDatea').focus();
                		break;
                    
                    case 'carchg':
                        var as = _q_appendData("carchg", "", true);
                        var t_plusmoney = 0, t_minusmoney = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_plusmoney += parseFloat(as[i].plusmoney);
                            t_minusmoney += parseFloat(as[i].minusmoney);
                        }
                        $('#txtPlusmoney').val(t_plusmoney);
                        $('#txtMinusmoney').val(t_minusmoney);
                        sum();
                        Unlock(1);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
					return;
				}
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tre') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;

                q_box('tre_wh_s.aspx', q_name + '_s', "95%", "95%", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {
            	q_box('z_trans_wh.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['tranno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
               	//小數 可能會有問題需注意
                var t_money = 0,t_mount = 0,t_volume=0,t_weight=0;
                for ( i = 0; i < q_bbsCount; i++) {
                	t_money = q_add(t_money,q_float('txtTranmoney_' + i));
                	t_mount = q_add(t_mount,q_float('txtMount_' + i));
                	t_volume = q_add(t_volume,q_float('txtVolume_' + i));
                	t_weight = q_add(t_weight,q_float('txtWeight_' + i));
                }
                t_mount = round(t_mount,3);
				var t_plusmoney = q_float('txtPlusmoney');
				var t_minusmoney = q_float('txtMinusmoney');
				var t_tax = q_float('txtTax'); 
				
				var t_total = q_add(q_sub(q_add(t_money,t_plusmoney),t_minusmoney),t_tax);
               	
               	$('#txtMount').val(FormatNumber(t_mount));
               	$('#txtVolume').val(FormatNumber(t_volume));
               	$('#txtWeight').val(FormatNumber(t_weight));
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTotal').val(FormatNumber(t_total));
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 1 || q_cur == 2) {
                    $('#btnCarchg').removeAttr('disabled');
                	$('#txtDatea').datepicker();
                } else {
                    $('#btnCarchg').attr('disabled', 'disabled');
                	$('#txtDatea').datepicker('destroy');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele',r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this.mul( Math.pow(10,arg))).div( Math.pow(10,arg));
			};
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			};
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px;
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
                width: 10%;
            }
            .tbbm .tr1 {
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
                background-color: #DAA520;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                font-size: medium;
            }
            .dbbs {
                width: 1200px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
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
		<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a style="float:right; color: blue; font-size: medium;">立帳登錄日期</a></td>
					<td colspan="4">
					<input id="textDate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a style="float:right; color: blue; font-size: medium;">司機編號</a></td>
					<td colspan="4">
						<input id="textDriverno"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a style="float:right; color: blue; font-size: medium;">出車登錄日期</a></td>
					<td colspan="4">
					<input id="textBdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					<span style="float:left; display:block; width:25px;"><a>～</a></span>
					<input id="textEdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a style="float:right; color: blue; font-size: medium;">出車交運日期</a></td>
					<td colspan="4">
					<input id="textBtrandate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					<span style="float:left; display:block; width:25px;"><a>～</a></span>
					<input id="textEtrandate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td> </td>
					<td>
					<input id="btnImport_trans" type="button" value="匯入"/>
					</td>
					<td></td>
					<td></td>
					<td>
					<input id="btnCancel_import" type="button" value="關閉"/>
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;">總計</td>
						<td align="center" style="width:120px; color:black;">單號</td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="noa" style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:1px;">
						<td> </td>
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno" type="text" style="float:left;width:45%;"/>
							<input id="txtDriver" type="text" style="float:left;width:55%;"/>
							<input id="txtTggno" type="text" style="display:none;"/>
							<input id="txtTgg" type="text" style="display:none;"/>
						</td>
						<td> </td>
						<td><input id="btnImport" type="button" class="txt c1" value="匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text"  class="txt c1"/></td>
					</tr>	
					<tr class="tr_carchg">
						<td><span> </span><a id="lblCarchgno" class="lbl btn"> </a></td>
						<td colspan="5"><input id="txtCarchgno" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnCarchg" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>			
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
						<td><input id="txtYear1" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text"  class="txt c1"/></td>
						<td><input id="txtYear2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>

					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;">交運日期</td>
					<td align="center" style="width:80px;">車牌</td>
					<td align="center" style="width:80px;">客戶</td>
					<td align="center" style="width:120px;">起點</td>
					<td align="center" style="width:120px;">迄點</td>
					<td align="center" style="width:80px;">數量</td>
					<td align="center" style="width:80px;">材積</td>
					<td align="center" style="width:80px;">重量</td>
					<td align="center" style="width:80px;">應付運費</td>
					<td align="center" style="width:150px;">備註</td>
					<td align="center" style="width:150px;">出車單號</td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;" /></td>
					<td><input type="text" id="txtCarno.*" style="width:95%;" /></td>
					<td><input type="text" id="txtComp.*" style="width:95%;" /></td>
					<td><input type="text" id="txtStraddr.*" style="float:left;width:95%;" /></td>
					<td><input type="text" id="txtEndaddr.*" style="float:left;width:95%;" /></td>
					<td><input type="text" id="txtMount.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtVolume.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtWeight.*" style="width:95%;text-align: right;" /></td>
					<td>
						<input type="text" id="txtMoney.*" style="width:95%;text-align: right;" />
					</td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtTranaccy.*" style="display:none;" />
						<input type="text" id="txtTranno.*" style="float:left;width:70%;" />
						<input type="text" id="txtTrannoq.*" style="float:left;width:20%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>