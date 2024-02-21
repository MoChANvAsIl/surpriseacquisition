import processing.serial.*;
import processing.net.*;
import http.requests.*;


Serial arduino;

void setup() {
  size(400, 300);
  
  // Type your Arduino port
  arduino = new Serial(this, "COM5", 9600);
  
}

void draw() {
  while (arduino.available() > 0) {
    String companyName = arduino.readStringUntil('\n'); 
    if (companyName != null) {
      println("Received Company Name: " + companyName);
      companyName = companyName.trim();
      sendToServer(companyName);
    }
  }
}

void sendToServer(String companyName) {
  PostRequest post = new PostRequest("http://www.surpriseacquisition.com/main.php"); // link to the main.php file
  post.addData("company", companyName);
  post.send();
  System.out.println("Reponse Content: " + post.getContent());
  System.out.println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));
}
