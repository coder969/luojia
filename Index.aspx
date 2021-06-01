<%@ Page Language="C#"  MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Model" %>
<%@ Import Namespace="Com.FrameWork.Util" %>
<%@ Import Namespace="Services" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="TitleContent">
酒店预订,网上订酒店,酒店预订网,特价酒店,来住吧旅行网
</asp:Content>
<asp:Content ID="MetaContent" runat="server" ContentPlaceHolderID="MetaContent">
<%
    string keywords = "酒店预订,网上订酒店,连锁酒店,快捷酒店,酒店预订网,特价酒店";
    CacheManager cm = CacheManager.getInstance();
    Model.Parmer pdesc = cm.getParam("description");    
    string description = "";
    if (pdesc != null)
    {
        description = pdesc.pvalue;
    }
%>
<meta name="keywords" content="<%:keywords %>"/>
<meta name="description" content="<%:description %>"/>
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="head">
<link type="text/css" rel="stylesheet" href="/Content/css/index.css" />
<script type="text/javascript" src="/Scripts/city.js"></script>
<script type="text/javascript" src="/Scripts/common.js"></script>
<script type="text/javascript">
    var quna_server_date = new Date(Date.parse('01/04/2012'));
    function tabHomeHotel(id)
    {
        var self = $("#hothotel").children("li");
        self.removeClass("current");
        $("#" + id + "").addClass("current");
        AjaxHomeHotHotel(id);
    }
