import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  static final String routeName = "/privacy-policy";
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: SingleChildScrollView(child: Text(
        '''
        We collect and use the following information to provide, improve, protect, and promote our Services.

Account information. We collect, and associate with your account, the information you provide to us when you do things such as sign up for your account, upgrade to a paid plan, and set up two-factor authentication (like your name, email address, phone number, payment info, and physical address).

Your Stuff. Our Services are designed as a simple and personalized way for you to store your files, documents, photos, comments, messages, and so on (“Your Stuff”), collaborate with others, and work across multiple devices and services. To make that possible, we store, process, and transmit Your Stuff as well as information related to it. This related information includes your profile information that makes it easier to collaborate and share Your Stuff with others, as well as things like the size of the file, the time it was uploaded, collaborators, and usage activity.

Contacts. You may choose to give us access to your contacts to make it easy for you to do things like share and collaborate on Your Stuff, send messages, and invite others to use the Services. If you do, we’ll store those contacts on our servers for you to use.

Usage information. We collect information related to how you use the Services, including actions you take in your account (like sharing, editing, viewing, creating and moving files or folders). We use this information to provide, improve, and promote our Services, and protect Dropbox users. Please refer to our FAQ for more information about how we use this usage information.

Device information. We also collect information from and about the devices you use to access the Services. This includes things like IP addresses, the type of browser and device you use, the web page you visited before coming to our sites, and identifiers associated with your devices. Your devices (depending on their settings) may also transmit location information to the Services. For example, we use device information to detect abuse and identify and troubleshoot bugs.

Cookies and other technologies. We use technologies like cookies and pixel tags to provide, improve, protect, and promote our Services. For example, cookies help us with things like remembering your username for your next visit, understanding how you are interacting with our Services, and improving them based on that information. You can set your browser to not accept cookies, but this may limit your ability to use the Services. If our systems receive a DNT:1 signal from your browser, we’ll respond to that signal as outlined here. We may also use third-party service providers that set cookies and similar technologies to promote Dropbox services. You can learn more about how cookies and similar technologies work, as well as how to opt out of the use of them for advertising purposes, here.

Marketing. We give users the option to use some of our Services free of charge. These free Services are made possible by the fact that some users upgrade to one of our paid Services. If you register for our Services, we will, from time to time, send you information about upgrades when permissible. Users who receive these marketing materials can opt out at any time. If you don’t want to receive a particular type of marketing material from us, click the ‘unsubscribe’ link in the corresponding emails, or update your preferences in the Notifications section of your personal account.

We sometimes contact people who don’t have a Dropbox account. For recipients in the EU, we or a third party will obtain consent before reaching out. If you receive an email and no longer wish to be contacted by Dropbox, you can unsubscribe and remove yourself from our contact list via the message itself.

Bases for processing your data. We collect and use the personal data described above in order to provide you with the Services in a reliable and secure manner. We also collect and use personal data for our legitimate business needs. To the extent we process your personal data for other purposes, we ask for your consent in advance or require that our partners obtain such consent. For more information on the lawful bases for processing your data, please see our FAQ.

For more details on the categories of personal information that are included in the information above, please see our FAQ.
        '''
      )),

    );
  }
}


