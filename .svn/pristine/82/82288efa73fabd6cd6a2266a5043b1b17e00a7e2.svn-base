<!DOCTYPE html>
<html>
<head>
<title>공급단가합의서</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
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

.caution + .caution{ margin-top:10px; }

.left-right-box{ overflow:hidden; margin:20px 0 10px; }
.left-right-box .tittext{ float:left; margin:0; }
.left-right-box .caution{ float:right; color:red; font-size:12px; }
</style>
</head> 
    
<body>

<page size="A4">
    <p class="sub-tit">공급단가 합의서</p>           
    <p class="text00">
        본 문서는 전자서명법 등 관련 법령에 의하여 효력이 인정되는 공인인증기관이 발행한 인증서를 사용하여 전자서명된 문서입니다.
    </p>
    
    <h2 class="tittext">[공급단가 내역]</h2>
    <table class="tableStyle t_center">
        <colgroup>
            <col style="width:6%">
            <col style="width:11%">
            <col>
            <col style="width:8%">
            <col style="width:15%">
            <col style="width:10%">
            <col style="width:20%">
        </colgroup>
        <thead>
            <tr>
                <th>NO</th>
                <th>자재번호</th>
                <th>자재명</th>
                <th>단위</th>
                <th>단가</th>
                <th>통화</th>
                <th>적용기간</th>
            </tr>
        </thead>
        <tbody>
            <#list ITEM_LIST as item>
            <tr>
                <td>${item?index + 1}</td>
                <td>${item.ITEM_CD}</td>
                <td>${item.ITEM_NM}</td>
                <td>${item.UNIT}</td>
                <td>${item.UNIT_PRICE}</td>
                <td><#if item.CURRENCY_CD?exists>${item.CURRENCY_CD}</#if></td>
                <td>
                    <#if item.PRICE_ST_DATE?exists>${item.PRICE_ST_DATE}</#if>
                    &nbsp;~&nbsp;
                    <#if item.PRICE_ED_DATE?exists>${item.PRICE_ED_DATE}</#if>
                </td>
            </tr>
            </#list>
        </tbody>
    </table>

    <table class="tableStyle m_t20">
        <colgroup>
            <col style="width:15%">
            <col style="width:35%">
            <col style="width:15%">
            <col>
        </colgroup>
        <tbody>
            <tr>
                <th>구매자</th>
                <td>에스케이실트론 주식회사</td>
                <th>공급자</th>
                <td>${VENDOR_NM}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>경상북도 구미시 임수로 53 (임수동)</td>
                <th>주소</th>
                <td>${VENDOR_ADDRESS}</td>
            </tr>
            <tr>
                <th>대표이사</th>
                <td>대표이사 변영삼 (인)</td>
                <th>대표이사</th>
                <td>${VENDOR_REPRE} (인)</td>
            </tr>
        </tbody>
    </table>
    <table class="tableStyle" style="border-top:0px solid #333;">
    <colgroup>
            <col style="width:50%">
            <col>
        </colgroup>
    <tr>
        <td style="border-bottom:0px solid #ddd; border-left:0px solid #ddd; border-right:0px solid #ddd;text-align: right;"><span id='silSignInfo'></span></td>
        <td style="border-bottom:0px solid #ddd; border-left:0px solid #ddd; border-right:0px solid #ddd;text-align: right;"><span id='venSignInfo'></span></td>
    </tr>
    </table>    
    

    <p class="text00">
        구매자와 공급자 상호 동등한 입장에서 체결한 공급단가 합의서에 동의의 증거로서 본 합의서에 전자서명 하여 이를 보관합니다.
    </p>

    <table class="bottom-table ">
        <colgroup>
            <col style="width:15%">
            <col style="width:20%">
            <col style="width:12%">
            <col style="width:*">
        </colgroup>
        <thead>
            <tr>
                <th colspan="4">${CNTRT_FORM_CREATE_DATE?substring(0,4)}년 ${CNTRT_FORM_CREATE_DATE?substring(4,6)}월 ${CNTRT_FORM_CREATE_DATE?substring(6,8)}일</th>
            </tr>           
        </thead>
    </table>

</page>



</body>
</html>