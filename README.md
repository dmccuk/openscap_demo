![Alt text](openscap.png?raw=true)

## Openscap demo code
>>>>>>> 6689063e86505944f2bc498693970d391fd4b65b

This demo is all about installing and setting up OpenScap so you can check if your servers are secure and hardened. Similiar tool like CIS and Nessus offer the same reports, but openscap is free.

More info: https://www.open-scap.org/

### Pre-requisites and instructions:

To be able to use this demo code, I've written a very basic terraform module to manage the server creatiogn in AWS.

````
1) git clone https://github.com/dmccuk/openscap_demo.git
2) cd openscap_demo
3) create your ssh key:

$ ssh-keygen -f sshkey #no passkey for the demo

4) Set your AWS access & secret keys in awscli - (https://linuxtechlab.com/easy-way-to-install-aws-cli-on-linux/)
5) terraform init
6) terraform plan
7) terraform apply
8) Watch your EC2 instance build in eu-west-2. The server will create an initial report of itself with a pre-openscap scan. Once complete, it will set up some audit rules before re-running the scan.

Feel free to change any of the variables to your own specifications.

9) Once built, visit the webpage reports directory: **http://your-aws-instance-ip/reports

````

Check the differences between the two reports. What are they? As you scroll down the reports, click on the issues and see them expand to show you how to resolve them.

If you want to make a manual update and see the results, do the following:

````
$ ssh -i sshkey ec2-user@you-aws-instance-ip
...
$ sudo -i
# vi /etc/ssh/sshd_config
#PermitEmptyPasswords no  #<-- UN-HASH
save file
# systemctl restart sshd
# sudo oscap xccdf eval \
 --profile xccdf_org.ssgproject.content_profile_ospp42 \
 --results-arf arf.xml \
 --report common-report.html \
 /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
# cp common-report.html /var/www/html/reports/post-common-report1.html
````
Now go back and check the new report. At the time of writing this, there were 5 Criticals, after making this update, there will be only 4.

## What next?
Now you can work through the list and resolve all the issues until your server is as secure as it can be (while still letting you login to it!).


