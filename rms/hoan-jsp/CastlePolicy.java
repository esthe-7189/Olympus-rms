//@UTF-8 CastlePolicy.java
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : neodal <mirr1004@gmail.com>
 *
 * Last modified Jun 27 2009
 *
 * History:
 *     
 *     Jun 29 2009 - 파일 관련 정책 부분 제거
 */

package castlejsp;

public class CastlePolicy 
{
	public String strErrorMessage;

	public String strAdminModuleName;
	public String strAdminID;
	public String strAdminPassword;
	public String strAdminLastModified;

	public String strSiteBool;
	public String strMode;
	public String strAlert;

	public String strLogBool;
	public String strLogDegree;
	public String strLogFileName;
	public String strLogCharset;
	public String strLogListCount;

	public String strTargetParam;
	public String strTargetCookie;

	public String strSQLInjectionBool;
	public String strXSSBool;
	public String strWordBool;
	public String strTagBool;
	public String strIPBool;

	public String strIPBase;

	public java.util.Vector listSQLInjection;
	public java.util.Vector listXSS;
	public java.util.Vector listWord;
	public java.util.Vector listTag;
	public java.util.Vector listIP;

	public String strIpAddr;
	public String strRemoteAddr;
	public String strPageUrl;
	public String strQuery;
	public String strCookies;

//Cookie
	public boolean write(String filename) 
	{

		try 
		{
			java.io.File file = new java.io.File(filename);

			if (file.exists()) {

				if (!file.canRead()) {
					strErrorMessage = "정책 파일 읽기 권한 없음";
					return true;
				}

				if (!file.canWrite()) {
					strErrorMessage = "정책 파일 쓰기 권한 없음";
					return true;
				}

				if (!file.delete()) {
					strErrorMessage = "이전 정책 파일 삭제 실패";
					return true;
				}

			}

			if (!file.createNewFile()) {
				strErrorMessage = "신규 정책 파일 생성 실패";
				return true;
			}

			java.io.BufferedWriter outfile = new java.io.BufferedWriter(new java.io.FileWriter(file));

			outfile.write("<%\n");
			outfile.write("    castlejsp.CastlePolicy castlePolicy = new castlejsp.CastlePolicy();\n");
			outfile.write("\n");
			outfile.write("    castlePolicy.listSQLInjection = new java.util.Vector();\n");
			outfile.write("\n");

			java.util.Enumeration e = listSQLInjection.elements();
			while (e.hasMoreElements()) {
				String s = (String)e.nextElement();
				outfile.write("    castlePolicy.listSQLInjection.add(\"" + s + "\");\n");
			}
			outfile.write("\n");
			outfile.write("\n");

				// XSS 
			outfile.write("    castlePolicy.listXSS = new java.util.Vector();\n");
			outfile.write("\n");
			e = listXSS.elements();
			while (e.hasMoreElements()) {
				String s = (String)e.nextElement();
				outfile.write("    castlePolicy.listXSS.add(\"" + s + "\");\n");
			}
			outfile.write("\n");
			outfile.write("\n");
			
				// Word 
			outfile.write("    castlePolicy.listWord = new java.util.Vector();\n");
			outfile.write("\n");
			e = listWord.elements();
			while (e.hasMoreElements()) {
				String s = (String)e.nextElement();
				outfile.write("    castlePolicy.listWord.add(\"" + s + "\");\n");
			}
			outfile.write("\n");
			outfile.write("\n");
			
				// Tag 
			outfile.write("    castlePolicy.listTag = new java.util.Vector();\n");
			outfile.write("\n");
			e = listTag.elements();
			while (e.hasMoreElements()) {
				String s = (String)e.nextElement();
				outfile.write("    castlePolicy.listTag.add(\"" + s + "\");\n");
			}
			outfile.write("\n");
			outfile.write("\n");

				// IP
			outfile.write("    castlePolicy.listIP = new java.util.Vector();\n");
			e = listIP.elements();
			while (e.hasMoreElements()) {
				String s = (String)e.nextElement();
				outfile.write("    castlePolicy.listIP.add(\"" + s + "\");\n");
			}
			outfile.write("\n");
			outfile.write("\n");

			outfile.write("    castlePolicy.strAdminModuleName = \"" + strAdminModuleName + "\";\n");
			outfile.write("    castlePolicy.strAdminID = \"" + strAdminID + "\";\n");
			outfile.write("    castlePolicy.strAdminPassword = \"" + strAdminPassword + "\";\n");
			outfile.write("    castlePolicy.strAdminLastModified = \"" + strAdminLastModified + "\";\n");
			outfile.write("\n");
			outfile.write("    castlePolicy.strSiteBool = \"" + strSiteBool + "\";\n");
			outfile.write("    castlePolicy.strMode = \"" + strMode + "\";\n");
			outfile.write("    castlePolicy.strAlert = \"" + strAlert + "\";\n");
			outfile.write("\n");
			outfile.write("    castlePolicy.strLogBool = \"" + strLogBool + "\";\n");
			outfile.write("    castlePolicy.strLogDegree = \"" + strLogDegree + "\";\n");
			outfile.write("    castlePolicy.strLogFileName = \"" + strLogFileName + "\";\n");
			outfile.write("    castlePolicy.strLogCharset = \"" + strLogCharset + "\";\n");
			outfile.write("    castlePolicy.strLogListCount = \"" + strLogListCount + "\";\n");
			outfile.write("\n");
			outfile.write("    castlePolicy.strTargetParam = \"" + strTargetParam + "\";\n");
			outfile.write("    castlePolicy.strTargetCookie = \"" + strTargetCookie + "\";\n");
			outfile.write("\n");
			outfile.write("    castlePolicy.strSQLInjectionBool = \"" + strSQLInjectionBool + "\";\n");
			outfile.write("    castlePolicy.strXSSBool = \"" + strXSSBool + "\";\n");
			outfile.write("    castlePolicy.strWordBool = \"" + strWordBool + "\";\n");
			outfile.write("    castlePolicy.strTagBool = \"" + strTagBool + "\";\n");
			outfile.write("    castlePolicy.strIPBool = \"" + strIPBool + "\";\n");
			outfile.write("\n");
			outfile.write("    castlePolicy.strIPBase = \"" + strIPBase + "\";\n");
			outfile.write("\n");
			outfile.write("%>\n");

			outfile.flush();
			outfile.close();
		}
		catch (java.io.IOException e) { 
			System.out.println(e);
			return true;
		}

		return false;
	}

}

