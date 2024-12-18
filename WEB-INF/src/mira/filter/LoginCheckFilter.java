package mira.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginCheckFilter implements Filter {

    public void init(FilterConfig arg0) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, 
            FilterChain chain)
    throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest)request;
        HttpSession session = httpRequest.getSession(false);
        
        boolean login = false;
        if (session != null) {
            if (session.getAttribute("ID") != null) {
                login = true;
            }
        }
        if (login) {
            chain.doFilter(request, response);
        } else {
            RequestDispatcher dispatcher = 
                request.getRequestDispatcher("/rms/member/loginForm.jsp");
            dispatcher.forward(request, response);
        }
    }

    public void destroy() {
    }
}
