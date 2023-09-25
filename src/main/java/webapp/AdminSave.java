package webapp;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




@WebServlet("/AdminSave")
public class AdminSave extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int id=Integer.parseInt(req.getParameter("id"));
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		
		
		String from = "jayesh1332bari@gmail.com";
		String to = req.getParameter("email");

		Random random = new Random();
		int otp = random.nextInt(10000);

		HttpSession hs = req.getSession();
		hs.setAttribute("otp", otp);
		hs.setAttribute("id", id);
		hs.setAttribute("name", name);
		hs.setAttribute("email", email);
		hs.setAttribute("password", password);

		Properties properties = System.getProperties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.ssl.enable", "true");
		properties.put("mail.smtp.auth", "true");

		Session session = Session.getInstance(properties, new Authentication());

		session.setDebug(true);
		try {
			InternetAddress from1 = new InternetAddress(from);

			InternetAddress to1 = new InternetAddress(to);

			MimeMessage message = new MimeMessage(session);
			message.setFrom(from1);
			message.addRecipient(RecipientType.TO, to1);

			message.setSubject("Registration OTP");
			message.setText("OTP : " + otp);

			Transport.send(message);
		} catch (Exception e) {
		}
		RequestDispatcher dispatcher=req.getRequestDispatcher("otp1.html");
		dispatcher.forward(req, resp);
	}

}
