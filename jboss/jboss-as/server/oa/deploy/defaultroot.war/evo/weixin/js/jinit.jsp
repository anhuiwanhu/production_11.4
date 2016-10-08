<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Formatter"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.io.UnsupportedEncodingException"%>
<%!

    public static void main(String[] args) {
        String jsapi_ticket = "jsapi_ticket";

        // 注意 URL 一定要动态获取，不能 hardcode
        String url = "http://example.com";
        Map<String, String> ret = sign(jsapi_ticket, url);
        for (Map.Entry entry : ret.entrySet()) {
            System.out.println(entry.getKey() + ", " + entry.getValue());
        }
    };

    public static Map<String, String> sign(String jsapi_ticket, String url) {
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = create_nonce_str();
        String timestamp = create_timestamp();
        String string1;
        String signature = "";

        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + url;
        System.out.println(string1);

        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }

        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);

        return ret;
    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    private static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }

    private static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }

%>
<% 
String  url_weixin  =  "http://" + request.getServerName() //服务器地址  
                    + ":"   
                    + request.getServerPort()           //端口号  
                    + request.getAttribute("javax.servlet.forward.request_uri")      //项目名称  
                            ; //参数  
if(request.getAttribute("javax.servlet.forward.query_string")!=null)
{  
    url_weixin+="?"+request.getAttribute("javax.servlet.forward.query_string");          
} 
%>
<%
		String jsapi_ticket = com.whir.evo.weixin.util.WeiXinUtils.getJSToken();
        Map<String, String> ret_weixin = sign(jsapi_ticket, url_weixin);
        for (Map.Entry entry : ret_weixin.entrySet()) {
            System.out.println(entry.getKey() + ", " + entry.getValue());
        }
%>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jweixin-1.1.0.js"></script>
<script>
	wx.config({
      debug: false,
      appId: '<%=com.whir.evo.weixin.util.Constants.corpid%>',
      timestamp: <%=ret_weixin.get("timestamp")%>,
      nonceStr: '<%=ret_weixin.get("nonceStr")%>',
      signature: '<%=ret_weixin.get("signature")%>',
      jsApiList: [
        'hideMenuItems','closeWindow','getNetworkType','openEnterpriseChat','openLocation','getLocation'
      ]
	});
	
	wx.ready(function(){
		wx.hideMenuItems({
			menuList: ["menuItem:share:appMessage","menuItem:share:timeline","menuItem:share:qq","menuItem:share:QZone","menuItem:share:weiboApp","menuItem:favorite","menuItem:share:facebook","menuItem:share:QZone","menuItem:copyUrl","menuItem:share:email"]
		});
	});
</script>