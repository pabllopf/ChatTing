<%@page import="models.Error"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(request.getSession().getAttribute("currentAccount") == null){
        request.getSession().setAttribute("ErrorPage", new Error().saveError("Error: please Login or Sign Up first."));
        response.sendRedirect("ErrorPage.jsp");
    }
    
    response.setIntHeader("Refresh", 15);
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/ChatStyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="icon" href="resources/icon.png">
        <title>ChatTing</title>
    </head>
    <body>  
        <div class="page">   
            <jsp:include page="clock/Clock.jsp"/>
            <jsp:include page="page/NavMenu.jsp"/>
            <jsp:include page="page/AdminButton.jsp"/>
            
            <main>
                <div>
                    <jsp:include page="page/NameChat.jsp"/>
                    
                    <form method="post" action="FrontController">
                        <input type="hidden" name="command" value="ConfirmDeleteCommand">
                        <input style="background-color: red;" type="submit" value="Confirm To Delete All" name="confirm">
                    </form>
                    
                     <form method="post" action="FrontController">
                        <input type="hidden" name="command" value="CancelDeleteCommand">
                        <input type="submit" value="Cancel & Clean List" name="cancel">
                    </form>
                    
                    <jsp:include page="page/PrintMessagesToDelete.jsp"/>
                </div>
            </main>
        </div>
    </body>
</html>