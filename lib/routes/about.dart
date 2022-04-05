import 'package:flutter/material.dart';

class AboutRoute extends StatefulWidget {
  static final String routeName = "/about";
  @override
  _AboutRouteState createState() => _AboutRouteState();
}

class _AboutRouteState extends State<AboutRoute> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: SingleChildScrollView(child: Text(
          '''
        Our Stuff
The Services are protected by copyright, trademark, and other US and foreign laws. These Terms don’t grant you any right, title, or interest in the Services, others’ content in the Services, Dropbox trademarks, logos and other brand features. We welcome feedback, but note that we may use comments or suggestions without any obligation to you.

Copyright
We respect the intellectual property of others and ask that you do too. We respond to notices of alleged copyright infringement if they comply with the law, and such notices should be reported using our Copyright Policy. We reserve the right to delete or disable content alleged to be infringing and terminate accounts of repeat infringers. Our designated agent for notice of alleged copyright infringement on the Services is:


Paid Accounts
Billing. You can increase your storage space and add paid features to your account (turning your account into a “Paid Account”). We’ll automatically bill you from the date you convert to a Paid Account and on each periodic renewal until cancellation. If you’re on an annual plan, we’ll send you a notice email reminding you that your plan is about to renew within a reasonable period of time prior to the renewal date. You’re responsible for all applicable taxes, and we’ll charge tax when required to do so. Some countries have mandatory local laws regarding your cancellation rights, and this paragraph doesn’t override these laws.

Cancellation. You may cancel your Dropbox Paid Account at any time. Refunds are only issued if required by law. For example, users living in the European Union have the right to cancel their Paid Account subscriptions within 14 days of signing up for, upgrading to, or renewing a Paid Account by clicking here.

Downgrades. Your Paid Account will remain in effect until it's cancelled or terminated under these Terms. If you don’t pay for your Paid Account on time, we reserve the right to suspend it or remove Paid Account features.

Changes. We may change the fees in effect on renewal of your subscription, to reflect factors such as changes to our product offerings, changes to our business, or changes in economic conditions. We’ll give you no less than 30 days’ advance notice of these changes via a message to the email address associated with your account and you’ll have the opportunity to cancel your subscription before the new fee comes into effect.
        '''
      )),

    );
  }
}


