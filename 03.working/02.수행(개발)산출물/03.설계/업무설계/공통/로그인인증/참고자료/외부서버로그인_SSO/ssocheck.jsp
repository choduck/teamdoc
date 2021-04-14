<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="com.ksign.access.sso.sso10.SSO10Conf"%>
<%@ page import="com.ksign.access.api.*" %>

<%
//***********************************************************************
//*		JSP �α��� üũ														*
//***********************************************************************
	SSORspData rspData = null;
	SSOService ssoService = SSOService.getInstance();
	rspData = ssoService.ssoGetLoginData(request);

	String SSO_MEM_ID = rspData.getAttribute("KSIGN_FED_USER_ID");
	if((SSO_MEM_ID == null) || (SSO_MEM_ID == "")){
		SSO_MEM_ID = rspData.getAttribute(SSO10Conf.UIDKey);
	}
	String SSO_REALNAME_YN = rspData.getAttribute("REALNAME_YN");
	String SSO_MEM_NM = rspData.getAttribute("NAME");
	
	String MEM_ID = (String)request.getSession().getAttribute("MEM_ID");
	String MEM_NM = (String)request.getSession().getAttribute("MEM_NM");
	String REALNAME_YN = (String)request.getSession().getAttribute("REALNAME_YN");
	
	if((MEM_ID == null) || (MEM_ID == "")){	
		if((SSO_MEM_ID == null) || (SSO_MEM_ID == "")){
//			out.println("�� ȸ��");
		}else{
			session.setAttribute("MEM_ID", SSO_MEM_ID);
			session.setAttribute("MEM_NM", SSO_MEM_NM);
			session.setAttribute("REALNAME_YN", SSO_REALNAME_YN);
//			out.println("ȸ�� sso���� ���� ��ü session���� sso�� ����");
		}
	}else{
		if((SSO_MEM_ID == null) || (SSO_MEM_ID == "")){
			session.setAttribute("MEM_ID", "");
			session.setAttribute("MEM_NM", "");
			session.setAttribute("REALNAME_YN", "");
//			out.println(SSO_MEM_ID);
//			out.println("��ȸ�� : ��ü session ���� �ϳ� sso ���� ���� ����, ��ü session�� �ʱ�ȭ ");
		}else{
			if(MEM_ID != SSO_MEM_ID){
				session.setAttribute("MEM_ID", SSO_MEM_ID);
				session.setAttribute("MEM_NM", SSO_MEM_NM);
				session.setAttribute("REALNAME_YN", SSO_REALNAME_YN);
//				out.println("ȸ�� : ��ü session���� sso���� �ٸ� sso������ ��ü session�� ����");
			}else{
//				out.println("ȸ�� : sso���� ��ü session���� ����");
			}
		}
	}
	
	String SSOreturnUrl = request.getParameter("SSOreturnUrl");
	response.sendRedirect(SSOreturnUrl);
%>