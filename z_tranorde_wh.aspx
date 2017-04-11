<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var t_custtype;
            
            $(document).ready(function() {
            	q_getId();
             	 q_gt('custtype', '', 0, 0, 0, "");    
            });
            function q_gtPost(s2) {
            	switch(s2){
            		case 'custtype':
                        t_custtype='';
                        var as = _q_appendData("custtype", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_custtype += (t_custtype.length>0?',':'') + as[i].namea;
                        }
            			q_gf('', 'z_trans_wh');  
            		default:
            			break;
            	}
            	
            }
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_trans_wh',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_tranorde_wh.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					}, {
						type : '1', //[3][4]   1
						name : 'xdate'
					}, {
						type : '1', //[5][6]   2
						name : 'xtrandate'
					}, {
						type : '2', //[7][8]   3
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[9][10]    4
						name : 'xdriver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					},{
						type : '6', //[11]       5
						name : 'xcarno'
					}, {
						type : '2', //[12][13]    6
						name : 'xproduct',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					},{
						type : '6', //[14]       7
						name : 'xcusttype'
					},{
						type : '6', //[15]       8
						name : 'xnoa'
					}]
				});
				q_popAssign();
				q_langShow();

	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtXnoa').val(t_para.noa);
	            }
	            
	            $('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				
				$('#txtXtrandate1').mask('999/99/99');
				$('#txtXtrandate1').datepicker();
				$('#txtXtrandate2').mask('999/99/99');
				$('#txtXtrandate2').datepicker();
				
				AddDataList('txtXcusttype',t_custtype);
            }

			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
            
            function AddDataList(elementid,string){
				var obj = $('#'+elementid);
				var dl_id = guid();
				var options = '<datalist id="'+dl_id+'">';
				var data = string.split(',');
				for(var i=0;i<data.length;i++){
					options += '<option value="'+data[i]+'"></option>';
                }
                options+='</datalist>';
				obj.attr('list',dl_id);
				$(options).insertAfter(obj);
			}
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
			//function q_boxClose(s2) {}
			
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          