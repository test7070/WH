<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

            var q_name = "tranordejs", t_content = "where=^^['')^^", bbsKey = ['noa','noq'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.project+"','"+t_para.noa+"',"+t_para.chk1+","+t_para.chk2+",'"+t_para.date+"')^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						abbs = _q_appendData(q_name, "", true);
						//refresh();
						break;
				}
			}
			var maxAbbsCount = 0;
            function refresh() {
            	//ref ordest_b.aspx
				var w = window.parent;
				
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						//alert(abbs[i].chk1+'__'+abbs[i].chk2);
						/*for(var j=0;j<w.$('#_orde').children().length;j++){
							if(w.$('#_orde').children().eq(j).find('.ordeno').text()==abbs[i].noa+'-'+abbs[i].noq){
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}*/
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa 
								&& w.$('#txtNo2_' + j).val() == abbs[i].noq
								//&& (w.$('#chkChk1_' + j).prop('checked').toString() == abbs[i].chk1.toString())
								//&& (w.$('#chkChk2_' + j).prop('checked').toString() == abbs[i].chk2.toString()) 
								) {			
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
								//alert(abbs[i].rec);
							}
						}
					}
					maxAbbsCount = abbs.length;
				}
				/*abbs.sort(function(a,b){
					var x = (a.sel==true || a.sel=="true"?1:0);
					var y = (b.sel==true || b.sel=="true"?1:0);
					return y-x;
				});*/
				/*for(var i=0;i<abbs.length;i++){
					if(abbs[i].kind == ''){
						abbs.splice(i,1);
						i--;
					}
				}*/
				_refresh();
				q_bbsCount = abbs.length;
				
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtNoa_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
				//_readonlys(true);
			}
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px" ><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:30px;"><a style="font-weight: bold;text-align: center;display: block;">　</a></td>
					<td align="center" style="width:50px;"><a>趟次</a></td>
					<td align="center" style="width:60px;"><a>類型</a></td>
					<td align="center" style="width:130px;"><a>訂單編號</a></td>
					<td align="center" style="width:100px;"><a>客戶</a></td>
					<td align="center" style="width:100px;"><a>貨主</a></td>
					<td align="center" style="width:80px;"><a>起點</a></td>
					<td align="center" style="width:80px;"><a>迄點</a></td>
					<td align="center" style="width:60px;"><a>提貨時間</a></td>
					<td align="center" style="width:60px;"><a>卸貨時間</a></td>
					<td align="center" style="width:60px;"><a>長cm</a></td>
					<td align="center" style="width:60px;"><a>寬cm</a></td>
					<td align="center" style="width:60px;"><a>高cm</a></td>
					<td align="center" style="width:60px;"><a>數量</a></td>
					<td align="center" style="width:60px;"><a>單位</a></td>
					<td align="center" style="width:60px;"><a>材積</a></td>
					<td align="center" style="width:60px;"><a>重量</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:400px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:30px;"><a style="font-weight: bold;text-align: center;display: block;">　</a></td>
					<td align="center" style="width:50px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:130px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:80px;"> </td>
					<td align="center" style="width:80px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:60px;"> </td>
					<td align="center" style="width:60px;"> </td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:30px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:50px;"><input id="txtN.*" type="text" style="width:95%;text-align: center;"/></td>
					<td style="width:60px;"><input id="txtTypea.*" type="text" style="width:95%;" readonly="readonly"/></td>
					<td style="width:130px;">
						<input id="txtNoa.*" type="text" style="float:left;width:78%;text-align: right;"  readonly="readonly" />
						<input id="txtNoq.*" type="text" style="float:left;width:20%; text-align: right;"  readonly="readonly" />
						<input id="txtMoney1.*" type="text" style="display:none;"/>
						<input id="txtMoney2.*" type="text" style="display:none;"/>
						<input id="txtMoney3.*" type="text" style="display:none;"/>
						<input id="txtMoney4.*" type="text" style="display:none;"/>
						<input id="txtMemo.*" type="text" style="display:none;"/>
						<input id="txtMemo2.*" type="text" style="display:none;"/>
					</td>
					<td style="width:100px;">
						<input id="txtCustno.*" type="text" style="display:none;"/>
						<input id="txtCust.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
					</td>
					<td style="width:100px;">
						<input id="txtProductno.*" type="text" style="display:none;"/>
						<input id="txtProduct.*" type="text" style="float:left;width:95%;" readonly="readonly" />
					</td>
					<td style="width:80px;">
						<input id="txtAddrno.*" type="text" style="display:none;"/>
						<input id="txtAddr.*" type="text" style="float:left;width:95%;" readonly="readonly" />
						<input id="txtAddrs.*" type="text" style="display:none;"/>
					</td>
					<td style="width:80px;">
						<input id="txtAddrno2.*" type="text" style="display:none;"/>
						<input id="txtAddr2.*" type="text" style="float:left;width:95%;" readonly="readonly" />
						<input id="txtAddrs2.*" type="text" style="display:none;"/>
					</td>
					<td style="width:60px;"><input id="txtTime1.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtTime2.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtLengthb.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtWidth.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtHeight.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtMount.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtUnit.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtVolume.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtWeight.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

