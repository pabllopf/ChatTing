package frontController.commands;
import ejbs.stateless.ChatHandler;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Error;
import models.LogMessage;
import models.Page;
import models.User;

public class LoginCommand extends AbstractCommand{
    @Override
    public void process() {
        logRemote.add(new LogMessage("LoginCommand::process"));
                
        User account = new User(request.getParameter("userText"), request.getParameter("passwordText"));
        
        if(userHandler.login(account)){
            request.getSession().setAttribute("currentAccount", account);
            request.getSession().setAttribute("numPage", new Page(1));
            
            
            if(userHandler.loadChat(account) != null){
                request.getSession().setAttribute("currentChat", new ChatHandler().loadChat(userHandler.loadChat(account)));
            }
        
            statistics.countNewLoggin();
            logRemote.add(new LogMessage("Logged::name::" + account.getUser()));
            forward("/RefreshChat.jsp");
        }else{
            request.getSession().setAttribute("Error", new Error().saveError("Incorrect username or password."));
            forward("/Login.jsp");
        }
    }
}
