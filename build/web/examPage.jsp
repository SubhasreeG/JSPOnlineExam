<%@page contentType="text/html" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
    <title>Online Exam Server</title>
    <link rel='stylesheet' href='Style.css' type='text/css' />
</head>
<body>
    <%!
        Connection con;
        PreparedStatement ps1, ps2;
        public void jspInit()
        {
            try
            {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam","root","");
                ps1 = con.prepareStatement("select count(*) from USERS where user_name = ? and password=?");
                ps2 = con.prepareStatement("select * from USERS");
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
        }
    %>
    <%
        String param = request.getParameter("s1");
        if(param =="link")
        {
            ResultSet rs = ps2.executeQuery();
            out.println("<table>");
            while(rs.next())
            {
                out.println("<tr>");
                out.println("<td>"+rs.getString(1)+"</td>");
                out.println("<td>"+rs.getString(2)+"</td");
                out.println("</tr>");
            }
            out.println("</table>");
            rs.close();
        }
        else
        {
            String user = request.getParameter("uname");
            String pass = request.getParameter("pass");

            ps1.setString(1,user);
            ps1.setString(2,pass);
            
            ResultSet rs = ps1.executeQuery();
            int cnt = 0;
            if (rs.next())
                cnt = rs.getInt(1);
            if(cnt == 0){
                out.println("<div class='center'><b><i><font color=red>Invalid credentials</fonr></i></b><br>");
                out.println("<b><i><a href=index.html><font size=6 color=yellow>Try again</font></i></a></b></div>");
                
            }   
            else
            {
                session.setAttribute("user", user);
                if(user.equals("admin")){
                    String redirectURL = "/online_exam/viewMarks.jsp";
                    response.sendRedirect(redirectURL);
                }
                else{
                        out.println("<div id='quiz'>");
                        out.println("<h2 >ONLINE EXAMINATION</h2>");
                        out.println("<b>Student: "+user+"</b>");
                        out.println("<h5>Choose the correct option(Marking scheme: +2/0)</h5>");
                        out.println("<hr />");
                        out.println("<form name='examForm' method='post' action='examServer.jsp'>");
                        out.println("<b>1. Which component is used to compile, debug and execute java program?</b> <br />");
                        out.println("<input type='radio' name='ans1' value='JVM'>JVM <br />");
                        out.println("<input type='radio' name='ans1' value='JDK'>JDK<br />");
                        out.println("<input type='radio' name='ans1' value='JIT'>JIT <br />");
                        out.println("<input type='radio' name='ans1' value='JRE'>JRE");
                        out.println("<br /><br />");
                        out.println("<b>2. Which of the below is invalid identifier with the main method?</b> <br />");
                        out.println("<input type='radio' name='ans2' value='public'>public <br />");
                        out.println("<input type='radio' name='ans2' value='static'>static<br />");
                        out.println("<input type='radio' name='ans2' value='private'>private <br />");
                        out.println("<input type='radio' name='ans2' value='final'>final");
                        out.println("<br /><br />");
                        out.println("<b>3. What is the extension of compiled java classes?</b> <br />");
                        out.println("<input type='radio' name='ans3' value='.class'>.class <br />");
                        out.println("<input type='radio' name='ans3' value='.java'>.java<br />");
                        out.println("<input type='radio' name='ans3' value='.txt'>.txt <br />");
                        out.println("<input type='radio' name='ans3' value='.js'>.js");
                        out.println("<br /><br />");
                        out.println("<b>4. What guarantees type-safety in a collection?</b> <br />");
                        out.println("<input type='radio' name='ans4' value='Generics'>Generics <br />");
                        out.println("<input type='radio' name='ans4' value='Abstract classes'>Abstract classes<br />");
                        out.println("<input type='radio' name='ans4' value='Interfaces'>Interfaces <br />");
                        out.println("<input type='radio' name='ans4' value='Collection'>Collection");
                        out.println("<br /><br />");
                        out.println("<b>5.  Method Overloading is an example of</b><br />");
                        out.println("<input type='radio' name='ans5' value='Static Binding'>Static Binding<br />");
                        out.println("<input type='radio' name='ans5' value='Dynamic Binding'>Dynamic Binding<br />");
                        out.println("<input type='radio' name='ans5' value='Both of the above'>Both the above <br />");
                        out.println("<input type='radio' name='ans5' value='None of the above'>None of these");
                        out.println("<br /><br />");
                        out.println("<b>6. Which one of the following is not a Java feature?</b> <br />");
                        out.println("<input type='radio' name='ans6' value='Object-oriented'>Object-oriented <br />");
                        out.println("<input type='radio' name='ans6' value='Use of Pointers'>Use of Pointers<br />");
                        out.println("<input type='radio' name='ans6' value='Portable'>Portable <br />");
                        out.println("<input type='radio' name='ans6' value='Dynamic and Extensible'>Dynamic and Extensible");
                        out.println("<br /><br />");
                        out.println("<b>7. Which environment variable is used to set the java path?</b> <br />");
                        out.println("<input type='radio' name='ans7' value='MAVEN_Path'>MAVEN_Path <br />");
                        out.println("<input type='radio' name='ans7' value='JavaPATH'>JavaPATH<br />");
                        out.println("<input type='radio' name='ans7' value='JAVA'>JAVA <br />");
                        out.println("<input type='radio' name='ans7' value='JAVA_HOME'>JAVA_HOME");
                        out.println("<br /><br />");
                        out.println("<b>8. Which exception is thrown when java is out of memory?</b> <br />");
                        out.println("<input type='radio' name='ans8' value='MemoryError'>MemoryError <br />");
                        out.println("<input type='radio' name='ans8' value='OutOfMemoryError'>OutOfMemoryError<br />");
                        out.println("<input type='radio' name='ans8' value='OutOfBounds'>OutOfBounds <br />");
                        out.println("<input type='radio' name='ans8' value='MemoryFullException'>MemoryFullException");
                        out.println("<br /><br />");
                        out.println("<b>9. Which of the following is a superclass of every class in Java?</b> <br />");
                        out.println("<input type='radio' name='ans9' value='ArrayList'>ArrayList <br />");
                        out.println("<input type='radio' name='ans9' value='Abstract class'>Abstract class<br />");
                        out.println("<input type='radio' name='ans9' value='Object class'>Object class <br />");
                        out.println("<input type='radio' name='ans9' value='String'>String");
                        out.println("<br /><br />");
                        out.println("<b>10. Which of these packages contains the exception Stack Overflow in Java?</b> <br />");
                        out.println("<input type='radio' name='ans10' value='java.lang'>java.lang <br />");
                        out.println("<input type='radio' name='ans10' value='java.io'>java.io<br />");
                        out.println("<input type='radio' name='ans10' value='java.system'>java.system <br />");
                        out.println("<input type='radio' name='ans10' value='java.util'>java.util");
                        out.println("<br /><br />");
                        out.println("<input type='hidden' id='uname' name='uname' value=user>");
                        out.println("<div class='form-group' style='text-align:center'>");
                        out.println("<input type='submit' class='btn-primary' value='Submit'>");
                        out.println("</div>");
                        out.println("</form>");
                        out.println("</div>");
                }
            }
        }
    %>
    <%!
        public void jspDestroy()
        {
            try
            {
                ps1.close();
                ps2.close();
                con.close();
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
        }
    %>
</body>
</html>
