package webapp;

import javax.mail.Authenticator;

import javax.mail.PasswordAuthentication;



public class Authentication extends Authenticator {

	@Override

	protected javax.mail.PasswordAuthentication getPasswordAuthentication() {



		return new PasswordAuthentication("jayesh1332bari@gmail.com", "gbnijuxbuyayemyh");

	}

}
