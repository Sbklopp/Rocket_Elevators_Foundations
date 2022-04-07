# Rocket_Elevators_API

Dropbox:
Fill in the contact form at the bottom of the index page, make sure to:
Put in an email
Remember that email
Attach an image
Head to the back office, create a new customer with the same email as the one from the contact form
Head to the dropbox dashboard (https://www.dropbox.com/home/Apps/RocketElevatorsFiles) and show that a folder has been uploaded with the same name you put in the contact form and that the image you attached is in that folder

Twilio:
Go to the back office and edit an elevator so that its status is set to “Intervention”
Pinky swear that Abdul received a text


As for freshdesk, we used this API to create support tickets for both questions and feature requests.
go to ADMIN> controllers > leads
Here, you can see that we are adding the request for the "contact us" form on the front page, giving the code the necessary values, and sending it over to our help desk.
GO TO FRESHDESK.COM
Heres where the tickets show up!
GO TO ADMIN> controllers > quotes
We are essentially doing the same thing here, only a little bit more information is added.


For AWS polly, its about the same simplicity.
GO TO ADMIN > CONTROLLERS > POLLY
Here, we are setting the values, deleting the text and mp3 files, then generating new ones based on the values we passed in.
Polly then synthesizes the tts, and outputs it to mp3.
The mp3 is then shown in the admin page for employees to hear!

For Google Maps you need to log into the Admin page and then select the Maps page 
There you'll be able to see the addresses from our database plotted on a map as well as Information about each.
Hovering over any of the plotted points will show their street address, company name, numbers of batteries, columns and elevators as well as the name of that addresses' technical contact.

Slack:
Go to the back office and edit an elevator status to anything other than the original status.
A message is posted in the Rocket Elevators Slack elevator operations channel when the status is updated.
