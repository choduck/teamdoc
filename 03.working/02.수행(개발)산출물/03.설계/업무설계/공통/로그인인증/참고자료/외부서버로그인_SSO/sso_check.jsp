<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "com.ksign.access.sso.sso10.SSO10Conf"%>
<%@ page import = "com.ksign.access.api.*" %>
<%
//***********************************************************************
//*		JSP 로그인 체크														*
//***********************************************************************
//	SSO 서버에서 아이디, 이름, 실명여부 값 가져옴
	SSORspData rspData = null;
	SSOService ssoService = SSOService.getInstance();
	rspData = ssoService.ssoGetLoginData(request);

	String MEM_ID = rspData.getAttribute("KSIGN_FED_USER_ID");
	if((MEM_ID == null) || (MEM_ID == "")){
		MEM_ID = rspData.getAttribute(SSO10Conf.UIDKey);
	}
	String REALNAME_YN = rspData.getAttribute("REALNAME_YN");
	String MEM_NM = rspData.getAttribute("NAME");

//	SSO 서버에서 로그인 정보 여부에 따라 세션값 설정
	String LoginChk = "";
	if( MEM_ID =="" || MEM_ID == null ) {
		LoginChk = "N";
	}else{
		LoginChk = "Y";
	}
	
//	SSO 서버에 token값 생성 여부 확인	
	String TokenChk = "N";
	String TokenChkCookie = "";
	Cookie[] cookiess = request.getCookies();
	if(cookiess == null || cookiess.length == 0){
	}else{
	  for(int i = 0; i<cookiess.length; i++){
	    if(cookiess[i].getName().equals("kalogin")){
	    	TokenChkCookie=cookiess[i].getValue();
	      break;
	    }
	  }
	}
		
	if(TokenChkCookie.length() > 0){	TokenChk = "Y";	}

//	token 값 존재 하지만 로그인 정보를 못 가져올때
	String site_url = request.getRequestURL().toString();
	site_url = site_url.replaceAll(":443","");		
	if(request.getQueryString() == null){
	}else{
		site_url = site_url +"?"+request.getQueryString();
	}
	if(TokenChk.equals("Y") && LoginChk.equals("N")){
		String SSOURL = "https://www.seoul.go.kr/seoul/jsp/oneid/ssocheck.jsp?SSOreturnUrl="+site_url;
		response.sendRedirect(SSOURL);
	}
%>
<script type="text/javascript">
/* <![CDATA[ */
var loginchk = "<%=LoginChk%>";		//javascript 변수로 로그인 여부 값 지정 
/* ]]> */
</script>  