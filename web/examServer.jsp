<%@page contentType="text/html" language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Online Exam Server</title>
    <link rel='stylesheet' href='Style.css' type='text/css' />
</head>
<body>
    <div class='wrapper'>
    <h2 style="text-align:center">ONLINE EXAMINATION</h2>
    <p>
        <a href="index.html">Back To Main Page</a>
    </p>
    <hr />
    <% 
        Enumeration<String> ans =request.getParameterNames();
        
        int mark=0; 
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam","root","");
        Statement stmt=con.createStatement();
        ResultSet rs=stmt.executeQuery("SELECT * FROM examtable");
        while(ans.hasMoreElements() && rs.next()) {
            Object objOri=ans.nextElement();
			String param=(String)objOri;
			String a=request.getParameter(param);
            String dbans=rs.getString("answers");
            
            if(a.equals(dbans)) { 
                mark=mark+2;
            } 
        } 
        try
        {
            String user = (String)session.getAttribute("user");;
            String queryString = "update users set marks = ? WHERE user_name = ?";
            PreparedStatement ps1 = con.prepareStatement(queryString);
            ps1.setInt(1, mark);
            ps1.setString(2, user);
            int i = ps1.executeUpdate();
        }
        catch(SQLException sql)
        {
            request.setAttribute("error", sql);
            out.println(sql);
        }
        if(mark>=10)
        {
            out.println("<h4>Your Mark Is : "+mark+"</h4>");
            out.println("<h3>Congratulations!</h3><h3> Well Done!</h3>");
        }
        else
        {
            out.println("<h4>Your Mark is : "+mark+"</h4>");
            out.println("<h3>OOPS!</h3><h3>Focus more and Prepare well for upcoming exams!</h3>");
        }
        %>
        </form>
    </div>
</body>
</html>