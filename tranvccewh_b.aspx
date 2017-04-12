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

            var q_name = "tranvccewh", t_content = "where=^^['')^^", bbsKey = ['noa','noq'], as;
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
	            	t_content = "where=^^['"+t_para.project+"','"+t_para.tranno+"','"+t_para.driverno+"')^^";
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
				
				$('#checkAllCheckbox').click(function(e){
					for(let i=0;i<q_bbsCount;i++){
						if($('#txtOrdeno_'+i).val().length>0){
							$('#chkSel_'+i).prop('checked',$('#checkAllCheckbox').prop('checked'));
						}
					}
				});
				
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
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa +"-" + abbs[i].noq) {			
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
					}
					maxAbbsCount = abbs.length;
				}
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
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:60px;"><a>類型</a></td>
					<td align="center" style="width:70px;"><a>車牌</a></td>
					<td align="center" style="width:100px;"><a>客戶</a></td>
					<td align="center" style="width:100px;"><a>品名</a></td>
					<td align="center" style="width:100px;"><a>起點</a></td>
					<td align="center" style="width:100px;"><a>迄點</a></td>
					<td align="center" style="width:60px;"><a>數量</a></td>
					<td align="center" style="width:60px;"><a>單位</a></td>
					<td align="center" style="width:60px;"><a>材積</a></td>
					<td align="center" style="width:60px;"><a>重量</a></td>
					<td align="center" style="width:120px;"><a>派車單號</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:400px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:60px;"><a> </a></td>
					<td align="center" style="width:70px;"><a> </a></td>
					<td align="center" style="width:100px;"><a> </a></td>
					<td align="center" style="width:100px;"><a> </a></td>
					<td align="center" style="width:100px;"><a> </a></td>
					<td align="center" style="width:100px;"><a> </a></td>
					<td align="center" style="width:60px;"><a> </a></td>
					<td align="center" style="width:60px;"><a> </a></td>
					<td align="center" style="width:60px;"><a> </a></td>
					<td align="center" style="width:60px;"><a> </a></td>
					<td align="center" style="width:120px;"><a> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:25px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:60px;"><input id="txtTypea.*" type="text" style="width:95%;" readonly="readonly"/></td>
					<td style="width:70px;"><input id="txtCarno.*" type="text" style="width:95%;" readonly="readonly"/></td>
					<td style="width:100px;">
						<input id="txtCustno.*" type="text" style="display:none;"/>
						<input id="txtCust.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
					</td>
					<td style="width:100px;">
						<input id="txtProductno.*" type="text" style="display:none;"/>
						<input id="txtProduct.*" type="text" style="float:left;width:95%;" readonly="readonly" />
					</td>
					<td style="width:100px;">
						<input id="txtStraddrno.*" type="text" style="display:none;"/>
						<input id="txtStraddr.*" type="text" style="float:left;width:95%;" readonly="readonly" />
					</td>
					<td style="width:100px;">
						<input id="txtEndaddrno.*" type="text" style="display:none;"/>
						<input id="txtEndaddr.*" type="text" style="float:left;width:95%;" readonly="readonly" />
					</td>
					<td style="width:60px;"><input id="txtMount.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtUnit.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtVolume.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:60px;"><input id="txtWeight.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:120px;"><input id="txtOrdeno.*" type="text" style="width:95%;" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

