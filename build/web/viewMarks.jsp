<%@ page import="java.sql.*" %>
    <HTML>

    <HEAD>
        <TITLE>Marklist</TITLE>

        <link rel='stylesheet' href='Style.css' type='text/css' />
    </HEAD>

    <BODY>
        <div class="wrapper">
        <H3>Welcome Admin</H3>
        <H4>Student Marklist</H4>
        <p>
            <a href="index.html">Back To Main Page</a>
        </p>
        <hr />
        <% 
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance(); 
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_exam","root",""); 
            Statement statement=con.createStatement() ;
            ResultSet resultset=statement.executeQuery("select user_name, marks from users") ; 
        %>
           
                <TABLE BORDER="1" id="center">
                    <TR>
                        <TH>Student Name</TH>
                        <TH>Marks</TH>
                    </TR>
                    <% while(resultset.next()){
                        if(!resultset.getString(1).equals("admin")){ %>
                        <TR>
                            <TD>
                                <%= resultset.getString(1) %>
                            </TD>
                            <TD>
                                <%= resultset.getInt(2) %>
                            </TD>
                        </TR>
                        <% }} %>
                </TABLE>
            </div>
    </BODY>

    </HTML>