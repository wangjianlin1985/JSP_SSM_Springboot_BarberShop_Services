﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Barber" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Barber> barberList = (List<Barber>)request.getAttribute("barberList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String name = (String)request.getAttribute("name"); //姓名查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>理发师查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Barber/frontlist">理发师信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Barber/barber_frontAdd.jsp" style="display:none;">添加理发师</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<barberList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Barber barber = barberList.get(i); //获取到理发师对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Barber/<%=barber.getBarberId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=barber.getBarberPhoto()%>" /></a>
			     <div class="showFields">
			     	  
			     	<div class="field">
	            		姓名:<%=barber.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=barber.getGender() %>
			     	</div>
			     	<div class="field">
	            		理发师年龄:<%=barber.getBarberAge() %>
			     	</div>
			     	<div class="field">
	            		工作经验:<%=barber.getWorkYears() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Barber/<%=barber.getBarberId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="barberEdit('<%=barber.getBarberId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="barberDelete('<%=barber.getBarberId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>理发师查询</h1>
		</div>
		<form name="barberQueryForm" id="barberQueryForm" action="<%=basePath %>Barber/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="barberEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;理发师信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="barberEditForm" id="barberEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="barber_barberId_edit" class="col-md-3 text-right">理发师id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="barber_barberId_edit" name="barber.barberId" class="form-control" placeholder="请输入理发师id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="barber_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="barber_name_edit" name="barber.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="barber_gender_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="barber_gender_edit" name="barber.gender" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="barber_barberAge_edit" class="col-md-3 text-right">理发师年龄:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="barber_barberAge_edit" name="barber.barberAge" class="form-control" placeholder="请输入理发师年龄">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="barber_barberPhoto_edit" class="col-md-3 text-right">理发师照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="barber_barberPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="barber_barberPhoto" name="barber.barberPhoto"/>
			    <input id="barberPhotoFile" name="barberPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="barber_workYears_edit" class="col-md-3 text-right">工作经验:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="barber_workYears_edit" name="barber.workYears" class="form-control" placeholder="请输入工作经验">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="barber_barberDesc_edit" class="col-md-3 text-right">理发师介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="barber.barberDesc" id="barber_barberDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="barber_barberMemo_edit" class="col-md-3 text-right">理发师备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="barber_barberMemo_edit" name="barber.barberMemo" rows="8" class="form-control" placeholder="请输入理发师备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#barberEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxBarberModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var barber_barberDesc_edit = UE.getEditor('barber_barberDesc_edit'); //理发师介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.barberQueryForm.currentPage.value = currentPage;
    document.barberQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.barberQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.barberQueryForm.currentPage.value = pageValue;
    documentbarberQueryForm.submit();
}

/*弹出修改理发师界面并初始化数据*/
function barberEdit(barberId) {
	$.ajax({
		url :  basePath + "Barber/" + barberId + "/update",
		type : "get",
		dataType: "json",
		success : function (barber, response, status) {
			if (barber) {
				$("#barber_barberId_edit").val(barber.barberId);
				$("#barber_name_edit").val(barber.name);
				$("#barber_gender_edit").val(barber.gender);
				$("#barber_barberAge_edit").val(barber.barberAge);
				$("#barber_barberPhoto").val(barber.barberPhoto);
				$("#barber_barberPhotoImg").attr("src", basePath +　barber.barberPhoto);
				$("#barber_workYears_edit").val(barber.workYears);
				barber_barberDesc_edit.setContent(barber.barberDesc, false);
				$("#barber_barberMemo_edit").val(barber.barberMemo);
				$('#barberEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除理发师信息*/
function barberDelete(barberId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Barber/deletes",
			data : {
				barberIds : barberId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#barberQueryForm").submit();
					//location.href= basePath + "Barber/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交理发师信息表单给服务器端修改*/
function ajaxBarberModify() {
	$.ajax({
		url :  basePath + "Barber/" + $("#barber_barberId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#barberEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#barberQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

})
</script>
</body>
</html>

