![Alt text](openscap.PNG?)

## Openscap demo code

This demo is all about installing and setting up OpenScap so you can check if your servers are secure and hardened. Similiar tool like CIS and Nessus offer the same reports, but openscap is free.

More info: https://www.open-scap.org/

### Pre-requisites and instructions:

To be able to use this demo code, I've written a very basic terraform module to manage the server creatiogn in AWS.

````
1) git clone https://github.com/dmccuk/openscap_demo.git
2) cd openscap_demo/openscap_demo
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
If you get any issues during the build and subsequent running of the openscap scanning, it will probably be down to updated Profile names. Just run this command to list the latest ones and pick one in the list before updating /tmp/script.sh with the new profile name.

```
[root@ip-172-31-6-89 ~]# oscap info "/usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml"
Document type: Source Data Stream
Imported: 2019-11-29T16:29:18

Stream: scap_org.open-scap_datastream_from_xccdf_ssg-rhel7-xccdf-1.2.xml
Generated: (null)
Version: 1.3
Checklists:
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-xccdf-1.2.xml
WARNING: Datastream component 'scap_org.open-scap_cref_security-data-oval-com.redhat.rhsa-RHEL7.xml' points out to the remote 'https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL7.xml'. Use '--fetch-remote-resources' option to download it.
WARNING: Skipping 'https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL7.xml' file which is referenced from datastream
                Status: draft
                Generated: 2019-11-29
                Resolved: true
                Profiles:
                        Title: Health Insurance Portability and Accountability Act (HIPAA)
                                Id: xccdf_org.ssgproject.content_profile_hipaa
                        Title: DRAFT - ANSSI DAT-NT28 (high)
                                Id: xccdf_org.ssgproject.content_profile_anssi_nt28_high
                        Title: C2S for Red Hat Enterprise Linux 7
                                Id: xccdf_org.ssgproject.content_profile_C2S
                        Title: DRAFT - ANSSI DAT-NT28 (intermediary)
                                Id: xccdf_org.ssgproject.content_profile_anssi_nt28_intermediary
                        Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 7
                                Id: xccdf_org.ssgproject.content_profile_pci-dss
                        Title: DRAFT - ANSSI DAT-NT28 (minimal)
                                Id: xccdf_org.ssgproject.content_profile_anssi_nt28_minimal
                        Title: VPP - Protection Profile for Virtualization v. 1.0 for Red Hat Enterprise Linux Hypervisor (RHELH)
                                Id: xccdf_org.ssgproject.content_profile_rhelh-vpp
                        Title: Standard System Security Profile for Red Hat Enterprise Linux 7
                                Id: xccdf_org.ssgproject.content_profile_standard
                        Title: OSPP - Protection Profile for General Purpose Operating Systems v4.2.1
                                Id: xccdf_org.ssgproject.content_profile_ospp
                        Title: Unclassified Information in Non-federal Information Systems and Organizations (NIST 800-171)
                                Id: xccdf_org.ssgproject.content_profile_cui
                        Title: DRAFT - ANSSI DAT-NT28 (enhanced)
                                Id: xccdf_org.ssgproject.content_profile_anssi_nt28_enhanced
                        Title: Red Hat Corporate Profile for Certified Cloud Providers (RH CCP)
                                Id: xccdf_org.ssgproject.content_profile_rht-ccp
                        Title: Australian Cyber Security Centre (ACSC) Essential Eight
                                Id: xccdf_org.ssgproject.content_profile_e8
                        Title: [DRAFT] DISA STIG for Red Hat Enterprise Linux Virtualization Host (RHELH)
                                Id: xccdf_org.ssgproject.content_profile_rhelh-stig
                        Title: DISA STIG for Red Hat Enterprise Linux 7
                                Id: xccdf_org.ssgproject.content_profile_stig
                        Title: NIST National Checklist Program Security Guide
                                Id: xccdf_org.ssgproject.content_profile_ncp
                        Title: Criminal Justice Information Services (CJIS) Security Policy
                                Id: xccdf_org.ssgproject.content_profile_cjis
                Referenced check files:
                        ssg-rhel7-oval.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
                        ssg-rhel7-ocil.xml
                                system: http://scap.nist.gov/schema/ocil/2
                        security-data-oval-com.redhat.rhsa-RHEL7.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-pcidss-xccdf-1.2.xml
WARNING: Skipping 'https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL7.xml' file which is referenced from datastream
                Status: draft
                Generated: 2019-11-29
                Resolved: true
                Profiles:
                        Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 7
                                Id: xccdf_org.ssgproject.content_profile_pci-dss_centric
                Referenced check files:
                        ssg-rhel7-oval.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
                        ssg-rhel7-ocil.xml
                                system: http://scap.nist.gov/schema/ocil/2
                        security-data-oval-com.redhat.rhsa-RHEL7.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
Checks:
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-oval.xml
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-ocil.xml
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-cpe-oval.xml
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-oval.xml000
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-ocil.xml000
        Ref-Id: scap_org.open-scap_cref_security-data-oval-com.redhat.rhsa-RHEL7.xml
Dictionaries:
        Ref-Id: scap_org.open-scap_cref_ssg-rhel7-cpe-dictionary.xml
````

Check the differences between the two reports. What are they? As you scroll down the reports, click on the issues and see them expand to show you how to resolve them.

### Further testing:

If you want to make a manual update and see the results, try the following:

````
$ ssh -i sshkey ec2-user@your-aws-instance-ip
...
$ sudo -i
# vi /etc/ssh/sshd_config
#PermitEmptyPasswords no  #<-- UN-HASH
save file
# systemctl restart sshd
# sudo oscap xccdf eval \
 --profile xccdf_org.ssgproject.content_profile_rht-ccp \
 --results-arf arf.xml \
 --report common-report.html \
 /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
# cp common-report.html /var/www/html/reports/post-common-report1.html
````
Now go back and check the new report. At the time of writing this, there were 5 Criticals, after making this update, there will be only 4.

## What next?
Now you can work through the list and resolve all the issues until your server is as secure as it can be (while still letting you login to it!).


