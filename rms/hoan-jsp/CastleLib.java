//@UTF-8 CastleLib.java
/*
 * Castle: KISA Web Attack Defender - JSP Version
 * 
 * Author : neodal <mirr1004@gmail.com>
 *
 * Last modified Jan 05 2009
 *
 */

package castlejsp;

public class CastleLib
{
	public static String msg(String strMsg) {

		StringBuffer sb = new StringBuffer();

		sb.append("<html>\n");
		sb.append(" <head>");
		sb.append("   <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
		sb.append(" </head>");
		sb.append("	<script> alert(\"" + strMsg + "\"); </script>\n");
		sb.append("</html>\n");

		return sb.toString();
	}

	public static String move(String strUrl) {

		StringBuffer sb = new StringBuffer();

		sb.append("<html>\n");
		sb.append(" <head>");
		sb.append("   <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
		sb.append("	</head>");
		sb.append("	<script> location.replace('" + strUrl + "'); </script>\n");
		sb.append("</html>\n");

		return sb.toString();
	}

	public static String close() {

		StringBuffer sb = new StringBuffer();

		sb.append("<html>\n");
		sb.append(" <head>");
		sb.append("   <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
		sb.append(" </head>");
		sb.append("	<script> window.close(); </script>\n");
		sb.append("</html>\n");

		return sb.toString();
	}

	public static String back() {

		StringBuffer sb = new StringBuffer();

		sb.append("<html>\n");
		sb.append(" <head>");
		sb.append("   <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
		sb.append(" </head>");
		sb.append("	<script> history.back(-1); </script>\n");
		sb.append("</html>\n");

		return sb.toString();
	}

	public static String msgMove(String strMsg, String strUrl) {
		return msg(strMsg) + move(strUrl);
	}

	public static String msgBack(String strMsg) {
		return msg(strMsg) + back();
	}

	public static String msgClose(String strMsg) {
		return msg(strMsg) + close();
	}

	public static String getCharsets() {

		StringBuffer sb = new StringBuffer();

		java.util.Map map = java.nio.charset.Charset.availableCharsets();
		java.util.Iterator it = map.keySet().iterator();

		while (it.hasNext()) {
			String charsetName = (String)it.next();
			java.nio.charset.Charset charset = java.nio.charset.Charset.forName(charsetName);
			System.out.println(charsetName);
			sb.append(charsetName + "<br>\n");

		}

		return sb.toString();
	}

	public static String getDirPath(String strPath) {

		String strReturnPath = new String("");

		String[] result = strPath.split("/");

		for (int i = 0; i < result.length - 1; i++) {
			if (i != 0) 
				strReturnPath += "/" + result[i];
			else
				strReturnPath += result[i];
		}

		return strReturnPath;
	}

	public static String getDoubleMD5(String strMessage) {
		return getMD5(getMD5(strMessage));
	}

	public static String getMD5(String strMessage) {

		String strMD = "";

		try {
			java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");

			md.reset();
			md.update(strMessage.getBytes());

			byte b[] = md.digest();
			StringBuffer h = new StringBuffer();

			for (int i=0; i < b.length; i++)
				h.append(Integer.toHexString(0xFF & b[i]));

			strMD = new String(h.toString());

		}catch (java.security.NoSuchAlgorithmException e) {
			System.out.println(e);
		}

		return strMD;
	}

	public static String getBase64Encode(byte[] raw) {

		StringBuffer encoded = new StringBuffer();

		for (int i = 0; i < raw.length; i += 3) 
			encoded.append(encodeBlock(raw, i));

		return encoded.toString();
	}

	public static String getBase64Encode(String str) {
		return getBase64Encode(str.getBytes());
	}

	protected static char[] encodeBlock(byte[] raw, int offset) {

		int block = 0;
		int slack = raw.length - offset - 1;
		int end = (slack >= 2) ? 2 : slack;

		for (int i = 0; i <= end; i++) {
			byte b = raw[offset + i];
			int neuter = (b < 0) ? b + 256 : b;
			block += neuter << (8 * (2 - i));
		}

		char[] base64 = new char[4];

		for (int i = 0; i < 4; i++) {
			int sixbit = (block >>> (6 * (3 - i))) & 0x3f;
			base64[i] = getChar(sixbit);
		}

		if (slack < 1)
			base64[2] = '=';

		if (slack < 2)
			base64[3] = '=';

		return base64;
	}

	protected static char getChar(int sixBit) {

		if (sixBit >= 0 && sixBit <= 25)
			return (char) ('A' + sixBit);

		if (sixBit >= 26 && sixBit <= 51)
			return (char) ('a' + (sixBit - 26));

		if (sixBit >= 52 && sixBit <= 61)
			return (char) ('0' + (sixBit - 52));

		if (sixBit == 62)
			return '+';

		if (sixBit == 63)
			return '/';

		return '?';
	}

	public static byte[] getBase64Decode(String base64) {

		int pad = 0;

		for (int i = base64.length() - 1; base64.charAt(i) == '='; i--)
			pad++;

		int length = base64.length() * 6 / 8 - pad;
		byte[] raw = new byte[length];
		int rawIndex = 0;

		for (int i = 0; i < base64.length(); i += 4) {

			int block =
				(getValue(base64.charAt(i)) << 18)
					+ (getValue(base64.charAt(i + 1)) << 12)
					+ (getValue(base64.charAt(i + 2)) << 6)
					+ (getValue(base64.charAt(i + 3)));

			for (int j = 0; j < 3 && rawIndex + j < raw.length; j++)
				raw[rawIndex + j] = (byte) ((block >> (8 * (2 - j))) & 0xff);

			rawIndex += 3;
		}

		return raw;
	}

	protected static int getValue(char c) {

		if (c >= 'A' && c <= 'Z')
			return c - 'A';

		if (c >= 'a' && c <= 'z')
			return c - 'a' + 26;

		if (c >= '0' && c <= '9')
			return c - '0' + 52;

		if (c == '+')
			return 62;

		if (c == '/')
			return 63;

		if (c == '=')
			return 0;

		return -1;
	}
}

