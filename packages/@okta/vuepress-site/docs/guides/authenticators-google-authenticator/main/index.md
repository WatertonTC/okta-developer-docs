---
title: Google Authenticator integration guide
---

<ApiLifecycle access="ie" /><br>

This guide shows you how to integrate Google Authenticator into your authentication use cases using the embedded SDK.

---
#### Learning outcome

Understand the Google Authenticator flow

#### What you need

* <StackSnippet snippet="oiesdksetup" />
* Google Authenticator installed on a mobile device

#### Sample code

<StackSnippet snippet="samplecode" />

---

## Why choose Google Authenticator

Google Authenticator is an authenticator app developed by Google used to verify the identity of a user. The app is often used with a password to strengthen user accounts from security attacks. This approach is considered more secure than other authenticators such as SMS because it's resistant to SIM swap attacks. It doesn't require a cellular or wireless network to use and setup can be as easy as a snapshot of a QR Code.

### Authentication flow

After a user is enrolled in Google Authenticator, the Service Provider (for example, a website) presents a challenge to provide a time-based one-time passcode (TOTP) during authentication. Google Authenticator generates the TOTP, which the user submits to the Service Provider for verification. The Service Provider independently generates the password and validates that the submitted password is identical to the generated one.

A shared key linking the Google Authenticator app and Service Provider allows for both entities to generate the same password. The Service Provider generates the shared key and adds it to the app during enrollment.

As the Service Provider, you can provide Google Authenticator support to your users. Enable Google Authenticator in your Okta org and use the embedded SDK to build support for it in your application.

The following diagram illustrates how the Google Authenticator enrollment and challenge flows can work in your application.

<div class="full">

![Diagram showing the Google Authenticator enrollment flow](/img/authenticators/authenticators-google-flow-overview.png)

</div>

## Update configurations

Before you can start using Google Authenticator, create an Okta org application as described in <StackSnippet snippet="orgconfigurepwdonly" inline/>. Then add Google Authenticator to your app integration by executing the following steps:

### Add Google Authenticator to your org

First, add Google Authenticator to your org and enable it.

1. Open the **Admin Console** for your org.
2. Choose **Security > Authenticators** to show the available authenticators.
3. If the **Google Authenticator** isn't in the list:
   1. Click **Add Authenticator**.
   2. Click **Add** on the **Google Authenticator** tile, and then click **Add** in the next dialog.
4. Select the **Enrollment** tab.
5. Check that **Google Authenticator** is set to either **Optional** or **Required** in the **Eligible Authenticators** section of the default policy.
   1. If **Google Authenticator** is set to **Disabled**, click **Edit** for the default policy
   2. Select **Optional** from the dropdown box for the **Google Authenticator**, and then click **Update Policy**.

### Set your app integration to use Google Authenticator

New apps are automatically assigned the shared default [authentication policy](https://help.okta.com/okta_help.htm?type=oie&id=ext-about-asop). This policy has a catch-all rule that allows a user access to the app using either one or two factors, depending on your org setup. In production, it becomes evident when you can share your authentication needs between apps. Okta recommends that you create a policy specifically for your app for testing purposes.

1. Open the **Admin Console** for your org.
2. Choose **Security > Authentication Policies** to show the available authentication policies.
3. Click **Add a Policy**.
4. Give the policy a name, and then click **Save**.
5. Locate the Catch-all Rule of the new policy and select **Actions > Edit**.
6. Select **Allowed after successful authentication**.
7. Set **User must authenticate with** to **Password + Another factor**.
8. For **Possession factor constraints**
   1. Verify that **Device Bound** is selected.
   2. Verify that **Google Authenticator** is listed in the box under **Additional factor types**. If it isn't listed, check that the authenticator has been enabled using steps 4 and 5 of [Add Google Authenticator to your org](#add-google-authenticator-to-your-org).
   3. Click **Save**.

9. Select the **Applications** tab for your newly created policy, and then click **Add App**.
10. Find your app in the list and click **Add** next to it.
11. Click **Close**.
12. Verify that the app is now listed in the **Applications** tab of the new policy.

## Install Google Authenticator

Install the Google Authenticator app on your mobile device either using either the Google Play Store (Android) or Apple App Store (iOS).

## Integrate SDK for authenticator enrollment

### Summary of steps

The following summarizes the Google Authenticator enrollment flow using a user sign-in use case.

<StackSnippet snippet="enrollmentintegrationsummary" />

<StackSnippet snippet="enrollmentintegrationsteps" />

## Integrate SDK for authenticator challenge

### Summary of steps

The following summarizes the Google Authenticator challenge flow using a user sign-in use case.

<StackSnippet snippet="challengeintegrationsummary" />

<StackSnippet snippet="challengeintegrationsteps" />

## See also

<StackSnippet snippet="relatedusecases" />
