<!DOCTYPE html>
<html>
<head>
<title>구매의향서</title>
<meta http-equiv="Content-Type" content="text/html;charset=ko">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<style type="text/css">
/* reset CSS */
* { padding:0; margin:0; line-height:inherit; text-decoration:none; border:0 none; font-style:normal; font-weight:inherit; color:inherit; list-style-type:none; }
html, body,input, textarea { color:#000; font-size:11px; font-family:'맑은고딕', 'Malgun Gothic','돋움', 'Dotum', sans-serif; letter-spacing: -0.5px; }
table { border-spacing:0; border-collapse:collapse; }
body {
    background: #eee;
}
page[size="A4"] {
    background: #fff;
    width: 21cm;
    height: 29.7cm;
    display: block;
    margin: 0.5cm auto;
    /* box-shadow: 0 0 0.5cm rgba(0,0,0,0.5); */
    box-sizing:border-box;
    padding:20px;
}
@media print {
    body {
        background: none;
    }
    page[size="A4"] {
        background: #fff;
        width: 21cm;
        height: 29.7cm;
        display: block;
        margin: 0.5cm auto;
        box-sizing:border-box;
        padding:20px;
        page-break-after:always
    }
}
.m_t0 { margin-top:0 !important; }
.m_t10 { margin-top:10px !important; }
.m_t20 { margin-top:20px !important; }
.m_t30 { margin-top:30px !important; }
.m_t40 { margin-top:40px !important; }
.m_t50 { margin-top:50px !important; }
.t_left { text-align:left !important; }
.t_right { text-align:right !important; }
.t_center { text-align:center !important; }
.w50{ width:50px !important; }
/* design */
.wrap { width:595px; margin:0 auto; padding:10px; }
.intro { height:842px; box-sizing:border-box; }
.tit-name { font-size:50px; font-weight:bold; text-align:center; padding-top:400px; }
.date { text-align:center; font-size:35px; padding-top:100px; }
.company-name { font-size:24px; text-align:center; padding-top:300px;  }
.company-kt { font-size:15px; text-align:center; margin-top:10px;  }
.sub-tit { font-size:20px; text-align:center; font-weight:bold; padding:20px 0; }
.sub-tit2{  text-align:center; margin-top:20px; }
.tittext { font-size:12px;  font-weight:bold;   margin:20px 0 10px;}
.listtype01 li { line-height:22px;margin:2px 0;  position:relative;padding-left:16px;}
.listtype01 li em { position:absolute;;top:-1px;left:0;}
.text00{ line-height:22px; margin-top:30px; }
.text00.st2{ padding:10px; border:1px solid #ddd; }
.txt01 { line-height:22px; }
.btm-desc { margin:30px 0; text-align:center; }
.btm-table { width:100%; table-layout:fixed; }
.btm-table th { height:26px; font-weight:bold; text-align:left; vertical-align:middle; }
.btm-table td { height:26px; text-align:left; vertical-align:middle; }
.sign { display:inline-block; position:relative; } 
.sign img { position:absolute; top:-20px; right:-60px; width:50px; height:50px; }
.tableStyle { width:100%; border-top:2px solid #333; }
.tableStyle thead th { border-right:1px solid #ddd; border-bottom:1px solid #ddd; background:#f9f9f9; padding:6px; font-weight:bold; }
.tableStyle thead th:first-child {border-left:1px solid #ddd}
.tableStyle tbody th { background:#f9f9f9; padding:6px; text-align:left; border-bottom:1px solid #ddd; border-left:1px solid #ddd; font-weight:bold; }
.tableStyle tbody td { border-bottom:1px solid #ddd; border-left:1px solid #ddd; border-right:1px solid #ddd; padding:4px; }

.bottom-table { width:100%; margin-top:20px; }
.bottom-table thead th { text-align:center; font-weight:bold; padding:5px 0; }
.bottom-table thead th input[type="text"] { width:30px; text-align:center; }
.bottom-table tbody th { text-align:left; font-weight:bold; }
.bottom-table tbody td { padding:5px 0; } 

.tableBorder {border-top:1px solid black;border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black}

.caution + .caution{ margin-top:10px; }

.left-right-box{ overflow:hidden; margin:20px 0 10px; }
.left-right-box .tittext{ float:left; margin:0; }
.left-right-box .caution{ float:right; color:red; font-size:12px; }
</style>
</head> 
    
<body>

<page size="A4">
    <h1 class="tit-name">구매의향서</h1>
</page>

<page size="A4">

    <p class="sub-tit">구매의향서</p>           
    
    <div style="padding-left:40px">
    ※ 구매희망품목
    <table style="width:85%;" class="tableBorder">
    <thead>
        <tr>
            <th class="tableBorder">품목명</th><th class="tableBorder">수량</th><th class="tableBorder">단가</th><th class="tableBorder">금액</th>
        </tr>
    </thead>
    <tbody>
        <#list ITEM_LIST as item>
        <tr>
            <td class="tableBorder">${item.ITEM_NM}</td><td class="tableBorder">${item.ITEM_QTY}</td><td class="tableBorder">${item.ITEM_PRICE}</td><td class="tableBorder">${item.ITEM_AMT}</td>
        </tr>
        </#list>
    </tbody>
    </table>
    </div>
    <div style="padding-left:15px">
    <p class="text00">
        위와 같이 귀사 제품에 대한 당사의 구매의향서를 제출합니다.
    </p>
    </div>
    <table class="bottom-table">
        <colgroup>
            <col style="width:15%">
            <col style="width:20%">
            <col style="width:12%">
            <col style="width:*">
        </colgroup>
        <thead>
            <tr>
                <th colspan="4">${LOI_FORM_CREATE_DATE?substring(0,4)}년 ${LOI_FORM_CREATE_DATE?substring(4,6)}월 ${LOI_FORM_CREATE_DATE?substring(6,8)}일</th>
            </tr>           
        </thead>
    </table>
    
    <table style="width:100%">
    <tr>
        <td style="width:50%;">
        <ol class="listtype01">
            <li>구매자</li>
            <li>에스케이실트론 주식회사</li>
            <li>경상북도 구미시 임수로 53 (임수동)</li>
            <li>대표이사 변영삼 (인)  &nbsp;&nbsp;&nbsp;&nbsp;<span id='silSignInfo'></span></li>
            </ol>
        </td>
        <td>
        <ol class="listtype01">
            <li>공급자</li>
            <li>${VENDOR_NM}</li>
            <li>${VENDOR_ADDRESS}</li>
            <li>${VENDOR_REPRE} (인)  &nbsp;&nbsp;&nbsp;&nbsp;<span id='venSignInfo'></span></li>
            </ol> 
        </td>
    </tr>
    </table>
</page>

</body>
</html>