</script>
<style type="text/css">
ul,li {list-style:none;}
img {border:0;}
.shuoming {margin-top:20px; border:1px solid #ccc; padding-bottom:10px;}
.shuoming dt {height:30px; line-height:30px; font-weight:bold; text-indent:10px;}
.shuoming dd {line-height:20px; padding:5px 20px;}
#focus {width:511px; height:148px; overflow:hidden; position:relative;}
#focus ul {height:380px; position:absolute;}
#focus ul li {float:left; width:511px; height:230px; overflow:hidden; position:relative; background:#fff;}
#focus ul li div {position:absolute; overflow:hidden;}
#focus .btnBg {position:absolute; width:511px; height:20px; left:0; bottom:0;}
#focus .btn {position:absolute; width:511px; height:10px; padding:5px 10px; right:0; bottom:0; text-align:right;}
#focus .btn span {display:inline-block; _display:inline; _zoom:1; width:25px; height:10px; _font-size:0; margin-left:5px; cursor:pointer; background:#fff;}
#focus .btn span.on {background:#fff;}
</style>
</asp:Content>
<asp:Content id="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
<%
    IList<Chain> chainlist = ViewData["chainlist"] as IList<Chain>;
    IList<FlashImage> flashlist = ViewData["flashlist"] as IList<FlashImage>;
    IList<Question> queslist = ViewData["question"] as IList<Question>;
%>
<div class="wraper clearfix">
    <div class="aside">
        <div class="search">
            <h3>预订国内酒店</h3>
            <p>在线预订2-7折+高额返现！</p>
            <form id="formsearch">
            <ul>
                <li><span>*</span><i>入住城市：</i><input name="select_incity" id="select_incity" tabindex="1" type="text" class="city" mod_address_suggest="@beijing|北京|bj|53@shanghai|上海|sh|321@shenzhen|深圳|sz|91@guangzhou|广州|gz|80@dalian|大连|dl|248@chengdu|成都|cd|324@tianjin|天津|tj|343@wuhan|武汉|wh|192@xian|西安|xa|317@chongqing|重庆|cq|394@hangzhou|杭州|hz|383@qingdao|青岛|qd|292@"
                 mod_address_source="hotelDomestic" mod_notice_tip="中文/拼音" mod="address|notice" type="hidden" mod_address_reference="cityid" onkeyup="value=value.replace(/[^A-Za-z0-9\u4E00-\u9FA5\']/g,'')" />
                <input type="hidden" id="cityid" name="cityid"/></li>
                <li><span>*</span><i>入住日期：</i><input tabindex="2" type="text" class="date" id="indate" name="indate" readonly="readonly" onclick="MyCalendar.SetDate(this);" value="yyyy-mm-dd" /></li>
                <li><span>*</span><i>退房日期：</i><input tabindex="3" type="text" class="date" id="outdate" name="outdate" readonly="readonly" onclick="MyCalendar.SetDate(this);" value="yyyy-mm-dd"/></li>
                <li class="fh_li"><span>&nbsp;</span>酒店星级：<select tabindex="4" id="star" name="star"><option value="0">星级不限</option><option value="2">二星级/经济型</option><option value="3">三星级/舒适型</option><option value="4">四星级/高档型</option><option value="5">五星级/豪华型</option></select></li>
                <li><span>&nbsp;</span>酒店位置：<input tabindex="5" type="text" id="address" name="address" value="" /></li>
                <li><span>&nbsp;</span>酒店名称：<input tabindex="6" type="text" id="hname" name="hname" value=""/></li>
                <li class="fh_last"><input tabindex="7" type="button" onclick="subhotel();" value="" class="btn" id="sbtn"/></li>
                <script type="text/javascript">qunaObj.module.searchBox.init();</script>
            </ul>
            </form>
        </div>
        <div class="newhotel">
            <div class="tbar">
                <h3>最新咨询</h3>
            </div>
            <div class="order" id="marquee">
            <%if(queslist != null && queslist.Count > 0)
            {
                foreach (var item in queslist)
                {
                   %>
                   <dl>
                    <dt><span class="icon1">最新咨询</span><a target="_blank" href="/question/<%:item.id %>.html" title="<%:item.title %>"><%:Html.cut(item.title,18) %></a></dt>
                    <dd><span title="<%:item.acontent %>"><%:Html.cut(item.acontent,36) %></span></dd>
                   </dl> 
                   <%  
                }    
            }
            %>      
           </div>
        </div>
    </div>
    <div class="main">
        <div class="hotarea clearfix">
            <div class="hotcity">
                <div class="tbar">
                   <h3>景点门票</h3>
                </div>
                <ul class="clearfix">
                   <li><a href="scenery/53.html" target="_blank" title="北京门票预定">北京门票</a></li>
                   <li><a href="scenery/321.html" target="_blank" title="上海门票预定">上海门票</a></li>
                   <li><a href="scenery/80.html" target="_blank" title="广州门票预定">广州门票</a></li>
                   <li><a href="scenery/91.html" target="_blank" title="深圳门票预定">深圳门票</a></li>
                   <li><a href="scenery/383.html" target="_blank" title="杭州门票预定">杭州门票</a></li>
                   <li><a href="scenery/224.html" target="_blank" title="南京门票预定">南京门票</a></li>
                   <li><a href="scenery/324.html" target="_blank" title="成都门票预定">成都门票</a></li>
                   <li><a href="scenery/192.html" target="_blank" title="武汉门票预定">武汉门票</a></li>
                   <li><a href="scenery/343.html" target="_blank" title="天津门票预定">天津门票</a></li>
                   <li><a href="scenery/226.html" target="_blank" title="苏州门票预定">苏州门票</a></li>
                   <li><a href="scenery/61.html" target="_blank" title="厦门门票预定">厦门门票</a></li>
                   <li><a href="scenery/317.html" target="_blank" title="西安门票预定">西安门票</a></li>
                </ul>
             </div>
            <div id="focus">
            <ul>
            <%if(flashlist != null && flashlist.Count > 0)
                {
                    foreach(var item in flashlist)
                    {
                        %><li><a href="<%:item.website %>" target="_blank"><img alt="<%:item.title %>" src="<%:item.imgurl %>"/></a></li><%  
                    }  
                }
            %>
            </ul>
            </div>    
        </div>
        <div class="hothotel">
            <div class="tbar">
               <h3>热门酒店</h3>
                <ul class="tabs" id="hothotel">                    
                    <li id="53" onclick="tabHomeHotel('53');" class="current"><a title="北京酒店">北京</a></li>               
                    <li id="321" onclick="tabHomeHotel('321');"><a title="上海酒店">上海</a></li>
                    <li id="80" onclick="tabHomeHotel('80');"><a title="广州酒店">广州</a></li>
                    <li id="91" onclick="tabHomeHotel('91');"><a title="深圳酒店">深圳</a></li>
                    <li id="383" onclick="tabHomeHotel('383');"><a title="杭州酒店">杭州</a></li>
                    <li id="343" onclick="tabHomeHotel('342');"><a title="天津酒店">天津</a></li>
                    <li id="324" onclick="tabHomeHotel('324');"><a title="成都酒店">成都</a></li>
                    <li id="224" onclick="tabHomeHotel('224');"><a title="南京酒店">南京</a></li>
                    <li id="292" onclick="tabHomeHotel('292');"><a title="青岛酒店">青岛</a></li>
                    <li id="61" onclick="tabHomeHotel('61');"><a title="厦门酒店">厦门</a></li>
                    <li id="192" onclick="tabHomeHotel('192');"><a title="武汉酒店">武汉</a></li>
               </ul>
            </div>
            <div class="content">
            <!---->
            <div class="tab-panel" id="ulhot">            
                   
            </div>
            <!--end-->
            </div>
        </div>                
        <div class="brand-recommend">
            <div class="tbar">
                <h3>推荐品牌</h3>
                <a class="more" href="/chain/">更多</a>
            </div>
            <ul class="clearfix">
            <%if(chainlist != null && chainlist.Count > 0)
            {
              foreach(var item in chainlist)
              {
              %>
               <li>
                  <a class="pic" href="/Chain/<%:item.pinyin %>.html" target="_blank"><img src="<%:item.photoUrl %>" alt="<%:item.chainName %>" /></a>
                  <p class="name"><a href="/Chain/<%:item.pinyin %>.html" target="_blank" title="<%:item.chainName %>"><%:item.chainName %></a></p>
               </li>
              <%       
              }
            }
            %>
            </ul>
        </div>
        <!---->
        <div class="hothotel">
        <div class="tbar">
            <h3>热门景点</h3>
            <ul class="tabs" id="tabsense">                    
                <li id="li53" onclick="AjaxHomeHotSence('53');" class="current"><a title="北京景点">北京</a></li>               
                <li id="li321" onclick="AjaxHomeHotSence('321');"><a title="上海景点">上海</a></li>
                <li id="li80" onclick="AjaxHomeHotSence('80');"><a title="广州景点">广州</a></li>
                <li id="li91" onclick="AjaxHomeHotSence('91');"><a title="深圳景点">深圳</a></li>
                <li id="li383" onclick="AjaxHomeHotSence('383');"><a title="杭州景点">杭州</a></li>
                <li id="li343" onclick="AjaxHomeHotSence('343');"><a title="天津景点">天津</a></li>
                <li id="li324" onclick="AjaxHomeHotSence('324');"><a title="成都景点">成都</a></li>
                <li id="li224" onclick="AjaxHomeHotSence('224');"><a title="南京景点">南京</a></li>
                <li id="li292" onclick="AjaxHomeHotSence('292');"><a title="青岛景点">青岛</a></li>
                <li id="li61" onclick="AjaxHomeHotSence('61');"><a title="厦门景点">厦门</a></li>
                <li id="li192" onclick="AjaxHomeHotSence('192');"><a title="武汉景点">武汉</a></li>
            </ul>
        </div>
        <div class="content jq" id="jq">
        <div class="tab-panel">
        <ul id="ulsence" class="items clearfix">

        </ul>
        </div>
        </div>
        </div>
     <!--景点结束-->
    </div>
</div>
<div class="ftnav clearfix" style="display:none;">
   <dl>
      <dt>预订常见问题</dt>
      <dd><a title="我们的预订服务时间" rel="nofollow">我们的预订服务时间</a></dd>
      <dd><a title="网上可以提前多久预订？" rel="nofollow">网上可以提前多久预订？</a></dd>
      <dd><a title="网上直接预订有保障吗？" rel="nofollow">网上直接预订有保障吗？</a></dd>
      <dd><a title="网上预订需要先注册吗？" rel="nofollow">网上预订需要先注册吗？</a></dd>
   </dl>
   <dl class="d02">
      <dt>关于入住</dt>
      <dd><a title="网上预订好如何付费？" rel="nofollow">网上预订好如何付费？</a></dd>
      <dd><a title="预订好到酒店怎么说？" rel="nofollow">预订好到酒店怎么说？</a></dd>
      <dd><a title="入住人一定需要是预订人吗？" rel="nofollow">入住人一定需要是预订人吗？</a></dd>
      <dd><a title="预订好到前台找不到订单怎么办？"rel="nofollow">预订好到前台找不到订单怎么办？</a></dd>
   </dl>
   <dl>
      <dt>关于奖金</dt>
      <dd><a title="什么是点评奖金？" rel="nofollow">什么是点评奖金？</a></dd>
      <dd><a title="如何获得点评奖金？" rel="nofollow">如何获得点评奖金？</a></dd>
      <dd><a title="帮同事预订也有奖金吗？"rel="nofollow">帮同事预订也有奖金吗？</a></dd>
      <dd><a title="如何申请兑换奖金？" rel="nofollow">如何申请兑换奖金？</a></dd>
   </dl>
   <dl>
      <dt>关于订单</dt>
      <dd><a title="网上预订单能保留多久？" rel="nofollow">网上预订单能保留多久？</a></dd>
      <dd><a title="订单确认是什么意思？" rel="nofollow">订单确认是什么意思？</a></dd>
      <dd><a title="订单NO SHOW是什么意思？" rel="nofollow">订单NO SHOW是什么意思？</a></dd>
      <dd><a title="需要担保的预订是什么意思？" rel="nofollow">需要担保的预订是什么意思？</a></dd>
   </dl>
   <dl class="last">
      <dt>其他帮助</dt>
      <dd><a title="预订信息填写注意事项" rel="nofollow">预订信息填写注意事项</a></dd>
      <dd><a title="办理入住时的注意事项" rel="nofollow">办理入住时的注意事项</a></dd>
      <dd><a title="入住时间和离店时间" rel="nofollow">入住时间和离店时间</a></dd>
      <dd><a title="关于订单修改注意事项" rel="nofollow">关于订单修改注意事项</a></dd>
   </dl>
</div>
<script type="text/javascript">
    initTITLE(0);
    AjaxHomeHotSence("53");
    AjaxHomeHotHotel("53");
    loadAD(); 
</script>
</asp:Content>